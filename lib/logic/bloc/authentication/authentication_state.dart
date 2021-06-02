part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final User user;

  const AuthenticationState._({
    this.status = AuthenticationStatus.Unknown,
    this.user = User.empty,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.Authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.Unauthenticated);

  const AuthenticationState.success()
      : this._(status: AuthenticationStatus.Success);

  const AuthenticationState.error()
      : this._(status: AuthenticationStatus.Error);

  @override
  List<Object> get props => [this.status, this.user];
}
