import 'package:base_project/core/navigation/error_page.dart';
import 'package:base_project/core/navigation/path.dart';
import 'package:base_project/features/assessment/presentation/bloc/assessment_bloc.dart';
import 'package:base_project/features/product_detail/presentation/page/product_detail_screen.dart';
import 'package:base_project/features/search/presentation/page/search_screen.dart';
import 'package:base_project/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_project/features/auth/presentation/pages/login_page.dart';
import 'package:base_project/core/di/injection.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/dash_board/presentation/bloc/dash_board_bloc.dart';
import '../../features/dash_board/presentation/page/dash_board_screen.dart';
import '../../features/products/presentation/bloc/products_bloc.dart';

final GoRouter router = GoRouter(
  initialLocation: PathRoute.products,
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
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<DashBoardBloc>()),
              BlocProvider(create: (_) => sl<TodoBloc>()),
              BlocProvider(create: (_) => sl<ProductsBloc>()),
              BlocProvider(create: (_) => sl<AssessmentBloc>()),
            ],
            child: const DashBoardScreen(),
          );
        },
        routes: [
          // FIX: Put the more specific, static route before the parameterized one.
          GoRoute(
            path: PathRoute.search,
            name: 'productSearch',
            builder: (BuildContext context, GoRouterState state) {
              return const SearchScreen();
            },
          ),
          GoRoute(
            path: PathRoute.productDetail, // e.g., 'product/:id'
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
  errorBuilder: (context, state) => ErrorPage(state: state),
);
