import 'package:flutter/material.dart';
import 'package:quanlygom/views/product/widgets/product_screen/product_action.dart';
import 'package:quanlygom/views/product/widgets/product_screen/product_image.dart';
import 'package:quanlygom/views/product/widgets/product_screen/product_info.dart';

class ProductItem extends StatelessWidget {
  final String name;
  final double price;
  final int stock;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductItem({
    super.key,
    required this.name,
    required this.price,
    required this.stock,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImage(),

          ProductInfo(name: name, price: price, stock: stock),

          const Divider(height: 1),

          ProductActions(onEdit: onEdit, onDelete: onDelete),
        ],
      ),
    );
  }
}
