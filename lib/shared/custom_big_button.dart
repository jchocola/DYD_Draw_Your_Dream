import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:flutter/material.dart';

class CustomBigButton extends StatelessWidget {
  const CustomBigButton({super.key, this.title, this.onTap});
  final String? title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppConstant.appPadding),
        color: Colors.blue, child: Center(child: Text(title ?? 'Big Button'))));
  }
}
