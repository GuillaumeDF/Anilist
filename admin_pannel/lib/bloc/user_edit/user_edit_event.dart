part of 'user_edit_bloc.dart';

abstract class UserEditEvent extends Equatable {
  const UserEditEvent();

  @override
  List<Object> get props => [];
}

class InitiatField extends UserEditEvent {
  const InitiatField(this.field);

  final String field;

  @override
  List<Object> get props => [field];
}

class SetTextValue extends UserEditEvent {
  const SetTextValue(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

/*class NewSettingProfileInitial extends SettingsEvent {
  const NewSettingProfileInitial(this.field);

  final String field;

  @override
  List<Object> get props => [field];
}

class ChangeSettingWidget extends SettingsEvent {
  const ChangeSettingWidget(this.newValue);

  final bool newValue;

  @override
  List<Object> get props => [newValue];
}

class ChangeSettingProfile extends SettingsEvent {
  const ChangeSettingProfile(this.newValue);

  final String newValue;

  @override
  List<Object> get props => [newValue];
}*/
