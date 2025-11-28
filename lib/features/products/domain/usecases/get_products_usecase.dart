import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:base_project/core/error.dart';
import 'package:base_project/core/usecase.dart';

import '../entities/product_list_entity.dart';
import '../repositories/products_repository.dart';

/// The parameters for fetching products, including pagination.
class GetProductsParams extends Equatable {
  final int limit;
  final int skip;

  const GetProductsParams({required this.limit, required this.skip});

  @override
  List<Object?> get props => [limit, skip];
}

class GetProductsUseCase implements UseCase<ProductListEntity, GetProductsParams> {
  final ProductsRepository repository;

  GetProductsUseCase(this.repository);

  @override
  Future<Either<Failure, ProductListEntity>> call(GetProductsParams params) async {
    return await repository.getProducts(limit: params.limit, skip: params.skip);
  }
}
