import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:isnad_worker/core/file_management/domain/entities/file_tag.dart';
import 'package:isnad_worker/core/file_management/domain/use_case/download_file_use_case.dart';
import 'package:isnad_worker/core/file_management/domain/use_case/get_file_content_use_case.dart';
import 'package:isnad_worker/core/file_management/domain/use_case/get_files_use_case.dart';
import 'package:isnad_worker/core/utils/service_locator/service_locator.dart';
import 'package:path_provider/path_provider.dart';

final _fileContentCache = <String, Uint8List>{};
final _fileDataUriCache = <String, String>{};
final _directoryProfileFileIdCache = <String, String?>{};
final _fileIdToPathCache = <String, String>{};

/// Downloads the file straight to disk (no base64/JSON blow-up), caching the
/// local path so repeat views of the same file skip the network entirely.
Future<String?> downloadFileToTemp(String fileId) async {
  final cachedPath = _fileIdToPathCache[fileId];
  if (cachedPath != null && await File(cachedPath).exists()) {
    return cachedPath;
  }

  final dir = await getTemporaryDirectory();
  final savePath = '${dir.path}/file_cache_$fileId';
  final result = await sl<DownloadFileUseCase>()(
    DownloadFileUseCaseParams(fileId: fileId, savePath: savePath),
  );
  return result.fold((_) => null, (_) {
    _fileIdToPathCache[fileId] = savePath;
    return savePath;
  });
}

Future<String?> loadFileDataUri(String fileId) async {
  if (_fileDataUriCache.containsKey(fileId)) {
    return _fileDataUriCache[fileId];
  }
  final result = await sl<GetFileContentUseCase>()(
    GetFileContentUseCaseParams(fileId: fileId),
  );
  return result.fold((_) => null, (dataUri) {
    _fileDataUriCache[fileId] = dataUri;
    _fileContentCache[fileId] = base64Decode(dataUri.split(',').last);
    return dataUri;
  });
}

Future<Uint8List?> loadFileBytes(String fileId) async {
  if (_fileContentCache.containsKey(fileId)) {
    return _fileContentCache[fileId];
  }
  final dataUri = await loadFileDataUri(fileId);
  if (dataUri == null) return null;
  return _fileContentCache[fileId];
}

Future<String?> loadDirectoryProfileFileId(String directoryId) async {
  if (_directoryProfileFileIdCache.containsKey(directoryId)) {
    return _directoryProfileFileIdCache[directoryId];
  }
  final result = await sl<GetFilesUseCase>()(
    GetFilesUseCaseParams(directoryId: directoryId),
  );
  return result.fold(
    (_) {
      _directoryProfileFileIdCache[directoryId] = null;
      return null;
    },
    (files) {
      final profileFile = files
          .where((f) => f.fileTag == FileTag.profilePicture)
          .firstOrNull;
      final fileId = profileFile?.id;
      _directoryProfileFileIdCache[directoryId] = fileId;
      return fileId;
    },
  );
}
