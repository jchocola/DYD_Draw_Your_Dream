import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomBigButton extends StatelessWidget {
  const CustomBigButton({
    super.key,
    this.title,
    this.onTap,
    this.withGradient = false,
    this.titleColor = Colors.black54,
    this.buttonColor = AppColor.white,
  });
  final String? title;
  final void Function()? onTap;
  final bool withGradient;
  final Color titleColor;
  final Color buttonColor;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstant.borderRadius),
          gradient: withGradient ? AppConstant.buttonGradient() : null,
          color: withGradient ? null : buttonColor,
        ),

        padding: EdgeInsets.symmetric(
          horizontal: AppConstant.appPadding,
          vertical: 12,
        ),
        child: Center(
          child: Text(
            title ?? 'Big Button',
            style: theme.textTheme.titleMedium?.copyWith(color: titleColor),
          ),
        ),
      ),
    );
  }
}
