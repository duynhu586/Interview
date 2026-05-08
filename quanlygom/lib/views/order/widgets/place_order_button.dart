import 'package:flutter/material.dart';

class PlaceOrderButton extends StatelessWidget {
  final VoidCallback onPressed;

  const PlaceOrderButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Text("Tạo đơn hàng"),
      ),
    );
  }
}
