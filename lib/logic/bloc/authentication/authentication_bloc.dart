import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:pedantic/pedantic.dart';

import 'package:ani_list/constants/constants.dart';
import 'package:authentication/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<User> _userSubscription;

  AuthenticationBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AuthenticationUserChanged(user)),
    );
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationUserChanged) {
      yield event.user != User.empty
          ? AuthenticationState.authenticated(event.user)
          : const AuthenticationState.unauthenticated();
    } else if (event is AuthenticationLogoutRequested) {
      unawaited(_authenticationRepository.logOut());
    } else if (event is AuthenticationChangeEmailRequested) {
      try {
        await _authenticationRepository.changeEmail(email: event.email);
        yield AuthenticationState.success();
      } on Exception {
        yield AuthenticationState.error();
      }
    } else if (event is AuthenticationChangePasswordRequested) {
      try {
        await _authenticationRepository.changePassword(
            password: event.password);
        yield AuthenticationState.success();
      } on Exception {
        yield AuthenticationState.error();
      }
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
