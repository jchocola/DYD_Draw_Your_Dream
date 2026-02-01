import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyd_drawer/feature/feature_drawers/data/models/painter_model.dart';
import 'package:dyd_drawer/feature/feature_drawers/domain/entity/painter_entity.dart';
import 'package:dyd_drawer/feature/feature_drawers/domain/repo/store_repo.dart';
import 'package:dyd_drawer/main.dart';
import 'package:uuid/uuid.dart';

class FirestoreRepoImpl implements StoreRepo {
  final _firestore = FirebaseFirestore.instance.collection('Painters');

  @override
  Future<void> deletePainterById({required String painterId}) async {
    try {
      await _firestore.doc(painterId).delete();
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Future<List<PainterEntity>> getPaintersByAuthorId({
    required String authorId,
  }) async {
    try {
      final paintersDoc = await _firestore
          .where("authorId", isEqualTo: authorId)
          .get();

      return paintersDoc.docs
          .map((doc) => PainterModel.fromMap(doc.data()).toEntity())
          .toList();
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  @override
  Future<void> saveNewPainter({required PainterEntity painterEntity}) async {
    try {
      final id = Uuid().v4().substring(0, 8);

      final model = PainterModel.fromEntity(painterEntity);
      await _firestore.doc(id).set(model.toMap());
    } catch (e) {
      logger.e(e);
    }
  }
}
