import 'dart:async';

import 'package:base_project/features/products/domain/entities/product_entity.dart';
import 'package:base_project/features/products/domain/usecases/search_products_usecase.dart';
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
  final SearchProductsUseCase searchProductsUseCase;

  SearchBloc(this.searchProductsUseCase) : super(SearchInitial()) {
    on<SearchQueryChanged>(
      _onSearchQueryChanged,
      transformer: debounceRestartable(_searchDebounceDuration),
    );
  }

  Future<void> _onSearchQueryChanged(
      SearchQueryChanged event, Emitter<SearchState> emit) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    final result = await searchProductsUseCase.call(SearchProductsParams(query: query));

    result.fold(
      (failure) => emit(const SearchFailure(message: 'Could not perform search.')),
      (productList) => emit(SearchSuccess(productList.products)),
    );
  }
}
