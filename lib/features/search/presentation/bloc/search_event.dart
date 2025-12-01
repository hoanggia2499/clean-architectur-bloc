part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

/// Fired when the user types in the search input.
class SearchQueryChanged extends SearchEvent {
  final String query;

  const SearchQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

/// Fired when the bloc is initialized to load past search terms.
class LoadSearchHistory extends SearchEvent {}

/// Fired when a search is successfully executed and should be saved.
class SaveSearchTerm extends SearchEvent {
  final String query;

  const SaveSearchTerm(this.query);

  @override
  List<Object> get props => [query];
}
