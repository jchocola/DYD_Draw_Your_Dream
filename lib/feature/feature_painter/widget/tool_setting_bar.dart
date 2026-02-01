import 'package:dyd_drawer/feature/feature_painter/bloc/painting_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToolSettingBar extends StatelessWidget {
  const ToolSettingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaintingControllerBloc, PaintingControllerState>(
      builder: (context, state) {
        if (state is PaitingControllerInitialized) {
          if (state.isDrawing) {
            return _buildDrawingSettings();
          } else if (state.isErasing) {
            return _buildEraserSettings();
          } else {
            return SizedBox.shrink();
          }
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildDrawingSettings() {
    return BlocBuilder<PaintingControllerBloc, PaintingControllerState>(
      builder: (context, state) {
        if (state is PaitingControllerInitialized) {
          return Column(
            children: [
              /// Brush Size Slider
              Row(
                children: [
                  Text('Размер кисти:'),
                  Flexible(
                    child: Slider(
                      value: state.brushSize,
                      onChanged: (value) {
                        // Update brush size in the bloc
                        context.read<PaintingControllerBloc>().add(
                          PaintingControllerEvent_changeBrushSize(size: value),
                        );
                      },
                      min: 1,
                      max: 50,
          
                    ),
                  ),
                  Text(state.brushSize.toInt().toString()),
                ],
              ),
            ],
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }




  Widget _buildEraserSettings() {
    return BlocBuilder<PaintingControllerBloc, PaintingControllerState>(
      builder: (context, state) {
        if (state is PaitingControllerInitialized) {
          return Column(
            children: [
              /// Eraser Size Slider
              Row(
                children: [
                  Text('Размер ластика:'),
                  Flexible(
                    child: Slider(
                      value: state.eraserSize,
                      onChanged: (value) {
                        // Update eraser size in the bloc
                        context.read<PaintingControllerBloc>().add(
                          PaintingControllerEvent_changeEraserSize(size: value),
                        );
                      },
                      min: 1,
                      max: 50,
          
                    ),
                  ),
                  Text(state.eraserSize.toInt().toString()),
                ],
              ),
            ],
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
