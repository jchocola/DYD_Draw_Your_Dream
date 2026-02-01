/*
    ABSTRACT CLASS FOR AUTH-FEATURE
    User can:
      - create new account (pass EMAIL , PASSWPRD)
      - sign in (pass EMAIL , PASSWORD)
      - logout 
      - get current logged user
      - set user name
 */

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  Future<UserCredential> createNewUserWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserCredential> signInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<void> logOut();

  Future<User?> getCurrentUser();

  Future<void> setUserName({required String name});
}
