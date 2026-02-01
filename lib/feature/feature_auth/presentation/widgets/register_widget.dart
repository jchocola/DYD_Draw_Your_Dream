/*
    REGISTER PART
      - user can input [NAME / EMAIL / PASSWORD / CONFIRM PASSWORD]
      
    NOTE :
      - Validate [ EMAIL ]
      - Lenght of [PASSWORD] is 8-16 symbols
 */

import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/shared/custom_textfiled.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({
    super.key,
    this.nameController,
    this.emailController,
    this.passwordController,
    this.confirmController,
    this.formKey,
    this.onFormChanged,
  });
  final TextEditingController? nameController;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final TextEditingController? confirmController;
  final GlobalKey<FormState>? formKey;
  final ValueChanged<bool>? onFormChanged;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      onChanged: () {
        // validate only email and password for the overall form-valid state
        final emailText = emailController?.text ?? '';
        final passwordText = passwordController?.text ?? '';
        final nameText = nameController?.text.isEmpty ?? true;
        final confirmText = confirmController?.text.isEmpty ?? true;
        final emailValid = EmailValidator.validate(emailText);
        final passwordValid = passwordText.length >= 8 && passwordText.length <= 16;
        final valid = emailValid && passwordValid && !nameText && !confirmText;
        
        onFormChanged?.call(valid);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppConstant.appSpacing,
        children: [
          Text('Регистрация', style: AppConstant.specialFont),

          ///
          /// NAME
          ///
          CustomTextfiled(title: 'Имя', controller: nameController, hintText: 'Введите ваше имя',),

          ///
          /// EMAIL
          ///
          CustomTextfiled(
            title: "E-mail",
            hintText: 'Ваша электронная почта',
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
          ),

          ///
          /// DIVIDER
          ///
          Divider(),

          ///
          /// PASSWORD
          ///
          CustomTextfiled(
            title: 'Пароль',
            hintText: '8-16 символов',
            controller: passwordController,
            obscureText: true,
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

          ///
          /// CONFIRM PASSWORD
          ///
          CustomTextfiled(
            title: 'Подтверждение пароля',
            hintText: '8-16 символов',
            controller: confirmController,
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
