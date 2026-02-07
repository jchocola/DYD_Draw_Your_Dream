// ignore_for_file: unused_local_variable

import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/core/icon/app_icon.dart';

import 'package:dyd_drawer/feature/feature_painter/bloc/painting_controller_bloc.dart';
import 'package:dyd_drawer/shared/color_pallete_picker.dart';
import 'package:dyd_drawer/shared/custom_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_popup/flutter_popup.dart';

class MenuToolBar extends StatelessWidget {
  const MenuToolBar({super.key});

  static const toolIconSize = 25.0;

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).colorScheme.tertiary;
    final iconButtonColor = Theme.of(
      context,
    ).colorScheme.tertiary.withValues(alpha: 0.2);
    final popupKey = GlobalKey<CustomPopupState>();
    final theme = Theme.of(context);
    return BlocBuilder<PaintingControllerBloc, PaintingControllerState>(
      builder: (context, state) {
        if (state is PaitingControllerInitialized) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ///
              /// SAVE IMAGE TO GALLERY
              ///
              IconButton.filled(
                onPressed: () => context.read<PaintingControllerBloc>().add(
                  PaintingControllerEventPopupShare(),
                ),
                icon: CustomIcon(
                  svgAsset: AppIcon.downloadIcon,
                  color: theme.colorScheme.tertiary,
                  size: toolIconSize,
                ),
                style: IconButton.styleFrom(backgroundColor: iconButtonColor),
              ),

              ///
              /// PICK IMAGE AND SET AS BACKGROUND
              ///
              IconButton.filled(
                onPressed: () {
                  if (state.backgroundImageFile != null) {
                    context.read<PaintingControllerBloc>().add(
                      PaintingControllerEventClearBackgroundImage(),
                    );
                  } else {
                    context.read<PaintingControllerBloc>().add(
                      PaintingControllerEventPickImageAndSetBackground(),
                    );
                  }
                },
                icon: CustomIcon(
                  size: toolIconSize,
                  svgAsset: AppIcon.imageIcon,
                  color: theme.colorScheme.tertiary,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: state.backgroundImageFile != null
                      ? theme.colorScheme.secondary
                      : iconButtonColor,
                ),
              ),

              ///
              /// PENCIL TOOL
              ///
              IconButton.filled(
                onPressed: () => context.read<PaintingControllerBloc>().add(
                  PaintingControllerEventToggleDrawing(),
                ),
                icon: CustomIcon(
                  size: toolIconSize,
                  svgAsset: AppIcon.pencilIcon,
                  color: theme.colorScheme.tertiary,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: state.isDrawing
                      ? theme.colorScheme.secondary
                      : iconButtonColor,
                ),
              ),

              ///
              /// ERASER TOOL
              ///
              IconButton.filled(
                onPressed: () => context.read<PaintingControllerBloc>().add(
                  PaintingControllerEventToggleErasing(),
                ),
                icon: CustomIcon(
                  size: toolIconSize,
                  svgAsset: AppIcon.ereaserIcon,
                  color: theme.colorScheme.tertiary,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: state.isErasing
                      ? theme.colorScheme.secondary
                      : iconButtonColor,
                ),
              ),

              ///
              /// COLOR PICKER
              ///
              CustomPopup(
                //backgroundColor: theme.colorScheme.onPrimaryContainer,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppConstant.appPadding,
                ),
                key: popupKey,
                content: ColorPalletePicker(),
                child: IconButton.filled(
                  onPressed: () {
                    popupKey.currentState?.show();
                  },
                  icon: CustomIcon(
                    size: toolIconSize,
                    svgAsset: AppIcon.colorLensIcon,
                    color: theme.colorScheme.tertiary,
                  ),
                  style: IconButton.styleFrom(backgroundColor: iconButtonColor),
                ),
              ),
            ],
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
