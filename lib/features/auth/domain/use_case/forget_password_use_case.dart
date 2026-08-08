import 'package:dartz/dartz.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';

import '../../../../core/usecase/usecase.dart';
import '../repo/auth_repo.dart';

class ForgetPasswordUseCase
    implements UseCase<String, ForgetPasswordUseCaseParams> {
  final AuthRepo repository;

  ForgetPasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(
    ForgetPasswordUseCaseParams params,
  ) async {
    return await repository.forgetPassword(params);
  }
}

class ForgetPasswordUseCaseParams {
  final String email;

  ForgetPasswordUseCaseParams({required this.email});

  Map<String, dynamic> toMap() {
    return {'Email': email};
  }
}
