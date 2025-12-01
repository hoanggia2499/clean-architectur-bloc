import 'package:base_project/core/error.dart';
import 'package:base_project/core/usecase.dart';
import 'package:base_project/features/search/domain/repositories/search_history_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddSearchTermUseCase implements UseCase<void, AddSearchTermParams> {
  final SearchHistoryRepository repository;

  AddSearchTermUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(AddSearchTermParams params) async {
    return await repository.addSearchTerm(params.query);
  }
}

class AddSearchTermParams extends Equatable {
  final String query;

  const AddSearchTermParams(this.query);

  @override
  List<Object?> get props => [query];
}
