abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure({required this.message});
}

class LogoutSuccess extends LoginState {}

class LogoutFailure extends LoginState {
  final String message;

  LogoutFailure(this.message);
}
