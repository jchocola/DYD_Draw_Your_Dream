import 'package:background/background.dart';
import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/core/icon/app_icon.dart';
import 'package:dyd_drawer/feature/feature_painter/bloc/painting_controller_bloc.dart';
import 'package:dyd_drawer/feature/feature_painter/widget/menu_tool_bar.dart';
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
    return BlocBuilder<PaintingControllerBloc, PaintingControllerState>(
      builder: (context, state) {
        if (state is PaitingControllerInitialized) {
          return  SafeArea(
            child: Padding(
              padding: EdgeInsets.all(AppConstant.appPadding),
              child: Column(
                spacing: AppConstant.appPadding,
                children: [
                  MenuToolBar(),

                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          logger.d('Toggle drawing');
                         state.controller.toggleDrawing();
                        },
                        icon: Icon(Icons.brush),
                      ),
                      IconButton(
                        onPressed: () {
                          logger.d('Toggle drawing');
                          state.controller.changeBrushValues(
                            size: 10,
                            color: Colors.red,
                          );
                        },
                        icon: Icon(Icons.brush),
                      ),

                      IconButton(
                        onPressed: () {
                          logger.d('Toggle drawing');
                          state.controller.changeBrushValues(
                            size: 10,
                            color: Colors.cyanAccent,
                          );
                        },
                        icon: Icon(Icons.brush),
                      ),

                      IconButton(
                        onPressed: () {
                          logger.d('Toggle drawing');
                          state.controller.toggleErasing();
                          state.controller.changeEraseValues(
                            size: 10,
                            color: Colors.black87,
                          );
                        },
                        icon: Icon(Icons.brush),
                      ),

                      IconButton(
                        onPressed: () async {
                          logger.d('Toggle drawing');
                          final image = await state.controller.renderImage();

                          logger.d('Rendered image: $image');
                        },
                        icon: Icon(Icons.brush),
                      ),

                      IconButton(
                        onPressed: () async {
                          logger.d('Toggle drawing');
                          state.controller.addShape(ShapeType.circle);
                        },
                        icon: Icon(Icons.brush),
                      ),
                    ],
                  ),

                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(
                      AppConstant.borderRadius,
                    ),
                    child: Container(
                      color: Colors.white,
                      height: size.height * 0.6,
                      width: double.infinity,
                      child: PainterWidget(
                        boundaryMargin: 0.0,
                        controller: state.controller,
                      ),
                    ),
                  ),
                  //EditingBoard()
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
