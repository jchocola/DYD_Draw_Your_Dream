/*
    REGISTER PART
      - user can input [NAME / EMAIL / PASSWORD / CONFIRM PASSWORD]
      
    NOTE :
      - Validate [ EMAIL ]
      - Lenght of [PASSWORD] is 8-16 symbols
 */

import 'package:dyd_drawer/core/constant/app_constant.dart';
import 'package:dyd_drawer/shared/custom_textfiled.dart';
import 'package:flutter/material.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({super.key, this.nameController, this.emailController, this.passwordController, this.confirmController});
  final TextEditingController? nameController;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final TextEditingController? confirmController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppConstant.appSpacing,
      children: [
        Text('Регистрация',  style: AppConstant.specialFont),

        ///
        /// NAME
        ///
        CustomTextfiled(title: 'Name', controller: nameController),

        ///
        /// EMAIL
        ///
        CustomTextfiled(title: "E-mail", controller: emailController),

        ///
        /// DIVIDER
        ///
        Divider(),

        ///
        /// PASSWORD
        ///
        CustomTextfiled(title: 'Password', controller: passwordController, obscureText: true,),

        ///
        /// CONFIRM PASSWORD
        ///
        CustomTextfiled(
          title: 'Confirm Password',
          controller: confirmController,
          obscureText: true,
        ),
      ],
    );
  }
}
