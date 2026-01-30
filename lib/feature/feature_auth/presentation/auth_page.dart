/*
  AUTH PAGE 
      - page , where user can LOGIN or REGISTER
 */

import 'package:background/background.dart';
import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/core/icon/app_icon.dart';
import 'package:dyd_drawer/core/router/app_route.dart';
import 'package:dyd_drawer/feature/feature_auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:dyd_drawer/feature/feature_auth/presentation/widgets/login_widget.dart';
import 'package:dyd_drawer/feature/feature_auth/presentation/widgets/register_widget.dart';
import 'package:dyd_drawer/main.dart';
import 'package:dyd_drawer/shared/custom_big_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // text controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  bool isLogin =
      true; // variable for track mode , true = LOGIN , false = REGISTER

  // Toogle isLogin value functtion
  void toogleIsLogin() {
    setState(() {
      clearControllers();
      isLogin = !isLogin;
    });
  }

  Future<void> registerUser() async {
    logger.i('Register user with :');
    logger.i('EMAIL : ${emailController.text}');
    logger.i('PASSWORD : ${passwordController.text}');
    context.read<AuthBloc>().add(
      AuthBlocEvent_registerUser(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        confirmPassword: confirmController.text,
      ),
    );
  }

  Future<void> loginUser() async {
    logger.i('Login user with :');
    logger.i('EMAIL : ${emailController.text}');
    logger.i('PASSWORD : ${passwordController.text}');
    context.read<AuthBloc>().add(
      AuthBlocEvent_logIn(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
  }

  // build UI
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Background(
          path: AppConstant.appBg,
          child: BlocConsumer<AuthBloc, AuthBlocState>(
            listener: (context, state) {
              if (state is AuthBlocState_authenticated) {
                context.go(AppRoute.GALLERY_PAGE);
              }
              if (state is AuthBlocState_failure) {
                logger.e('Auth Error : ${state.error}');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.error}')),
                );
              }
            },
            builder: (context, state) {
              if (state is AuthBlocState_loading) {
                return Center(child: CircularProgressIndicator());
              }
              return _buildBody(context);
            },
          ),
        ),
      ),
    );
  }

  // Build Body UI
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
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isLogin
                          ? LoginWidget(
                              emailController: emailController,
                              passwordController: passwordController,
                            )
                          : RegisterWidget(
                              nameController: nameController,
                              emailController: emailController,
                              passwordController: passwordController,
                              confirmController: confirmController,
                            ),
                    ],
                  ),
                ),
              ),
            ),

            ///
            /// BUTTONS PART
            ///
            SingleChildScrollView(
              child: Column(
                spacing: AppConstant.appSpacing,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // LOGIN BUTTON
                  isLogin
                      ? CustomBigButton(
                          withGradient: true,
                          title: 'Войти',
                          onTap: loginUser,
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
                              child: CustomBigButton(
                                title: "Зарегистрироваться",
                                onTap: registerUser,
                              ),
                            ),
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void clearControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmController.clear();
  }

  @override
  void dispose() {
    super.dispose();

    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
  }
}
