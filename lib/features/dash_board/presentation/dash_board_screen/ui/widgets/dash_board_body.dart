import 'package:base_project/features/assessment/presentation/assessment_screen/ui/assessment_screen.dart';
import 'package:base_project/features/assessment/presentation/bloc/assessment_bloc.dart';
import 'package:base_project/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:base_project/features/calendar/presentation/calendar_screen/ui/calendar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/di/injection.dart';
import '../../../../../list/presentation/bloc/_bloc.dart';
import '../../../../../list/presentation/list_screen/ui/list_screen.dart';

class DashBoardBody extends StatelessWidget {
  final int index;
  const DashBoardBody({super.key, required this.index});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Text('Page not found: $index'),
      ),
    );
  }
}
