import 'dart:async';

import 'package:base_project/core/usecase.dart';
import 'package:base_project/features/products/domain/entities/product_entity.dart';
import 'package:base_project/features/search/domain/entities/search_term_entity.dart';
import 'package:base_project/features/products/domain/usecases/search_products_usecase.dart';
import 'package:base_project/features/search/domain/usecases/add_search_term_usecase.dart';
import 'package:base_project/features/search/domain/usecases/get_search_history_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_event.dart';
part 'search_state.dart';

const _searchDebounceDuration = Duration(milliseconds: 500);

EventTransformer<E> debounceRestartable<E>(
  Duration duration,
) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchProductsUseCase _searchProductsUseCase;
  final GetSearchHistoryUseCase _getSearchHistoryUseCase;
  final AddSearchTermUseCase _addSearchTermUseCase;

  SearchBloc(
    this._searchProductsUseCase,
    this._getSearchHistoryUseCase,
    this._addSearchTermUseCase,
  ) : super(const SearchInitial([])) {
    on<SearchQueryChanged>(
      _onSearchQueryChanged,
      transformer: debounceRestartable(_searchDebounceDuration),
    );
    on<LoadSearchHistory>(_onLoadSearchHistory);
    on<SaveSearchTerm>(_onSaveSearchTerm);

    // Automatically load history when the BLoC is created.
    add(LoadSearchHistory());
  }

  Future<void> _onLoadSearchHistory(
    LoadSearchHistory event,
    Emitter<SearchState> emit,
  ) async {
    final result = await _getSearchHistoryUseCase(NoParams());
    result.fold(
      (failure) => emit(const SearchInitial([])), // On failure, show an empty history
      (history) => emit(SearchInitial(history)),
    );
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      // If query is cleared, reload the history.
      add(LoadSearchHistory());
      return;
    }

    emit(SearchLoading());

    final result = await _searchProductsUseCase.call(SearchProductsParams(query: query));

    result.fold(
      (failure) => emit(const SearchFailure(message: 'Could not perform search.')),
      (productList) => emit(SearchSuccess(productList.products, query)),
    );
  }

  Future<void> _onSaveSearchTerm(
    SaveSearchTerm event,
    Emitter<SearchState> emit,
  ) async {
    await _addSearchTermUseCase.call(AddSearchTermParams(event.query));
    // No need to emit a new state, this is a background task.
  }
}
