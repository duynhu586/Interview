import 'package:flutter/material.dart';
import 'package:quanlygom/models/category/category.dart';
import 'package:quanlygom/request/category/CreateCategoryRequest.dart';
import 'package:quanlygom/request/category/UpdateCategoryRequest.dart';
import 'package:quanlygom/services/category/category_service.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryService _service;
  List<Category> categories = [];
  bool isLoading = false;

  CategoryViewModel(this._service);

  // 1. LẤY DANH SÁCH (READ)
  Future<void> fetchCategories() async {
    isLoading = true;
    notifyListeners();
    categories = await _service.fetchCategories();
    isLoading = false;
    notifyListeners();
  }

  // 2. TẠO MỚI (CREATE)
  Future<bool> createCategory(String name, String? description) async {
    final request = CreateCategoryRequest(name: name, description: description);
    final success = await _service.createCategory(request);
    if (success) await fetchCategories(); // Refresh lại danh sách sau khi tạo
    return success;
  }

  // 3. CẬP NHẬT (UPDATE)
  Future<bool> updateCategory({
    required String id,
    required String name,
    String? description,
  }) async {
    final request = UpdateCategoryRequest(
      id: id,
      name: name,
      description: description,
    );

    final success = await _service.updateCategory(request);
    if (success) {
      // Thay vì fetch lại toàn bộ, ta cập nhật trực tiếp trong list cho mượt UI
      final index = categories.indexWhere((element) => element.id == id);
      if (index != -1) {
        categories[index] = Category(
          id: id,
          name: name,
          description: description,
        );
        notifyListeners();
      }
    }
    return success;
  }

  // 4. XÓA (DELETE)
  Future<bool> deleteCategory(String id) async {
    final success = await _service.deleteCategory(id);
    if (success) {
      // Xóa khỏi list hiện tại để UI biến mất ngay lập tức
      categories.removeWhere((element) => element.id == id);
      notifyListeners();
    }
    return success;
  }
}
