part of 'dash_board_bloc.dart';

abstract class DashBoardState extends Equatable {
  const DashBoardState();

  @override
  List<Object> get props => [];
}

class DashBoardInitial extends DashBoardState {}

class DashBoardLoading extends DashBoardState {}


class DashBoardFailure extends DashBoardState {
  final String message;

  const DashBoardFailure({required this.message});

  @override
  List<Object> get props => [message];
}
