import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widget/navigation_bar.dart';
import '../../../../assessment/presentation/bloc/assessment_bloc.dart';
import '../../../../assessment/presentation/page/assessment_screen.dart';
import '../../../../products/presentation/bloc/products_bloc.dart';
import '../../../../products/presentation/page/products_screen.dart';
import '../../../../todo/presentation/bloc/todo_bloc.dart';
import '../../../../todo/presentation/page/todo_screen.dart';
import '../../bloc/dash_board_bloc.dart';

class DashBoardBody extends StatelessWidget {
  const DashBoardBody({super.key});

  final List<Widget> _pages = const [
    TodoScreen(),
    ProductsScreen(),
    AssessmentScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashBoardBloc, DashBoardState>(
      // Only listen for changes when the tab index is different to avoid
      // re-triggering on other state changes.
      listenWhen: (previous, current) => previous.tabIndex != current.tabIndex,
      listener: (context, state) {
        switch (state.tabIndex) {
          case 0:
            context.read<TodoBloc>().add(TodoPageInitialized());
            break;
          case 1:
            // context.read<ProductsBloc>().add(ProductsInitialized());
            break;
          case 2:
            context.read<AssessmentBloc>().add(AssessmentPageInitialized());
            break;
        }
      },
      // The BlocBuilder remains the single source of truth for the UI.
      child: BlocBuilder<DashBoardBloc, DashBoardState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state.tabIndex,
              children: _pages,
            ),
            bottomNavigationBar: ConvexAppBar(
              items: const [
                TabItem(icon: Icons.add_to_drive_outlined, title: 'Todo'),
                TabItem(icon: Icons.category, title: 'Category'),
                TabItem(icon: Icons.assessment, title: 'Assessment'),
              ],
              activeIndex: state.tabIndex,
              onTap: (int index) => context
                  .read<DashBoardBloc>()
                  .add(TabChangeEvent(index: index)),
            ),
          );
        },
      ),
    );
  }
}
