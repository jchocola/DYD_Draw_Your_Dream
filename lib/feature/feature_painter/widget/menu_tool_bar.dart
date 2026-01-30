import 'package:dyd_drawer/core/icon/app_icon.dart';
import 'package:flutter/material.dart';

class MenuToolBar extends StatelessWidget {
  const MenuToolBar({super.key});

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).colorScheme.tertiary;
    final iconButtonColor = Theme.of(context).colorScheme.tertiary.withOpacity(0.2);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton.filled(onPressed: () {}, icon: Icon(AppIcon.downloadIcon, color: iconColor,), style: IconButton.styleFrom(backgroundColor: iconButtonColor)),
        IconButton.filled(onPressed: () {}, icon: Icon(AppIcon.imageIcon , color: iconColor,), style: IconButton.styleFrom(backgroundColor: iconButtonColor)),
        IconButton.filled(onPressed: () {}, icon: Icon(AppIcon.pencilIcon, color: iconColor,), style: IconButton.styleFrom(backgroundColor: iconButtonColor)),
        IconButton.filled(onPressed: () {}, icon: Icon(AppIcon.ereaserIcon, color: iconColor,), style: IconButton.styleFrom(backgroundColor: iconButtonColor)),
        IconButton.filled(onPressed: () {}, icon: Icon(AppIcon.colorLensIcon, color: iconColor,), style: IconButton.styleFrom(backgroundColor: iconButtonColor)),
      ],
    );
  }
}
