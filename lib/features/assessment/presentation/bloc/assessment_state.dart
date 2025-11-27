part of 'assessment_bloc.dart';

abstract class AssessmentState extends Equatable {
  const AssessmentState();

  @override
  List<Object> get props => [];
}

class AssessmentInitial extends AssessmentState {}

class AssessmentLoading extends AssessmentState {}


class AssessmentFailure extends AssessmentState {
  final String message;

  const AssessmentFailure({required this.message});

  @override
  List<Object> get props => [message];
}
