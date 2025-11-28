import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final int rating;
  final String comment;
  final DateTime date;
  final String reviewerName;

  const ReviewEntity({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
  });

  @override
  List<Object?> get props => [rating, comment, date, reviewerName];
}
