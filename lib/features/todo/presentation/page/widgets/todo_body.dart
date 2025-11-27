import 'package:base_project/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBody extends StatelessWidget {
  const TodoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is TodoInitial) {
          print("TodoInitial");
        }
      },
      child: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
        return Center(
          child: Text("TODO"),
        );
      }),
    );
  }
}
