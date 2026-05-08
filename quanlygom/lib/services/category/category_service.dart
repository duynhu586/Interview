import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quanlygom/models/category/category.dart';
import 'package:quanlygom/request/category/CreateCategoryRequest.dart';
import 'package:quanlygom/request/category/UpdateCategoryRequest.dart';

class CategoryService {
  final String baseUrl;
  final String token;

  CategoryService(this.baseUrl, this.token);

  Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  // 4.2 Lấy danh sách danh mục (phân trang)
  Future<List<Category>> fetchCategories({int page = 1, int size = 20}) async {
    try {
      final res = await http.get(
        Uri.parse('$baseUrl/categories?page=$page&size=$size'), //
        headers: headers,
      );

      final jsonData = jsonDecode(res.body);
      // Giống cấu trúc ProductService: data -> content
      final List list = jsonData['data']['content'];
      return list.map((e) => Category.fromJson(e)).toList();
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }

  // 4.1 TẠO MỚI (Sử dụng CreateCategoryRequest)
  Future<bool> createCategory(CreateCategoryRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/categories'),
        headers: headers,
        body: jsonEncode(request.toJson()), //
      );

      return response.statusCode == 201 || response.statusCode == 200; //
    } catch (e) {
      print('Error creating category: $e');
      return false;
    }
  }

  // 4.4 CẬP NHẬT (Sử dụng UpdateCategoryRequest)
  Future<bool> updateCategory(UpdateCategoryRequest request) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/categories/${request.id}'), //
        headers: headers,
        body: jsonEncode(request.toJson()),
      );

      // Cập nhật thường trả về 200 hoặc 204
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print('Error updating category: $e');
      return false;
    }
  }

  // 4.5 XÓA
  Future<bool> deleteCategory(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/categories/$id'),
        headers: headers,
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print('Error deleting category: $e');
      return false;
    }
  }
}
