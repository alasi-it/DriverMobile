import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:isnad_worker/core/file_management/data/models/file_descriptor_model.dart';
import 'package:isnad_worker/core/file_management/domain/entities/file_tag.dart';
import 'package:isnad_worker/core/file_management/domain/repo/file_management_repo.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';
import 'package:isnad_worker/core/usecase/usecase.dart';

class UploadFileUseCase
    implements UseCase<FileDescriptorModel, UploadFileUseCaseParams> {
  final FileManagementRepo repository;

  UploadFileUseCase({required this.repository});

  @override
  Future<Either<Failure, FileDescriptorModel>> call(
    UploadFileUseCaseParams params,
  ) async {
    return await repository.upload(
      directoryId: params.directoryId,
      name: params.name,
      filePath: params.filePath,
      fileTag: params.fileTag,
      onSendProgress: params.onSendProgress,
    );
  }
}

class UploadFileUseCaseParams {
  final String directoryId;
  final String name;
  final String filePath;
  final FileTag fileTag;
  final ProgressCallback? onSendProgress;

  UploadFileUseCaseParams({
    required this.directoryId,
    required this.name,
    required this.filePath,
    required this.fileTag,
    this.onSendProgress,
  });
}
