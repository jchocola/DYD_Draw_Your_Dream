import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.svgAsset, this.size = 30, this.color = AppColor.grey2, this.onTap});
  final String svgAsset;
  final double size;
  final Color color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
       // padding: EdgeInsets.all(AppConstant.appPadding),
        height: size,
        width: size,
        child: SvgPicture.asset(
          svgAsset,
          color: color,
          fit: BoxFit.contain,
          height: size,
          width: size,
        ),
      ),
    );
  }
}
