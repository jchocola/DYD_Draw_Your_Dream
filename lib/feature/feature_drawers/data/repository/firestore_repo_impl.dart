import 'package:dyd_drawer/feature/feature_drawers/domain/entity/painter_entity.dart';
import 'package:dyd_drawer/feature/feature_drawers/domain/repo/store_repo.dart';

class FirestoreRepoImpl implements StoreRepo {
  @override
  Future<void> deletePainterById({required String painterId}) {
    // TODO: implement deletePainterById
    throw UnimplementedError();
  }

  @override
  Future<List<PainterEntity>> getPaintersByAuthorId({required String authorId}) {
    // TODO: implement getPaintersByAuthorId
    throw UnimplementedError();
  }

  @override
  Future<void> saveNewPainter({required PainterEntity painterEntity}) {
    // TODO: implement saveNewPainter
    throw UnimplementedError();
  }
}
