part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}


class DisplayPasswordLogin extends AuthState {
  final bool value;

  const DisplayPasswordLogin({required this.value});

  @override
  List<Object> get props => [value];
}


class DisplayNewPassword extends AuthState {
  final bool value;

  const DisplayNewPassword({required this.value});

  @override
  List<Object> get props => [value];
}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final LoginEntity loginEntity;
  const LoginSuccess({required this.loginEntity});
  @override
  List<Object> get props => [loginEntity];
}

class LoginError extends AuthState {
  final String message;
  const LoginError({required this.message});
  @override
  List<Object> get props => [message];
}

//* sign up
class SignUpLoading extends AuthState {}

class SignUpSuccess extends AuthState {
  final UserEntity userEntity;
  const SignUpSuccess({required this.userEntity});
  @override
  List<Object> get props => [userEntity];
}

class SignUpError extends AuthState {
  final String message;
  const SignUpError({required this.message});
  @override
  List<Object> get props => [message];
}

//*log out
class LogOutLoading extends AuthState {}

class LogOutSuccess extends AuthState {}

class LogOutError extends AuthState {}
