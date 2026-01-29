import 'package:dyd_drawer/core/icon/app_icon.dart';
import 'package:flutter/material.dart';

class MenuToolBar extends StatelessWidget {
  const MenuToolBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton.filled(onPressed: () {}, icon: Icon(AppIcon.downloadIcon)),
        IconButton.filled(onPressed: () {}, icon: Icon(AppIcon.imageIcon)),
        IconButton.filled(onPressed: () {}, icon: Icon(AppIcon.pencilIcon)),
        IconButton.filled(onPressed: () {}, icon: Icon(AppIcon.ereaserIcon)),
        IconButton.filled(onPressed: () {}, icon: Icon(AppIcon.colorLensIcon)),
      ],
    );
  }
}
