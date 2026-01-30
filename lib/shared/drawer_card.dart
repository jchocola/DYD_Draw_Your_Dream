import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:flutter/material.dart';

class DrawerCard extends StatelessWidget {
  const DrawerCard({super.key, this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstant.borderRadius),
        
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
       
      ),
    );
  }
}
