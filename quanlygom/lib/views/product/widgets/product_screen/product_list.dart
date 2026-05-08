import 'package:flutter/material.dart';
import 'package:quanlygom/models/product/product.dart';
import 'package:sizer/sizer.dart'; //

class ProductList extends StatelessWidget {
  final List<Product> products;

  /// 👇 truyền UI tùy ý vào
  final Widget Function(Product product) itemBuilder;

  const ProductList({
    super.key,
    required this.products,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: Text("Không có sản phẩm"));
    }

    final isTablet = Device.screenType == ScreenType.tablet;

    final crossAxisCount = isTablet ? 2 : 1;

    return GridView.builder(
      padding: EdgeInsets.only(
        left: 4.w,
        right: 4.w,
        top: 4.w,
        bottom: isTablet ? 15.h : 100.0,
      ),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: crossAxisCount == 1 ? 1.3 : 0.7,
        crossAxisSpacing: 3.w,
        mainAxisSpacing: 3.w,
      ),
      itemBuilder: (context, index) {
        return itemBuilder(products[index]);
      },
    );
  }
}
