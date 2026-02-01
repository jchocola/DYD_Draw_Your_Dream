import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';

void showSuccessSnackBar(BuildContext context, {String? title, String? message}) {
  CherryToast.success(
    title: Text(title ?? "Success", style: TextStyle(color: Colors.black)),
    description: Text(
      message ?? "Operation completed successfully",
      style: TextStyle(color: Colors.black),
    ),

    animationType: AnimationType.fromTop,

    animationDuration: Duration(milliseconds: 1000),

    autoDismiss: true,
  ).show(context);
}
