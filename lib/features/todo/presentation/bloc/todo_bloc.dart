import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {

  TodoBloc() : super(TodoInitial()) {
    on<FirstEvent>(_onTabChangeEvent);
  }

  FutureOr<void> _onTabChangeEvent(
      FirstEvent event, Emitter<TodoState> emit) {
    print("${event.exam}");
  }
}
