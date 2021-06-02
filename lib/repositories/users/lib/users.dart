import 'package:users/providers/firestore_provider.dart';
import 'package:users/users_repository.dart';

import 'models/user.dart';

class UsersRepository {
  FirestoreProvider _provider = FirestoreProvider();

  Future<User> getUser(String id) async => await _provider.getUser(id);

  Future<void> addUser(User user) async => await _provider.addUser(user);

  Future<void> deleteUser(User user) async => await _provider.deleteUser(user);

  Future<void> updateUser(User user) async => await _provider.updateUser(user);

  Future<void> addToAnimesList(User user, AnimesList list) async =>
      await _provider.addToAnimesList(user, list);

  Future<void> removeFromAnimesList(User user, AnimesList list) async =>
      await _provider.removeFromAnimesList(user, list);

  Future<void> addFav(User user, Favorites fav) async =>
      await _provider.addFav(user, fav);

  Future<void> removeFav(User user, Favorites fav) async =>
      await _provider.removeFav(user, fav);
}
