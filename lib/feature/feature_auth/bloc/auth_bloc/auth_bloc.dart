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

class AuthBlocEvent_registerUser extends AuthBlocEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  AuthBlocEvent_registerUser({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [name, email, password, confirmPassword];
}

class AuthBlocEvent_logOut extends AuthBlocEvent {}

class AuthBlocEvent_logIn extends AuthBlocEvent {
  final String email;
  final String password;
  AuthBlocEvent_logIn({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

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
          logger.i('Current User : ${currentUser.toString()}');
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

    /// REGISTER USER
    on<AuthBlocEvent_registerUser>((event, emit) async {
      try {
        logger.i('AuthBlocEvent_registerUser with email : ${event.email}');
        emit(AuthBlocState_loading());

         // check input data
         if (event.name.isEmpty || event.email.isEmpty || event.password.isEmpty || event.confirmPassword.isEmpty) {
          throw AppException.FAILED_TO_CREATE_NEW_USER;
        }

         if (event.email.isEmpty) {
          throw AppException.INVALID_EMAIL;
        }
       
        if (event.password != event.confirmPassword) {
          throw AppException.PASSWORDS_DO_NOT_MATCH;
        }
        if (event.name.isEmpty) {
          throw AppException.FAILED_TO_UPDATE_USER_NAME;
        }
       


        //1) register user with email , password
        await _authRepo.createNewUserWithEmailPassword(
          email: event.email,
          password: event.password,
        );

        //2) set user name
        await _authRepo.setUserName(name: event.name);


      } catch (e) {
        logger.e(e);
        emit(AuthBlocState_failure(error: e as AppException));
      } finally {
        // reload user after registration
        add(AuthBlocEvent_loadUser());
      }
    });

    /// LOG OUT USER
    on<AuthBlocEvent_logOut>((event, emit) async {
      try {
        await _authRepo.logOut();
      } catch (e) {
        logger.e(e);
        emit(AuthBlocState_failure(error: e as AppException));
      } finally {
        // reload user after log out
        add(AuthBlocEvent_loadUser());
      }
    });

    /// LOG IN USER
    on<AuthBlocEvent_logIn>((event, emit) async {
      try {
        logger.i('AuthBlocEvent_logIn with email : ${event.email}');
        emit(AuthBlocState_loading());

        await _authRepo.signInWithEmailPassword(
          email: event.email,
          password: event.password,
        );
      } catch (e) {
        logger.e(e);
        emit(AuthBlocState_failure(error: e as AppException));
      } finally {
        // reload user after log in
        add(AuthBlocEvent_loadUser());
      }
    });
  }
}
