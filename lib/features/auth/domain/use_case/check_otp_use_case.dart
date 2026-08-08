import 'package:dartz/dartz.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';
import 'package:isnad_worker/features/auth/data/model/login_model/login_response_model.dart';

import '../../../../core/usecase/usecase.dart';
import '../repo/auth_repo.dart';

class CheckOtpUseCase
    implements UseCase<LoginResponseModel, CheckOtpUseCaseParams> {
  final AuthRepo repository;

  CheckOtpUseCase({required this.repository});

  @override
  Future<Either<Failure, LoginResponseModel>> call(
    CheckOtpUseCaseParams params,
  ) async {
    return await repository.checkOtp(params);
  }
}

class CheckOtpUseCaseParams {
  final String key;
  final String code;

  CheckOtpUseCaseParams({required this.code, required this.key});

  Map<String, dynamic> toMap() {
    return {"key": key, "code": code};
  }
}
