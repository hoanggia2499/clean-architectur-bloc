import 'package:base_project/features/todo/presentation/todo_screen/ui/todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widget/navigation_bar.dart';
import '../../../../assessment/presentation/assessment_screen/ui/assessment_screen.dart';
import '../../../../calendar/presentation/calendar_screen/ui/calendar_screen.dart';
import '../../bloc/dash_board_bloc.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  // A list of the pages to be displayed by the IndexedStack.
  final List<Widget> _pages = const [
    TodoScreen(),
    CalendarScreen(),
    AssessmentScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // The BlocBuilder now controls the entire screen's state. The anti-pattern
    // of using BlocListener + a local variable has been removed.
    return BlocBuilder<DashBoardBloc, DashBoardState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            // The BLoC state directly controls which page is visible.
            index: state.tabIndex,
            children: _pages,
          ),
          bottomNavigationBar: ConvexAppBar(
            items: const [
              TabItem(icon: Icons.add_to_drive_outlined, title: 'Todo'),
              TabItem(icon: Icons.calendar_today, title: 'Calendar'),
              TabItem(icon: Icons.assessment, title: 'Assessment'),
            ],
            // The BLoC state is the single source of truth for the active index.
            activeIndex: state.tabIndex,
            onTap: (int index) =>
                context.read<DashBoardBloc>().add(TabChangeEvent(index: index)),
          ),
        );
      },
    );
  }
}
