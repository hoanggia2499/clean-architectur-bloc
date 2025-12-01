import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:base_project/core/error.dart';
import 'package:base_project/features/product_detail/data/datasources/product_detail_remote_data_source.dart';
import 'package:base_project/features/product_detail/domain/entities/product_detail_entity.dart';
import 'package:base_project/features/product_detail/domain/repositories/product_detail_repository.dart';

class ProductDetailRepositoryImpl implements ProductDetailRepository {
  final ProductDetailRemoteDataSource remoteDataSource;

  ProductDetailRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ProductDetailEntity>> getProductDetail(int productId) async {
    try {
      final productDetail = await remoteDataSource.getProductDetail(productId);
      return Right(productDetail);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'An unexpected error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
