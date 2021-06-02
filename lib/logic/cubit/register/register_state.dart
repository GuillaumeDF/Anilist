part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  final String email;
  final String password;
  final String confirm;

  const RegisterState({this.email, this.password, this.confirm});

  @override
  List<Object> get props => [this.email, this.password, this.confirm];
}

class RegisterInitial extends RegisterState {}

class RegisterInProgress extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterError extends RegisterState {}