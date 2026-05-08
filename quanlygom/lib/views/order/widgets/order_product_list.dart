import 'package:flutter/material.dart';
import 'package:quanlygom/models/product/product.dart';
import 'package:quanlygom/views/order/widgets/order_product_item.dart';

class OrderProductList extends StatelessWidget {
  final List<Product> products;
  final int Function(String productId) getQuantity;
  final Function(Product) onIncrease;
  final Function(String) onDecrease;

  const OrderProductList({
    super.key,
    required this.products,
    required this.getQuantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (_, i) {
          final p = products[i];

          return OrderProductItem(
            product: p,
            quantity: getQuantity(p.id),
            onIncrease: () => onIncrease(p),
            onDecrease: () => onDecrease(p.id),
          );
        },
      ),
    );
  }
}
