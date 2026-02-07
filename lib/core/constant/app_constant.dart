import 'package:dyd_drawer/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstant {
  static String appBg = 'assets/splash.png';

  static double appbarHeight = 60;

  static double appPadding = 16;

  static double appSpacing = 10;
  static double borderRadius = 16;

  static double drawerCardBorder = 12;

  static double drawerCardAspectRatio = 1 / 1;
  static int crossAxisCount = 2;

  static LinearGradient buttonGradient() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [const Color(0xff8924E7), const Color(0xff6A46F9)],
    );
  }

  static final specialFont = GoogleFonts.pressStart2p().copyWith(
    fontSize: AppConstant.specialTextHeight,
    color: AppColor.white,
    shadows: [
      // Основное мягкое свечение
      Shadow(
        blurRadius: 10.0,
        color: Colors.purpleAccent.withValues(alpha: 0.8),
        offset: Offset(0, 0),
      ),
      // Дополнительное широкое свечение для объема
      Shadow(
        blurRadius: 35.0,
        color: Colors.purple.withValues(alpha: 0.6),
        offset: Offset(0, 0),
      ),
      // Тонкий контур для четкости (опционально)
      Shadow(blurRadius: 2.0, color: Colors.purple, offset: Offset(0, 0)),
    ],
  );
  static double specialTextHeight = 20;

  static final normalFont = GoogleFonts.roboto();
}
