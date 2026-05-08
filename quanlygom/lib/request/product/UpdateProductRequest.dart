class UpdateProductRequest {
  final String id;
  final String name;
  final String categoryId;
  final double currentPrice;
  final int stockQuantity;

  UpdateProductRequest({
    required this.name,
    required this.categoryId,
    required this.currentPrice,
    required this.stockQuantity,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "categoryId": categoryId,
    "currentPrice": currentPrice,
    "stockQuantity": stockQuantity,
  };
}
