import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:isnad_worker/core/network/errors/exception.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';
import 'package:isnad_worker/core/network/local/network_info.dart';
import 'package:isnad_worker/core/network/remote/apis/hanlders/repo_impl_callhandler.dart';
import 'package:isnad_worker/core/services/social_auth_service.dart';
import 'package:isnad_worker/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:isnad_worker/features/auth/data/model/login_model/login_response_model.dart';
import 'package:isnad_worker/features/auth/data/model/register_model/register_model.dart';
import 'package:isnad_worker/features/auth/domain/repo/auth_repo.dart';
import 'package:isnad_worker/features/auth/domain/use_case/check_otp_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/confirm_forget_password_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/create_account_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/forget_password_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/login_social_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/login_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/send_otp_use_case.dart';

class AuthRepoImp implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;
  final SocialAuthService socialAuthService;

  AuthRepoImp({
    required this.authRemoteDataSource,
    required this.networkInfo,
    required this.socialAuthService,
  });

  @override
  Future<Either<Failure, LoginResponseModel>> loginSocial() async {
    return await RepoImplCallHandler<LoginResponseModel>(networkInfo)(() async {
      final token = await socialAuthService.loginWithGoogle();
      if (token == null || token.isEmpty) {
        throw ServerException('google_login_failed'.tr());
      }
      final paramsWithToken = LoginSocialUseCaseParams(idToken: token);

      return await authRemoteDataSource.loginSocial(paramsWithToken);
    });
  }

  @override
  Future<Either<Failure, LoginResponseModel>> login(
    LoginUseCaseParams params,
  ) async {
    return await RepoImplCallHandler<LoginResponseModel>(networkInfo)(() async {
      return await authRemoteDataSource.login(params);
    });
  }

  @override
  Future<Either<Failure, RegisterModel>> createNewAccount(
    CreateAccountUseCaseParams params,
  ) async {
    return await RepoImplCallHandler<RegisterModel>(networkInfo)(() async {
      return await authRemoteDataSource.createNewAccount(params);
    });
  }

  @override
  Future<Either<Failure, String>> sendOtp(SendOtpUseCaseParams params) async {
    return await RepoImplCallHandler<String>(networkInfo)(() async {
      return await authRemoteDataSource.sendOtp(params);
    });
  }

  @override
  Future<Either<Failure, String>> forgetPassword(
    ForgetPasswordUseCaseParams params,
  ) async {
    return await RepoImplCallHandler<String>(networkInfo)(() async {
      return await authRemoteDataSource.forgetPassword(params);
    });
  }

  @override
  Future<Either<Failure, LoginResponseModel>> checkOtp(
    CheckOtpUseCaseParams params,
  ) async {
    return await RepoImplCallHandler<LoginResponseModel>(networkInfo)(() async {
      return await authRemoteDataSource.checkOtp(params);
    });
  }

  @override
  Future<Either<Failure, String>> confirmForgetPassword(
    ConfirmForgetPasswordUseCaseParams params,
  ) async {
    return await RepoImplCallHandler<String>(networkInfo)(() async {
      return await authRemoteDataSource.confirmForgotPassword(params);
    });
  }
}
