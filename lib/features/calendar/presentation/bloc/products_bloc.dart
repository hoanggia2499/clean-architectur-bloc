import 'dart:async';

import 'package:base_project/core/usecase.dart';
import 'package:base_project/features/calendar/domain/entities/product_list_entity.dart';
import 'package:base_project/features/calendar/domain/usecases/get_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error.dart';
import '../../domain/entities/product_entity.dart';
part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUseCase getProductsUseCase;
  ProductsBloc(this.getProductsUseCase) : super(ProductsInitial()) {
    on<ProductsPageInitialized>(_onTabChangeEvent);
    on<AllProductsReceived>(_onGetAllProducts);
  }

  FutureOr<void> _onTabChangeEvent(
      ProductsPageInitialized event, Emitter<ProductsState> emit) async {
    try {
      emit(ProductsLoading());
      add(AllProductsReceived());
    } catch (e) {
      emit(ProductsFailure(message: e.toString()));
    }
  }

  FutureOr<void> _onGetAllProducts(
      AllProductsReceived event, Emitter<ProductsState> emit) async {
    try {
      final result = await getProductsUseCase
          .call(GetProductsParams(limit: 9, skip: 0)); //TODO
      result.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(ProductsFailure(message: failure.message));
          } else {
            emit(const ProductsFailure(
                message: 'An unexpected error occurred.'));
          }
        },
        (productListEntity) => emit(
            ProductsSuccess(products: productListEntity, hasReachedMax: false)),
      );
    } catch (e) {
      emit(ProductsFailure(message: e.toString()));
    }
  }
}
