import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/feature/feature_painter/bloc/painting_controller_bloc/painting_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final List<List<Color>> colorPalette = [
  // Оттенки серого (Grayscale)
  [
    Color(0xFFFEFFFE),
    Color(0xFFEBEBEB),
    Color(0xFFD6D6D6),
    Color(0xFFC2C2C2),
    Color(0xFFADADAD),
    Color(0xFF999999),
    Color(0xFF858585),
    Color(0xFF707070),
    Color(0xFF5C5C5C),
    Color(0xFF474747),
    Color(0xFF333333),
    Color(0xFF000000),
  ],
  // Ряд 2 (Самые темные/насыщенные)
  [
    Color(0xFF1E4C63),
    Color(0xFF102E76),
    Color(0xFF180B4F),
    Color(0xFF3F1256),
    Color(0xFF4E1629),
    Color(0xFF781E0E),
    Color(0xFF722F10),
    Color(0xFF734C16),
    Color(0xFF73591A),
    Color(0xFF8C8629),
    Color(0xFF707625),
    Color(0xFF3F5623),
  ],
  // Ряд 3
  [
    Color(0xFF2F6C8C),
    Color(0xFF1941A3),
    Color(0xFF280B72),
    Color(0xFF591E78),
    Color(0xFF6F223D),
    Color(0xFFA62C17),
    Color(0xFFA0461A),
    Color(0xFFA06B23),
    Color(0xFF9F7D28),
    Color(0xFFC3BC3C),
    Color(0xFF9DA536),
    Color(0xFF587934),
  ],
  // Ряд 4
  [
    Color(0xFF3D8AB0),
    Color(0xFF2355CE),
    Color(0xFF331B8E),
    Color(0xFF702898),
    Color(0xFF8D2E4F),
    Color(0xFFD03A20),
    Color(0xFFCA5A24),
    Color(0xFFC8872E),
    Color(0xFFC99F35),
    Color(0xFFF3EC4E),
    Color(0xFFC6D147),
    Color(0xFF729C44),
  ],
  // Ряд 5 (Средние тона)
  [
    Color(0xFF479FD3),
    Color(0xFF285FF4),
    Color(0xFF4724AB),
    Color(0xFF8C33B6),
    Color(0xFFAA395D),
    Color(0xFFEB512E),
    Color(0xFFED732E),
    Color(0xFFF3AF3D),
    Color(0xFFF4C944),
    Color(0xFFFEFB67),
    Color(0xFFDDEB5C),
    Color(0xFF86B953),
  ],
  // Ряд 6
  [
    Color(0xFF78D3F8),
    Color(0xFF7FA6F8),
    Color(0xFF7E52F4),
    Color(0xFFC45FF6),
    Color(0xFFDE789D),
    Color(0xFFF09286),
    Color(0xFFF1A984),
    Color(0xFFF5C983),
    Color(0xFFF8DA85),
    Color(0xFFFEF9A1),
    Color(0xFFEBF29B),
    Color(0xFFBADC94),
  ],
  // Ряд 7
  [
    Color(0xFFA5E1F9),
    Color(0xFFADC5FA),
    Color(0xFFAB8DF7),
    Color(0xFFD796F8),
    Color(0xFFE8A7BF),
    Color(0xFFF4B8B1),
    Color(0xFFF6C7AF),
    Color(0xFFF8DAAE),
    Color(0xFFF9E5AF),
    Color(0xFFFEFBC0),
    Color(0xFFF2F7BE),
    Color(0xFFD2E7BA),
  ],
  // Ряд 8 (Самые светлые/пастельные)
  [
    Color(0xFFD2EFFD),
    Color(0xFFD5E1FB),
    Color(0xFFD5C9FA),
    Color(0xFFE9CBFB),
    Color(0xFFF3D4DF),
    Color(0xFFF9DBD9),
    Color(0xFFFAE3D8),
    Color(0xFFFBEDD7),
    Color(0xFFFCF2D8),
    Color(0xFFFDFBE0),
    Color(0xFFF7FADE),
    Color(0xFFE1EDD6),
  ],
];

class ColorPalletePicker extends StatelessWidget {
  const ColorPalletePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaintingControllerBloc, PaintingControllerState>(
      builder: (context, state) {
        if (state is PaitingControllerInitialized) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(AppConstant.appPadding),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 12,
              ),
              itemCount: 96, // 8 строк * 12 столбцов
              itemBuilder: (context, index) {
                int row = index ~/ 12;
                int col = index % 12;
                return GestureDetector(
                  onTap: () {
                    context.read<PaintingControllerBloc>().add(
                      PaintingControllerEventChangeColor(
                        color: colorPalette[row][col],
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorPalette[row][col],
                      border: state.pickedColor == colorPalette[row][col]
                          ? Border.all(color: Colors.white, width: 2)
                          : null,
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
