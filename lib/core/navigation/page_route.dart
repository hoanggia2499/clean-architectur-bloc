import 'package:base_project/core/navigation/path.dart';
import 'package:base_project/features/product_detail/presentation/page/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_project/features/auth/presentation/pages/login_page.dart';
import 'package:base_project/core/di/injection.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/dash_board/presentation/page/dash_board_screen.dart';
import 'error_page.dart';

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
          return const DashBoardScreen();
        },
        routes: [
          GoRoute(
            // The path uses a parameter to capture the product ID.
            path: PathRoute.productDetail,
            name: 'productDetail',
            builder: (BuildContext context, GoRouterState state) {
              // Extract the ID from the path parameters.
              final productId =
                  int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
              return ProductDetailScreen(productId: productId);
            },
          ),
        ]),
  ],
  errorBuilder: (context, state) => ErrorScreen(
    state: state,
  ),
);
