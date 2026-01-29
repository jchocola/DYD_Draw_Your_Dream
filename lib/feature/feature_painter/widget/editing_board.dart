import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:flutter/material.dart';

class EditingBoard extends StatelessWidget {
  const EditingBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
        color: Colors.green,
      ),
      
    ));
  }
}
