import 'package:flutter/material.dart';
import 'package:quanlygom/models/product/product.dart';

class OrderProductItem extends StatelessWidget {
  final Product product;
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const OrderProductItem({
    super.key,
    required this.product,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // Đổ bóng nhẹ tạo chiều sâu
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        // Viền để phân cách rõ các item trên nền trắng
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            // --- Icon thay cho ảnh ---
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons
                    .inventory_2_outlined, // Icon hộp hàng nhìn rất hợp với quản lý gốm/kho
                color: Colors.blueAccent,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),

            // --- Thông tin ---
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xFF2D3436),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "${product.price}đ",
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "| Tồn: ${product.stock}",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // --- Bộ điều khiển số lượng ---
            Row(
              children: [
                _buildQuantityBtn(
                  Icons.remove,
                  onDecrease,
                  isEnabled: quantity > 0,
                ),
                SizedBox(
                  width: 30,
                  child: Text(
                    "$quantity",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                _buildQuantityBtn(Icons.add, onIncrease, isEnabled: true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget helper để nút bấm trông gọn hơn
  Widget _buildQuantityBtn(
    IconData icon,
    VoidCallback onTap, {
    required bool isEnabled,
  }) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isEnabled
              ? Colors.blueAccent.withOpacity(0.1)
              : Colors.grey.shade100,
        ),
        child: Icon(
          icon,
          size: 18,
          color: isEnabled ? Colors.blueAccent : Colors.grey.shade400,
        ),
      ),
    );
  }
}
