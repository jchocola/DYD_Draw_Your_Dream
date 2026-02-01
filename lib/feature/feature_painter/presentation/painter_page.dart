import 'package:background/background.dart';
import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/core/exception/app_exception_converter.dart';
import 'package:dyd_drawer/core/icon/app_icon.dart';
import 'package:dyd_drawer/core/snackbar/show_error_snackbar.dart';
import 'package:dyd_drawer/core/snackbar/show_success_snackbar.dart';
import 'package:dyd_drawer/feature/feature_painter/bloc/painting_controller_bloc.dart';
import 'package:dyd_drawer/feature/feature_painter/widget/editing_board.dart';
import 'package:dyd_drawer/feature/feature_painter/widget/menu_tool_bar.dart';
import 'package:dyd_drawer/feature/feature_painter/widget/tool_setting_bar.dart';
import 'package:dyd_drawer/shared/custom_appbar.dart';
import 'package:dyd_drawer/shared/custom_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PainterPage extends StatelessWidget {
  const PainterPage({super.key, this.isEdit = false});
  final bool isEdit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppbar(
        title: isEdit ?'Редактирование' : 'Новое изображенение',
        withAction: true,
        withLeading: true,
        leading: CustomIcon(
          onTap: () => context.pop(),
          svgAsset: AppIcon.arrowBackIcon,
        ),
        action: CustomIcon(
          onTap: () => context.read<PaintingControllerBloc>().add(
            PaintingControllerEvent_savePainterToStore(),
          ),
          svgAsset: AppIcon.checkIcon,
        ),
      ),
      body: Background(path: AppConstant.appBg, child: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocConsumer<PaintingControllerBloc, PaintingControllerState>(
      listener: (context, state) {
        if (state is PaintingControllerFailure) {
          showErrorSnackBar(context, message: appExceptionConvert(context, exception: state.exception));
        } else if (state is PaintingControllerSuccess) {
          showSuccessSnackBar(context, message: appExceptionConvert(context, exception: state.exception));
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
                  EditingBoard(),
                  // ClipRRect(
                  //   borderRadius: BorderRadiusGeometry.circular(
                  //     AppConstant.borderRadius,
                  //   ),
                  //   child: Container(
                  //     color: Colors.white.withOpacity(0.2),
                  //     height: size.height * 0.6,
                  //     width: double.infinity,
                  //     child: PainterWidget(
                  //       boundaryMargin: 0.0,
                  //       controller: state.controller,
                  //     ),
                  //   ),
                  // ),

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
