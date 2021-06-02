import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserRepository extends Equatable {
  const UserRepository({
    @required this.email,
    @required this.id,
    @required this.name,
    @required this.photo,
  })  : assert(email != null),
        assert(id != null);

  final String email;
  final String id;
  final String name;
  final String photo;
  static const empty =
      UserRepository(email: '', id: '', name: null, photo: null);
  static final _databaseReference = FirebaseFirestore.instance;

  @override
  List<Object> get props => [email, id, name, photo];

  UserRepository copyWith() {
    return UserRepository(
        email: email ?? "No email",
        id: id ?? "No id",
        name: name ?? "No name",
        photo: photo ?? "No photo");
  }

  Future<DocumentSnapshot> getSettings() async {
    final settingsWidget =
        _databaseReference.collection('users').doc(this.id).get();
    return (settingsWidget);
  }

  Future<bool> getAdmin() async {
    try {
      bool admin = (await this.getSettings())['admin'];
      return admin;
    } catch (_) {
      return false;
    }
  }
}
