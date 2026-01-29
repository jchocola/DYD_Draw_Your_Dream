/*
    LOGIN PART
      - user can input [LOGIN / PASSWORD]
 */

import 'package:dyd_drawer/shared/custom_textfiled.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Login'),

        ///
        /// LOGIN
        ///
        CustomTextfiled(
          title: 'E-mail',
        ),

        ///
        /// PASSWORD
        ///
        CustomTextfiled(
          title: 'Password',
        ),
      ],
    );
  }
}
