import 'dart:convert';

import 'package:base_project/core/error.dart';
import 'package:base_project/features/search/data/models/search_term_model.dart';
import 'package:base_project/features/search/domain/entities/search_term_entity.dart';
import 'package:base_project/features/search/domain/repositories/search_history_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SearchHistoryRepositoryImpl implements SearchHistoryRepository {
  final FlutterSecureStorage _storage;
  static const _historyKey = 'search_history';

  SearchHistoryRepositoryImpl(this._storage);

  @override
  Future<Either<Failure, void>> addSearchTerm(String query) async {
    try {
      final history = await getSearchHistory();
      final List<SearchTermModel> updatedHistory = history.fold(
        (l) => [],
        (r) => r.map((e) => SearchTermModel(query: e.query, timestamp: e.timestamp)).toList(),
      );

      // Remove existing entry if it exists to avoid duplicates and move it to the top.
      updatedHistory.removeWhere((term) => term.query.toLowerCase() == query.toLowerCase());

      // Add the new term to the beginning of the list.
      updatedHistory.insert(0, SearchTermModel(query: query, timestamp: DateTime.now()));

      // Apply business rules: not older than 3 days and max 20 items.
      final threeDaysAgo = DateTime.now().subtract(const Duration(days: 3));
      final filteredHistory = updatedHistory
          .where((term) => term.timestamp.isAfter(threeDaysAgo))
          .take(20)
          .toList();

      final jsonString = jsonEncode(filteredHistory.map((e) => e.toJson()).toList());
      await _storage.write(key: _historyKey, value: jsonString);

      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<SearchTermEntity>>> getSearchHistory() async {
    try {
      final jsonString = await _storage.read(key: _historyKey);
      if (jsonString == null) {
        return const Right([]);
      }

      final List<dynamic> jsonList = jsonDecode(jsonString);
      final history = jsonList
          .map((json) => SearchTermModel.fromJson(json as Map<String, dynamic>))
          .toList();

      // Also apply the age filter when retrieving history.
      final threeDaysAgo = DateTime.now().subtract(const Duration(days: 3));
      final filteredHistory = history
          .where((term) => term.timestamp.isAfter(threeDaysAgo))
          .toList();

      return Right(filteredHistory);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
