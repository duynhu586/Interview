import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'package:quanlygom/view-models/customer/customer_list_view_model.dart';
import 'package:quanlygom/view-models/order/create_order_view_model.dart';

void showCustomerPicker(BuildContext context) {
  final customerVM = context.read<CustomerListViewModel>();
  final orderVM = context.read<CreateOrderViewModel>();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return SizedBox(
        height: 60.h,
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Text("Chọn khách hàng", style: TextStyle(fontSize: 18)),

            const Divider(),

            Expanded(
              child: ListView.builder(
                itemCount: customerVM.customers.length,
                itemBuilder: (context, index) {
                  final customer = customerVM.customers[index];

                  return ListTile(
                    title: Text(customer.name),
                    subtitle: Text(customer.phoneNumber),
                    onTap: () {
                      orderVM.selectCustomer(customer.id);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
