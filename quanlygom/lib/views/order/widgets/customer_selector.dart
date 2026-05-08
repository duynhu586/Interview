import 'package:flutter/material.dart';

class CustomerSelector extends StatelessWidget {
  final String? selectedName;
  final VoidCallback onSelect;

  const CustomerSelector({
    super.key,
    required this.selectedName,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(selectedName ?? "Chọn khách hàng"),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onSelect,
    );
  }
}
