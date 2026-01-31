// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:dyd_drawer/core/exception/app_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:image_picker/image_picker.dart';
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

class PaintingControllerEvent_changeEraserSize extends PaintingControllerEvent {
  final double size;
  PaintingControllerEvent_changeEraserSize({required this.size});
  @override
  List<Object?> get props => [size];
}

class PaintingControllerEvent_saveToGallery extends PaintingControllerEvent {}

class PaintingControllerEvent_pickImageAndSetBackground
    extends PaintingControllerEvent {}

class PaintingControllerEvent_clearBackgroundImage
    extends PaintingControllerEvent {}

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

///
/// BLOC
///
class PaintingControllerBloc
    extends Bloc<PaintingControllerEvent, PaintingControllerState> {
  final ImagePicker _picker;

  PaintingControllerBloc({required ImagePicker picker})
    : _picker = picker,
      super(
        PaitingControllerInitialized(
          controller: PainterController(
            settings: PainterSettings(
              size: Size(2160, 3840), // 4K SIZE CANVAS
              brush: BrushSettings(size: 5, color: Colors.black),
              erase: EraseSettings(size: 10),
            ),
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
        currentState.controller.changeBrushValues(color: event.color);
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
        emit(
          currentState.copyWith(
            isDrawing: newIsDrawing,
            isErasing: newIsDrawing ? false : currentState.isErasing,
          ),
        );
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
        emit(
          currentState.copyWith(
            isErasing: newIsErasing,
            isDrawing: newIsErasing ? false : currentState.isDrawing,
          ),
        );
      }
    });

    ///
    /// CHANGE BRUSH SIZE
    ///
    on<PaintingControllerEvent_changeBrushSize>((event, emit) {
      logger.d('PaintingControllerBloc: Change brush size to ${event.size}');
      final currentState = state;
      if (currentState is PaitingControllerInitialized) {
        currentState.controller.changeBrushValues(size: event.size);
        emit(currentState.copyWith(brushSize: event.size));
      }
    });

    ///
    /// CHANGE ERASER SIZE
    ///
    on<PaintingControllerEvent_changeEraserSize>((event, emit) {
      logger.d('PaintingControllerBloc: Change eraser size to ${event.size}');
      final currentState = state;
      if (currentState is PaitingControllerInitialized) {
        currentState.controller.changeEraseValues(size: event.size);
        emit(currentState.copyWith(eraserSize: event.size));
      }
    });

    ///
    /// SAVE TO GALLERY
    ///
    on<PaintingControllerEvent_saveToGallery>(((event, emit) async {
      logger.d('PaintingControllerBloc: Save drawing to gallery');
      final currentState = state;
      if (currentState is PaitingControllerInitialized) {
        try {
          final imageBytes = await currentState.controller.renderImage();
          ();
          if (imageBytes != null) {
            await ImageGallerySaverPlus.saveImage(imageBytes);

            emit(
              PaintingControllerSuccess(
                exception: AppException.SAVED_IMAGE_TO_GALLERY_SUCCESSFULLY,
              ),
            );
            logger.d('Image saved to gallery successfully.');
          } else {
            logger.e('Failed to export image bytes.');
            emit(
              PaintingControllerFailure(
                exception: AppException.FAILED_TO_SAVE_IMAGE_TO_GALLERY,
              ),
            );
          }
        } catch (e) {
          logger.e('Error saving image to gallery: $e');
          emit(
            PaintingControllerFailure(
              exception: AppException.FAILED_TO_SAVE_IMAGE_TO_GALLERY,
            ),
          );
        } finally {
          emit(currentState);
        }
      }
    }));

    ///
    /// PICK IMAGE AND SET BACKGROUND
    ///
    on<PaintingControllerEvent_pickImageAndSetBackground>(((event, emit) async {
      logger.d('PaintingControllerBloc: Pick image and set as background');
      final currentState = state;
      if (currentState is PaitingControllerInitialized) {
        try {
          final XFile? pickedFile = await _picker.pickImage(
            source: ImageSource.gallery,
          );
          if (pickedFile != null) {
            final File imageFile = File(pickedFile.path);
            await currentState.controller.setBackgroundImage(
              imageFile.readAsBytesSync(),
            );
            emit(currentState.copyWith(backgroundImageFile: imageFile));
            logger.d('Background image set successfully.');
          } else {
            logger.e('No image selected.');
          }
        } catch (e) {
          logger.e('Error picking image: $e');
        }
      }
    }));

    ///
    /// CLEAR BACKGROUND IMAGE
    ///
    on<PaintingControllerEvent_clearBackgroundImage>(((event, emit) async {
      logger.d('PaintingControllerBloc: Clear background image');
      final currentState = state;
      if (currentState is PaitingControllerInitialized) {
        try {
          await currentState.controller.setBackgroundImage(null);

          final updatedState = PaitingControllerInitialized(
            controller: currentState.controller,
            pickedColor: currentState.pickedColor,
            isDrawing: currentState.isDrawing,
            isErasing: currentState.isErasing,
            brushSize: currentState.brushSize,
            eraserSize: currentState.eraserSize,
            backgroundImageFile: null,
          );
          emit(updatedState);
          logger.d('Background image cleared successfully.');
        } catch (e) {
          logger.e('Error clearing background image: $e');
        }
      }
    }));
  }
}
