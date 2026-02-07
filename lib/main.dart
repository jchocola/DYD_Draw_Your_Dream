import 'dart:async';
import 'package:dyd_drawer/core/DI/di.dart';
import 'package:dyd_drawer/core/router/router.dart';
import 'package:dyd_drawer/core/snackbar/show_error_snackbar.dart';
import 'package:dyd_drawer/core/snackbar/show_success_snackbar.dart';
import 'package:dyd_drawer/core/theme/app_theme.dart';
import 'package:dyd_drawer/feature/feature_auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:dyd_drawer/feature/feature_auth/domain/auth_repo.dart';
import 'package:dyd_drawer/feature/feature_drawers/bloc/drawers_bloc.dart';
import 'package:dyd_drawer/feature/feature_drawers/domain/repo/storage_repo.dart';
import 'package:dyd_drawer/feature/feature_drawers/domain/repo/store_repo.dart';
import 'package:dyd_drawer/feature/feature_internet_connectivity/bloc/internet_connectivity_bloc.dart';
import 'package:dyd_drawer/feature/feature_notification/domain/notification_repo.dart';
import 'package:dyd_drawer/feature/feature_painter/bloc/painting_controller_bloc/painting_controller_bloc.dart';
import 'package:dyd_drawer/feature/feature_painter/bloc/picked_painter_bloc/picked_painter_bloc.dart';
import 'package:dyd_drawer/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/web.dart';

// debug logger
final logger = Logger();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase app init
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // DI
  await DI();

  // NOTIFICATION
  await getIt<NotificationRepo>().init();

  // ORIENTATION MODE (up and down)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  // RUN APP
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => InternetConnectivityBloc()),
        BlocProvider(
          create: (context) =>
              AuthBloc(authRepo: getIt<AuthRepo>())
                ..add(AuthBlocEventLoadUser()),
        ),
        BlocProvider(
          create: (context) => DrawersBloc(
            storeRepo: getIt<StoreRepo>(),
            authRepo: getIt<AuthRepo>(),
          ),
        ),

        BlocProvider(
          create: (context) => PaintingControllerBloc(
            drawersBloc: context.read<DrawersBloc>(),
            storeRepo: getIt<StoreRepo>(),
            picker: getIt<ImagePicker>(),
            storageRepo: getIt<StorageRepo>(),
            authBloc: context.read<AuthBloc>(),
            notificationRepo: getIt<NotificationRepo>(),
          )..add(PaintingControllerEventInitialize()),
        ),
        BlocProvider(create: (context)=> PickedPainterBloc())
      ],
      child: MaterialApp.router(
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        title: 'DYD - Draw Your Dream',
        builder: (context, child) {
          return BlocListener<
            InternetConnectivityBloc,
            InternetConnectivityState
          >(
            listener: (context, state) {
              final navContext = rootNavigatorKey.currentContext;

              if (navContext != null) {
                if (state is InternetConnectivityStateConnected) {
                  showSuccessSnackBar(
                    navContext,
                    title: 'Юху...',
                    message: 'Вы снова в сети!',
                  );
                }
                if (state is InternetConnectivityStateDisconnected) {
                  showErrorSnackBar(
                    navContext,
                    title: 'Упс...',
                    message: 'Интернет пропал',
                  );
                }
              }
            },
            child: child!,
          );
        },
      ),
    );
  }
}
