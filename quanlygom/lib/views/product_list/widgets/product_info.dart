import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProductInfo extends StatelessWidget {
  final String name;
  final double price;
  final int stock;

  const ProductInfo({
    required this.name,
    required this.price,
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.5.h),
          Text(
            "Giá: ${price.toInt()} VNĐ",
            style: const TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "Tồn kho: $stock",
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
