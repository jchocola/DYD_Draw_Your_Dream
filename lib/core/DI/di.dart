/*
  DEPENDENCY INJECTION
    This function controls and injects all dependencies for app
 */

import 'package:dyd_drawer/feature/feature_auth/data/firebase_auth_repo_impl.dart';
import 'package:dyd_drawer/feature/feature_auth/domain/auth_repo.dart';
import 'package:dyd_drawer/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

final getIt = GetIt.instance;

Future<void> DI() async {
  // AUTH
  final _auth = FirebaseAuth.instance;
  getIt.registerSingleton<AuthRepo>(FirebaseAuthRepoImpl(auth: _auth));

  getIt.registerSingleton<ImagePicker>(ImagePicker());

  logger.f('DI initialized');
}
