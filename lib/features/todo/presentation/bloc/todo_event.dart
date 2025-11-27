part of 'todo_bloc.dart';
abstract class TodoEvent {}


class FirstEvent extends TodoEvent{
  int exam;
  FirstEvent({required this.exam});
}
