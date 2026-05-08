import 'package:quanlygom/models/order/order_item.dart';

class Order {
  final String id;
  final String customerId;
  final double totalAmount;
  final int itemCount;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.customerId,
    required this.totalAmount,
    required this.itemCount,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      customerId: json['customerId'],
      totalAmount: (json['totalAmount'] as num).toDouble(),
      itemCount: json['itemCount'],
      items: (json['items'] as List).map((e) => OrderItem.fromJson(e)).toList(),
    );
  }
}
