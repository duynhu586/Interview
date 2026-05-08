class OrderItem {
  final String id;
  final String productId;
  final String productName;
  final double unitPrice;

  OrderItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.unitPrice,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      productId: json['productId'],
      productName: json['productName'] ?? 'null',
      unitPrice: (json['unitPrice'] as num).toDouble(),
    );
  }
}
