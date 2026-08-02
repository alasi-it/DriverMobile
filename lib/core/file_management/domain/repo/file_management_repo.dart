import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:isnad_worker/core/file_management/data/models/file_descriptor_model.dart';
import 'package:isnad_worker/core/file_management/domain/entities/file_tag.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';

abstract class FileManagementRepo {
  Future<Either<Failure, FileDescriptorModel>> upload({
    required String directoryId,
    required String name,
    required String filePath,
    required FileTag fileTag,
    ProgressCallback? onSendProgress,
  });

  Future<Either<Failure, List<FileDescriptorModel>>> getFiles({
    required String directoryId,
  });

  Future<Either<Failure, String>> getFileContent({required String fileId});

  Future<Either<Failure, void>> downloadFile({
    required String fileId,
    required String savePath,
    ProgressCallback? onReceiveProgress,
  });
}
