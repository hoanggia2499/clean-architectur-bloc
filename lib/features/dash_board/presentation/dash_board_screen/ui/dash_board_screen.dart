import 'package:base_project/features/dash_board/presentation/dash_board_screen/ui/widgets/dash_board_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widget/app_scaffold.dart';
import '../../../../../core/widget/navigation_bar/bar.dart';
import '../../../../../core/widget/navigation_bar/item.dart';
import '../bloc/dash_board_bloc.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashBoardBloc, DashBoardState>(
      listener: (context, state) {},
      child: BlocBuilder<DashBoardBloc, DashBoardState>(
        builder: (context, state) {
          return AppScaffold(
            bodyLandScape: DashBoardBody(),
            bodyPortrait: DashBoardBody(),
            bottomNavigationBar: ConvexAppBar(
              style: TabStyle.fixed,
              items: [
                TabItem(icon: Icons.list),
                TabItem(icon: Icons.calendar_today),
                TabItem(icon: Icons.assessment),
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
