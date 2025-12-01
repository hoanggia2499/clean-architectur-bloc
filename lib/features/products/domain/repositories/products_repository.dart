import 'package:dartz/dartz.dart';
import 'package:base_project/core/error.dart';
import 'package:base_project/features/products/domain/entities/product_list_entity.dart';

abstract class ProductsRepository {
  Future<Either<Failure, ProductListEntity>> getProducts({
    required int limit,
    required int skip,
    String? sortBy,
    String? order,
  });

  Future<Either<Failure, ProductListEntity>> searchProducts({required String query});
}
