import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/core/icon/app_icon.dart';
import 'package:dyd_drawer/feature/feature_painter/widget/editing_board.dart';
import 'package:dyd_drawer/feature/feature_painter/widget/menu_tool_bar.dart';
import 'package:dyd_drawer/shared/custom_appbar.dart';
import 'package:flutter/material.dart';

class EditPainterPage extends StatelessWidget {
  const EditPainterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Редактирование',
        withAction: true,
        action: IconButton(onPressed: () {}, icon: Icon(AppIcon.checkIcon)),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
        child: Column(
          spacing: AppConstant.appPadding,
          children: [MenuToolBar(), EditingBoard()],
        ),
      ),
    );
  }
}
