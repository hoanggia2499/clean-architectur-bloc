import 'dart:async';

import 'package:base_project/core/usecase.dart';
import 'package:base_project/features/calendar/domain/entities/product_list_entity.dart';
import 'package:base_project/features/calendar/domain/usecases/get_products_usecase.dart';
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

  ProductsBloc(this.getProductsUseCase) : super(ProductsInitial()) {
    on<ProductsRefreshed>(
      _onProductsRefreshed,
      // Use restartable() for refresh events. If the user pulls to refresh
      // again while a refresh is in progress, the old one is cancelled
      // and a new one starts. This is efficient and ensures the user gets
      // the latest data from their most recent action.
      transformer: restartable(),
    );
    on<ProductsFetched>(
      _onProductsFetched,
      // Use droppable() for fetching more items. This prevents the user from
      // spamming the fetch event while one is already in progress, avoiding
      // duplicate data and unnecessary API calls.
      transformer: droppable(),
    );
  }

  FutureOr<void> _onProductsRefreshed(
      ProductsRefreshed event, Emitter<ProductsState> emit) async {
    emit(ProductsInitial());
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
    final result =
        await getProductsUseCase.call(GetProductsParams(limit: _productLimit, skip: skip));

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
          emit(ProductsSuccess(
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
          ));
        }
      },
    );
  }
}
