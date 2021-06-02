import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:authentication/authentication.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthenticationRepository _authenticationRepository;

  RegisterCubit(this._authenticationRepository)
      : assert(_authenticationRepository != null),
        super(RegisterInitial());

  Future<void> register(String email, String password, String confirm) async {
    emit(RegisterInProgress());
    // TODO Error handling
    if (password == confirm) {
      try {
        await _authenticationRepository.signUp(
          email: email,
          password: password,
        );
        emit(RegisterSuccess());
      } on Exception {
        emit(RegisterError());
      }
    }
  }
}
