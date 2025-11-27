part of 'assessment_bloc.dart';

abstract class AssessmentEvent extends Equatable {
  const AssessmentEvent();

  @override
  List<Object> get props => [];
}

/// Event triggered when the Assessment page is first displayed or re-selected.
class AssessmentPageInitialized extends AssessmentEvent {}
