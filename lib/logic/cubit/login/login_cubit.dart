import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:authentication/authentication.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginCubit(this._authenticationRepository)
      : assert(_authenticationRepository != null),
        super(LoginInitial());

  Future<void> logInWithCredentials(String email, String password) async {
    emit(LoginInProgress());
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on Exception {
      emit(LoginError());
    }
  }

  Future<void> logInWithGoogle() async {
    emit(LoginInProgress());
    try {
      await _authenticationRepository.logInWithGoogle();
      emit(LoginSuccess());
    } on Exception {
      emit(LoginError());
    }
  }
}
