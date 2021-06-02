import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'animes_list.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String photo;
  final String bio;
  final bool admin;

  final List<Favorites> favs;
  final List<AnimesList> animesList;

  const User(this.id, this.email, this.name, this.photo, this.bio, this.favs,
      this.animesList, this.admin);
  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        email = data['email'],
        photo = data['photo'],
        bio = data['bio'],
        admin = data['admin'],
        favs = List<Favorites>.from(
            data['favs'].map((x) => Favorites.fromData(x))),
        animesList = List<AnimesList>.from(
            data['animesList'].map((x) => AnimesList.fromData(x)));

  Map<String, Object> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photo': photo,
      'bio': bio,
      'admin': admin,
      'favs': favs,
      'animesList': animesList,
    };
  }

  static User fromJson(Map<String, Object> json) {
    return User(
      json['id'] as String,
      json['name'] as String,
      json['email'] as String,
      json['photo'] as String,
      json['bio'] as String,
      json['favs'] as List<Favorites>,
      json['animesList'] as List<AnimesList>,
      json['admin'] as bool,
    );
  }

  static User fromSnapshot(DocumentSnapshot snap) {
    return User(
      snap.id,
      snap.data()['name'],
      snap.data()['email'],
      snap.data()['photo'],
      snap.data()['bio'],
      snap.data()['admin'],
      snap.data()['favs'],
      snap.data()['animesList'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photo': photo,
      'bio': bio,
      'admin': admin,
      'favs': favs,
      'animesList': animesList,
    };
  }

  List<Object> get props => [
        this.id,
        this.email,
        this.name,
        this.photo,
        this.bio,
        this.favs,
        this.animesList,
        this.admin,
      ];
}

class Favorites {
  String id;
  String imageUrl;
  String title;
  String score;

  Favorites({this.id, this.imageUrl, this.title, this.score});

  factory Favorites.fromData(Map<String, dynamic> data) => Favorites(
        id: data['id'],
        imageUrl: data['imageUrl'],
        title: data['title'],
        score: data['score'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'imageUrl': imageUrl,
        'title': title,
        'score': score,
      };
}
