import 'package:dartz/dartz.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';
import 'package:isnad_worker/features/auth/data/model/login_model/login_response_model.dart';
import 'package:isnad_worker/features/auth/data/model/register_model/register_model.dart';
import 'package:isnad_worker/features/auth/domain/use_case/check_otp_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/confirm_forget_password_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/create_account_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/forget_password_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/login_use_case.dart';
import 'package:isnad_worker/features/auth/domain/use_case/send_otp_use_case.dart';

abstract class AuthRepo {
  Future<Either<Failure, LoginResponseModel>> loginSocial();
  Future<Either<Failure, LoginResponseModel>> login(LoginUseCaseParams params);
  Future<Either<Failure, String>> sendOtp(SendOtpUseCaseParams params);
  Future<Either<Failure, LoginResponseModel>> checkOtp(
    CheckOtpUseCaseParams params,
  );

  Future<Either<Failure, RegisterModel>> createNewAccount(
    CreateAccountUseCaseParams params,
  );

  Future<Either<Failure, String>> forgetPassword(
    ForgetPasswordUseCaseParams params,
  );
  Future<Either<Failure, String>> confirmForgetPassword(
    ConfirmForgetPasswordUseCaseParams params,
  );
}
