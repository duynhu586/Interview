import 'package:flutter/material.dart';

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
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Ảnh sản phẩm
          Center(
            child: Container(
              height: 200,
              width: double.infinity, // vẫn nên full width
              alignment: Alignment.center,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.category, size: 50, color: Colors.blue),
              ),
            ),
          ),

          // 🔹 Thông tin sản phẩm
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),

                Text(
                  "Giá: ${price.toInt()} VNĐ",
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  "Tồn kho: $stock",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // 🔹 Action buttons
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text("Sửa"),
                  style: TextButton.styleFrom(foregroundColor: Colors.blue),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete, size: 18),
                  label: const Text("Xóa"),
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
