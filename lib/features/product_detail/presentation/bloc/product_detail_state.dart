import 'package:equatable/equatable.dart';
import 'package:base_project/features/product_detail/domain/entities/product_detail_entity.dart';

abstract class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object> get props => [];
}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailSuccess extends ProductDetailState {
  final ProductDetailEntity product;

  const ProductDetailSuccess(this.product);

  @override
  List<Object> get props => [product];
}

class ProductDetailFailure extends ProductDetailState {
  final String message;

  const ProductDetailFailure(this.message);

  @override
  List<Object> get props => [message];
}
