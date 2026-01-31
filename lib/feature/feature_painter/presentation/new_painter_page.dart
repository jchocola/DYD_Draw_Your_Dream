import 'package:background/background.dart';
import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/core/icon/app_icon.dart';
import 'package:dyd_drawer/core/snackbar/show_error_snackbar.dart';
import 'package:dyd_drawer/core/snackbar/show_success_snackbar.dart';
import 'package:dyd_drawer/feature/feature_painter/bloc/painting_controller_bloc.dart';
import 'package:dyd_drawer/feature/feature_painter/widget/menu_tool_bar.dart';
import 'package:dyd_drawer/feature/feature_painter/widget/tool_setting_bar.dart';
import 'package:dyd_drawer/main.dart';
import 'package:dyd_drawer/shared/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_painter/simple_painter.dart';

class NewPainterPage extends StatelessWidget {
  const NewPainterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppbar(
        title: 'Новое Изображенение',
        withAction: true,
        action: IconButton(onPressed: () {}, icon: Icon(AppIcon.checkIcon)),
      ),
      body: Background(path: AppConstant.appBg, child: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocConsumer<PaintingControllerBloc, PaintingControllerState>(
      listener: (context, state) {
        if (state is PaintingControllerFailure) {
          showErrorSnackBar(context, message: state.exception.toString());
        } else if (state is PaintingControllerSuccess) {
          showSuccessSnackBar(context, message: state.exception.toString());
        }
      },
      builder: (context, state) {
        if (state is PaitingControllerInitialized) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(AppConstant.appPadding),
              child: Column(
                spacing: AppConstant.appPadding,
                children: [
                  ///
                  /// MENU TOOL BAR
                  ///
                  MenuToolBar(),

                  ///
                  /// PAINTING AREA
                  ///
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(
                      AppConstant.borderRadius,
                    ),
                    child: Container(
                      color: Colors.white.withOpacity(0.2),
                      height: size.height * 0.6,
                      width: double.infinity,
                      child: PainterWidget(
                        boundaryMargin: 0.0,
                        controller: state.controller,
                      ),
                    ),
                  ),

                  /// TOOL SETTING BAR
                  Expanded(child: ToolSettingBar()),
                ],
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
