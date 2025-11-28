import 'package:equatable/equatable.dart';
import 'package:base_project/features/product_detail/domain/entities/review_entity.dart';

class ProductDetailEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;
  final List<ReviewEntity> reviews;

  const ProductDetailEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
    required this.reviews,
  });

  @override
  List<Object?> get props => [id, title, brand, category, rating];
}
