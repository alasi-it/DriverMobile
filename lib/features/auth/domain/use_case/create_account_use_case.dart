import 'package:dartz/dartz.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';
import 'package:isnad_worker/features/auth/data/model/register_model/register_model.dart';

import '../../../../core/usecase/usecase.dart';
import '../repo/auth_repo.dart';

class CreateAccountUseCase
    implements UseCase<RegisterModel, CreateAccountUseCaseParams> {
  final AuthRepo repository;

  CreateAccountUseCase({required this.repository});

  @override
  Future<Either<Failure, RegisterModel>> call(
    CreateAccountUseCaseParams params,
  ) async {
    return await repository.createNewAccount(params);
  }
}

class CreateAccountUseCaseParams {
  final String fullName;
  final String password;
  final String phoneNumber;
  final String? deviceId;
  final String? nationalId;
  final String email;
  final int? gender;

  CreateAccountUseCaseParams({
    required this.fullName,
    required this.password,
    this.deviceId,
    this.nationalId,
    required this.phoneNumber,
    required this.email,
    this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'nameAr': fullName,
      'password': password,
      'phoneNumber': phoneNumber,
      if (deviceId != null) 'deviceId': deviceId,
      'email': email,
      'userName': email.contains('@')
          ? (email.split('@').first.length > 18
                ? email.split('@').first.substring(0, 18)
                : email.split('@').first)
          : (email.length > 18 ? email.substring(0, 18) : email),
      if (gender != null) 'gender': gender == 0 ? 'male' : 'female',
      "identityType": "nationalID",
      "identityNumber": nationalId,
    };
  }
}

// {
//   "userName": "sayedsiu",
//   "password": "1234554321@",
//   "email": "mohamed11@mail.com",
//   "nameAr": "mohamed Fouad",
//   "nameEn": "string",
//   "phoneNumber": "201061696046",
//   "dateOfBirth": "2026-04-16T08:23:29.651Z",
//   "gender": "male",
//   "identityType": "nationalID",
//   "identityNumber": "123123213123"
// }
