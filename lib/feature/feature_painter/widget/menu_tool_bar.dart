import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/core/icon/app_icon.dart';
import 'package:dyd_drawer/feature/feature_painter/bloc/painting_controller_bloc.dart';
import 'package:dyd_drawer/shared/color_pallete_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_popup/flutter_popup.dart';

class MenuToolBar extends StatelessWidget {
  const MenuToolBar({super.key});

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).colorScheme.tertiary;
    final iconButtonColor = Theme.of(
      context,
    ).colorScheme.tertiary.withOpacity(0.2);
    final popupKey = GlobalKey<CustomPopupState>();
    final theme = Theme.of(context);
    return BlocBuilder<PaintingControllerBloc, PaintingControllerState>(
      builder: (context, state) {
        if (state is PaitingControllerInitialized) {
          return  Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton.filled(
            onPressed: () {},
            icon: Icon(AppIcon.downloadIcon, color: iconColor),
            style: IconButton.styleFrom(backgroundColor: iconButtonColor),
          ),
          IconButton.filled(
            onPressed: () {},
            icon: Icon(AppIcon.imageIcon, color: iconColor),
            style: IconButton.styleFrom(backgroundColor: iconButtonColor),
          ),
      
      
          ///
          /// PENCIL TOOL
          ///
          IconButton.filled(
            
            onPressed: () => context.read<PaintingControllerBloc>().add(PaintingControllerEvent_toggleDrawing()),
            icon: Icon(AppIcon.pencilIcon, color: iconColor),
            style: IconButton.styleFrom(backgroundColor: state.isDrawing ? theme.colorScheme.secondary : iconButtonColor,),
          ),
      
      
          ///
          /// ERASER TOOL
          ///
          IconButton.filled(
            onPressed: () => context.read<PaintingControllerBloc>().add(PaintingControllerEvent_toggleErasing()),
            icon: Icon(AppIcon.ereaserIcon, color: iconColor),
            style: IconButton.styleFrom(backgroundColor: state.isErasing ? theme.colorScheme.secondary : iconButtonColor,),
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
              icon: Icon(AppIcon.colorLensIcon, color: iconColor),
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
