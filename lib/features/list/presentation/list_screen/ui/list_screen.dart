import 'package:flutter/material.dart';

import '../../../../../core/widget/app_scaffold.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(bodyLandScape: ListBody(), bodyPortrait: ListBody());
  }
}
