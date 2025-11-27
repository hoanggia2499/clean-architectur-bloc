part of '_bloc.dart';
abstract class ListEvent {}


class FirstEvent extends ListEvent{
  int exam;
  FirstEvent({required this.exam});
}
