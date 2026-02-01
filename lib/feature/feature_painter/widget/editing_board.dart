import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/feature/feature_painter/bloc/painting_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_painter/simple_painter.dart';

class EditingBoard extends StatelessWidget {
  const EditingBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocBuilder<PaintingControllerBloc, PaintingControllerState>(
      builder: (context, state) {
        if (state is PaitingControllerInitialized) {
          return ClipRRect(
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
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
