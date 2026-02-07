/*
  AUTH PAGE 
      - page , where user can LOGIN or REGISTER
 */

import 'package:background/background.dart';
import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/core/exception/app_exception_converter.dart';
import 'package:dyd_drawer/core/icon/app_icon.dart';
import 'package:dyd_drawer/core/router/app_route.dart';
import 'package:dyd_drawer/core/snackbar/show_error_snackbar.dart';
import 'package:dyd_drawer/feature/feature_auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:dyd_drawer/feature/feature_auth/presentation/widgets/login_widget.dart';
import 'package:dyd_drawer/feature/feature_auth/presentation/widgets/register_widget.dart';
import 'package:dyd_drawer/feature/feature_drawers/bloc/drawers_bloc.dart';
import 'package:dyd_drawer/main.dart';
import 'package:dyd_drawer/shared/custom_big_button.dart';
import 'package:dyd_drawer/shared/custom_icon.dart';
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

  // form keys
  final _formKey = GlobalKey<FormState>(); // for validation email and password
  final ValueNotifier<bool> _isFormValid = ValueNotifier<bool>(false);

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
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
      AuthBlocEventRegisterUser(
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

    // validate
    if (_formKey.currentState?.validate()== false) {
      return;
    }

    context.read<AuthBloc>().add(
      AuthBlocEventLogIn(
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
              if (state is AuthBlocStateAuthenticated) {
                // load painters
                context.read<DrawersBloc>().add(DrawersBlocEventLoadPainters());

                // go to gallery page
                context.go(AppRoute.galleryPage);
              }
              if (state is AuthBlocStateFailure) {
                logger.e('Auth Error : ${state.error}');
                showErrorSnackBar(
                  context,
                  title: 'Упс !',
                  message: appExceptionConvert(context, exception: state.error),
                );
              }
            },
            builder: (context, state) {
              if (state is AuthBlocStateLoading) {
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
    final theme = Theme.of(context);

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
                              formKey: _formKey,
                            )
                          : RegisterWidget(
                              nameController: nameController,
                              emailController: emailController,
                              passwordController: passwordController,
                              confirmController: confirmController,
                              formKey: _formKey,
                              onFormChanged: (isValid) {
                                _isFormValid.value = isValid;
                              },
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
                          titleColor: theme.colorScheme.tertiary,
                        )
                      : Container(),

                  //REGISTRATION BUTTON
                  isLogin
                      ? CustomBigButton(
                          titleColor: theme.primaryColor,
                          title: "Регистрация",
                          onTap: toogleIsLogin,
                        )
                      : Container(),

                  // REGISTER BUTTON AND BACK TO LOGIN MODE
                  !isLogin
                      ? Row(
                          spacing: AppConstant.appSpacing,
                          children: [
                            CustomIcon(
                              onTap: toogleIsLogin,
                              svgAsset: AppIcon.arrowBackIcon,
                            ),

                            ///
                            /// REGISTER BUTTON
                            ///
                            Flexible(
                              child: ValueListenableBuilder<bool>(
                                valueListenable: _isFormValid,
                                builder: (context, isValid, child) =>
                                    CustomBigButton(
                                      buttonColor: isValid
                                          ? theme.colorScheme.tertiary
                                          : theme
                                                .colorScheme
                                                .onPrimaryContainer,
                                      title: "Зарегистрироваться",
                                      onTap: isValid ? registerUser : null,
                                    ),
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
    _isFormValid.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
  }
}
