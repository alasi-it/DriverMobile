import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:isnad_worker/core/file_management/data/models/download_token_model.dart';
import 'package:isnad_worker/core/file_management/data/models/file_descriptor_model.dart';
import 'package:isnad_worker/core/file_management/domain/entities/file_tag.dart';
import 'package:isnad_worker/core/network/errors/exception.dart';
import 'package:isnad_worker/core/network/remote/apis/dio_helper.dart';
import 'package:isnad_worker/core/network/remote/apis/hanlders/remote_data_source_handler.dart';
import 'package:isnad_worker/core/network/remote/end_points.dart';
import 'package:mime/mime.dart';

abstract class FileManagementRemoteDataSource {
  Future<FileDescriptorModel> upload({
    required String directoryId,
    required String name,
    required String filePath,
    required FileTag fileTag,
    ProgressCallback? onSendProgress,
  });

  Future<List<FileDescriptorModel>> getFiles({required String directoryId});

  Future<String> getFileContent({required String fileId});

  Future<String> getDownloadToken({required String fileId});

  Future<void> downloadFile({
    required String fileId,
    required String savePath,
    ProgressCallback? onReceiveProgress,
  });
}

class FileManagementRemoteDataSourceImpl
    implements FileManagementRemoteDataSource {
  final DioHelper networkManager;

  FileManagementRemoteDataSourceImpl({required this.networkManager});

  @override
  Future<FileDescriptorModel> upload({
    required String directoryId,
    required String name,
    required String filePath,
    required FileTag fileTag,
    ProgressCallback? onSendProgress,
  }) async {
    final fileName = filePath.split(Platform.pathSeparator).last;
    final mimeType = lookupMimeType(filePath) ?? 'application/octet-stream';

    final formData = FormData.fromMap({
      'Name': name,
      'FileTag': fileTag.apiValue,
      'OverrideExisting': true,
      'File': await MultipartFile.fromFile(
        filePath,
        filename: fileName,
        contentType: MediaType.parse(mimeType),
      ),
    });
    printFormData(formData);
    final base = await RemoteDataSourceCallHandler().call<FileDescriptorModel>(
      () => networkManager.post(
        url: FILE_UPLOAD_URL,
        query: {'directoryId': directoryId},
        headers: {'Content-Type': 'multipart/form-data'},
        data: formData,
        onSendProgress: onSendProgress,
      ),
      (json) => FileDescriptorModel.fromJson(json as Map<String, dynamic>),
    );

    return base.data ?? (throw ServerException('Empty response'));
  }

  @override
  Future<List<FileDescriptorModel>> getFiles({
    required String directoryId,
  }) async {
    final base = await RemoteDataSourceCallHandler()
        .call<List<FileDescriptorModel>>(
          () => networkManager.get(
            url: FILE_LIST_URL,
            query: {'directoryId': directoryId},
          ),
          (json) => List<FileDescriptorModel>.from(
            (json as List).map((e) => FileDescriptorModel.fromJson(e)),
          ),
        );

    return base.data ?? [];
  }

  @override
  Future<String> getFileContent({required String fileId}) async {
    final result = await RemoteDataSourceCallHandler().call<String>(
      () => networkManager.get(url: fileIdUrl(fileId)),
      (json) {
        if (json is Map<String, dynamic>) {
          return (json['data'] ?? json['content'] ?? json['fileContent'] ?? '')
              .toString();
        }
        return json?.toString() ?? '';
      },
    );

    final b64 = result.data ?? '';
    if (b64.isEmpty) return '';
    return _buildDataUri(b64);
  }

  @override
  Future<String> getDownloadToken({required String fileId}) async {
    final result = await RemoteDataSourceCallHandler().call<DownloadTokenModel>(
      () => networkManager.get(url: fileDownloadTokenUrl(fileId)),
      (json) => DownloadTokenModel.fromJson(json as Map<String, dynamic>),
    );

    final token = result.data?.token ?? '';
    if (token.isEmpty) throw ServerException('Empty download token');
    return token;
  }

  @override
  Future<void> downloadFile({
    required String fileId,
    required String savePath,
    ProgressCallback? onReceiveProgress,
  }) async {
    final token = await getDownloadToken(fileId: fileId);
    await networkManager.download(
      url: fileDownloadUrl(fileId),
      savePath: savePath,
      query: {'token': token},
      onReceiveProgress: onReceiveProgress,
    );
  }

  String _buildDataUri(String base64String) {
    String b64 = base64String.trim();
    if (b64.contains(',')) {
      b64 = b64.split(',').last;
    }

    try {
      final bytes = base64Decode(b64);
      final mime = _detectMimeType(bytes);
      return 'data:$mime;base64,$b64';
    } catch (_) {
      return base64String;
    }
  }

  String _detectMimeType(Uint8List bytes) {
    if (bytes.length < 4) return 'application/octet-stream';

    if (bytes[0] == 0xFF && bytes[1] == 0xD8 && bytes[2] == 0xFF) {
      return 'image/jpeg';
    }
    if (bytes[0] == 0x89 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x4E &&
        bytes[3] == 0x47) {
      return 'image/png';
    }
    if (bytes[0] == 0x47 &&
        bytes[1] == 0x49 &&
        bytes[2] == 0x46 &&
        bytes[3] == 0x38) {
      return 'image/gif';
    }
    if (bytes[0] == 0x52 &&
        bytes[1] == 0x49 &&
        bytes[2] == 0x46 &&
        bytes[3] == 0x46) {
      return 'image/webp';
    }
    if (bytes[0] == 0x25 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x44 &&
        bytes[3] == 0x46) {
      return 'application/pdf';
    }

    return 'application/octet-stream';
  }
}

void printFormData(FormData formData) {
  print("====== FormData Fields ======");
  for (var field in formData.fields) {
    print("${field.key}: ${field.value}");
  }

  print("====== FormData Files ======");
  for (var file in formData.files) {
    print("${file.key}: ${file.value.filename}");
  }
}
