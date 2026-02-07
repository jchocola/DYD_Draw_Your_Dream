import 'dart:async';
import 'dart:ui';

import 'package:dyd_drawer/feature/feature_drawers/domain/entity/painter_entity.dart';
import 'package:equatable/equatable.dart';

///
/// EVENT
///
abstract class PaintingControllerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaintingControllerEventInitialize extends PaintingControllerEvent {}

class PaintingControllerEventChangeColor extends PaintingControllerEvent {
  final Color color;
  PaintingControllerEventChangeColor({required this.color});
  @override
  List<Object?> get props => [color];
}

class PaintingControllerEventToggleDrawing extends PaintingControllerEvent {}

class PaintingControllerEventToggleErasing extends PaintingControllerEvent {}

class PaintingControllerEventChangeBrushSize extends PaintingControllerEvent {
  final double size;
  PaintingControllerEventChangeBrushSize({required this.size});
  @override
  List<Object?> get props => [size];
}

class PaintingControllerEventChangeEraserSize extends PaintingControllerEvent {
  final double size;
  PaintingControllerEventChangeEraserSize({required this.size});
  @override
  List<Object?> get props => [size];
}

class PaintingControllerEventSaveToGallery extends PaintingControllerEvent {}

class PaintingControllerEventPopupShare extends PaintingControllerEvent {}

class PaintingControllerEventPickImageAndSetBackground
    extends PaintingControllerEvent {}

class PaintingControllerEventClearBackgroundImage
    extends PaintingControllerEvent {}

class PaintingControllerEventSavePainterToStore
    extends PaintingControllerEvent {
  final Completer<void>? completer;
  PaintingControllerEventSavePainterToStore({this.completer});

  @override
  List<Object?> get props => [completer];
}

class PaintingControllerEventEditImageFromServer
    extends PaintingControllerEvent {
  final PainterEntity painter;
  final Completer? completer;
  PaintingControllerEventEditImageFromServer({
    required this.painter,
    this.completer,
  });
  @override
  List<Object?> get props => [painter, completer];
}

class PaintingControllerEventResetPaintingController
    extends PaintingControllerEvent {}
