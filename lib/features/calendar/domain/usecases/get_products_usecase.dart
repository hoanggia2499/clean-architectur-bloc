import 'package:dartz/dartz.dart';
import 'package:base_project/core/error.dart';
import 'package:base_project/core/usecase.dart';
import 'package:base_project/features/calendar/domain/entities/product_list_entity.dart';
import 'package:base_project/features/calendar/domain/repositories/calendar_repository.dart';

class GetProductsUseCase implements UseCase<ProductListEntity, NoParams> {
  final CalendarRepository repository;

  GetProductsUseCase(this.repository);

  @override
  Future<Either<Failure, ProductListEntity>> call(NoParams params) async {
    return await repository.getProducts();
  }
}
