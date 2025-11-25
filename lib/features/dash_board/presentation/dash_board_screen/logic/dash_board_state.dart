part of 'dash_board_cubit.dart';

sealed class DashBoardState extends Equatable {
  const DashBoardState();
}

final class DashBoardInitialState extends DashBoardState {
  const DashBoardInitialState();
  
  @override
  List<Object> get props => [];
}
