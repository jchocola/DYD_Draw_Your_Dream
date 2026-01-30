/*
   CUSTOM APPBAR - USER CAN PASS [TITLE, LEADING, ACTION]

   NOTE :
    if (withLeading == true) must to pass [LEADING]
 */

import 'dart:ui';

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
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: withLeading ? leading : null,
      title: Text(title ?? '', style: theme.textTheme.titleMedium!.copyWith(color: theme.colorScheme.tertiary),),
      centerTitle: true,
      actions: withAction ? [action!] : [],
      flexibleSpace: ClipRRect(
        borderRadius: BorderRadiusGeometry.only(
          bottomLeft: Radius.circular(AppConstant.borderRadius),
          bottomRight: Radius.circular(AppConstant.borderRadius),
        ),
        child: Stack(
          children: [

            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: theme.colorScheme.primary.withOpacity(0.12)),
            ),


            // 2. Фон с внутренней тенью и цветом
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A1625).withOpacity(0.6), // Базовый темный оттенок
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
                // Эмуляция Inner Shadow (Y: 1, Blur: 40, Color: #E3E3E3 20%)
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFE3E3E3).withOpacity(0.2), // Светлый блик сверху
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5], // Расстояние размытия тени
                ),
              ),)
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppConstant.appbarHeight);
}
