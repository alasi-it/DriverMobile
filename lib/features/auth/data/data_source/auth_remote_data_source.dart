import 'package:isnad_worker/core/network/errors/exception.dart';
import 'package:isnad_worker/core/network/remote/apis/dio_helper.dart';
import 'package:isnad_worker/core/network/remote/apis/hanlders/remote_data_source_handler.dart';
import 'package:isnad_worker/core/network/remote/end_points.dart';
import 'package:isnad_worker/features/auth/data/model/login_model/login_response_model.dart';
import 'package:isnad_worker/features/auth/data/model/register_model/register_model.dart';
import 'package:isnad_worker/features/auth/domain/use_case/check_otp_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/confirm_forget_password_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/create_account_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/forget_password_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/login_social_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/login_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/send_otp_use_case.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> loginSocial(LoginSocialUseCaseParams params);
  Future<LoginResponseModel> login(LoginUseCaseParams params);
  Future<RegisterModel> createNewAccount(CreateAccountUseCaseParams params);
  Future<LoginResponseModel> checkOtp(CheckOtpUseCaseParams params);
  Future<String> sendOtp(SendOtpUseCaseParams params);
  Future<String> forgetPassword(ForgetPasswordUseCaseParams params);
  Future<String> confirmForgotPassword(
    ConfirmForgetPasswordUseCaseParams params,
  );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioHelper networkManager;

  AuthRemoteDataSourceImpl({required this.networkManager});

  @override
  Future<LoginResponseModel> loginSocial(
    LoginSocialUseCaseParams params,
  ) async {
    final data = await RemoteDataSourceCallHandler().call<LoginResponseModel>(
      () => networkManager.post(url: SOCIAL_LOGIN_URL, data: params.toMap()),
      (json) => LoginResponseModel.fromMap(json),
    );

    return data.data ?? (throw ServerException('Empty response'));
  }

  @override
  Future<LoginResponseModel> login(LoginUseCaseParams params) async {
    final data = await RemoteDataSourceCallHandler().call<LoginResponseModel>(
      () => networkManager.post(url: LOGIN_URL, data: params.toMap()),
      (json) => LoginResponseModel.fromMap(json),
    );

    return data.data ?? (throw ServerException('Empty response'));
  }

  @override
  Future<RegisterModel> createNewAccount(
    CreateAccountUseCaseParams params,
  ) async {
    final data = await RemoteDataSourceCallHandler().call<RegisterModel>(
      () => networkManager.post(url: REGISTER_URL, data: params.toMap()),
      (json) => RegisterModel.fromJson(json),
    );

    return data.data ?? (throw ServerException('Empty response'));
  }

  @override
  Future<String> sendOtp(SendOtpUseCaseParams params) async {
    final data = await RemoteDataSourceCallHandler().call<String>(
      () => networkManager.post(url: SEND_OTP_URL, data: params.toMap()),
      (json) => json['message'] as String,
    );

    return data.data ?? (throw ServerException('Empty response'));
  }

  @override
  Future<String> forgetPassword(ForgetPasswordUseCaseParams params) async {
    final data = await RemoteDataSourceCallHandler().call<String>(
      () => networkManager.get(url: FORGET_PASSWORD_URL, query: params.toMap()),
      (json) => json['message'] ?? '',
    );

    return 'Otp Sended' ?? (throw ServerException('Empty response'));
  }

  @override
  Future<LoginResponseModel> checkOtp(CheckOtpUseCaseParams params) async {
    final data = await RemoteDataSourceCallHandler().call<LoginResponseModel>(
      () => networkManager.post(url: CHECK_OTP_URL, data: params.toMap()),
      (json) => LoginResponseModel.fromMap(json),
    );

    return data.data ?? (throw ServerException('Empty response'));
  }

  @override
  Future<String> confirmForgotPassword(
    ConfirmForgetPasswordUseCaseParams params,
  ) async {
    final data = await RemoteDataSourceCallHandler().call<String>(
      () => networkManager.post(
        url: CONFIRM_FORGET_PASSWORD,
        data: params.toMap(),
      ),
      (json) => json['message'] ?? '',
    );

    return 'success' ?? (throw ServerException('Empty response'));
  }
}
