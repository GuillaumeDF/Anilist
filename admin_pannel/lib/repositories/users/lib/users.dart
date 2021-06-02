import 'package:users/providers/firestore_provider.dart';

import 'models/user.dart';

class UsersRepository {
  FirestoreProvider _provider = FirestoreProvider();

  Future<User> getUser(String id) async => await _provider.getUser(id);

  Future<void> addUser(User user) async => await _provider.addUser(user);

  Future<void> deleteUser(User user) async => await _provider.deleteUser(user);

  Future<void> updateUser(User user) async => await _provider.updateUser(user);

  Future<void> setUserTextField(String id, String field, String value) async =>
      await _provider.setUserTextField(id, field, value);

  Future<String> getUserTextField(String id, String field) async =>
      await _provider.getUserTextField(id, field);
}
