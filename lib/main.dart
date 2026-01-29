import 'package:dyd_drawer/core/router/router.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';

// debug logger
final logger = Logger();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'DYD - Draw Your Dream');
  }
}
