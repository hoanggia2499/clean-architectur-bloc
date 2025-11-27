part of '_bloc.dart';
abstract class zEvent {}


class FirstEvent extends zEvent{
  int exam;
  FirstEvent({required this.exam});
}
