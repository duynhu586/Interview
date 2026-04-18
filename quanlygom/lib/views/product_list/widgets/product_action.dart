import 'package:flutter/material.dart';

class ProductActions extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductActions({required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton.icon(
            onPressed: onEdit,
            icon: const Icon(Icons.edit, size: 18),
            label: const Text("Sửa"),
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
    );
  }
}
