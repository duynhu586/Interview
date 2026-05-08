import 'package:flutter/material.dart';
import 'package:quanlygom/models/product/product.dart';
import 'package:quanlygom/request/product/CreateProductRequest.dart';
import 'package:quanlygom/request/product/UpdateProductRequest.dart';
import 'package:quanlygom/services/product/product_service.dart';

class ProductListViewModel extends ChangeNotifier {
  final ProductService _productService;

  ProductListViewModel(this._productService);

  List<Product> _products = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Tải danh sách sản phẩm
  Future<void> loadProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Gọi service (đã hỗ trợ phân trang trong hướng dẫn trước)
      _products = await _productService.fetchProducts();
    } catch (e) {
      _errorMessage = "Không thể tải sản phẩm: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Xử lý xóa sản phẩm (Logic gọi API xóa có thể thêm vào đây)
  Future<bool> deleteProduct(String id) async {
    try {
      // Gọi API xóa...
      await _productService.deleteProduct(id);
      _products.removeWhere((p) => p.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = "Không thể xóa sản phẩm: $e";
      notifyListeners();
      return false;
    }
  }

  // product_view_model.dart

  Future<bool> createProduct({
    required String name,
    required double price,
    required int stock,
    required String categoryId,
  }) async {
    try {
      // Tạo object Request với các trường tương ứng API muốn
      final request = CreateProductRequest(
        name: name,
        categoryId: categoryId,
        currentPrice: price,
        stockQuantity: stock,
      );

      // Truyền request vào service (Không dùng "as Product" nữa)
      final success = await _productService.createProduct(request);

      if (success) {
        await loadProducts(); // Tải lại danh sách để cập nhật UI
        return true;
      }
      return false;
    } catch (e) {
      print("ViewModel Error: $e");
      return false;
    }
  }

  Future<bool> updateProduct({
    required String id,
    required String name,
    required double price,
    required int stock,
    required String categoryId,
  }) async {
    try {
      await _productService.updateProduct(
        UpdateProductRequest(
          id: id,
          name: name,
          categoryId: categoryId,
          currentPrice: price,
          stockQuantity: stock,
        ),
      );
      await loadProducts();
      return true;
    } catch (e) {
      return false;
    }
  }

  String? _selectedCategoryId; // Lưu ID danh mục đang chọn để lọc

  // Getter để UI dùng hiển thị (thay vì dùng products gốc)
  List<Product> get filteredProducts {
    if (_selectedCategoryId == null) {
      return _products;
    }
    return _products.where((p) => p.categoryId == _selectedCategoryId).toList();
  }

  // Hàm thực hiện lọc
  void filterByCategory(String? categoryId) {
    print("Đang lọc với ID: $categoryId");
    _selectedCategoryId = categoryId;
    notifyListeners(); // Cập nhật lại giao diện
  }
}
