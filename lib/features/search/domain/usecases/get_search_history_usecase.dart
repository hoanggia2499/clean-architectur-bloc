import 'package:base_project/core/error.dart';
import 'package:base_project/core/usecase.dart';
import 'package:base_project/features/search/domain/entities/search_term_entity.dart';
import 'package:base_project/features/search/domain/repositories/search_history_repository.dart';
import 'package:dartz/dartz.dart';

class GetSearchHistoryUseCase implements UseCase<List<SearchTermEntity>, NoParams> {
  final SearchHistoryRepository repository;

  GetSearchHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<SearchTermEntity>>> call(NoParams params) async {
    return await repository.getSearchHistory();
  }
}
