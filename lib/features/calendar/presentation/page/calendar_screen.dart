import 'package:base_project/features/calendar/presentation/page/widgets/calendar_body.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/app_scaffold.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        bodyLandScape: const CalendarBody(),
        bodyPortrait: const CalendarBody());
  }
}
