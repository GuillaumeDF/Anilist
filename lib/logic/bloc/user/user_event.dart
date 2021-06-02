part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUser extends UserEvent {
  final String id;

  const GetUser(this.id);
  @override
  List<Object> get props => [this.id];
}

class AddUser extends UserEvent {
  final User user;

  const AddUser(this.user);

  @override
  List<Object> get props => [this.user];
}

class UpdateUser extends UserEvent {
  final User updatedUser;

  const UpdateUser(this.updatedUser);

  @override
  List<Object> get props => [this.updatedUser];
}

class DeleteUser extends UserEvent {
  final User user;

  const DeleteUser(this.user);

  @override
  List<Object> get props => [this.user];
}
