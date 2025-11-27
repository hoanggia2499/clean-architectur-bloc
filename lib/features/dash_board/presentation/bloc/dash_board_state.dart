part of 'dash_board_bloc.dart';

abstract class DashBoardState extends Equatable {
  const DashBoardState();

  @override
  List<Object> get props => [];
}

class DashBoardInitial extends DashBoardState {}

class DashBoardLoading extends DashBoardState {}

class IndexState extends DashBoardState {
  final int index;

  const IndexState({required this.index});

  @override
  List<Object> get props => [index];
}



class DashBoardFailure extends DashBoardState {
  final String message;

  const DashBoardFailure({required this.message});

  @override
  List<Object> get props => [message];
}
