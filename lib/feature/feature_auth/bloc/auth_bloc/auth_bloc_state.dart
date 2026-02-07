import 'package:dyd_drawer/core/exception/app_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

///
/// STATE
///
abstract class AuthBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthBlocStateInitial extends AuthBlocState {}

class AuthBlocStateLoading extends AuthBlocState {}

class AuthBlocStateAuthenticated extends AuthBlocState {
  final User user;
  AuthBlocStateAuthenticated({required this.user});
  @override
  List<Object?> get props => [user];
}

class AuthBlocStateUnAuthenticated extends AuthBlocState {}

class AuthBlocStateFailure extends AuthBlocState {
  final AppException error;
  AuthBlocStateFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
