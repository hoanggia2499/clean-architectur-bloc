part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsSuccess extends ProductsState {
  final List<ProductEntity> products;
  final bool hasReachedMax;

  const ProductsSuccess({
    this.products = const [],
    this.hasReachedMax = false,
  });

  ProductsSuccess copyWith({
    List<ProductEntity>? products,
    bool? hasReachedMax,
  }) {
    return ProductsSuccess(
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [products, hasReachedMax];
}

class ProductsFailure extends ProductsState {
  final String message;

  const ProductsFailure({required this.message});

  @override
  List<Object> get props => [message];
}
