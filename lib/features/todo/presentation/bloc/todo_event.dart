part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

/// Event triggered when the Todo page is first displayed or re-selected.
class TodoPageInitialized extends TodoEvent {}
