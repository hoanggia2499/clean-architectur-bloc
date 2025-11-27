import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'dash_board_event.dart';
part 'dash_board_state.dart';

class DashBoardBloc extends Bloc<DashBoardEvent, DashBoardState> {
  // The initial state now correctly sets the starting tab index via the base class.
  DashBoardBloc() : super(DashBoardInitial()) {
    on<TabChangeEvent>(_onTabChangeEvent);
  }

  FutureOr<void> _onTabChangeEvent(
      TabChangeEvent event, Emitter<DashBoardState> emit) {
    // Only emit a new state if the tab index has actually changed.
    if (event.index != state.tabIndex) {
      emit(IndexState(tabIndex: event.index));
      print(event.index);
    }
  }
}
