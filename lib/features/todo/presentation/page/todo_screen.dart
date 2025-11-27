import 'package:base_project/features/todo/presentation/page/widgets/todo_body.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/app_scaffold.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(bodyLandScape: const TodoBody(),bodyPortrait: const TodoBody());
  }
}