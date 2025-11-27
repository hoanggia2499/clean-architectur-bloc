import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part '_event.dart';
part '_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {

  ListBloc() : super(ListInitial()) {
    on<FirstEvent>(_onTabChangeEvent);
  }

  FutureOr<void> _onTabChangeEvent(
      FirstEvent event, Emitter<ListState> emit) {
    print("${event.exam}");
  }
}
