import 'dart:async';

import 'package:base_project/core/usecase.dart';
import 'package:base_project/features/products/domain/usecases/get_products_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../../../core/error.dart';
import '../../domain/entities/product_entity.dart';
part 'products_event.dart';
part 'products_state.dart';

const _productLimit = 10;

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUseCase getProductsUseCase;

  late final ScrollController _scrollController;

  ProductsBloc(this.getProductsUseCase) : super(ProductsInitial()) {
    _scrollController = ScrollController()..addListener(_onScroll);

    on<ProductsRefreshed>(
      _onProductsRefreshed,
      transformer: restartable(),
    );
    on<ProductsFetched>(
      _onProductsFetched,
      transformer: droppable(),
    );
    on<SortOrderChanged>(
      _onSortOrderChanged,
      transformer: restartable(),
    );

    add(ProductsRefreshed());
  }

  ScrollController get scrollController => _scrollController;

  void _onScroll() {
    if (_isBottom) add(ProductsFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Future<void> close() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    return super.close();
  }

  FutureOr<void> _onSortOrderChanged(
      SortOrderChanged event, Emitter<ProductsState> emit) {
    if (state is ProductsSuccess) {
      final currentState = state as ProductsSuccess;
      // Update the sort order in the state first
      emit(currentState.copyWith(sortOrder: event.sortOrder));
      // Then trigger a refresh to fetch sorted data
      add(ProductsRefreshed());
    }
  }

  FutureOr<void> _onProductsRefreshed(
      ProductsRefreshed event, Emitter<ProductsState> emit) async {
    await _fetchAndEmitProducts(emit: emit, skip: 0);
  }

  Future<void> _onProductsFetched(
      ProductsFetched event, Emitter<ProductsState> emit) async {
    if (state is ProductsSuccess) {
      final currentState = state as ProductsSuccess;
      if (currentState.hasReachedMax) return;

      await _fetchAndEmitProducts(
        emit: emit,
        skip: currentState.products.length,
        isFetchingMore: true,
      );
    }
  }

  Future<void> _fetchAndEmitProducts({
    required Emitter<ProductsState> emit,
    required int skip,
    bool isFetchingMore = false,
  }) async {
    final currentSortOrder = state is ProductsSuccess ? (state as ProductsSuccess).sortOrder : SortOrder.none;

    if (!isFetchingMore) {
      emit(ProductsInitial());
    }
    
    String? sortBy, order;
    if (currentSortOrder != SortOrder.none) {
      sortBy = 'price';
      order = currentSortOrder == SortOrder.asc ? 'asc' : 'desc';
    }

    final result = await getProductsUseCase.call(
        GetProductsParams(limit: _productLimit, skip: skip, sortBy: sortBy, order: order));

    result.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(ProductsFailure(message: failure.message));
        } else {
          emit(const ProductsFailure(message: 'An unexpected error occurred.'));
        }
      },
      (productList) {
        final newProducts = productList.products;
        final currentState = state;

        if (isFetchingMore && currentState is ProductsSuccess) {
          emit(currentState.copyWith(
            products: currentState.products + newProducts,
            hasReachedMax: newProducts.isEmpty ||
                (currentState.products.length + newProducts.length) >=
                    productList.total,
          ));
        } else {
          emit(ProductsSuccess(
            products: newProducts,
            hasReachedMax: newProducts.isEmpty ||
                newProducts.length >= productList.total,
            sortOrder: currentSortOrder, // Preserve the sort order
          ));
        }
      },
    );
  }
}
