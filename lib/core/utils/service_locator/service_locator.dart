import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:isnad_worker/core/file_management/domain/use_case/download_file_use_case.dart';
import 'package:isnad_worker/core/file_management/domain/use_case/get_file_content_use_case.dart';
import 'package:isnad_worker/core/file_management/domain/use_case/get_files_use_case.dart';
import 'package:isnad_worker/core/file_management/domain/use_case/upload_file_use_case.dart';
import 'package:isnad_worker/core/network/local/network_info.dart';
import 'package:isnad_worker/core/network/remote/apis/dio_helper.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    // Core / Network
    sl.registerLazySingleton<DioHelper>(() => DioHelper());
    sl.registerLazySingleton<Connectivity>(() => Connectivity());
    sl.registerLazySingleton<InternetConnection>(() => InternetConnection());

    // NetworkInfo
    sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(
        connectivity: sl<Connectivity>(),
        internetChecker: sl<InternetConnection>(),
      ),
    );

    // Data sources

    sl.registerLazySingleton<UploadFileUseCase>(
      () => UploadFileUseCase(repository: sl()),
    );
    sl.registerLazySingleton<GetFilesUseCase>(
      () => GetFilesUseCase(repository: sl()),
    );
    sl.registerLazySingleton<GetFileContentUseCase>(
      () => GetFileContentUseCase(repository: sl()),
    );
    sl.registerLazySingleton<DownloadFileUseCase>(
      () => DownloadFileUseCase(repository: sl()),
    );
  }
}
