import 'package:base_project/features/search/domain/entities/search_term_entity.dart';

class SearchTermModel extends SearchTermEntity {
  const SearchTermModel({required super.query, required super.timestamp});

  factory SearchTermModel.fromJson(Map<String, dynamic> json) {
    return SearchTermModel(
      query: json['query'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'query': query,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }
}
