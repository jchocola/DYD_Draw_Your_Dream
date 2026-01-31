// ignore_for_file: camel_case_types


import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_painter/simple_painter.dart';

import 'package:dyd_drawer/main.dart';

///
/// EVENT
///
abstract class PaintingControllerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaintingControllerEvent_initialize extends PaintingControllerEvent {}

class PaintingControllerEvent_changeColor extends PaintingControllerEvent {
  final Color color;
  PaintingControllerEvent_changeColor({required this.color});
  @override
  List<Object?> get props => [color];
}

class PaintingControllerEvent_toggleDrawing extends PaintingControllerEvent {}

class PaintingControllerEvent_toggleErasing extends PaintingControllerEvent {}

class PaintingControllerEvent_changeBrushSize extends PaintingControllerEvent {
  final double size;
  PaintingControllerEvent_changeBrushSize({required this.size});
  @override
  List<Object?> get props => [size];
}

///
/// STATE
///
abstract class PaintingControllerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaitingControllerInitialized extends PaintingControllerState {
  final PainterController controller; // PAINTER CONTROLLER
  final Color pickedColor; // CURRENT PICKED COLOR
  final bool isDrawing; // IS DRAWING MODE ON/OFF
  final bool isErasing; // IS ERASING MODE ON/OFF
  final double brushSize; // BRUSH SIZE
  PaitingControllerInitialized({
    required this.controller,
    this.pickedColor = Colors.black,
    this.isDrawing = false,
    this.isErasing = false,
    this.brushSize = 5,
  });
  @override
  List<Object?> get props => [controller, pickedColor, isDrawing, isErasing, brushSize];

  PaitingControllerInitialized copyWith({
    PainterController? controller,
    Color? pickedColor,
    bool? isDrawing,
    bool? isErasing,
    double? brushSize,
  }) {
    return PaitingControllerInitialized(
      controller: controller ?? this.controller,
      pickedColor: pickedColor ?? this.pickedColor,
      isDrawing: isDrawing ?? this.isDrawing,
      isErasing: isErasing ?? this.isErasing,
      brushSize: brushSize ?? this.brushSize,
    );
  }
}

///
/// BLOC
///
class PaintingControllerBloc
    extends Bloc<PaintingControllerEvent, PaintingControllerState> {
  PaintingControllerBloc()
    : super(
        PaitingControllerInitialized(
          controller: PainterController(
            settings: PainterSettings(size: Size(500, 500), brush: BrushSettings(size: 5, color: Colors.black)),
            
          ),
          pickedColor: Colors.black,
          isDrawing: false,
          isErasing: false,
          brushSize: 5,
        ),
      ) {
    ///
    /// INITIALIZE
    ///
    on<PaintingControllerEvent_initialize>((event, emit) {
      logger.d('PaintingControllerBloc: Initialize controller');
      final currentState = state;
      if (currentState is PaitingControllerInitialized) {
        currentState.controller.changeBrushValues(
          size: 5,
          color: currentState.pickedColor,
        );
      }
    });

    ///
    /// CHANGE COLOR
    ///
    on<PaintingControllerEvent_changeColor>((event, emit) {
      logger.d('PaintingControllerBloc: Change color to ${event.color}');
      final currentState = state;
      if (currentState is PaitingControllerInitialized) {
        currentState.controller.changeBrushValues( color: event.color);
        emit(currentState.copyWith(pickedColor: event.color));
      }
    });

    //// TOGGLE DRAWING
    ////
    on<PaintingControllerEvent_toggleDrawing>((event, emit) {
      logger.d('PaintingControllerBloc: Toggle drawing mode');
      final currentState = state;
      if (currentState is PaitingControllerInitialized) {
        final newIsDrawing = !currentState.isDrawing;
        currentState.controller.toggleDrawing();
        emit(currentState.copyWith(isDrawing: newIsDrawing , isErasing: newIsDrawing ? false : currentState.isErasing,));
      }
    });

    //// TOGGLE ERASING
    ////
    on<PaintingControllerEvent_toggleErasing>((event, emit) {
      logger.d('PaintingControllerBloc: Toggle erasing mode');
      final currentState = state;
      if (currentState is PaitingControllerInitialized) {
        final newIsErasing = !currentState.isErasing;
        currentState.controller.toggleErasing();
        emit(currentState.copyWith( isErasing: newIsErasing, isDrawing: newIsErasing ? false : currentState.isDrawing,));
      }
    });



    ///
    /// CHANGE BRUSH SIZE
    ///
    on<PaintingControllerEvent_changeBrushSize>((event, emit) {
      logger.d('PaintingControllerBloc: Change brush size to ${event.size}');
      final currentState = state;
      if (currentState is PaitingControllerInitialized) {
        currentState.controller.changeBrushValues(
          size: event.size,
        );
        emit(currentState.copyWith(brushSize: event.size));
      }
    });
  }
}
