import 'package:admin_pannel/models/authentication/authentication_repository.dart';
import 'package:admin_pannel/models/user/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(Uninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    yield Uninitialized();
    final isSignedIn = _authenticationRepository.isSignedIn();
    if (isSignedIn) {
      yield* _mapLoggedInToState();
    } else {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _authenticationRepository.logOut();
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    final user = _authenticationRepository.getUser();

    if (user != null) {
      yield (await user.getAdmin()) == true
          ? Authenticated(
              user.copyWith(),
            )
          : Unauthenticated();
    } else
      yield Unauthenticated();
  }
}
