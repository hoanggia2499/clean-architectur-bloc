import 'package:base_project/core/widget/app_scaffold.dart';
import 'package:base_project/features/search/presentation/bloc/search_bloc.dart';
import 'package:base_project/features/search/presentation/page/widgets/search_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchBloc>(),
      child: const AppScaffold(
        bodyPortrait: SearchBody(),
        bodyLandScape: SearchBody(),
      ),
    );
  }
}
