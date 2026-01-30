import 'package:dyd_drawer/core/DI/di.dart';
import 'package:dyd_drawer/core/router/router.dart';
import 'package:dyd_drawer/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';

// debug logger
final logger = Logger();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase app init
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // DI
  await DI();

  // RUN APP
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'DYD - Draw Your Dream',
    );
  }
}
