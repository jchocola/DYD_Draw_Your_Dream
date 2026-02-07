// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dyd_drawer/core/exception/app_exception.dart';
import 'package:dyd_drawer/feature/feature_auth/domain/auth_repo.dart';
import 'package:dyd_drawer/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepoImpl implements AuthRepo {
  final FirebaseAuth _auth;

  FirebaseAuthRepoImpl({required FirebaseAuth auth}) : _auth = auth;

  @override
  Future<UserCredential> createNewUserWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      logger.i('Create new user with ${email} ,${password}');

      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      logger.e(e.code);
      switch (e.code) {
        case 'email-already-in-use':
          throw AppException.emailAlreadyInUse;
        case 'invalid-email':
          throw AppException.invalidEmail;
        case 'operation-not-allowed':
          throw AppException.operationNotAllowed;
        case 'weak-password':
          throw AppException.weakPassword;
        case 'too-many-requests':
          throw AppException.tooManyRequests;
        case 'user-token-expired':
          throw AppException.userTokenExpired;
        case 'network-request-failed':
          throw AppException.networkRequestFailed;
        default:
          throw AppException.failedToCreateNewUser;
      }
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  @override
  Future<void> logOut() async {
    try {
      logger.i('Sign Out');
      await _auth.signOut();
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Future<UserCredential> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      logger.e(e);
      switch (e.code) {
        case 'invalid-email':
          throw AppException.invalidEmail;
        case 'user-disabled':
          throw AppException.userDisabled;
        case 'user-not-found':
          throw AppException.userNotFound;
        case 'wrong-password:':
          throw AppException.wrongPassword;
        case 'too-many-requests':
          throw AppException.tooManyRequests;
        case 'user-token-expired':
          throw AppException.userTokenExpired;
        case 'invalid-credential':
          throw AppException.invalidCredential;
        case 'network-request-failed':
          throw AppException.networkRequestFailed;
        case 'operation-not-allowed:':
          throw AppException.operationNotAllowed;
        default:
          throw AppException.failedToSignIn;
      }
    }
  }

  @override
  Future<void> setUserName({required String name}) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();
        logger.i('User name updated to ${name}');
      } else {
        logger.e('No user is currently signed in.');
      }
    } catch (e) {
      logger.e(e);
      throw AppException.failedToUpdateUserName;
    }
  }
}
