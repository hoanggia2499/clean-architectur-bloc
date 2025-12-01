import 'package:equatable/equatable.dart';

class SearchTermEntity extends Equatable {
  final String query;
  final DateTime timestamp;

  const SearchTermEntity({required this.query, required this.timestamp});

  @override
  List<Object?> get props => [query, timestamp];
}
