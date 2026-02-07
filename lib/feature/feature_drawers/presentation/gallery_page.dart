import 'package:background/background.dart';
import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/core/icon/app_icon.dart';
import 'package:dyd_drawer/core/router/app_route.dart';
import 'package:dyd_drawer/feature/feature_auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:dyd_drawer/feature/feature_drawers/bloc/drawers_bloc.dart';
import 'package:dyd_drawer/feature/feature_drawers/widget/drawer_list_widget.dart';
import 'package:dyd_drawer/feature/feature_painter/bloc/painting_controller_bloc/painting_controller_bloc.dart';
import 'package:dyd_drawer/main.dart';
import 'package:dyd_drawer/shared/custom_appbar.dart';
import 'package:dyd_drawer/shared/custom_big_button.dart';
import 'package:dyd_drawer/shared/custom_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    void logOutUser() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Выйти из системы ?'),
            actions: [
              TextButton(
                onPressed: () {
                  context.pop();
                },
                child: Text(
                  'Отмена',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.tertiary,
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthBlocEventLogOut());
                },
                child: Text(
                  'Подтвердить',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.primaryColor,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    void createNewPainter() {
      logger.i('CREATE NEW PAINTER TAPPED');
      context.read<PaintingControllerBloc>().add(
        PaintingControllerEventResetPaintingController(),
      );
      context.push(AppRoute.createPainter);
    }

    return BlocListener<AuthBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is AuthBlocStateUnAuthenticated) {
          context.go(AppRoute.authPage);
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppbar(
          title: 'Галерея',
          withLeading: true,
          leading: CustomIcon(
            svgAsset: AppIcon.logOutIcon,
            size: 30,
            color: theme.colorScheme.error,
            onTap: logOutUser,
          ),
          withAction: true,
          action: BlocBuilder<DrawersBloc, DrawersBlocState>(
            builder: (context, state) {
              if (state is DrawersBlocStateLoaded &&
                  state.painters.isNotEmpty) {
                return CustomIcon(
                  svgAsset: AppIcon.painterIcon,
                  size: 30,
                  color: theme.colorScheme.onPrimaryContainer,
                  onTap: createNewPainter,
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ),
        body: Background(path: AppConstant.appBg, child: _buildBody(context)),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final theme = Theme.of(context);

    void createNewPainter() {
      logger.i('CREATE NEW PAINTER TAPPED');

      context.read<PaintingControllerBloc>().add(
        PaintingControllerEventResetPaintingController(),
      );
      context.push(AppRoute.createPainter);
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstant.appPadding,
        vertical: AppConstant.appPadding * 2,
      ),
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
          BlocBuilder<DrawersBloc, DrawersBlocState>(
            builder: (context, state) {
              if (state is DrawersBlocStateLoaded) {
                if (state.painters.isEmpty) {
                  return CustomBigButton(
                    titleColor: theme.colorScheme.tertiary,
                    withGradient: true,
                    title: 'Создать ',
                    onTap: createNewPainter,
                  );
                } else {
                  return SizedBox.shrink();
                }
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
