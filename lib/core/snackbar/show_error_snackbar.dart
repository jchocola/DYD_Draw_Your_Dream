import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, {String? title, String? message}) {
  CherryToast.error(
    title: Text(title ?? "Error", style: TextStyle(color: Colors.black)),
    description: Text(
      message ?? "An error occurred",
      style: TextStyle(color: Colors.black),
    ),

    animationType: AnimationType.fromTop,

    animationDuration: Duration(milliseconds: 1000),

    autoDismiss: true,
  ).show(context);
}
