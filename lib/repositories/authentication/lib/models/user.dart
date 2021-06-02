import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String photo;

  const User({
    @required this.id,
    @required this.email,
    @required this.name,
    @required this.photo,
  })  : assert(id != null),
        assert(email != null);

  static const empty = User(id: '', email: '', name: null, photo: null);

  @override
  List<Object> get props => [id, email, name, photo];
}
