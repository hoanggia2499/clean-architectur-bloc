import 'package:equatable/equatable.dart';
import 'package:base_project/features/calendar/domain/entities/product_entity.dart';

class ProductListEntity extends Equatable {
  final List<ProductEntity> products;
  final int total;
  final int skip;
  final int limit;

  const ProductListEntity({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  @override
  List<Object?> get props => [products, total, skip, limit];
}
