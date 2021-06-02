part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationUserChanged extends AuthenticationEvent {
  final User user;

  const AuthenticationUserChanged(this.user);

  @override
  List<Object> get props => [this.user];
}

class AuthenticationChangeEmailRequested extends AuthenticationEvent {
  final String email;

  const AuthenticationChangeEmailRequested(this.email);

  @override
  List<Object> get props => [this.email];
}

class AuthenticationChangePasswordRequested extends AuthenticationEvent {
  final String password;

  const AuthenticationChangePasswordRequested(this.password);

  @override
  List<Object> get props => [this.password];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}