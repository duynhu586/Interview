import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quanlygom/models/product/product.dart';
import 'package:quanlygom/view-models/category/category_view_model.dart';
import 'package:quanlygom/view-models/product/product_view_model.dart';
import 'package:quanlygom/views/category/category_form_screen.dart';
import 'package:quanlygom/views/product/product_form_screen.dart';

import 'package:quanlygom/views/product/widgets/product_screen/product_appbar.dart';
import 'package:quanlygom/views/product/widgets/product_screen/product_item.dart';
import 'package:quanlygom/views/share_widgets/add_floating_button.dart';
import 'package:quanlygom/views/product/widgets/product_screen/product_list.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key}); // Không cần nhận viewModel ở đây nữa

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    // Gọi API lấy danh sách sản phẩm ngay khi khởi tạo màn hình
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductListViewModel>().loadProducts();
      context.read<CategoryViewModel>().fetchCategories(); // Di chuyển vào đây
    });
  }

  @override
  Widget build(BuildContext context) {
    // Lắng nghe sự thay đổi từ ViewModel
    final viewModel = context.watch<ProductListViewModel>();

    return Scaffold(
      appBar: const ProductAppBar(title: "Quản lý Gốm"),

      floatingActionButton: AppFloatingActionButton(
        onAddProduct: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProductFormScreen()),
          );
        },
        onAddCategory: () {
          // Xử lý thêm danh mục
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CategoryFormScreen()),
          );
        },
      ),

      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ProductList(
              products: viewModel.filteredProducts,
              itemBuilder: (product) {
                return ProductItem(
                  name: product.name,
                  price: product.price,
                  stock: product.stock,
                  onEdit: () => onEdit(product),
                  onDelete: () => onDelete(product),
                );
              },
            ),
    );
  }

  void onEdit(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ProductFormScreen(product: product)),
    ).then((_) {
      context.read<ProductListViewModel>().loadProducts();
    });
  }

  void onDelete(Product product) {
    _showDeleteDialog(product);
  }

  void _showDeleteDialog(Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Xóa sản phẩm"),
        content: Text("Bạn có chắc muốn xóa ${product.name}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Hủy"),
          ),
          TextButton(
            onPressed: () async {
              final bool success = await context
                  .read<ProductListViewModel>()
                  .deleteProduct(product.id);

              Navigator.pop(context);

              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Đã xóa ${product.name}")),
                );
              } else {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Xóa thất bại")));
              }
            },
            child: Text("Xóa"),
          ),
        ],
      ),
    );
  }
}
