// ignore_for_file: camel_case_types

/*
  AUTH BLOC - control auth flow logic
 */

import 'package:dyd_drawer/core/exception/app_exception.dart';
import 'package:dyd_drawer/feature/feature_auth/domain/auth_repo.dart';
import 'package:dyd_drawer/main.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// EVENTS
///
abstract class AuthBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthBlocEvent_loadUser extends AuthBlocEvent {}

///
/// STATE
///
abstract class AuthBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthBlocState_initial extends AuthBlocState {}

class AuthBlocState_loading extends AuthBlocState {}

class AuthBlocState_authenticated extends AuthBlocState {
  final User user;
  AuthBlocState_authenticated({required this.user});
  @override
  List<Object?> get props => [user];
}

class AuthBlocState_unAuthenticated extends AuthBlocState {}

class AuthBlocState_failure extends AuthBlocState {
  final AppException error;
  AuthBlocState_failure({required this.error});

  @override
  List<Object?> get props => [error];
}

// class AuthBlocState_success extends AuthBlocState {
//   final AppException success;
// }

///
/// BLOC
///
class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final AuthRepo _authRepo;

  AuthBloc({required AuthRepo authRepo})
    : _authRepo = authRepo,
      super(AuthBlocState_initial()) {



    // LOAD USER
    on<AuthBlocEvent_loadUser>((event, emit) async {
      logger.d('LOAD USER');
      try {
        //1) get currentUser
        final currentUser = await _authRepo.getCurrentUser();

        //2) if currentUser != null , emit (AuthBlocState_authenticated) , else emit (AuthBlocState_unAuthenticated)
        if (currentUser != null) {
          logger.i('Current User : ${currentUser.email}');
          emit(AuthBlocState_authenticated(user: currentUser));
        } else {
          logger.i('UnAuthenticated state');
          emit(AuthBlocState_unAuthenticated());
        }
      } catch (e) {
        logger.e(e);
        // 1) emit error
        emit(AuthBlocState_failure(error: e as AppException));

        // 2) emit AuthBlocState_unAuthenticated
        emit(AuthBlocState_unAuthenticated());
      }
    });


    
  }
}
