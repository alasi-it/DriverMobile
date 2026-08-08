import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:isnad_worker/core/usecase/usecase.dart';
import 'package:isnad_worker/core/utils/service_locator/service_locator.dart';
import 'package:isnad_worker/features/auth/data/model/login_model/login_response_model.dart';
import 'package:isnad_worker/features/auth/data/model/register_model/register_model.dart';
import 'package:isnad_worker/features/auth/domain/use_case/check_otp_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/confirm_forget_password_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/create_account_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/forget_password_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/login_social_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/login_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/send_otp_use_case.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> loginSocial() async {
    emit(SocialLoginLoadingState());
    final result = await sl<LoginSocialUseCase>()(NoParams());

    result.fold(
      (error) {
        emit(SocialLoginFailureState(error.errMessage));
      },
      (model) {
        emit(SocialLoginSuccessState(model));
      },
    );
  }

  Future<void> createNewAccount({
    required String fullName,
    required String password,
    required String phone,
    required String email,
    String? deviceId,
    String? nationalId,
    int? gender,
  }) async {
    print('loading');
    emit(RegisterLoadingState());
    final result = await sl<CreateAccountUseCase>()(
      CreateAccountUseCaseParams(
        fullName: fullName,
        password: password,
        phoneNumber: phone,
        email: email,
        deviceId: deviceId,
        nationalId: nationalId,
        gender: gender,
      ),
    );

    result.fold(
      (error) {
        print('error is ${error.errMessage}');

        emit(RegisterFailureState(error.errMessage));
      },
      (model) {
        emit(RegisterSuccessState(model));
      },
    );
  }

  Future<void> login({
    required String phoneNumber,
    required String password,
    required String deviceId,
  }) async {
    emit(LoginLoadingState());
    final result = await sl<LoginUseCase>()(
      LoginUseCaseParams(
        phoneNumber: phoneNumber,
        password: password,
        deviceId: deviceId,
      ),
    );

    result.fold(
      (error) {
        emit(LoginFailureState(error.errMessage));
      },
      (model) {
        if (model.isNotAllowed) {
          emit(LoginNotAllowedState());
        } else {
          emit(LoginSuccessState(model));
        }
      },
    );
  }

  Future<void> sendOtp({
    required String phoneNumber,
    required String type,
    required String email,
  }) async {
    emit(SendOtpLoadingState());
    final result = await sl<SendOtpUseCase>()(
      SendOtpUseCaseParams(phoneNumber: phoneNumber, type: type, email: email),
    );

    result.fold(
      (error) {
        emit(SendOtpFailureState(error.errMessage));
      },
      (model) {
        emit(SendOtpSuccessState(model));
      },
    );
  }

  Future<void> checkOtp({required String code, required String key}) async {
    emit(CheckOtpLoadingState());
    final result = await sl<CheckOtpUseCase>()(
      CheckOtpUseCaseParams(code: code, key: key),
    );

    result.fold(
      (error) {
        emit(CheckOtpFailureState(error.errMessage));
      },
      (model) {
        emit(CheckOtpSuccessState(model));
      },
    );
  }

  Future<void> forgetPassword({required String email}) async {
    emit(ForgerPassWordLoadingState());
    final result = await sl<ForgetPasswordUseCase>()(
      ForgetPasswordUseCaseParams(email: email),
    );

    result.fold(
      (error) {
        emit(ForgerPassWordFailureState(error.errMessage));
      },
      (model) {
        emit(ForgerPassWordSuccessState(model));
      },
    );
  }

  Future<void> confirmForgetPassword({
    required String email,
    required String token,
    String? password,
  }) async {
    emit(ConfirmForgerPassWordLoadingState());
    final result = await sl<ConfirmForgetPasswordUseCase>()(
      ConfirmForgetPasswordUseCaseParams(
        email: email,
        token: token,
        password: password,
      ),
    );

    result.fold(
      (error) {
        emit(ConfirmForgerPassWordFailureState(error.errMessage));
      },
      (model) {
        emit(ConfirmForgerPassWordSuccessState(model));
      },
    );
  }
}
