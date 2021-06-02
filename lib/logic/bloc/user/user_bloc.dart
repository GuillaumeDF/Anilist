import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:users/users_repository.dart';

import 'package:ani_list/logic/bloc/bloc.dart';
import 'package:ani_list/constants/constants.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UsersRepository _usersRepository;
  final AuthenticationBloc _authBloc;
  StreamSubscription _authSubscription;

  UserBloc(
      {@required UsersRepository usersRepository,
      @required AuthenticationBloc authBloc})
      : assert(usersRepository != null),
        _usersRepository = usersRepository,
        _authBloc = authBloc,
        super(UserState.initial()) {
    _authSubscription = _authBloc.stream.listen((state) {
      if (state.status == AuthenticationStatus.Authenticated) {
        add(GetUser(state.user.id));
      }
    });
  }

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    yield UserState.loading();
    if (event is GetUser) {
      yield* _mapGetToState(event.id);
    } else if (event is AddUser) {
      yield* _mapAddToState(event.user);
    } else if (event is UpdateUser) {
      yield* _mapUpdateToState(event.updatedUser);
    } else if (event is DeleteUser) {
      yield* _mapDeleteToState(event.user);
    }
  }

  Stream<UserState> _mapGetToState(String id) async* {
    try {
      var userInDb = await _usersRepository.getUser(id);
      if (userInDb == null) {
        yield UserState.noUser();
      } else {
        yield UserState.success(userInDb);
      }
    } on Exception {
      yield UserState.error();
    }
  }

  Stream<UserState> _mapAddToState(User user) async* {
    try {
      await _usersRepository.addUser(user);
      yield UserState.success(user);
    } on Exception {
      yield UserState.error();
    }
  }

  Stream<UserState> _mapUpdateToState(User user) async* {
    try {
      await _usersRepository.updateUser(user);
      yield UserState.success(user);
    } on Exception {
      yield UserState.error();
    }
  }

  Stream<UserState> _mapDeleteToState(User user) async* {
    try {
      await _usersRepository.deleteUser(user);
      yield UserState.success(user);
    } on Exception {
      yield UserState.error();
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
