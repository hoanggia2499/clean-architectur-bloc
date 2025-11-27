import 'package:base_project/core/navigation/path.dart';
import 'package:base_project/features/assessment/presentation/bloc/assessment_bloc.dart';
import 'package:base_project/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:base_project/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_project/features/auth/presentation/pages/login_page.dart';
import 'package:base_project/core/di/injection.dart';
import 'package:go_router/go_router.dart';
import '../../features/assessment/presentation/page/assessment_screen.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/calendar/presentation/page/calendar_screen.dart';
import '../../features/dash_board/presentation/bloc/dash_board_bloc.dart';
import '../../features/dash_board/presentation/page/dash_board_screen.dart';
import '../../features/todo/presentation/page/todo_screen.dart';

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
        // Provide all necessary BLoCs for the screens within the dashboard here.
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<DashBoardBloc>()),
            BlocProvider(create: (_) => sl<TodoBloc>()),
            BlocProvider(create: (_) => sl<CalendarBloc>()),
            BlocProvider(create: (_) => sl<AssessmentBloc>()),
          ],
          child: const DashBoardScreen(),
        );
      },
    ),
    GoRoute(
      path: PathRoute.todo,
      name: 'todo',
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (_) => sl<TodoBloc>(),
          child: const TodoScreen(),
        );
      },
    ),
    GoRoute(
      path: PathRoute.calendar,
      name: 'calendar',
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (_) => sl<CalendarBloc>(),
          child: const CalendarScreen(),
        );
      },
    ),
    GoRoute(
      path: PathRoute.assessment,
      name: 'assessment',
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (_) => sl<AssessmentBloc>(),
          child: const AssessmentScreen(),
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
