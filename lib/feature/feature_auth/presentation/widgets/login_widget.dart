/*
    LOGIN PART
      - user can input [LOGIN / PASSWORD]
 */

import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/shared/custom_textfiled.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    super.key,
    this.emailController,
    this.passwordController,
    this.formKey,
  });
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final GlobalKey<FormState>? formKey;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppConstant.appSpacing,
        children: [
          Text('Вход', style: AppConstant.specialFont),
      
          ///
          /// LOGIN
          ///
          CustomTextfiled(
            title: 'E-mail',
            controller: emailController,
            onChanged: (value) {
              formKey?.currentState?.validate() ?? false;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return null;
              }
              if (value != null && !EmailValidator.validate(value)) {
                return 'Пожалуйста, введите корректный адрес электронной почты';
              }
              return null;
            },
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
            onChanged: (value) {
              formKey?.currentState?.validate();
            },
      
            validator: (value) {
              if (value == null || value.isEmpty) {
                return null;
              }
              if (value.length < 8 || value.length > 16) {
                return 'Пароль должен содержать от 8 до 16 символов';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
