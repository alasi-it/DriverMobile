import 'package:dartz/dartz.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';

import '../../../../core/usecase/usecase.dart';
import '../repo/auth_repo.dart';

class ConfirmForgetPasswordUseCase
    implements UseCase<String, ConfirmForgetPasswordUseCaseParams> {
  final AuthRepo repository;

  ConfirmForgetPasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(
    ConfirmForgetPasswordUseCaseParams params,
  ) async {
    return await repository.confirmForgetPassword(params);
  }
}

class ConfirmForgetPasswordUseCaseParams {
  final String email;
  final String token;
  final String? password;

  ConfirmForgetPasswordUseCaseParams({
    required this.email,
    required this.token,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {'email': email, "token": token, "password": (password ?? "String")};
  }
}
