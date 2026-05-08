import 'package:quanlygom/models/category/category.dart';

class Product {
  final String id;
  final String name;
  final String categoryId;
  final Category? category;
  final double price;
  final int stock;

  Product({
    required this.id,
    required this.name,
    required this.categoryId,
    this.category,
    required this.price,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'] ?? '',
      categoryId: json['categoryId'],
      category: json['category'] != null
          ? Category.fromJson(json['category'])
          : null,
      price: (json['currentPrice'] ?? 0).toDouble(),
      stock: json['stockQuantity'] ?? 0,
    );
  }
}
