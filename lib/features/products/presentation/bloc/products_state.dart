part of 'products_bloc.dart';

enum SortOrder { none, asc, desc }

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsFailure extends ProductsState {
  final String message;

  const ProductsFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class ProductsSuccess extends ProductsState {
  final List<ProductEntity> products;
  final bool hasReachedMax;
  final SortOrder sortOrder;

  const ProductsSuccess({
    this.products = const [],
    this.hasReachedMax = false,
    this.sortOrder = SortOrder.none,
  });

  ProductsSuccess copyWith({
    List<ProductEntity>? products,
    bool? hasReachedMax,
    SortOrder? sortOrder,
  }) {
    return ProductsSuccess(
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  List<Object> get props => [products, hasReachedMax, sortOrder];
}
