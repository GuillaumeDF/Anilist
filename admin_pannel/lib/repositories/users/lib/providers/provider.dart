import 'package:users/models/user.dart';

class GetUserFailure implements Exception {}

class UpdateUserFailure implements Exception {}

class AddUserFailure implements Exception {}

class DeleteUserFailure implements Exception {}

abstract class AProvider {
  /// Returns the [User] based on the provided id.
  /// Throws a [GetUserFailure] if an exception occurs.
  Future<User> getUser(String id);

  /// Creates a new user with the provided [User].
  /// Throws a [AddUserFailure] if an exception occurs.
  Future<void> addUser(User user);

  /// Delete the provided [User].
  /// Throws a [DeleteUserFailure] if an exception occurs.
  Future<void> deleteUser(User user);

  /// Updates the provided [User].
  /// Throws a [UpdateUserFailure] if an exception occurs.
  Future<void> updateUser(User user);

  /// Updates the provided [User].
  /// Throws a [UpdateUserFailure] if an exception occurs.
  Future<void> setUserTextField(String id, String field, String value);

  /// Updates the provided [User].
  /// Throws a [UpdateUserFailure] if an exception occurs.
  Future<String> getUserTextField(String id, String field);
}
