import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users/users_repository.dart';

part 'user_edit_event.dart';
part 'user_edit_state.dart';

class UserEditBloc extends Bloc<UserEditEvent, UserEditState> {
  final UsersRepository usersRepository = UsersRepository();
  final User user;

  String _field;

  UserEditBloc({this.user}) : super(UserEditInitial());

  @override
  Stream<UserEditState> mapEventToState(
    UserEditEvent event,
  ) async* {
    print(event);
    if (event is InitiatField) yield* _mapInitiatFieldToState(event.field);
    if (event is SetTextValue) yield* _mapSetTextValueToState(event.value);
  }

  Stream<UserEditState> _mapInitiatFieldToState(String field) async* {
    yield LoadingEdit();
    this._field = field;
    yield NewValueTextField(
        await this.usersRepository.getUserTextField(user.id, field));
  }

  Stream<UserEditState> _mapSetTextValueToState(String value) async* {
    yield LoadingEdit();
    await this.usersRepository.setUserTextField(user.id, this._field, value);
    yield NewValueTextField(value);
  }

  /*Stream<SettingsState> _mapChangeSettingProfileToState(String value) async* {
    yield LoadingSetting();
    await this.user.setSettingsProfile(this._field, value);
    yield NewSettingProfile(
        (await this.user.getSettings())[this._field].toString());
  }

  Stream<SettingsState> _mapChangeSettingWidgetToState(bool value) async* {
    yield LoadingSetting();
    await this.user.setSettingsWidget(this._index, value);
    yield NewSettingWidget(
        (await this.user.getSettings())['settings'][this._index]);
  }*/
}
