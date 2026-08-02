import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:isnad_worker/core/file_management/domain/repo/file_management_repo.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';
import 'package:isnad_worker/core/usecase/usecase.dart';

class DownloadFileUseCase implements UseCase<void, DownloadFileUseCaseParams> {
  final FileManagementRepo repository;

  DownloadFileUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(DownloadFileUseCaseParams params) async {
    return await repository.downloadFile(
      fileId: params.fileId,
      savePath: params.savePath,
      onReceiveProgress: params.onReceiveProgress,
    );
  }
}

class DownloadFileUseCaseParams {
  final String fileId;
  final String savePath;
  final ProgressCallback? onReceiveProgress;

  DownloadFileUseCaseParams({
    required this.fileId,
    required this.savePath,
    this.onReceiveProgress,
  });
}
