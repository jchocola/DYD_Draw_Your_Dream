/*
  AUTH PAGE 
      - page , where user can LOGIN or REGISTER
 */

import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/core/icon/app_icon.dart';
import 'package:dyd_drawer/core/router/app_route.dart';
import 'package:dyd_drawer/feature/feature_auth/presentation/widgets/login_widget.dart';
import 'package:dyd_drawer/feature/feature_auth/presentation/widgets/register_widget.dart';
import 'package:dyd_drawer/shared/custom_big_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin =
      true; // variable for track mode , true = LOGIN , false = REGISTER

  // Toogle isLogin value functtion
  void toogleIsLogin() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
        child: Column(
          spacing: AppConstant.appSpacing,
          children: [
            ///
            /// LOGIN AND REGISTER PART
            ///
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [isLogin ? LoginWidget() : RegisterWidget()],
              ),
            ),
              
            ///
            /// BUTTONS PART
            ///
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  spacing: AppConstant.appSpacing,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // LOGIN BUTTON
                    isLogin
                        ? CustomBigButton(
                            title: 'Войти',
                            onTap: () {
                              context.go(AppRoute.GALLERY_PAGE);
                            },
                          )
                        : Container(),
                
                    //REGISTRATION BUTTON
                    isLogin
                        ? CustomBigButton(
                            title: "Регистрация",
                            onTap: toogleIsLogin,
                          )
                        : Container(),
                
                    // REGISTER BUTTON AND BACK TO LOGIN MODE
                    !isLogin
                        ? Row(
                            spacing: AppConstant.appSpacing,
                            children: [
                              IconButton(
                                onPressed: toogleIsLogin,
                                icon: Icon(AppIcon.arrowBackIcon),
                              ),
                              Flexible(
                                child: CustomBigButton(title: "Зарегистрироваться"),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
