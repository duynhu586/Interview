import 'package:flutter/material.dart';

class OrderSummary extends StatelessWidget {
  final int totalItems;
  final double totalPrice;

  const OrderSummary({
    super.key,
    required this.totalItems,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const Text("Số sản phẩm"), Text("$totalItems")],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Tổng tiền"),
              Text("${totalPrice.toStringAsFixed(0)} đ"),
            ],
          ),
        ],
      ),
    );
  }
}
