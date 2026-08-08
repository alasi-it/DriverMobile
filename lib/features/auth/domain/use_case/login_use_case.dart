import 'package:dartz/dartz.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';
import 'package:isnad_worker/features/auth/data/model/login_model/login_response_model.dart';

import '../../../../core/usecase/usecase.dart';
import '../repo/auth_repo.dart';

class LoginUseCase implements UseCase<LoginResponseModel, LoginUseCaseParams> {
  final AuthRepo repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, LoginResponseModel>> call(
    LoginUseCaseParams params,
  ) async {
    return await repository.login(params);
  }
}

class LoginUseCaseParams {
  final String phoneNumber;
  final String password;
  final String deviceId;

  LoginUseCaseParams({
    required this.phoneNumber,
    required this.password,
    required this.deviceId,
  });

  Map<String, dynamic> toMap() {
    return {
      'userName': phoneNumber,
      'password': password,
      'deviceId': deviceId,
    };
  }
}
