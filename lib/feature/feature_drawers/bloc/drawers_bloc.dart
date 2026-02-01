// ignore_for_file: camel_case_types

import 'package:dyd_drawer/core/exception/app_exception.dart';
import 'package:dyd_drawer/feature/feature_auth/domain/auth_repo.dart';
import 'package:dyd_drawer/feature/feature_drawers/domain/repo/store_repo.dart';
import 'package:dyd_drawer/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dyd_drawer/feature/feature_drawers/domain/entity/painter_entity.dart';

///
/// EVENT
///
abstract class DrawersBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DrawersBlocEvent_loadPainters extends DrawersBlocEvent {}

///
/// STATE
///
abstract class DrawersBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DrawersBlocStateInitial extends DrawersBlocState {}

class DrawersBlocStateLoading extends DrawersBlocState {}

class DrawersBlocStateLoaded extends DrawersBlocState {
  final List<PainterEntity> painters;
  DrawersBlocStateLoaded({required this.painters});
  @override
  List<Object?> get props => [painters];
}

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
    on<DrawersBlocEvent_loadPainters>((event, emit) async {
      try {
        logger.i('DrawersBlocEvent_loadPainters');

        final currentUser = await _authRepo.getCurrentUser();

        if (currentUser != null) {
          final painters = await _storeRepo.getPaintersByAuthorId(
            authorId: currentUser.uid,
          );

          emit(DrawersBlocStateLoaded(painters: painters));
        } else {
          throw AppException.USER_NOT_AUTHENTICATED;
        }
      } catch (e) {
        logger.e(e);
      }
    });
  }
}
