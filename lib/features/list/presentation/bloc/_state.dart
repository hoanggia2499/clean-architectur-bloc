part of '_bloc.dart';

abstract class ListState extends Equatable {
  const ListState();

  @override
  List<Object> get props => [];
}

class ListInitial extends ListState {}

class ListLoading extends ListState {}


class ListFailure extends ListState {
  final String message;

  const ListFailure({required this.message});

  @override
  List<Object> get props => [message];
}
