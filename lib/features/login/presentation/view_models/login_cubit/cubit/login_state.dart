part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginWithEmailAndPasswordLoading extends LoginState {}
class LoginWithGoogleLoading extends LoginState {}
class LoginSuccess extends LoginState {}
class LoginError extends LoginState {
  final String error;

  LoginError(this.error);
}

class LoginChangeSuffix extends LoginState{}

