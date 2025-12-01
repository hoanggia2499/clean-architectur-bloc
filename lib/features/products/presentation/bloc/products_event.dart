part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class ProductsRefreshed extends ProductsEvent {}

class ProductsFetched extends ProductsEvent {}

class SortOrderChanged extends ProductsEvent {
  final SortOrder sortOrder;

  const SortOrderChanged(this.sortOrder);

  @override
  List<Object> get props => [sortOrder];
}
