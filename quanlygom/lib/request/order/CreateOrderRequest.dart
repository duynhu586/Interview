import 'package:quanlygom/request/order/OrderItemRequest.dart';

class CreateOrderRequest {
  final String customerId;
  final List<OrderItemRequest> items;

  CreateOrderRequest({required this.customerId, required this.items});

  Map<String, dynamic> toJson() {
    return {
      "customerId": customerId,
      "items": items.map((e) => e.toJson()).toList(),
    };
  }
}
