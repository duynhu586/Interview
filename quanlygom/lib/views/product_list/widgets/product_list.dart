import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart'; //
import 'product_item.dart';

class ProductList extends StatelessWidget {
  final List<dynamic> products;
  final Function(dynamic) onEdit;
  final Function(dynamic) onDelete;

  const ProductList({
    super.key,
    required this.products,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: Text("Không có sản phẩm"));
    }

    // ✅ Sử dụng Device.screenType để xác định loại thiết bị
    int crossAxisCount;
    if (Device.screenType == ScreenType.tablet) {
      crossAxisCount = 3; // iPad / Tablet
    } else {
      crossAxisCount = 1; // Mobile mặc định
    }

    return GridView.builder(
      padding: EdgeInsets.all(2.w),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        // Tùy chỉnh tỉ lệ khung hình để item không bị quá dài trên mobile
        childAspectRatio: crossAxisCount == 1 ? 1.3 : 0.7,
        crossAxisSpacing: 2.w,
        mainAxisSpacing: 2.w,
      ),
      itemBuilder: (context, index) {
        final product = products[index];

        return ProductItem(
          name: product.name,
          price: product.price,
          stock: product.stock,
          onEdit: () => onEdit(product),
          onDelete: () => onDelete(product),
        );
      },
    );
  }
}
