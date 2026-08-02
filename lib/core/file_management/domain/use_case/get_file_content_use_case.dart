import 'package:dartz/dartz.dart';
import 'package:isnad_worker/core/file_management/domain/repo/file_management_repo.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';
import 'package:isnad_worker/core/usecase/usecase.dart';

class GetFileContentUseCase
    implements UseCase<String, GetFileContentUseCaseParams> {
  final FileManagementRepo repository;

  GetFileContentUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(
    GetFileContentUseCaseParams params,
  ) async {
    return await repository.getFileContent(fileId: params.fileId);
  }
}

class GetFileContentUseCaseParams {
  final String fileId;

  GetFileContentUseCaseParams({required this.fileId});
}
