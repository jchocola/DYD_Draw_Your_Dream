/*
   CUSTOM APPBAR - USER CAN PASS [TITLE, LEADING, ACTION]

   NOTE :
    if (withLeading == true) must to pass [LEADING]
 */

import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    this.title,
    this.withLeading = false,
    this.leading,
    this.withAction = false,
    this.action,
  });

  // TITLE
  final String? title;

  ///
  /// LEADING
  ///
  final bool withLeading;
  final Widget? leading;

  ///
  /// ACTIONS
  ///
  final bool withAction;
  final Widget? action;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: withLeading ? leading : null,
      title: Text(title ?? ''),
      centerTitle: true,
      actions: withAction ? [action!] : [],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppConstant.appbarHeight);
}
