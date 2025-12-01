import 'package:base_project/features/assessment/presentation/bloc/assessment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssessmentBody extends StatelessWidget {
  const AssessmentBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssessmentBloc, AssessmentState>(
        builder: (context, state) {
      return Center(
        child: Text("ASSESSMENT"),
      );
    });
  }
}
