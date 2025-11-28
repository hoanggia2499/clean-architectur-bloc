import 'package:dartz/dartz.dart';
import 'package:base_project/core/error.dart';

import '../entities/product_list_entity.dart';

abstract class ProductsRepository {
  Future<Either<Failure, ProductListEntity>> getProducts({
    required int limit,
    required int skip,
  });
}
