import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quanlygom/view-models/category/category_view_model.dart';

class CategoryDropdown extends StatelessWidget {
  final String? selectedId;
  final Function(String?) onChanged;

  const CategoryDropdown({
    super.key,
    required this.selectedId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Gọi fetchCategories khi widget được xây dựng nếu danh sách trống
    final viewModel = context.watch<CategoryViewModel>();

    return DropdownButtonFormField<String>(
      value: selectedId,
      decoration: const InputDecoration(
        labelText: "Danh mục",
        border: OutlineInputBorder(),
      ),
      hint: const Text("Chọn danh mục"),
      items: viewModel.categories.map((cat) {
        return DropdownMenuItem(
          value: cat.id,
          child: Text(cat.name ?? "Không tên"),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? "Vui lòng chọn danh mục" : null,
    );
  }
}
