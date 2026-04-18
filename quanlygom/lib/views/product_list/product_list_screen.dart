import 'package:flutter/material.dart';
import 'package:quanlygom/views/product_list/models/product_view_data.dart';
import 'package:quanlygom/views/product_list/widgets/product_list.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      ProductViewData(
        name: "Bình gốm Bát Tràng hoa văn cổ",
        price: 250000,
        stock: 15,
      ),
      ProductViewData(name: "Chén trà men ngọc", price: 45000, stock: 120),
      ProductViewData(name: "Chén trà men ngọc", price: 45000, stock: 120),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách sản phẩm"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ProductList(
        products: products,
        onEdit: (product) {
          print("Sửa: ${product.name}");
        },
        onDelete: (product) {
          print("Xóa: ${product.name}");
        },
      ),
    );
  }
}
