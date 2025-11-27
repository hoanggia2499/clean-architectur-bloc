import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<TodoPageInitialized>(_onPageInitialized);
  }

  FutureOr<void> _onPageInitialized(
      TodoPageInitialized event, Emitter<TodoState> emit) {
    // This is where you would typically fetch data for the todo list.
    // For now, we just print a message as requested.
   emit(TodoInitial());
    // You could emit a loading state here and then a loaded/error state.
  }
}
