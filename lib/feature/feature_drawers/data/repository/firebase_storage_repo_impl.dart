import 'dart:typed_data';

import 'package:dyd_drawer/feature/feature_drawers/domain/repo/storage_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageRepoImpl implements StorageRepo {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  Future<void> deleteFile({required String fileUrl, required User user}) {
    // TODO: implement deleteFile
    throw UnimplementedError();
  }

  @override
  Future<String> saveFileAndGetUrl({
    required Uint8List fileBytes,
    required User user,
  }) async {
    try {
      final dateTime = DateTime.now();

      final ref = _firebaseStorage.ref().child(
        'drawings/${user.uid}/${dateTime.millisecondsSinceEpoch}.png',
      );
      final uploadTask = ref.putData(
        fileBytes,
        SettableMetadata(
          contentType: 'image/png',
          customMetadata: {"author": user.uid, 'date': dateTime.toIso8601String()},
        ),
      );
      return await uploadTask.then((task) => task.ref.getDownloadURL());
    } catch (e) {
      throw Exception('Error uploading file: $e');
    }
  }
}
