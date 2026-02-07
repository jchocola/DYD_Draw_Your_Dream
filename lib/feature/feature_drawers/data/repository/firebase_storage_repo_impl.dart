import 'dart:typed_data';

import 'package:dyd_drawer/feature/feature_drawers/domain/entity/painter_entity.dart';
import 'package:dyd_drawer/feature/feature_drawers/domain/repo/storage_repo.dart';
import 'package:dyd_drawer/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageRepoImpl implements StorageRepo {
  final _firebaseStorage = FirebaseStorage.instance;

  @override
  Future<void> deleteFile({required String fileUrl, required User user}) async {
    try {
      final storageRef = _firebaseStorage.refFromURL(fileUrl);

      await storageRef.delete();
      logger.d('Deleted File');
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Future<String> saveFileAndGetUrl({
    required Uint8List fileBytes,
    required User user,
  }) async {
    try {
      final dateTime = DateTime.now();

      final ref = _firebaseStorage
          .ref('Paintings')
          .child('/${user.uid}/${dateTime.millisecondsSinceEpoch}.png');
      final uploadTask = ref.putData(
        fileBytes,
        SettableMetadata(
          contentType: 'image/png',
          customMetadata: {
            "author": user.uid,
            'date': dateTime.toIso8601String(),
          },
        ),
      );
      return await uploadTask.then((task) => task.ref.getDownloadURL());
    } catch (e) {
      throw Exception('Error uploading file: $e');
    }
  }

  @override
  Future<Uint8List?> loadFileBytesViaDownloadUrl({
    required PainterEntity painter,
  }) async {
    try {
      // Create a reference from the HTTPS download URL
      final Reference httpsReference = FirebaseStorage.instance.refFromURL(
        painter.imageUrl,
      );

      // Download the file data to a Uint8List.
      final Uint8List? data = await httpsReference.getData();
      return data;
    } catch (e) {
      logger.e(e);
    }
    return null;
  }
}
