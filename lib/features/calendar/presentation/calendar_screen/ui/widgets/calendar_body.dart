import 'package:base_project/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarBody extends StatelessWidget {
  const CalendarBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CalendarBloc, CalendarState>(
      listener: (context, state) {},
      child:
          BlocBuilder<CalendarBloc, CalendarState>(builder: (context, state) {
        return Center(
          child: Text("CALENDAR"),
        );
      }),
    );
  }
}
