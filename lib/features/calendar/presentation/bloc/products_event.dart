part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class ProductsPageInitialized extends ProductsEvent {}
class AllProductsReceived extends ProductsEvent {}

/// Fired when the page is first initialized or when a pull-to-refresh is performed.
class ProductsRefreshed extends ProductsEvent {}

/// Fired when the user scrolls to the bottom of the list to load more products.
class ProductsFetched extends ProductsEvent {}
