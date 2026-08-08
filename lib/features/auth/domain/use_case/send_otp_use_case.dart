import 'package:dartz/dartz.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';

import '../../../../core/usecase/usecase.dart';
import '../repo/auth_repo.dart';

class SendOtpUseCase implements UseCase<String, SendOtpUseCaseParams> {
  final AuthRepo repository;

  SendOtpUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(SendOtpUseCaseParams params) async {
    return await repository.sendOtp(params);
  }
}

class SendOtpUseCaseParams {
  String? phoneNumber;
  final String type;
  String? email;

  SendOtpUseCaseParams({this.phoneNumber, required this.type, this.email});

  Map<String, dynamic> toMap() {
    return {
      // "phoneNumber": phoneNumber,
      "type": 'Mail', "email": email,
    };
  }
}
