import 'package:your_default_package/dash_board/presentation/dash_board_screen/ui/widgets/dash_board_body.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: const DashBoardBody());
  }
}