part of 'auth_cubit.dart';

@immutable
sealed class AuthState extends Equatable {}

final class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class SocialLoginLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class SocialLoginSuccessState extends AuthState {
  final LoginResponseModel data;

  SocialLoginSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class SocialLoginFailureState extends AuthState {
  final String message;

  SocialLoginFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class LoginLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class LoginSuccessState extends AuthState {
  final LoginResponseModel data;

  LoginSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class LoginFailureState extends AuthState {
  final String message;

  LoginFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class LoginNotAllowedState extends AuthState {
  @override
  List<Object?> get props => [];
}

class RegisterLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class RegisterSuccessState extends AuthState {
  final RegisterModel data;

  RegisterSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class RegisterFailureState extends AuthState {
  final String message;

  RegisterFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class SendOtpLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class SendOtpSuccessState extends AuthState {
  final String message;

  SendOtpSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class SendOtpFailureState extends AuthState {
  final String message;

  SendOtpFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class ForgerPassWordLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class ForgerPassWordSuccessState extends AuthState {
  final String token;

  ForgerPassWordSuccessState(this.token);

  @override
  List<Object?> get props => [token];
}

class ForgerPassWordFailureState extends AuthState {
  final String message;

  ForgerPassWordFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class CheckOtpLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class CheckOtpSuccessState extends AuthState {
  final LoginResponseModel model;

  CheckOtpSuccessState(this.model);

  @override
  List<Object?> get props => [model];
}

class CheckOtpFailureState extends AuthState {
  final String message;

  CheckOtpFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class ConfirmForgerPassWordLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class ConfirmForgerPassWordSuccessState extends AuthState {
  final String token;

  ConfirmForgerPassWordSuccessState(this.token);

  @override
  List<Object?> get props => [token];
}

class ConfirmForgerPassWordFailureState extends AuthState {
  final String message;

  ConfirmForgerPassWordFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
