import 'package:flutter/material.dart';

class CustomTextfiled extends StatelessWidget {
  const CustomTextfiled({super.key, this.title, this.controller});
  final String? title;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title ?? ''),
        TextField(
          controller: controller,
        ),
      ],
    );
  }
}
