import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:isnad_worker/core/file_management/data/data_source/file_management_remote_data_source.dart';
import 'package:isnad_worker/core/file_management/data/models/file_descriptor_model.dart';
import 'package:isnad_worker/core/file_management/domain/entities/file_tag.dart';
import 'package:isnad_worker/core/file_management/domain/repo/file_management_repo.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';
import 'package:isnad_worker/core/network/local/network_info.dart';
import 'package:isnad_worker/core/network/remote/apis/hanlders/repo_impl_callhandler.dart';

class FileManagementRepoImp implements FileManagementRepo {
  final FileManagementRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  FileManagementRepoImp({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, FileDescriptorModel>> upload({
    required String directoryId,
    required String name,
    required String filePath,
    required FileTag fileTag,
    ProgressCallback? onSendProgress,
  }) async {
    return await RepoImplCallHandler<FileDescriptorModel>(networkInfo)(
      () async {
        return await remoteDataSource.upload(
          directoryId: directoryId,
          name: name,
          filePath: filePath,
          fileTag: fileTag,
          onSendProgress: onSendProgress,
        );
      },
    );
  }

  @override
  Future<Either<Failure, List<FileDescriptorModel>>> getFiles({
    required String directoryId,
  }) async {
    return await RepoImplCallHandler<List<FileDescriptorModel>>(networkInfo)(
      () async {
        return await remoteDataSource.getFiles(directoryId: directoryId);
      },
    );
  }

  @override
  Future<Either<Failure, String>> getFileContent({
    required String fileId,
  }) async {
    return await RepoImplCallHandler<String>(networkInfo)(() async {
      return await remoteDataSource.getFileContent(fileId: fileId);
    });
  }

  @override
  Future<Either<Failure, void>> downloadFile({
    required String fileId,
    required String savePath,
    ProgressCallback? onReceiveProgress,
  }) async {
    return await RepoImplCallHandler<void>(networkInfo)(() async {
      return await remoteDataSource.downloadFile(
        fileId: fileId,
        savePath: savePath,
        onReceiveProgress: onReceiveProgress,
      );
    });
  }
}
