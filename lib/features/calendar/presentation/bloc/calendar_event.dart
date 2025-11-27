part of 'calendar_bloc.dart';
abstract class CalendarEvent {}


class FirstEvent extends CalendarEvent{
  int exam;
  FirstEvent({required this.exam});
}
