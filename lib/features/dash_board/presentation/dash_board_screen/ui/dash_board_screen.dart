import 'package:base_project/features/dash_board/presentation/dash_board_screen/ui/widgets/dash_board_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widget/app_scaffold.dart';
// The new, self-contained navigation bar
import '../../../../../core/widget/navigation_bar.dart';
import '../../bloc/dash_board_bloc.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return BlocListener<DashBoardBloc, DashBoardState>(
      listener: (context, state) {
        if (state is IndexState) {
          index = state.index;
        }
      },
      child: BlocBuilder<DashBoardBloc, DashBoardState>(
        builder: (context, state) {
          return Scaffold(
            body: DashBoardBody(index: index),
            bottomNavigationBar: ConvexAppBar(
              // The 'style' property is no longer needed as it defaults to a fixed style.
              items: const [
                TabItem(icon: Icons.list, title: 'List'),
                TabItem(icon: Icons.calendar_today, title: 'Calendar'),
                TabItem(icon: Icons.assessment, title: 'Assessment'),
              ],
              initialActiveIndex: 1,
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
