import 'package:base_project/core/error.dart';
import 'package:base_project/features/search/domain/entities/search_term_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SearchHistoryRepository {
  Future<Either<Failure, List<SearchTermEntity>>> getSearchHistory();
  Future<Either<Failure, void>> addSearchTerm(String query);
}
