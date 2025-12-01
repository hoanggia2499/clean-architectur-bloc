part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

/// The initial state, which can also display the search history.
class SearchInitial extends SearchState {
  final List<SearchTermEntity> historyTerms;

  const SearchInitial(this.historyTerms);

  @override
  List<Object> get props => [historyTerms];
}

class SearchLoading extends SearchState {}

class SearchFailure extends SearchState {
  final String message;

  const SearchFailure({required this.message});

  @override
  List<Object> get props => [message];
}

/// The success state, containing the search results and the query that produced them.
class SearchSuccess extends SearchState {
  final List<ProductEntity> products;
  final String currentQuery;

  const SearchSuccess(this.products, this.currentQuery);

  @override
  List<Object> get props => [products, currentQuery];
}
