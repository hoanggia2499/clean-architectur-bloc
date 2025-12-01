import 'dart:async';

import 'package:base_project/core/error.dart';
import 'package:base_project/features/product_detail/domain/usecases/get_product_detail_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_detail_event.dart';
import 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final GetProductDetailUseCase getProductDetailUseCase;

  ProductDetailBloc( this.getProductDetailUseCase)
      : super(ProductDetailInitial()) {
    on<GetProductDetail>(_onGetProductDetail);
  }

  FutureOr<void> _onGetProductDetail(
      GetProductDetail event, Emitter<ProductDetailState> emit) async {
    emit(ProductDetailLoading());
    final result = await getProductDetailUseCase.call(
        GetProductDetailParams(productId: event.productId));

    result.fold((failure) {
      if (failure is ServerFailure) {
        emit(ProductDetailFailure(failure.message));
      } else {
        emit(const ProductDetailFailure('An unexpected error occurred.'));
      }
    }, (product) {
      emit(ProductDetailSuccess(product));
    });
  }
}
