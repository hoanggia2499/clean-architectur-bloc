import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:base_project/core/error.dart';
import 'package:base_project/features/products/data/datasources/products_remote_data_source.dart';
import 'package:base_project/features/products/domain/entities/product_list_entity.dart';
import 'package:base_project/features/products/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;

  ProductsRepositoryImpl( this.remoteDataSource);

  @override
  Future<Either<Failure, ProductListEntity>> getProducts(
      {required int limit, required int skip, String? sortBy, String? order}) async {
    try {
      final productList = await remoteDataSource.getProducts(
          limit: limit, skip: skip, sortBy: sortBy, order: order);
      return Right(productList);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'An unexpected error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductListEntity>> searchProducts({required String query}) async {
    try {
      final productList = await remoteDataSource.searchProducts(query: query);
      return Right(productList);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'An unexpected error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
