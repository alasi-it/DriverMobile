import 'package:dartz/dartz.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';
import 'package:isnad_worker/features/auth/data/model/login_model/login_response_model.dart';

import '../../../../core/usecase/usecase.dart';
import '../repo/auth_repo.dart';

class LoginSocialUseCase implements UseCase<LoginResponseModel, NoParams> {
  final AuthRepo repository;

  LoginSocialUseCase({required this.repository});

  @override
  Future<Either<Failure, LoginResponseModel>> call(NoParams params) async {
    return await repository.loginSocial();
  }
}

class LoginSocialUseCaseParams {
  final String? idToken;

  LoginSocialUseCaseParams({this.idToken});

  Map<String, dynamic> toMap() {
    if (idToken == null) {
      throw Exception("idToken is null");
    }
    return {'idToken': idToken};
  }
}
