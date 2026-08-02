import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:isnad_worker/core/file_management/data/models/file_descriptor_model.dart';
import 'package:isnad_worker/core/file_management/domain/use_case/get_file_content_use_case.dart';
import 'package:isnad_worker/core/file_management/domain/use_case/get_files_use_case.dart';
import 'package:isnad_worker/core/utils/service_locator/service_locator.dart';
import 'package:meta/meta.dart';

part 'file_management_state.dart';

class FileManagementCubit extends Cubit<FileManagementState> {
  FileManagementCubit() : super(FileManagementInitial());

  Future<void> getFiles({required String directoryId}) async {
    emit(GetFilesManagementLoadingState());
    final result = await sl<GetFilesUseCase>()(
      GetFilesUseCaseParams(directoryId: directoryId),
    );

    result.fold(
      (error) => emit(GetFilesManagementErrorState(message: error.errMessage)),
      (model) => emit(GetFilesManagementSuccState(files: model)),
    );
  }

  Future<void> getFileContent({required String fileId}) async {
    emit(GetFileContentLoadingState());
    final result = await sl<GetFileContentUseCase>()(
      GetFileContentUseCaseParams(fileId: fileId),
    );

    result.fold(
      (error) => emit(GetFileContentErrorState(message: error.errMessage)),
      (dataUri) => emit(GetFileContentSuccState(dataUri: dataUri)),
    );
  }
}
