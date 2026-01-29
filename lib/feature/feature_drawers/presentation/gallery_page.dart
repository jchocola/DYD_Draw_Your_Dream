import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/core/icon/app_icon.dart';
import 'package:dyd_drawer/core/router/app_route.dart';
import 'package:dyd_drawer/feature/feature_drawers/widget/drawer_list_widget.dart';
import 'package:dyd_drawer/main.dart';
import 'package:dyd_drawer/shared/custom_appbar.dart';
import 'package:dyd_drawer/shared/custom_big_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Gallery',
        withLeading: true,
        leading: IconButton(
          onPressed: () {
            logger.i('LogOut Tapped');
            context.go(AppRoute.AUTH_PAGE);
          },
          icon: Icon(AppIcon.logOutIcon),
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
      child: Column(
        spacing: AppConstant.appPadding,
        children: [
          ///
          /// SAVED DRAWERS
          ///
          Expanded(child: DrawerListWidget()),

          ///
          /// CREATE BUTTON
          ///
          SafeArea(
            child: CustomBigButton(
              title: 'Create',
              onTap: () {
                logger.i('CREATE NEW PAINTER TAPPED');
                context.push(AppRoute.CREATE_PAINTER);
              },
            ),
          ),
        ],
      ),
    );
  }
}
