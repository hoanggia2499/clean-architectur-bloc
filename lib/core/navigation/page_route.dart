import 'package:base_project/core/navigation/path.dart';
import 'package:base_project/features/dash_board/presentation/dash_board_screen/ui/dash_board_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_project/features/dash_board/presentation/dash_board_screen/bloc/dash_board_bloc.dart';
import 'package:base_project/features/auth/presentation/pages/login_page.dart';
import 'package:base_project/core/di/injection.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

final GoRouter router = GoRouter(
  initialLocation: PathRoute.dashboard,
  routes: <RouteBase>[
    GoRoute(
      path: PathRoute.login,
      name: 'login',
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: LoginPage(),
        );
      },
    ),
    GoRoute(
      path: PathRoute.dashboard,
      name: 'dashboard',
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (_) => sl<DashBoardBloc>(),
          child: DashBoardScreen(),
        );
      },
    ),

  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.uri.path}'),
    ),
  ),
);
