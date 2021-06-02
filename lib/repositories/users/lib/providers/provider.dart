import 'package:users/models/user.dart';
import 'package:users/models/animes_list.dart';

class GetUserFailure implements Exception {}

class UpdateUserFailure implements Exception {}

class AddUserFailure implements Exception {}

class DeleteUserFailure implements Exception {}

class AddToListFailure implements Exception {}

class RemoveFromListFailure implements Exception {}

class AddFavFailure implements Exception {}

class RemoveFavFailure implements Exception {}

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

  /// Add new anime for the [User] to his list
  /// Throws a [AddToListFailure] if an exception occurs.
  Future<void> addToAnimesList(User user, AnimesList list);

  /// Removes a given anime from the animes list for the [User]
  /// Throws a [RemoveFromListFailure] if an exception occurs.
  Future<void> removeFromAnimesList(User user, AnimesList list);

  /// Add new favorite anime for the [User]
  /// Throws a [AddFavFailure] if an exception occurs.
  Future<void> addFav(User user, Favorites fav);

  /// Removes a given anime from the favorites for the [User]
  /// Throws a [RemoveFavFailure] if an exception occurs.
  Future<void> removeFav(User user, Favorites fav);
}
