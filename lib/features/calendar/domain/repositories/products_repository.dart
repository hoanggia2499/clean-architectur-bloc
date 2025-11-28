import 'package:dartz/dartz.dart';
import 'package:base_project/core/error.dart';
import 'package:base_project/features/calendar/domain/entities/product_list_entity.dart';

abstract class CalendarRepository {
  Future<Either<Failure, ProductListEntity>> getProducts({
    required int limit,
    required int skip,
  });
}
