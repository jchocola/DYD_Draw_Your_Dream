import 'dart:typed_data';

import 'package:dyd_drawer/feature/feature_drawers/domain/repo/storage_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseStorageRepoImpl implements StorageRepo {
  @override
  Future<void> deleteFile({required String fileUrl, required User user}) {
    // TODO: implement deleteFile
    throw UnimplementedError();
  }

  @override
  Future<String> saveFileAndGetUrl({required Uint8List fileBytes, required User user}) {
    // TODO: implement saveFileAndGetUrl
    throw UnimplementedError();
  }
}
