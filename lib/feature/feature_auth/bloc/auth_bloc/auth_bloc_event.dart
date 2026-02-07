import 'package:equatable/equatable.dart';

///
/// EVENTS
///
abstract class AuthBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthBlocEventLoadUser extends AuthBlocEvent {}

class AuthBlocEventRegisterUser extends AuthBlocEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  AuthBlocEventRegisterUser({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [name, email, password, confirmPassword];
}

class AuthBlocEventLogOut extends AuthBlocEvent {}

class AuthBlocEventLogIn extends AuthBlocEvent {
  final String email;
  final String password;
  AuthBlocEventLogIn({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}
