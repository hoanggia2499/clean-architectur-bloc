part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}


class TodoFailure extends TodoState {
  final String message;

  const TodoFailure({required this.message});

  @override
  List<Object> get props => [message];
}
