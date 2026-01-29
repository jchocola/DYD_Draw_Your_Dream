import 'package:flutter/material.dart';

class CustomTextfiled extends StatelessWidget {
  const CustomTextfiled({super.key, this.title});
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title ?? ''),
        TextField(),
      ],
    );
  }
}
