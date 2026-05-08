import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: const Icon(Icons.category, size: 50, color: Colors.blue),
      ),
    );
  }
}
