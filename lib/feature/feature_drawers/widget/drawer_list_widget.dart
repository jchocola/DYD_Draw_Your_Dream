import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/core/router/app_route.dart';
import 'package:dyd_drawer/main.dart';
import 'package:dyd_drawer/shared/drawer_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrawerListWidget extends StatelessWidget {
  const DrawerListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,

      itemCount: 15,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppConstant.crossAxisCount,
        mainAxisSpacing: AppConstant.appPadding,
        crossAxisSpacing: AppConstant.appPadding,
        childAspectRatio: AppConstant.drawerCardAspectRatio,
      ),
      itemBuilder: (context, index) {
        return DrawerCard(
          onTap: () {
            logger.i('ON PAINTER CARD TAPPED');
            context.push(AppRoute.EDIT_PAINTER);
          },
        );
      },
    );
  }
}
