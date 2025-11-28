import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:base_project/core/error.dart';
import 'package:base_project/features/calendar/data/datasources/products_remote_data_source.dart';
import 'package:base_project/features/calendar/domain/entities/product_list_entity.dart';
import 'package:base_project/features/calendar/domain/repositories/products_repository.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  final CalendarRemoteDataSource remoteDataSource;

  CalendarRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ProductListEntity>> getProducts(
      {required int limit, required int skip}) async {
    try {
      final productList = await remoteDataSource.getProducts(limit: limit, skip: skip);
      return Right(productList);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'An unexpected error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
