import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'assessment_event.dart';
part 'assessment_state.dart';

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {

  AssessmentBloc() : super(AssessmentInitial()) {
    on<AssessmentPageInitialized>(_onTabChangeEvent);
  }

  FutureOr<void> _onTabChangeEvent(
      AssessmentPageInitialized event, Emitter<AssessmentState> emit) {
    print("AssessmentBloc");
  }
}
