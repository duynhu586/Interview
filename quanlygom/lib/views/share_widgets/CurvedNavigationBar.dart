import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    (
      icon: Icons.inventory_2_outlined,
      iconActive: Icons.inventory_2_rounded,
      label: 'Kho',
    ),
    (
      icon: Icons.add_shopping_cart_outlined,
      iconActive: Icons.add_shopping_cart_rounded,
      label: 'Đơn hàng',
    ),
    (
      icon: Icons.bar_chart_outlined,
      iconActive: Icons.bar_chart_rounded,
      label: 'Thống kê',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final isTablet = screenWidth >= 600;

    final double iconSize = (screenWidth * 0.055).clamp(20.0, 42.0);
    final double fontSize = (screenWidth * 0.022).clamp(9.0, 16.5);
    final double barHeight = (screenHeight * 0.085).clamp(56.0, 92.0);

    return Container(
      width: double.infinity,
      height: barHeight + bottomPadding,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Tab row
          Expanded(
            child: Row(
              children: List.generate(_items.length, (i) {
                final item = _items[i];
                final isActive = i == currentIndex;

                return Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onTap(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      margin: EdgeInsets.symmetric(
                        horizontal: isTablet ? 24 : 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isActive
                            ? Colors.white.withOpacity(0.28)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: Icon(
                              isActive ? item.iconActive : item.icon,
                              key: ValueKey(isActive),
                              size: iconSize,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            item.label,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSize,
                              fontWeight: isActive
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          // Safe area padding
          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }
}
