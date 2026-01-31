import 'package:dyd_drawer/feature/feature_drawers/domain/entity/painter_entity.dart';

abstract class StoreRepo {
  Future<void> saveNewPainter({required PainterEntity painterEntity});

  Future<List<PainterEntity>> getPaintersByAuthorId({required String authorId});

  Future<void> deletePainterById({required String painterId});

  
}