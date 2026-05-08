import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:sizer/sizer.dart';

class AppFloatingActionButton extends StatelessWidget {
  final VoidCallback onAddProduct;
  final VoidCallback onAddCategory;

  const AppFloatingActionButton({
    super.key,
    required this.onAddProduct,
    required this.onAddCategory,
  });

  @override
  Widget build(BuildContext context) {
    bool isTablet = Device.screenType == ScreenType.tablet;

    // ✅ Bọc Padding bên ngoài SpeedDial để đẩy vị trí
    return Padding(
      padding: EdgeInsets.only(
        bottom: isTablet ? 0 : 0, // Đẩy lên trên phần võng của thanh navigation
        right: isTablet ? 2.w : 0, // Chỉnh lề phải một chút trên Tablet
      ),
      child: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),

        // Cấu hình kích thước thích ứng
        buttonSize: isTablet ? Size(8.h, 8.h) : const Size(55, 55),
        childrenButtonSize: isTablet ? Size(7.h, 7.h) : const Size(50, 50),

        // Khoảng cách giữa nút chính và các nút con khi bung ra
        spacing: isTablet ? 20 : 10,
        spaceBetweenChildren: isTablet ? 15 : 12,

        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        children: [
          // Nút thêm Sản phẩm
          SpeedDialChild(
            child: Icon(Icons.inventory_2, size: isTablet ? 22.sp : 28),
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            label: 'Thêm sản phẩm',
            labelStyle: TextStyle(
              fontSize: isTablet ? 14.sp : 16,
              fontWeight: FontWeight.w500,
            ),
            onTap: onAddProduct,
            shape: const CircleBorder(),
          ),
          // Nút thêm Danh mục
          SpeedDialChild(
            child: Icon(Icons.category, size: isTablet ? 24.sp : 32),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            label: 'Thêm danh mục',
            labelStyle: TextStyle(
              fontSize: isTablet ? 14.sp : 16,
              fontWeight: FontWeight.w500,
            ),
            onTap: onAddCategory,
            shape: const CircleBorder(),
          ),
        ],
      ),
    );
  }
}
