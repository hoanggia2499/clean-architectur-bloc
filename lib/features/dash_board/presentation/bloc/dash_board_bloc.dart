import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'dash_board_event.dart';
part 'dash_board_state.dart';

class DashBoardBloc extends Bloc<DashBoardEvent, DashBoardState> {
  DashBoardBloc() : super(DashBoardInitial()) {
    on<TabChangeEvent>(_onTabChangeEvent);
  }

  FutureOr<void> _onTabChangeEvent(
      TabChangeEvent event, Emitter<DashBoardState> emit) {
    emit(IndexState(index: event.index));

    print("${event.index}");
  }
}
