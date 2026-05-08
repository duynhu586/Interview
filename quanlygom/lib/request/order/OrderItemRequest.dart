class OrderItemRequest {
  final String orderId;
  final String productId;

  OrderItemRequest({required this.orderId, required this.productId});

  Map<String, dynamic> toJson() {
    return {"orderId": orderId, "productId": productId};
  }
}
