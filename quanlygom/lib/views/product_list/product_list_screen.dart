import 'package:flutter/material.dart';
import 'package:quanlygom/views/product_list/widgets/product_item.dart';
// Đảm bảo bạn đã import file chứa ProductItem của bạn
// import 'package:quanlygom/widgets/product_item.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách sản phẩm"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10), // Khoảng cách nhẹ phía trên
          // Hiển thị thử 1 item với dữ liệu giả (Hardcode)
          ProductItem(
            name: "Bình gốm Bát Tràng hoa văn cổ",
            price: 250000,
            stock: 15,
            onEdit: () {
              print("Sửa sản phẩm này");
            },
            onDelete: () {
              print("Xóa sản phẩm này");
            },
          ),

          // Bạn có thể thêm một cái nữa để xem danh sách trông thế nào
          ProductItem(
            name: "Chén trà men ngọc",
            price: 45000,
            stock: 120,
            onEdit: () => print("Edit item 2"),
            onDelete: () => print("Delete item 2"),
          ),
        ],
      ),
    );
  }
}
