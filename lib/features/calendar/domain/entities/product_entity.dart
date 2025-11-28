import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final String thumbnail;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.thumbnail,
  });

  @override
  List<Object?> get props => [id, title, category, price];
}
