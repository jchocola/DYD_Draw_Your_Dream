/*
    REGISTER PART
      - user can input [NAME / EMAIL / PASSWORD / CONFIRM PASSWORD]
      
    NOTE :
      - Validate [ EMAIL ]
      - Lenght of [PASSWORD] is 8-16 symbols
 */

import 'package:dyd_drawer/shared/custom_textfiled.dart';
import 'package:flutter/material.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Register'),

        ///
        /// NAME
        ///
        CustomTextfiled(title: 'Name',),

        ///
        /// EMAIL
        ///
        CustomTextfiled(title: "E-mail",),

        ///
        /// DIVIDER
        ///
        Divider(),
        
        ///
        /// PASSWORD
        ///
        CustomTextfiled(title: 'Password',),

        ///
        /// CONFIRM PASSWORD
        ///
         CustomTextfiled(title: 'Confirm Password',),
      ],
    );
  }
}
