import 'package:flutter/material.dart';
import 'package:quanlygom/models/customer/customer.dart';
import 'package:quanlygom/request/customer/CreateCustomerRequest.dart';
import 'package:quanlygom/request/customer/UpdateCustomerRequest.dart';
import 'package:quanlygom/services/customer/customer_service.dart';

class CustomerListViewModel extends ChangeNotifier {
  final CustomerService _customerService;

  CustomerListViewModel(this._customerService);

  // --- STATE ---
  List<Customer> _customers = [];
  bool _isLoading = false;
  String? _errorMessage;

  // --- GETTERS ---
  List<Customer> get customers => _customers;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // --- ACTIONS ---

  // Tải danh sách khách hàng
  Future<void> loadCustomers({int page = 1, int size = 20}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _customers = await _customerService.getCustomers(page: page, size: size);
    } catch (e) {
      _errorMessage = "Không thể tải danh sách khách hàng: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Tạo mới khách hàng
  Future<bool> createCustomer({
    required String name,
    required String phone,
    String? address,
  }) async {
    try {
      final request = CreateCustomerRequest(name: name, phoneNumber: phone);

      final success = await _customerService.createCustomer(request);

      if (success) {
        await loadCustomers(); // Refresh lại danh sách
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = "Lỗi khi tạo khách hàng: $e";
      notifyListeners();
      return false;
    }
  }

  // Cập nhật khách hàng
  Future<bool> updateCustomer({
    required String id,
    required String name,
    required String phone,
    String? address,
  }) async {
    try {
      final request = UpdateCustomerRequest(
        id: id,
        name: name,
        phoneNumber: phone,
      );

      final success = await _customerService.updateCustomer(request);
      if (success) {
        await loadCustomers();
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = "Lỗi khi cập nhật: $e";
      notifyListeners();
      return false;
    }
  }

  // Xóa khách hàng
  Future<bool> deleteCustomer(String id) async {
    try {
      final success = await _customerService.deleteCustomer(id);
      if (success) {
        _customers.removeWhere((c) => c.id == id);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = "Lỗi khi xóa khách hàng: $e";
      notifyListeners();
      return false;
    }
  }
}
