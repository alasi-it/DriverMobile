import 'package:dartz/dartz.dart';
import 'package:isnad_worker/core/file_management/data/models/file_descriptor_model.dart';
import 'package:isnad_worker/core/file_management/domain/entities/file_tag.dart';
import 'package:isnad_worker/core/file_management/domain/repo/file_management_repo.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';
import 'package:isnad_worker/core/usecase/usecase.dart';

class GetFilesUseCase
    implements UseCase<List<FileDescriptorModel>, GetFilesUseCaseParams> {
  final FileManagementRepo repository;

  GetFilesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<FileDescriptorModel>>> call(
    GetFilesUseCaseParams params,
  ) async {
    return await repository.getFiles(directoryId: params.directoryId);
  }
}

class GetFilesUseCaseParams {
  final String directoryId;
  final FileTag? fileTag;

  GetFilesUseCaseParams({required this.directoryId, this.fileTag});
}
