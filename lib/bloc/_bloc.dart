import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part '_event.dart';
part '_state.dart';

class zBloc extends Bloc<zEvent, zState> {

  zBloc() : super(zInitial()) {
    on<FirstEvent>(_onTabChangeEvent);
  }

  FutureOr<void> _onTabChangeEvent(
      FirstEvent event, Emitter<zState> emit) {
    print("${event.exam}");
  }
}
