import 'dart:ui';

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

///
/// STATE
///
abstract class PaintingControllerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaitingControllerInitialized extends PaintingControllerState {
  final PainterController controller;
  final Color pickedColor;
  PaitingControllerInitialized({
    required this.controller,
    this.pickedColor = Colors.black,
  });
  @override
  List<Object?> get props => [controller, pickedColor];

  PaitingControllerInitialized copyWith({
    PainterController? controller,
    Color? pickedColor,
  }) {
    return PaitingControllerInitialized(
      controller: controller ?? this.controller,
      pickedColor: pickedColor ?? this.pickedColor,
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
            settings: PainterSettings(size: Size(500, 500)),
          ),
          pickedColor: Colors.black,
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
          color: currentState.pickedColor
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
        currentState.controller.changeBrushValues(
          size: 5,
          color: event.color,
        );
        emit(
          currentState.copyWith(pickedColor: event.color),
        );
      }
    });
  }
}
