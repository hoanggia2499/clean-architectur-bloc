import 'package:base_project/features/dash_board/presentation/page/widgets/dash_board_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/widget/navigation_bar.dart';
import '../../../assessment/presentation/bloc/assessment_bloc.dart';
import '../../../assessment/presentation/page/assessment_screen.dart';
import '../../../products/presentation/bloc/products_bloc.dart';
import '../../../products/presentation/page/products_screen.dart';
import '../../../todo/presentation/bloc/todo_bloc.dart';
import '../../../todo/presentation/page/todo_screen.dart';
import '../bloc/dash_board_bloc.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use a BlocListener to perform actions in response to state changes.
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<DashBoardBloc>()),
        BlocProvider(create: (_) => sl<TodoBloc>()),
        BlocProvider(
            create: (_) => sl<ProductsBloc>()..add(ProductsRefreshed())),
        BlocProvider(create: (_) => sl<AssessmentBloc>()),
      ],
      child: const DashBoardBody(),
    );
  }
}
