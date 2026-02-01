import 'dart:ui';

import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomTextfiled extends StatelessWidget {
  const CustomTextfiled({
    super.key,
    this.title,
    this.controller,
    this.hintText,
    this.obscureText = false,
    this.validator,
    this.onChanged,
  });
  final String? title;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppConstant.borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Container(
          padding: EdgeInsets.all(AppConstant.appPadding),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColor.black.withOpacity(0.5),
                blurRadius: 40,
                offset: Offset(0, 4),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.0, 0.8],
              colors: [
                AppColor.purple.withOpacity(0.05),
                AppColor.darkBlue.withOpacity(0.08),
              ],
            ),

            // backgrounBlendMode: BlendMode.multiply,
            borderRadius: BorderRadius.circular(AppConstant.borderRadius),
            border: Border.all(color: AppColor.grey2, width: 0.5),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title ?? '', style: theme.textTheme.bodySmall),
              TextFormField(
                validator: validator,
                onChanged: onChanged,
                obscureText: obscureText,
                obscuringCharacter: '*',
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: theme.textTheme.bodyMedium,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColor.grey2, width: 0.3),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColor.grey2, width: 0.3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
