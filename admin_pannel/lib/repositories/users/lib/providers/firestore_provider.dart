import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:users/models/user.dart';
import 'package:users/providers/provider.dart';

class FirestoreProvider extends AProvider {
  final usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<User> getUser(String id) async {
    try {
      var userData = await usersCollection.doc(id).get();
      if (userData.exists == true) {
        return User.fromData(userData.data());
      } else {
        return null;
      }
    } on Exception {
      throw GetUserFailure();
    }
  }

  @override
  Future<void> addUser(User user) async {
    try {
      return usersCollection.doc(user.id).set(user.toDocument());
    } on Exception {
      throw AddUserFailure();
    }
  }

  @override
  Future<void> deleteUser(User user) async {
    try {
      return usersCollection.doc(user.id).delete();
    } on Exception {
      throw DeleteUserFailure();
    }
  }

  @override
  Future<void> updateUser(User user) async {
    try {
      return usersCollection.doc(user.id).set(user.toDocument());
    } on Exception {
      throw UpdateUserFailure();
    }
  }

  @override
  Future<void> setUserTextField(String id, String field, String value) async {
    try {
      return usersCollection.doc(id).update({field: value});
    } on Exception {
      throw UpdateUserFailure();
    }
  }

  @override
  Future<String> getUserTextField(String id, String field) async {
    try {
      return (await usersCollection.doc(id).get())[field];
    } on Exception {
      throw UpdateUserFailure();
    }
  }
}
