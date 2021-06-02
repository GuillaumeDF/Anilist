part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  final String email;
  final String password;

  const LoginState({this.email, this.password});

  @override
  List<Object> get props => [this.email, this.password];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {}