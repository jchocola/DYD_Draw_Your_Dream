import 'dart:async';

import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/core/router/app_route.dart';
import 'package:dyd_drawer/core/snackbar/show_alert_snackbar.dart';
import 'package:dyd_drawer/feature/feature_drawers/bloc/drawers_bloc.dart';
import 'package:dyd_drawer/feature/feature_painter/bloc/painting_controller_bloc.dart';
import 'package:dyd_drawer/main.dart';
import 'package:dyd_drawer/shared/drawer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DrawerListWidget extends StatelessWidget {
  const DrawerListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrawersBloc, DrawersBlocState>(
      builder: (context, state) {
        if (state is DrawersBlocStateLoaded) {
          // empty case
          if (state.painters.isEmpty) {
            return SizedBox.shrink();
          }

          return GridView.builder(
            shrinkWrap: true,

            itemCount: state.painters.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: AppConstant.crossAxisCount,
              mainAxisSpacing: AppConstant.appPadding,
              crossAxisSpacing: AppConstant.appPadding,
              childAspectRatio: AppConstant.drawerCardAspectRatio,
            ),
            itemBuilder: (context, index) {
              return DrawerCard(
                painterEntity: state.painters[index],
                onTap: () async {
                  final completer = Completer<void>();

                  showAlertSnackBar(context, title: 'Идет заргузка', message: 'Подкачиваем данные из сервера');
                  logger.i('ON PAINTER CARD TAPPED');
                  context.read<PaintingControllerBloc>().add(
                    PaintingControllerEvent_editImageFromServer(
                      painter: state.painters[index],
                      completer: completer,
                    ),
                  );

                  await completer.future;

                  context.push(
                    AppRoute.CREATE_PAINTER,
                    extra: {"isEdit": true},
                  );
                },
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
