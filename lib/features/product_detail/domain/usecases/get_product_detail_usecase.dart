import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:base_project/core/error.dart';
import 'package:base_project/core/usecase.dart';
import 'package:base_project/features/product_detail/domain/entities/product_detail_entity.dart';
import 'package:base_project/features/product_detail/domain/repositories/product_detail_repository.dart';

class GetProductDetailUseCase
    implements UseCase<ProductDetailEntity, GetProductDetailParams> {
  final ProductDetailRepository repository;

  GetProductDetailUseCase(this.repository);

  @override
  Future<Either<Failure, ProductDetailEntity>> call(GetProductDetailParams params) async {
    return await repository.getProductDetail(params.productId);
  }
}

class GetProductDetailParams extends Equatable {
  final int productId;

  const GetProductDetailParams({required this.productId});

  @override
  List<Object?> get props => [productId];
}
