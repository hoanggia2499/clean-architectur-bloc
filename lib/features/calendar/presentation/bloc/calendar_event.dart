part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

/// Event triggered when the Calendar page is first displayed or re-selected.
class CalendarPageInitialized extends CalendarEvent {}

class AllProductsReceived extends CalendarEvent {

}
