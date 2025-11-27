import 'package:base_project/features/list/presentation/bloc/_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListBody extends StatelessWidget {
  const ListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ListBloc, ListState>(
      listener: (context, state) {},
      child:
      BlocBuilder<ListBloc, ListState>(builder: (context, state) {
        return Center(
          child: Text("LIST"),
        );
      }),
    );
  }
}