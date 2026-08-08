import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:isnad_worker/core/file_management/domain/use_case/download_file_use_case.dart';
import 'package:isnad_worker/core/file_management/domain/use_case/get_file_content_use_case.dart';
import 'package:isnad_worker/core/file_management/domain/use_case/get_files_use_case.dart';
import 'package:isnad_worker/core/file_management/domain/use_case/upload_file_use_case.dart';
import 'package:isnad_worker/core/network/local/network_info.dart';
import 'package:isnad_worker/core/network/remote/apis/dio_helper.dart';
import 'package:isnad_worker/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:isnad_worker/features/auth/data/repo/auth_repo_imp.dart';
import 'package:isnad_worker/features/auth/domain/repo/auth_repo.dart';
import 'package:isnad_worker/features/auth/domain/use_case/check_otp_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/confirm_forget_password_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/create_account_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/forget_password_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/login_social_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/login_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/send_otp_use_case.dart';

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
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(networkManager: sl()),
    );
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
    //repo
    sl.registerLazySingleton<AuthRepo>(
      () => AuthRepoImp(
        authRemoteDataSource: sl(),
        networkInfo: sl(),
        socialAuthService: sl(),
      ),
    );

    // Auth use cases
    sl.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(repository: sl()),
    );
    sl.registerLazySingleton<LoginSocialUseCase>(
      () => LoginSocialUseCase(repository: sl()),
    );
    sl.registerLazySingleton<CreateAccountUseCase>(
      () => CreateAccountUseCase(repository: sl()),
    );
    sl.registerLazySingleton<SendOtpUseCase>(
      () => SendOtpUseCase(repository: sl()),
    );
    sl.registerLazySingleton<CheckOtpUseCase>(
      () => CheckOtpUseCase(repository: sl()),
    );
    sl.registerLazySingleton<ForgetPasswordUseCase>(
      () => ForgetPasswordUseCase(repository: sl()),
    );
    sl.registerLazySingleton<ConfirmForgetPasswordUseCase>(
      () => ConfirmForgetPasswordUseCase(repository: sl()),
    );
  }
}
