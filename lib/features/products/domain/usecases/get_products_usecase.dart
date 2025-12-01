import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:base_project/core/error.dart';
import 'package:base_project/core/usecase.dart';
import 'package:base_project/features/products/domain/entities/product_list_entity.dart';
import 'package:base_project/features/products/domain/repositories/products_repository.dart';

/// The parameters for fetching products, including pagination and sorting.
class GetProductsParams extends Equatable {
  final int limit;
  final int skip;
  final String? sortBy;
  final String? order;

  const GetProductsParams({
    required this.limit,
    required this.skip,
    this.sortBy,
    this.order,
  });

  @override
  List<Object?> get props => [limit, skip, sortBy, order];
}

class GetProductsUseCase
    implements UseCase<ProductListEntity, GetProductsParams> {
  final ProductsRepository repository;

  GetProductsUseCase(this.repository);

  @override
  Future<Either<Failure, ProductListEntity>> call(GetProductsParams params) async {
    return await repository.getProducts(
      limit: params.limit,
      skip: params.skip,
      sortBy: params.sortBy,
      order: params.order,
    );
  }
}
