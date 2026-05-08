import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProductInfo extends StatelessWidget {
  final String name;
  final double price;
  final int stock;

  const ProductInfo({
    required this.name,
    required this.price,
    required this.stock,
  });

  // product_info.dart

  @override
  Widget build(BuildContext context) {
    // Kiểm tra nếu là Tablet thì tăng size, ngược lại giữ nguyên
    bool isTablet = Device.screenType == ScreenType.tablet;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              // Nếu là tablet dùng 16.sp, mobile dùng 14.sp
              fontSize: isTablet ? 18.sp : 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            "Giá: ${price.toInt()} VNĐ",
            style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.w500,
              // Tương tự cho phần giá
              fontSize: isTablet ? 16.sp : 14.sp,
            ),
          ),
          Text(
            "Tồn kho: $stock",
            style: TextStyle(
              // Mobile dùng 12px, Tablet dùng 10.sp (tự động scale)
              fontSize: isTablet ? 14.sp : 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
