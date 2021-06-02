import 'dart:async';

import 'package:admin_pannel/constants/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users/users_repository.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  UserDataBloc(this.usersRepository)
      : assert(usersRepository != null),
        super(UserDataInitial());

  final UsersRepository usersRepository;

  @override
  Stream<UserDataState> mapEventToState(
    UserDataEvent event,
  ) async* {
    if (event is PanelPageStarted) yield* _mapPanelPageStartedToState();
  }

  Stream<UserDataState> _mapPanelPageStartedToState() async* {
    List<User> users = [];

    yield FetchingUsers();
    for (var uid in uidUser) users.add(await usersRepository.getUser(uid));
    yield UsersLoaded(users);
  }
}
