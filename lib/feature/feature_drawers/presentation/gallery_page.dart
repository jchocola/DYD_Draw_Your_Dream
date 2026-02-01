import 'package:background/background.dart';
import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/core/icon/app_icon.dart';
import 'package:dyd_drawer/core/router/app_route.dart';
import 'package:dyd_drawer/feature/feature_auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:dyd_drawer/feature/feature_drawers/bloc/drawers_bloc.dart';
import 'package:dyd_drawer/feature/feature_drawers/widget/drawer_list_widget.dart';
import 'package:dyd_drawer/main.dart';
import 'package:dyd_drawer/shared/custom_appbar.dart';
import 'package:dyd_drawer/shared/custom_big_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    void logOutUser() {
      context.read<AuthBloc>().add(AuthBlocEvent_logOut());
    }

    return BlocListener<AuthBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is AuthBlocState_unAuthenticated) {
          context.go(AppRoute.AUTH_PAGE);
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppbar(
          title: 'Gallery',
          withLeading: true,
          leading: IconButton(
            onPressed: logOutUser,
            icon: Icon(AppIcon.logOutIcon),
          ),
          withAction: true,
          action: BlocBuilder<DrawersBloc, DrawersBlocState>(
            builder: (context, state) {
              if (state is DrawersBlocStateLoaded &&
                  state.painters.isNotEmpty) {
                return IconButton(
                  onPressed: () {
                     logger.i('CREATE NEW PAINTER TAPPED');
                      context.push(AppRoute.CREATE_PAINTER);
                  },
                  icon: Icon(AppIcon.painterIcon),
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
                    title: 'Create',
                    onTap: () {
                      logger.i('CREATE NEW PAINTER TAPPED');
                      context.push(AppRoute.CREATE_PAINTER);
                    },
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
