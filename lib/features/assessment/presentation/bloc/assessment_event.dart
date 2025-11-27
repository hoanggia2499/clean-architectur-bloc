part of 'assessment_bloc.dart';
abstract class AssessmentEvent {}


class FirstEvent extends AssessmentEvent{
  int exam;
  FirstEvent({required this.exam});
}
