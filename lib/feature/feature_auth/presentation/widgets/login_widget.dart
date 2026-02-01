/*
    LOGIN PART
      - user can input [LOGIN / PASSWORD]
 */

import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/shared/custom_textfiled.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key, this.emailController, this.passwordController});
final TextEditingController? emailController;
final TextEditingController? passwordController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppConstant.appSpacing,
      children: [
        Text('Вход', style: AppConstant.specialFont,),

        ///
        /// LOGIN
        ///
        CustomTextfiled(
          title: 'E-mail',
          controller: emailController,
          hintText: 'Введите электронную почту',
        ),

        ///
        /// PASSWORD
        ///
        CustomTextfiled(
          obscureText: true,
          title: 'Подтверждение пароля',
          controller: passwordController,
          hintText: 'Введите пароль',
        ),

      ],
    );
  }
}
