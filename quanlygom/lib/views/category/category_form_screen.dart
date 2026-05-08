import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quanlygom/view-models/category/category_view_model.dart';
import 'package:quanlygom/views/share_widgets/custom_text_field.dart';
import 'package:quanlygom/views/share_widgets/submit_button.dart';

class CategoryFormScreen extends StatefulWidget {
  const CategoryFormScreen({super.key});

  @override
  State<CategoryFormScreen> createState() => _CategoryFormScreenState();
}

class _CategoryFormScreenState extends State<CategoryFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controller cho các trường nhập liệu
  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final viewModel = context.read<CategoryViewModel>();

    // Gọi createCategory với đầy đủ 2 tham số như ViewModel định nghĩa
    final success = await viewModel.createCategory(
      _nameController.text.trim(),
      _descController.text.trim().isEmpty ? null : _descController.text.trim(),
    );

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Thêm danh mục thành công!")),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Lỗi: Không thể tạo danh mục")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Lắng nghe trạng thái loading từ ViewModel
    final isLoading = context.watch<CategoryViewModel>().isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text("Tạo danh mục gốm"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Field Tên danh mục (Bắt buộc)
              CustomTextField(
                controller: _nameController,
                label: "Tên danh mục *",
                hintText: "VD: Gốm Bát Tràng",
                validator: (value) => (value == null || value.isEmpty)
                    ? "Vui lòng nhập tên danh mục"
                    : null,
              ),

              const SizedBox(height: 20),

              // Field Mô tả (Tùy chọn)
              CustomTextField(
                controller: _descController,
                label: "Mô tả",
                hintText: "Nhập mô tả ngắn gọn về loại gốm này...",
              ),

              const SizedBox(height: 40),

              // Nút lưu đồng nhất với form sản phẩm
              SubmitButton(
                text: "LƯU DANH MỤC",
                isLoading: isLoading,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
