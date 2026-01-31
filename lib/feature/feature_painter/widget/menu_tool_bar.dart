import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/core/icon/app_icon.dart';
import 'package:dyd_drawer/shared/color_pallete_picker.dart';
import 'package:flutter/material.dart';
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
    return Row(
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
        IconButton.filled(
          onPressed: () {},
          icon: Icon(AppIcon.pencilIcon, color: iconColor),
          style: IconButton.styleFrom(backgroundColor: iconButtonColor),
        ),


        
        IconButton.filled(
          onPressed: () {},
          icon: Icon(AppIcon.ereaserIcon, color: iconColor),
          style: IconButton.styleFrom(backgroundColor: iconButtonColor),
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
  }
}
