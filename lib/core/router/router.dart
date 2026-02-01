/*
   GO_ROUTER CONFIGURATION
 */

import 'package:dyd_drawer/feature/feature_auth/presentation/auth_page.dart';
import 'package:dyd_drawer/feature/feature_drawers/presentation/gallery_page.dart';
import 'package:dyd_drawer/feature/feature_painter/presentation/new_painter_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/auth',
  routes: [
    GoRoute(path: '/auth', builder: (context, state) => AuthPage()),
    GoRoute(path: '/gallery', builder: (context, state) => GalleryPage()),
    GoRoute(
      path: '/create',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final bool isEdit = extra?['isEdit'] ?? false;
        return PainterPage(isEdit: isEdit,);
      },
    ),
    // GoRoute(path: '/edit', builder: (context, state) => EditPainterPage()),
  ],
);
