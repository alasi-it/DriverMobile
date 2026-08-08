import 'package:isnad_worker/features/auth/data/model/login_model/user_model.dart';

class LoginResponseModel {
  final String? token;
  final String? refreshToken;
  final DateTime? refreshTokenExpiration;
  final bool need2FA;
  final bool isLockout;
  final bool isNotAllowed;
  final UserModel? user;

  LoginResponseModel({
    this.token,
    this.refreshToken,
    this.refreshTokenExpiration,
    required this.need2FA,
    required this.isLockout,
    required this.isNotAllowed,
    this.user,
  });

  factory LoginResponseModel.fromMap(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'],
      refreshToken: json['refreshToken'],
      refreshTokenExpiration: json['refreshTokenExpiration'] != null
          ? DateTime.parse(json['refreshTokenExpiration'])
          : null,
      need2FA: json['need2FA'] ?? false,
      isLockout: json['isLockout'] ?? false,
      isNotAllowed: json['isNotAllowed'] ?? false,
      user: json['user'] != null ? UserModel.fromMap(json['user']) : null,
    );
  }
}
