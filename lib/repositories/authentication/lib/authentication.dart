import 'dart:async';

import 'package:meta/meta.dart';

import 'models/user.dart';
import 'providers/provider.dart';
import 'providers/firebase_provider.dart';

class AuthenticationRepository<T extends AProvider> {
  FirebaseProvider _provider = FirebaseProvider();

  Stream<User> get user => _provider.user;

  Future<void> signUp({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    await _provider.signUp(email: email, password: password);
  }

  Future<void> logInWithGoogle() async => await _provider.logInWithGoogle();

  Future<void> logInWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    await _provider.logInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> changeEmail({@required String email}) async =>
      await _provider.changeEmail(email: email);

  Future<void> changePassword({@required String password}) async =>
      await _provider.changePassword(password: password);

  Future<void> logOut() async => await _provider.logOut();
}
