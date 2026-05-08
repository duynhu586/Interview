class CreateProductRequest {
  final String name;
  final String categoryId;
  final double currentPrice;
  final int stockQuantity;

  CreateProductRequest({
    required this.name,
    required this.categoryId,
    required this.currentPrice,
    required this.stockQuantity,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "categoryId": categoryId,
    "currentPrice": currentPrice,
    "stockQuantity": stockQuantity,
  };
}
