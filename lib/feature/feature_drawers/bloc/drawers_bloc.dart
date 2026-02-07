export 'package:dyd_drawer/feature/feature_drawers/bloc/drawers_bloc_event.dart';
export 'package:dyd_drawer/feature/feature_drawers/bloc/drawers_bloc_state.dart';

import 'package:dyd_drawer/core/exception/app_exception.dart';
import 'package:dyd_drawer/feature/feature_auth/domain/auth_repo.dart';
import 'package:dyd_drawer/feature/feature_drawers/bloc/drawers_bloc_event.dart';
import 'package:dyd_drawer/feature/feature_drawers/bloc/drawers_bloc_state.dart';
import 'package:dyd_drawer/feature/feature_drawers/domain/repo/store_repo.dart';
import 'package:dyd_drawer/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// BLOC
///
class DrawersBloc extends Bloc<DrawersBlocEvent, DrawersBlocState> {
  final StoreRepo _storeRepo;
  final AuthRepo _authRepo;
  DrawersBloc({required StoreRepo storeRepo, required AuthRepo authRepo})
    : _storeRepo = storeRepo,
      _authRepo = authRepo,
      super(DrawersBlocStateInitial()) {
    ///
    /// LOAD PAINTERS
    ///
    on<DrawersBlocEventLoadPainters>((event, emit) async {
      try {
        logger.i('DrawersBlocEvent_loadPainters');

        final currentUser = await _authRepo.getCurrentUser();

        if (currentUser != null) {
          final painters = await _storeRepo.getPaintersByAuthorId(
            authorId: currentUser.uid,
          );

          logger.i('Painters : ${painters.length}');

          emit(DrawersBlocStateLoaded(painters: painters));
        } else {
          throw AppException.userNotAuthenticated;
        }
      } catch (e) {
        logger.e(e);
      }
    });
  }
}
