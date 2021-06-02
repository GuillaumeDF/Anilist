import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String photo;
  final String bio;
  final bool admin;

  const User(this.id, this.email, this.name, this.photo, this.bio, this.admin);

  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        email = data['email'],
        photo = data['photo'],
        bio = data['bio'],
        admin = data['admin'];

  Map<String, Object> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photo': photo,
      'bio': bio,
      'admin': admin,
    };
  }

  static User fromJson(Map<String, Object> json) {
    return User(
      json['id'] as String,
      json['name'] as String,
      json['email'] as String,
      json['photo'] as String,
      json['bio'] as String,
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
    };
  }

  List<Object> get props =>
      [this.id, this.email, this.name, this.photo, this.bio, this.admin];
}
