import 'package:flutter/material.dart';

import 'package:authentication/models/user.dart';

class SignUpFailure implements Exception {}

class LogInWithEmailAndPasswordFailure implements Exception {}

class LogInWithGoogleFailure implements Exception {}

class LogOutFailure implements Exception {}

class ChangeEmailFailure implements Exception {}

class ChangePasswordFailure implements Exception {}

abstract class AProvider {
  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user;

  /// Creates a new user with the provided [email] and [password].
  /// Throws a [SignUpFailure] if an exception occurs.
  Future<void> signUp({@required String email, @required String password});

  /// Starts the Sign In with Google Flow.
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<void> logInWithGoogle();

  /// Signs in with the provided [email] and [password].
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword(
      {@required String email, @required String password});

  /// Changes user email with the provider new [email].
  /// Throws a [ChangeEmailFailure] if an exception occurs.
  Future<void> changeEmail({@required String email});

  /// Changes user email with the provider new [password].
  /// Throws a [ChangePasswordFailure] if an exception occurs.
  Future<void> changePassword({@required String password});

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut();
}
