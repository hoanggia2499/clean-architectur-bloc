part of 'dash_board_bloc.dart';
abstract class DashBoardEvent {}


class TabChangeEvent extends DashBoardEvent{
  int index;
  TabChangeEvent({required this.index});
}
