import 'package:dartz/dartz.dart';
import 'package:base_project/core/error.dart';
import 'package:base_project/features/product_detail/domain/entities/product_detail_entity.dart';

abstract class ProductDetailRepository {
  Future<Either<Failure, ProductDetailEntity>> getProductDetail(int productId);
}
