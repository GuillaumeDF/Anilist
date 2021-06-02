import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:users/models/user.dart';
import 'package:users/models/animes_list.dart';
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
  Future<void> addToAnimesList(User user, AnimesList list) async {
    try {
      return usersCollection.doc(user.id).update({
        "animesList": FieldValue.arrayUnion([list.toJson()])
      });
    } on Exception {
      throw AddToListFailure();
    }
  }

  @override
  Future<void> removeFromAnimesList(User user, AnimesList list) async {
    try {
      return usersCollection.doc(user.id).update({
        "animesList": FieldValue.arrayRemove([list.toJson()])
      });
    } on Exception {
      throw RemoveFromListFailure();
    }
  }

  @override
  Future<void> addFav(User user, Favorites fav) async {
    try {
      return usersCollection.doc(user.id).update({
        "favs": FieldValue.arrayUnion([fav.toJson()])
      });
    } on Exception {
      throw AddFavFailure();
    }
  }

  @override
  Future<void> removeFav(User user, Favorites fav) async {
    try {
      return usersCollection.doc(user.id).update({
        "favs": FieldValue.arrayRemove([fav.toJson()])
      });
    } on Exception {
      throw RemoveFavFailure();
    }
  }
}
