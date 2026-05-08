import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quanlygom/view-models/category/category_view_model.dart';
import 'package:quanlygom/view-models/product/product_view_model.dart';

class ProductAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const ProductAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.blueAccent,
      foregroundColor: Colors.white,
      actions: [
        Consumer<CategoryViewModel>(
          builder: (context, catVM, child) {
            return PopupMenuButton<String>(
              // Chuyển từ String? thành String để bắt giá trị "all"
              icon: const Icon(Icons.filter_list),
              onSelected: (value) {
                // Nếu chọn "all", ta truyền null vào ViewModel để hiển thị tất cả
                final String? selectedId = (value == "all") ? null : value;

                print("Giá trị thực tế gửi vào ViewModel: $selectedId");

                context.read<ProductListViewModel>().filterByCategory(
                  selectedId,
                );
              },
              itemBuilder: (context) => [
                const PopupMenuItem<String>(
                  value: "all", // Dùng chuỗi thay vì null
                  child: Text("Tất cả danh mục"),
                ),
                ...catVM.categories.map(
                  (cat) => PopupMenuItem<String>(
                    value: cat.id,
                    child: Text(cat.name ?? "Không tên"),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  // Bắt buộc phải có để xác định chiều cao AppBar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
