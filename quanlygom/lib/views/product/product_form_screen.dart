import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quanlygom/models/product/product.dart';
import 'package:quanlygom/view-models/category/category_view_model.dart';
import 'package:quanlygom/view-models/product/product_view_model.dart';
import 'package:quanlygom/views/category/widgets/category_dropdown.dart';
import 'package:quanlygom/views/share_widgets/custom_text_field.dart';
import 'package:quanlygom/views/share_widgets/submit_button.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;

  const ProductFormScreen({super.key, this.product});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController stockController;

  bool isLoading = false;
  String? selectedCategoryId;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.product?.name ?? "");
    priceController = TextEditingController(
      text: widget.product?.price.toString() ?? "",
    );
    stockController = TextEditingController(
      text: widget.product?.stock.toString() ?? "",
    );

    selectedCategoryId = widget.product?.categoryId;

    // Load dữ liệu category ngay khi vào màn hình
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryViewModel>().fetchCategories();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    stockController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final viewModel = context.read<ProductListViewModel>();

    final name = nameController.text.trim();
    final price = double.parse(priceController.text);
    final stock = int.parse(stockController.text);

    bool success;

    if (widget.product != null) {
      // UPDATE
      success = await viewModel.updateProduct(
        id: widget.product!.id,
        name: name,
        price:
            price, // ViewModel nhận tham số 'price' rồi mới đóng gói vào Request
        stock:
            stock, // ViewModel nhận tham số 'stock' rồi mới đóng gói vào Request
        categoryId: selectedCategoryId!,
      );
    } else {
      // CREATE
      success = await viewModel.createProduct(
        name: name,
        price: price,
        stock: stock,
        categoryId: selectedCategoryId!,
      );
    }
    setState(() => isLoading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.product != null
                ? "Cập nhật thành công"
                : "Tạo sản phẩm thành công",
          ),
        ),
      );

      Navigator.pop(context, true); // trả kết quả về
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Có lỗi xảy ra")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.product != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Sửa sản phẩm" : "Thêm sản phẩm")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            // Nên thêm để tránh tràn màn hình khi hiện bàn phím
            child: Column(
              children: [
                CustomTextField(
                  controller: nameController,
                  label: "Tên sản phẩm",
                  validator: (value) => (value == null || value.isEmpty)
                      ? "Không được để trống"
                      : null,
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  controller: priceController,
                  label: "Giá sản phẩm",
                  keyboardType: TextInputType.number,
                  validator: (value) => double.tryParse(value ?? '') == null
                      ? "Sai định dạng"
                      : null,
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  controller: stockController,
                  label: "Số lượng kho",
                  keyboardType: TextInputType.number,
                  validator: (value) => int.tryParse(value ?? '') == null
                      ? "Sai định dạng"
                      : null,
                ),
                const SizedBox(height: 20),

                // Widget CategoryDropdown của bạn giữ nguyên hoặc cho vào share_widgets nếu cần
                CategoryDropdown(
                  selectedId: selectedCategoryId,
                  onChanged: (val) => setState(() => selectedCategoryId = val),
                ),

                const SizedBox(height: 40),

                SubmitButton(
                  text: isEdit ? "CẬP NHẬT" : "TẠO MỚI",
                  isLoading: isLoading,
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
