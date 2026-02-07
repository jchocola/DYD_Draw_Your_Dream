import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/core/theme/app_color.dart';
import 'package:flutter/material.dart';

final lightTheme = ThemeData.light().copyWith(


  primaryColor: AppColor.black,
  

  
  colorScheme: ColorScheme.light(

    primary: AppColor.purple.withValues(alpha: 0.4),
   
    secondary: AppColor.darkBlue,

    tertiary: AppColor.white,

    onPrimaryContainer: AppColor.grey,

    error: AppColor.red


  ),


  ///
  /// DIVIDER
  ///
  dividerTheme: DividerThemeData(
    color: AppColor.grey3,
    thickness: 0.5,
  ),

  ///
  /// ICON THEME
  ///
  iconTheme: IconThemeData(
    color: AppColor.grey2,
  ),


  ///
  /// ICON BUTTON THEME
  ///
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: AppColor.grey2,
    ),
  ),


  ///
  /// TEXT THEME
  ///
  textTheme: TextTheme(
    bodySmall: AppConstant.normalFont.copyWith(
      color: AppColor.grey2
    ),
    bodyMedium: AppConstant.normalFont.copyWith(
      color: AppColor.grey2
    ),
    titleMedium: AppConstant.normalFont.copyWith(
      color: AppColor.grey2,
      fontSize: 17,
      fontWeight: FontWeight.w600,
    )
  ),


  ///
  /// DIALOG
  ///
  dialogTheme: DialogThemeData(
    backgroundColor: AppColor.purple.withValues(alpha: 0.3)
  ),

  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStatePropertyAll(AppConstant.normalFont.copyWith(color: AppColor.white))
    )
  )
);