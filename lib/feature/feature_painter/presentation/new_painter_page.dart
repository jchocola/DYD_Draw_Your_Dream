import 'package:background/background.dart';
import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/core/icon/app_icon.dart';
import 'package:dyd_drawer/feature/feature_painter/widget/editing_board.dart';
import 'package:dyd_drawer/feature/feature_painter/widget/menu_tool_bar.dart';
import 'package:dyd_drawer/main.dart';
import 'package:dyd_drawer/shared/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:simple_painter/simple_painter.dart';

class NewPainterPage extends StatefulWidget {
  const NewPainterPage({super.key});

  @override
  State<NewPainterPage> createState() => _NewPainterPageState();
}

class _NewPainterPageState extends State<NewPainterPage> {
  final PainterController controller = PainterController(
    settings: PainterSettings(),
  );

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
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
        child: Column(
          spacing: AppConstant.appPadding,
          children: [
            MenuToolBar(),

            Row(
              children: [
                IconButton(
                  onPressed: () {
                    logger.d('Toggle drawing');
                    controller.toggleDrawing();
                  },
                  icon: Icon(Icons.brush),
                ),
                IconButton(
                  onPressed: () {
                    logger.d('Toggle drawing');
                    controller.changeBrushValues(size: 10, color: Colors.red);
                  },
                  icon: Icon(Icons.brush),
                ),

                 IconButton(
                  onPressed: () {
                    logger.d('Toggle drawing');
                    controller.changeBrushValues(size: 10, color: Colors.cyanAccent);
                  },
                  icon: Icon(Icons.brush),
                ),

                IconButton(
                  onPressed: () {
                    logger.d('Toggle drawing');
                    controller.toggleErasing();
                    controller.changeEraseValues(size: 10, color: Colors.black87);
                  },
                  icon: Icon(Icons.brush),
                ),

                IconButton(
                  onPressed: () async{
                    logger.d('Toggle drawing');
                final image =    await controller.renderImage();

                logger.d('Rendered image: $image');
                  },
                  icon: Icon(Icons.brush),
                ),

                 IconButton(
                  onPressed: () async{
                    logger.d('Toggle drawing');
                 controller.addShape(ShapeType.circle);

               
                  },
                  icon: Icon(Icons.brush),
                ),
              ],
            ),

            SizedBox(
              height: 400,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(AppConstant.borderRadius),
                child: PainterWidget(
                 // boundaryMargin: 0.0,
                  controller: controller),
              )),
            //EditingBoard()
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
