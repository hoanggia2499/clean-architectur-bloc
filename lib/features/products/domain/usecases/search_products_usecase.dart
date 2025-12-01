import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:base_project/core/error.dart';
import 'package:base_project/core/usecase.dart';
import 'package:base_project/features/products/domain/entities/product_list_entity.dart';
import 'package:base_project/features/products/domain/repositories/products_repository.dart';

class SearchProductsUseCase
    implements UseCase<ProductListEntity, SearchProductsParams> {
  final ProductsRepository repository;

  SearchProductsUseCase(this.repository);

  @override
  Future<Either<Failure, ProductListEntity>> call(SearchProductsParams params) async {
    return await repository.searchProducts(query: params.query);
  }
}

class SearchProductsParams extends Equatable {
  final String query;

  const SearchProductsParams({required this.query});

  @override
  List<Object?> get props => [query];
}
