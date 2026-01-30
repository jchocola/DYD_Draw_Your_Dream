import 'package:dyd_drawer/core/DI/di.dart';
import 'package:dyd_drawer/core/router/router.dart';
import 'package:dyd_drawer/core/theme/app_theme.dart';
import 'package:dyd_drawer/feature/feature_auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:dyd_drawer/feature/feature_auth/domain/auth_repo.dart';
import 'package:dyd_drawer/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> AuthBloc(authRepo: getIt<AuthRepo>())..add(AuthBlocEvent_loadUser()))
      ],
      child: MaterialApp.router(
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        title: 'DYD - Draw Your Dream',
      ),
    );
  }
}
