import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quanlygom/models/order/cart_item.dart';
import 'package:quanlygom/view-models/customer/customer_list_view_model.dart';
import 'package:quanlygom/view-models/order/create_order_view_model.dart';
import 'package:quanlygom/view-models/product/product_view_model.dart';
import 'package:quanlygom/views/order/widgets/custom_picker.dart';
import 'package:quanlygom/views/order/widgets/customer_selector.dart';
import 'package:quanlygom/views/order/widgets/order_appbar.dart';

import 'package:quanlygom/views/order/widgets/order_product_list.dart';
import 'package:quanlygom/views/order/widgets/order_summary.dart';
import 'package:quanlygom/views/order/widgets/place_order_button.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final customerVM = context.read<CustomerListViewModel>();
      final productVM = context.read<ProductListViewModel>();

      context.read<CreateOrderViewModel>().initData(customerVM, productVM);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CreateOrderViewModel>();
    final productVM = context.watch<ProductListViewModel>();
    final customerVM = context.watch<CustomerListViewModel>();

    return Scaffold(
      appBar: const OrderAppBar(),

      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                /// 👤 chọn khách hàng
                CustomerSelector(
                  selectedName: vm.getSelectedCustomerName(
                    customerVM.customers,
                  ),
                  onSelect: () => showCustomerPicker(context),
                ),

                /// 📦 list product
                OrderProductList(
                  products: productVM.products, // Lấy list từ Product ViewModel
                  getQuantity: (id) => vm.items
                      .firstWhere(
                        (e) => e.productId == id,
                        orElse: () => CartItem(
                          productId: '',
                          productName: '',
                          price: 0,
                          quantity: 0,
                        ),
                      )
                      .quantity,
                  onIncrease: (p) => vm.addProduct(
                    productId: p.id,
                    name: p.name,
                    price: p.price,
                  ),
                  onDecrease: (p) => vm.decreaseProduct(p),
                ),

                /// 💰 summary
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: OrderSummary(
                    totalItems: vm.totalItems,
                    totalPrice: vm.totalAmount,
                  ),
                ),

                /// 🚀 button
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: PlaceOrderButton(
                    onPressed: () async {
                      final success = await vm.createOrder();

                      if (!context.mounted) return;

                      if (success) {
                        context.read<ProductListViewModel>().loadProducts();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Tạo đơn thành công")),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(vm.errorMessage ?? "Có lỗi xảy ra"),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
