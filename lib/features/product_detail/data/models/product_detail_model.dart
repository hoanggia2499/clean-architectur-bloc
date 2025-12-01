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
    final imagesList = json['images'] as List?;
    final reviewsList = json['reviews'] as List?;

    return ProductDetailModel(
      // Provide default values for all potentially null fields.
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num? ?? 0).toDouble(),
      discountPercentage:
          (json['discountPercentage'] as num? ?? 0).toDouble(),
      rating: (json['rating'] as num? ?? 0).toDouble(),
      stock: json['stock'] as int? ?? 0,
      brand: json['brand'] as String? ?? 'Unknown Brand',
      category: json['category'] as String? ?? '',
      thumbnail: json['thumbnail'] as String? ?? '',
      images: imagesList?.map((e) => e.toString()).toList() ?? [],
      reviews: reviewsList
              ?.map((reviewJson) =>
                  ReviewModel.fromJson(reviewJson as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
