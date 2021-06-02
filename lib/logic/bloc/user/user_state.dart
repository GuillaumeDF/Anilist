part of 'user_bloc.dart';

class UserState extends Equatable {
  final User user;
  final UserStatus status;

  const UserState._({this.user, this.status = UserStatus.Initial});

  const UserState.initial() : this._();

  const UserState.loading() : this._(status: UserStatus.Loading);

  const UserState.success(User user)
      : this._(user: user, status: UserStatus.Success);

  const UserState.error() : this._(status: UserStatus.Error);

  const UserState.noUser() : this._(status: UserStatus.NoUser);

  @override
  List<Object> get props => [this.status, this.user];
}
