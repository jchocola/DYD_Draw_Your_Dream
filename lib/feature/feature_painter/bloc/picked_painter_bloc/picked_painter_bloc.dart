import 'package:dyd_drawer/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dyd_drawer/feature/feature_drawers/domain/entity/painter_entity.dart';

///
/// EVENT
///
abstract class PickedPainterBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PickedPainterBlocEventSetPainter extends PickedPainterBlocEvent {
  final PainterEntity painter;
  PickedPainterBlocEventSetPainter({required this.painter});
  @override
  List<Object?> get props => [painter];
}

class PickedPainterBlocEventReset extends PickedPainterBlocEvent {}

///
/// STATE
///
abstract class PickedPainterBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PickedPainterBlocStateWaiting extends PickedPainterBlocState {}

class PickedPainterBlocStatePicked extends PickedPainterBlocState {
  final PainterEntity painter;
  PickedPainterBlocStatePicked({required this.painter});
  @override
  List<Object?> get props => [painter];
}

///
/// BLOC
///

class PickedPainterBloc
    extends Bloc<PickedPainterBlocEvent, PickedPainterBlocState> {
  PickedPainterBloc() : super(PickedPainterBlocStateWaiting()) {
    /// SET PAINTER
    on<PickedPainterBlocEventSetPainter>((event, emit) {
      logger.i('Set painter');
      emit(PickedPainterBlocStatePicked(painter: event.painter));
    });

    /// RESET
    on<PickedPainterBlocEventReset>((event, emit) {
      logger.i('Reset painter');
      emit(PickedPainterBlocStateWaiting());
    });
  }
}
