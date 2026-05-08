import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProductActions extends StatelessWidget {
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ProductActions({super.key, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final isTablet = Device.screenType == ScreenType.tablet;

    return Row(
      children: [
        if (onEdit != null)
          Expanded(
            child: TextButton.icon(
              onPressed: onEdit,
              icon: Icon(Icons.edit, size: isTablet ? 15.sp : 18),
              label: Text(
                "Sửa",
                style: TextStyle(fontSize: isTablet ? 14.sp : 16),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: isTablet ? 2.h : 1.h),
              ),
            ),
          ),

        if (onDelete != null)
          Expanded(
            child: TextButton.icon(
              onPressed: onDelete,
              icon: Icon(Icons.delete, size: isTablet ? 15.sp : 18),
              label: Text(
                "Xóa",
                style: TextStyle(fontSize: isTablet ? 14.sp : 16),
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: isTablet ? 2.h : 1.h),
              ),
            ),
          ),
      ],
    );
  }
}
