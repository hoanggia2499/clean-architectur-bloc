import 'package:base_project/features/assessment/presentation/page/widgets/assessment_body.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/app_scaffold.dart';

class AssessmentScreen extends StatelessWidget {
  const AssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bodyPortrait: const AssessmentBody(),
      bodyLandScape: const AssessmentBody(),
    );
  }
}
