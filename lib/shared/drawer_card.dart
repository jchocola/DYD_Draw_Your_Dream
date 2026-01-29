import 'package:flutter/material.dart';

class DrawerCard extends StatelessWidget {
  const DrawerCard({super.key, this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.amberAccent,
      ),
    );
  }
}
