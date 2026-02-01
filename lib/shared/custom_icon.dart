import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.svgAsset, this.size = 10, this.color = Colors.black54, this.onTap});
  final String svgAsset;
  final double size;
  final Color color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
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
