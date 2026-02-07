/*
  AUTH BLOC - control auth flow logic
 */

export 'package:dyd_drawer/feature/feature_auth/bloc/auth_bloc/auth_bloc_event.dart';
export 'package:dyd_drawer/feature/feature_auth/bloc/auth_bloc/auth_bloc_state.dart';
import 'package:dyd_drawer/core/exception/app_exception.dart';
import 'package:dyd_drawer/feature/feature_auth/bloc/auth_bloc/auth_bloc_event.dart';
import 'package:dyd_drawer/feature/feature_auth/bloc/auth_bloc/auth_bloc_state.dart';
import 'package:dyd_drawer/feature/feature_auth/domain/auth_repo.dart';
import 'package:dyd_drawer/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      super(AuthBlocStateInitial()) {
    // LOAD USER
    on<AuthBlocEventLoadUser>((event, emit) async {
      logger.d('LOAD USER');
      try {
        //1) get currentUser
        final currentUser = await _authRepo.getCurrentUser();

        //2) if currentUser != null , emit (AuthBlocState_authenticated) , else emit (AuthBlocState_unAuthenticated)
        if (currentUser != null) {
          logger.i('Current User : ${currentUser.toString()}');
          emit(AuthBlocStateAuthenticated(user: currentUser));
        } else {
          logger.i('UnAuthenticated state');
          emit(AuthBlocStateUnAuthenticated());
        }
      } catch (e) {
        logger.e(e);
        // 1) emit error
        emit(AuthBlocStateFailure(error: e as AppException));

        // 2) emit AuthBlocState_unAuthenticated
        emit(AuthBlocStateUnAuthenticated());
      }
    });

    /// REGISTER USER
    on<AuthBlocEventRegisterUser>((event, emit) async {
      try {
        logger.i('AuthBlocEvent_registerUser with email : ${event.email}');
        emit(AuthBlocStateLoading());

        // check input data
        if (event.name.isEmpty ||
            event.email.isEmpty ||
            event.password.isEmpty ||
            event.confirmPassword.isEmpty) {
          throw AppException.failedToCreateNewUser;
        }

        if (event.email.isEmpty) {
          throw AppException.invalidEmail;
        }

        if (event.password != event.confirmPassword) {
          throw AppException.passwordsDoNotMatch;
        }
        if (event.name.isEmpty) {
          throw AppException.failedToUpdateUserName;
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
        emit(AuthBlocStateFailure(error: e as AppException));
      } finally {
        // reload user after registration
        add(AuthBlocEventLoadUser());
      }
    });

    /// LOG OUT USER
    on<AuthBlocEventLogOut>((event, emit) async {
      try {
        await _authRepo.logOut();
      } catch (e) {
        logger.e(e);
        emit(AuthBlocStateFailure(error: e as AppException));
      } finally {
        // reload user after log out
        add(AuthBlocEventLoadUser());
      }
    });

    /// LOG IN USER
    on<AuthBlocEventLogIn>((event, emit) async {
      try {
        logger.i('AuthBlocEvent_logIn with email : ${event.email}');
        emit(AuthBlocStateLoading());

        await _authRepo.signInWithEmailPassword(
          email: event.email,
          password: event.password,
        );
      } catch (e) {
        logger.e(e);
        emit(AuthBlocStateFailure(error: e as AppException));
      } finally {
        // reload user after log in
        add(AuthBlocEventLoadUser());
      }
    });
  }
}
