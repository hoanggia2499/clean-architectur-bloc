import 'package:base_project/core/navigation/path.dart';
import 'package:base_project/features/assessment/presentation/assessment_screen/ui/assessment_screen.dart';
import 'package:base_project/features/assessment/presentation/bloc/assessment_bloc.dart';
import 'package:base_project/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:base_project/features/dash_board/presentation/dash_board_screen/ui/dash_board_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_project/features/auth/presentation/pages/login_page.dart';
import 'package:base_project/core/di/injection.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/calendar/presentation/calendar_screen/ui/calendar_screen.dart';
import '../../features/dash_board/presentation/bloc/dash_board_bloc.dart';
import '../../features/list/presentation/bloc/_bloc.dart';
import '../../features/list/presentation/list_screen/ui/list_screen.dart';

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
    GoRoute(
      path: PathRoute.list,
      name: 'list',
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (_) => sl<ListBloc>(),
          child: ListScreen(),
        );
      },
    ),
    GoRoute(
      path: PathRoute.calendar,
      name: 'calendar',
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (_) => sl<CalendarBloc>(),
          child: CalendarScreen(),
        );
      },
    ),
    GoRoute(
      path: PathRoute.assessment,
      name: 'assessment',
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (_) => sl<AssessmentBloc>(),
          child: AssessmentScreen(),
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
