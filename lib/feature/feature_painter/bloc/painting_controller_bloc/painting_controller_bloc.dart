export 'package:dyd_drawer/feature/feature_painter/bloc/painting_controller_bloc/painting_controller_event.dart';
export 'package:dyd_drawer/feature/feature_painter/bloc/painting_controller_bloc/painting_controller_state.dart';

import 'dart:io';
import 'package:dyd_drawer/core/exception/app_exception.dart';
import 'package:dyd_drawer/feature/feature_auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:dyd_drawer/feature/feature_drawers/bloc/drawers_bloc.dart';
import 'package:dyd_drawer/feature/feature_drawers/data/models/painter_model.dart';
import 'package:dyd_drawer/feature/feature_drawers/domain/entity/painter_entity.dart';
import 'package:dyd_drawer/feature/feature_drawers/domain/repo/storage_repo.dart';
import 'package:dyd_drawer/feature/feature_drawers/domain/repo/store_repo.dart';
import 'package:dyd_drawer/feature/feature_notification/domain/notification_repo.dart';
import 'package:dyd_drawer/feature/feature_painter/bloc/painting_controller_bloc/painting_controller_event.dart';
import 'package:dyd_drawer/feature/feature_painter/bloc/painting_controller_bloc/painting_controller_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_painter/simple_painter.dart';
import 'package:dyd_drawer/main.dart';
import 'package:uuid/uuid.dart';

///
/// BLOC
///
class PaintingControllerBloc
    extends Bloc<PaintingControllerEvent, PaintingControllerState> {
  final ImagePicker _picker;
  final StorageRepo _storageRepo;
  final AuthBloc _authBloc;
  final NotificationRepo _notificationRepo;
  final DrawersBloc _drawersBloc;
  final StoreRepo _storeRepo;

  PaintingControllerBloc({
    required ImagePicker picker,
    required StorageRepo storageRepo,
    required AuthBloc authBloc,
    required NotificationRepo notificationRepo,
    required DrawersBloc drawersBloc,
    required StoreRepo storeRepo,
  }) : _picker = picker,
       _storageRepo = storageRepo,
       _authBloc = authBloc,
       _notificationRepo = notificationRepo,
       _drawersBloc = drawersBloc,
       _storeRepo = storeRepo,
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
    on<PaintingControllerEventInitialize>((event, emit) {
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
    on<PaintingControllerEventChangeColor>((event, emit) {
      logger.d('PaintingControllerBloc: Change color to ${event.color}');
      final currentState = state;
      if (currentState is PaitingControllerInitialized) {
        currentState.controller.changeBrushValues(color: event.color);
        emit(currentState.copyWith(pickedColor: event.color));
      }
    });

    //// TOGGLE DRAWING
    ////
    on<PaintingControllerEventToggleDrawing>((event, emit) {
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
    on<PaintingControllerEventToggleErasing>((event, emit) {
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
    on<PaintingControllerEventChangeBrushSize>((event, emit) {
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
    on<PaintingControllerEventChangeEraserSize>((event, emit) {
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
    on<PaintingControllerEventSaveToGallery>(((event, emit) async {
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
                exception: AppException.saveImageToGallerySuccessfully,
              ),
            );
            logger.d('Image saved to gallery successfully.');
          } else {
            logger.e('Failed to export image bytes.');
            emit(
              PaintingControllerFailure(
                exception: AppException.failedToSaveImageToGallery,
              ),
            );
          }
        } catch (e) {
          logger.e('Error saving image to gallery: $e');
          emit(
            PaintingControllerFailure(
              exception: AppException.failedToSaveImageToGallery,
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
    on<PaintingControllerEventPickImageAndSetBackground>(((event, emit) async {
      logger.d('PaintingControllerBloc: Pick image and set as background');
      final currentState = state;
      if (currentState is PaitingControllerInitialized) {
        try {
          final XFile? pickedFile = await _picker.pickImage(
            source: ImageSource.gallery,
          );
          if (pickedFile != null) {
            // notify user
            emit(
              PaintingControllerSuccess(
                exception: AppException.settingBackgroundImage,
              ),
            );
            emit(currentState);

            // file
            final File imageFile = File(pickedFile.path);

            final bytes = await imageFile.readAsBytes();

            // decode to  Image
            final originalImage = img.decodeImage(bytes)!;

            // Canvas size
            final double canvasWidth = 2160;
            final double canvasHeight = 3840;

            // Resize with saved proportion
            final resizedImage = img.copyResize(
              originalImage,
              width: canvasWidth.toInt(),
              height: canvasHeight.toInt(),
              maintainAspect: true,
              interpolation: img.Interpolation.linear,
            );

            // convert to Bytes
            final resizedBytes = img.encodePng(resizedImage);

            await currentState.controller.setBackgroundImage(resizedBytes);
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
    on<PaintingControllerEventClearBackgroundImage>(((event, emit) async {
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

    ///
    /// SAVE PAINTER TO STORE
    ///
    on<PaintingControllerEventSavePainterToStore>(((event, emit) async {
      logger.d('PaintingControllerBloc: Save painter to store');
      final currentState = state;
      if (currentState is PaitingControllerInitialized) {
        try {
          ///
          /// check current user
          ///
          final authState = _authBloc.state;

          final User currentUser = authState is AuthBlocStateAuthenticated
              ? authState.user
              : throw AppException.userNotAuthenticated;

          final imageBytes = await currentState.controller.renderImage();

          emit(PaintingControllerStateLoading());

          if (imageBytes != null) {
            ///
            /// CASE 1: IF IS NEW PAINTER
            ///
            if (event.isEdit == false) {
              logger.i('Is New Painter!!!');

              ///
              /// 1) SAVE TO STORAGE AND GET DOWNLOAD URL
              ///
              final fileUrl = await _storageRepo.saveFileAndGetUrl(
                fileBytes: imageBytes,
                user: currentUser,
              );
              logger.d('Painter saved to store with URL: $fileUrl');

              ///
              /// 2) SAVE INFO ON FIRESTORE
              ///
              final id = Uuid().v4().substring(0, 8);
              final PainterEntity painterEntity = PainterEntity(
                id: id,
                authorId: currentUser.uid,
                imageUrl: fileUrl,
                createdAt: DateTime.now(),
              );
              await _storeRepo.saveNewPainter(painterEntity: painterEntity);
            } else {
              ///
              /// CASE 2 : IF IS EDIT
              ///
              logger.f('IS EDIT PAINTER');

              //1) DELETE OLD FILE ON STORAGE
              await _storageRepo.deleteFile(fileUrl: event.painter!.imageUrl);

              //2) SAVE NEW FILE AND GET DOWNLOAD
              final fileUrl = await _storageRepo.saveFileAndGetUrl(
                fileBytes: imageBytes,
                user: currentUser,
              );
              logger.d('Painter saved to store with URL: $fileUrl');

              //3) UPDATE PAINTER INFO ON FIRESTORE
              final painterModel = PainterModel.fromEntity(event.painter!);
              final updatedModel = painterModel.copyWith(imageUrl: fileUrl);

              await _storeRepo.updatePainter(
                updatedEntity: updatedModel.toEntity(),
              );
              logger.i('Updated painter model');
            }

            ///
            /// NOTIFY UI
            ///
            event.completer?.complete();

            ///
            /// 3) SHOW NOTIFICATION
            ///
            await _notificationRepo.showNotification(
              title: 'Вы - настоящий творец',
              body: 'Ваше исскуство сохранено на сервере',
            );

            ///
            /// 4) RELOAD PAINTERS
            ///
            _drawersBloc.add(DrawersBlocEventLoadPainters());

            ///
            /// 5) SAVE TO GALERY
            ///
            add(PaintingControllerEventSaveToGallery());

            logger.d('Painter saved to store successfully.');
          } else {
            logger.e('Failed to export image bytes.');
            emit(
              PaintingControllerFailure(
                exception: AppException.failedToSaveImageToGallery,
              ),
            );
          }
        } catch (e) {
          logger.e('Error saving painter to store: $e');
          emit(
            PaintingControllerFailure(
              exception: AppException.failedToSaveImageToGallery,
            ),
          );
        } finally {
          emit(currentState); // Return to current state
        }
      }
    }));

    ///
    /// EDIT IMAGE FROM SERVER
    ///
    on<PaintingControllerEventEditImageFromServer>((event, emit) async {
      try {
        final completer = event.completer;

        final currentState = state;
        if (currentState is PaitingControllerInitialized) {
          // 1) get UINT8LIST from server
          final imageBytes = await _storageRepo.loadFileBytesViaDownloadUrl(
            painter: event.painter,
          );

          // 2 ) check
          if (imageBytes != null) {
            // // 3 reset painting controller
            // add(PaintingControllerEvent_resetPaintingController());

            //3) set image byte like bg
            currentState.controller.setBackgroundImage(imageBytes);

            //4 ) notify UI
            completer?.complete();
          } else {
            logger.e('Failed to get image bytes data');
          }
        }
      } catch (e) {
        logger.e(e);
      }
    });

    ///
    ///
    /// RESET PAINTING CONTROLLER
    ///
    on<PaintingControllerEventResetPaintingController>((event, emit) {
      logger.d('RESET PAINTING CONTROLLER');
      emit(
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
      );
    });

    ///
    /// POP UP SHARE
    ///
    on<PaintingControllerEventPopupShare>((event, emit) async {
      final currentState = state;
      if (currentState is PaitingControllerInitialized) {
        try {
          final imageBytes = await currentState.controller.renderImage();

          final params = ShareParams(
            title: 'Посмотри на мое исскуство!',
            files: [XFile.fromData(imageBytes!, mimeType: 'image/png')],
          );

          await SharePlus.instance.share(params);
        } catch (e) {
          logger.e(e);
        }
      }
    });
  }
}
