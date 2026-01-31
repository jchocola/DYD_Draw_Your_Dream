import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

abstract class StorageRepo {
  Future<String> saveFileAndGetUrl({required Uint8List fileBytes, required User user});

  Future<void> deleteFile({required String fileUrl, required User user});
}
