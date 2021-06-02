part of 'user_edit_bloc.dart';

abstract class UserEditState extends Equatable {
  const UserEditState();

  @override
  List<Object> get props => [];
}

class UserEditInitial extends UserEditState {}

class NewValueSwitch extends UserEditState {
  final bool value;

  const NewValueSwitch(this.value);

  @override
  List<Object> get props => [value];
}

class NewValueTextField extends UserEditState {
  final String value;

  const NewValueTextField(this.value);

  @override
  List<Object> get props => [value];
}

class LoadingEdit extends UserEditState {}
