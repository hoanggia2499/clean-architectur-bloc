import 'package:base_project/features/product_detail/domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.rating,
    required super.comment,
    required super.date,
    required super.reviewerName,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      rating: json['rating'] as int,
      comment: json['comment'] as String,
      date: DateTime.parse(json['date'] as String),
      reviewerName: json['reviewerName'] as String,
    );
  }
}
