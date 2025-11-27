part of 'calendar_bloc.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object> get props => [];
}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {}


class CalendarFailure extends CalendarState {
  final String message;

  const CalendarFailure({required this.message});

  @override
  List<Object> get props => [message];
}
