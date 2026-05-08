import 'package:flutter/material.dart';
import 'package:quanlygom/models/customer/customer.dart';
import 'package:quanlygom/models/order/cart_item.dart';
import 'package:quanlygom/request/order/CreateOrderRequest.dart';
import 'package:quanlygom/request/order/OrderItemRequest.dart';
import 'package:quanlygom/services/order/order_service.dart';
import 'package:quanlygom/view-models/customer/customer_list_view_model.dart';
import 'package:quanlygom/view-models/product/product_view_model.dart';

class CreateOrderViewModel extends ChangeNotifier {
  final OrderService orderService;

  CreateOrderViewModel(this.orderService);

  // ===== STATE =====
  String? selectedCustomerId;

  final List<CartItem> _items = [];
  List<CartItem> get items => _items;

  bool isLoading = false;
  String? errorMessage;

  Future<void> initData(
    CustomerListViewModel customerVM,
    ProductListViewModel productVM,
  ) async {
    isLoading = true;
    notifyListeners();

    try {
      // Chạy song song cả 2 để tiết kiệm thời gian
      await Future.wait([customerVM.loadCustomers(), productVM.loadProducts()]);
    } catch (e) {
      errorMessage = "Không thể tải dữ liệu khởi tạo";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ===== COMPUTED =====
  double get totalAmount =>
      _items.fold(0, (sum, item) => sum + item.price * item.quantity);

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  bool get canSubmit =>
      selectedCustomerId != null && _items.isNotEmpty && !isLoading;

  // ===== ACTIONS =====

  void selectCustomer(String customerId) {
    selectedCustomerId = customerId;
    notifyListeners();
  }

  void addProduct({
    required String productId,
    required String name,
    required double price,
  }) {
    final index = _items.indexWhere((e) => e.productId == productId);

    if (index != -1) {
      _items[index].quantity++;
    } else {
      _items.add(
        CartItem(productId: productId, productName: name, price: price),
      );
    }

    notifyListeners();
  }

  void decreaseProduct(String productId) {
    final index = _items.indexWhere((e) => e.productId == productId);

    if (index == -1) return;

    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    } else {
      _items.removeAt(index);
    }

    notifyListeners();
  }

  void removeProduct(String productId) {
    _items.removeWhere((e) => e.productId == productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // ===== API CALL =====
  Future<bool> createOrder() async {
    // ✅ VALIDATION RÕ RÀNG
    if (selectedCustomerId == null) {
      errorMessage = "Vui lòng chọn khách hàng";
      notifyListeners();
      return false;
    }

    if (_items.isEmpty) {
      errorMessage = "Vui lòng chọn sản phẩm";
      notifyListeners();
      return false;
    }

    // (Optional) check tồn kho
    for (var item in _items) {
      // bạn cần truyền product stock vào CartItem hoặc check từ ProductVM
      if (item.quantity <= 0) {
        errorMessage = "Số lượng không hợp lệ";
        notifyListeners();
        return false;
      }
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final items = <OrderItemRequest>[];

      for (var item in _items) {
        for (int i = 0; i < item.quantity; i++) {
          items.add(
            OrderItemRequest(
              orderId: "00000000-0000-0000-0000-000000000000",
              productId: item.productId,
            ),
          );
        }
      }

      final request = CreateOrderRequest(
        customerId: selectedCustomerId!,
        items: items,
      );

      final result = await orderService.createOrder(request);

      if (result != null) {
        clearCart();
        selectedCustomerId = null;
        return true;
      }

      errorMessage = "Tạo đơn thất bại";
      return false;
    } catch (e) {
      errorMessage = "Lỗi hệ thống: ${e.toString()}";
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  String? getSelectedCustomerName(List<Customer> customers) {
    try {
      final c = customers.firstWhere((e) => e.id == selectedCustomerId);
      return c.name;
    } catch (_) {
      return null;
    }
  }
}
