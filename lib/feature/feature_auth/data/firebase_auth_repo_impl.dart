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
          throw AppException.EMAIL_ALREADY_IN_USE;
        case 'invalid-email':
          throw AppException.INVALID_EMAIL;
        case 'operation-not-allowed':
          throw AppException.OPERATION_NOT_ALLOWED;
        case 'weak-password':
          throw AppException.WEAK_PASSWORD;
        case 'too-many-requests':
          throw AppException.TOO_MANY_REQUESTS;
        case 'user-token-expired':
          throw AppException.USER_TOKEN_EXPIRED;
        case 'network-request-failed':
          throw AppException.NETWORK_REQUEST_FAILED;
        default:
          throw AppException.FAILED_TO_CREATE_NEW_USER;
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
          throw AppException.INVALID_EMAIL;
        case 'user-disabled':
          throw AppException.USER_DISABLED;
        case 'user-not-found':
          throw AppException.USER_NOT_FOUND;
        case 'wrong-password:':
          throw AppException.WRONG_PASSWORD;
        case 'too-many-requests':
          throw AppException.TOO_MANY_REQUESTS;
        case 'user-token-expired':
          throw AppException.USER_TOKEN_EXPIRED;
        case 'invalid-credential':
          throw AppException.INVALID_CREDENTIAL;
        case 'network-request-failed':
          throw AppException.NETWORK_REQUEST_FAILED;
        case 'operation-not-allowed:':
          throw AppException.OPERATION_NOT_ALLOWED;
        default:
          throw AppException.FAILED_TO_SIGN_IN;
      }
    }
  }
}
