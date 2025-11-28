import 'package:base_project/features/product_detail/data/models/review_model.dart';
import 'package:base_project/features/product_detail/domain/entities/product_detail_entity.dart';

class ProductDetailModel extends ProductDetailEntity {
  const ProductDetailModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.discountPercentage,
    required super.rating,
    required super.stock,
    required super.brand,
    required super.category,
    required super.thumbnail,
    required super.images,
    required super.reviews,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      stock: json['stock'] as int,
      brand: json['brand'] as String,
      category: json['category'] as String,
      thumbnail: json['thumbnail'] as String,
      images: List<String>.from(json['images'] as List),
      reviews: (json['reviews'] as List)
          .map((reviewJson) => ReviewModel.fromJson(reviewJson as Map<String, dynamic>))
          .toList(),
    );
  }
}
