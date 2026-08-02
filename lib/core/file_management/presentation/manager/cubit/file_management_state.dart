part of 'file_management_cubit.dart';

@immutable
sealed class FileManagementState extends Equatable {}

final class FileManagementInitial extends FileManagementState {
  @override
  List<Object?> get props => [];
}

final class GetFilesManagementLoadingState extends FileManagementState {
  @override
  List<Object?> get props => [];
}

final class GetFilesManagementSuccState extends FileManagementState {
  final List<FileDescriptorModel> files;

  GetFilesManagementSuccState({required this.files});

  @override
  List<Object?> get props => [files];
}

final class GetFilesManagementErrorState extends FileManagementState {
  final String message;

  GetFilesManagementErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

final class GetFileContentLoadingState extends FileManagementState {
  @override
  List<Object?> get props => [];
}

final class GetFileContentSuccState extends FileManagementState {
  final String dataUri;

  GetFileContentSuccState({required this.dataUri});

  @override
  List<Object?> get props => [dataUri];
}

final class GetFileContentErrorState extends FileManagementState {
  final String message;

  GetFileContentErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
