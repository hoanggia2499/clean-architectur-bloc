part of '_bloc.dart';

abstract class zState extends Equatable {
  const zState();

  @override
  List<Object> get props => [];
}

class zInitial extends zState {}

class zLoading extends zState {}


class zFailure extends zState {
  final String message;

  const zFailure({required this.message});

  @override
  List<Object> get props => [message];
}
