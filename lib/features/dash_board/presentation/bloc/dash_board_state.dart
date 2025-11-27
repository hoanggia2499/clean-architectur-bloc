part of 'dash_board_bloc.dart';

// The base state now holds the current tab index as a fundamental property.
abstract class DashBoardState extends Equatable {
  final int tabIndex;

  // Default to index 1 (Calendar) to match the UI's initial requirement.
  const DashBoardState({this.tabIndex = 1});

  @override
  List<Object> get props => [tabIndex];
}

// The initial state, defaults to the tab index set in the base class.
class DashBoardInitial extends DashBoardState {}

class DashBoardLoading extends DashBoardState {}

// This state now simply carries the new index via the base class property.
class IndexState extends DashBoardState {
  const IndexState({required super.tabIndex});
}

class DashBoardFailure extends DashBoardState {
  final String message;

  const DashBoardFailure({required this.message, super.tabIndex});

  @override
  List<Object> get props => [message, tabIndex];
}
