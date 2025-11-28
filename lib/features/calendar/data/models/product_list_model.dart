import 'package:base_project/features/calendar/data/models/product_model.dart';
import 'package:base_project/features/calendar/domain/entities/product_list_entity.dart';

class ProductListModel extends ProductListEntity {
  const ProductListModel({
    required super.products,
    required super.total,
    required super.skip,
    required super.limit,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      products: (json['products'] as List)
          .map((productJson) => ProductModel.fromJson(productJson as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int,
      skip: json['skip'] as int,
      limit: json['limit'] as int,
    );
  }
}
