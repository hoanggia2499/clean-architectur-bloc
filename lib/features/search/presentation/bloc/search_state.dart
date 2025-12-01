part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchFailure extends SearchState {
  final String message;

  const SearchFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class SearchSuccess extends SearchState {
  final List<ProductEntity> products;

  const SearchSuccess(this.products);

  @override
  List<Object> get props => [products];
}
