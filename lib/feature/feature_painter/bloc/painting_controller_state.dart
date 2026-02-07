import 'dart:io';
import 'package:dyd_drawer/core/exception/app_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:simple_painter/simple_painter.dart';

///
/// STATE
///
abstract class PaintingControllerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaintingControllerStateLoading extends PaintingControllerState {}

class PaitingControllerInitialized extends PaintingControllerState {
  final PainterController controller; // PAINTER CONTROLLER
  final Color pickedColor; // CURRENT PICKED COLOR
  final bool isDrawing; // IS DRAWING MODE ON/OFF
  final bool isErasing; // IS ERASING MODE ON/OFF
  final double brushSize; // BRUSH SIZE
  final double eraserSize; // ERASER SIZE
  final File? backgroundImageFile; // BACKGROUND IMAGE FILE
  PaitingControllerInitialized({
    required this.controller,
    this.pickedColor = Colors.black,
    this.isDrawing = false,
    this.isErasing = false,
    this.brushSize = 5,
    this.eraserSize = 10,
    this.backgroundImageFile,
  });
  @override
  List<Object?> get props => [
    controller,
    pickedColor,
    isDrawing,
    isErasing,
    brushSize,
    eraserSize,
    backgroundImageFile,
  ];

  PaitingControllerInitialized copyWith({
    PainterController? controller,
    Color? pickedColor,
    bool? isDrawing,
    bool? isErasing,
    double? brushSize,
    double? eraserSize,
    File? backgroundImageFile,
  }) {
    return PaitingControllerInitialized(
      controller: controller ?? this.controller,
      pickedColor: pickedColor ?? this.pickedColor,
      isDrawing: isDrawing ?? this.isDrawing,
      isErasing: isErasing ?? this.isErasing,
      brushSize: brushSize ?? this.brushSize,
      eraserSize: eraserSize ?? this.eraserSize,
      backgroundImageFile: backgroundImageFile ?? this.backgroundImageFile,
    );
  }
}

class PaintingControllerSuccess extends PaintingControllerState {
  final AppException exception;
  PaintingControllerSuccess({required this.exception});
  @override
  List<Object?> get props => [exception];
}

class PaintingControllerFailure extends PaintingControllerState {
  final AppException exception;
  PaintingControllerFailure({required this.exception});
  @override
  List<Object?> get props => [exception];
}