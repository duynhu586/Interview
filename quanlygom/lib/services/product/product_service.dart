import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quanlygom/models/product/product.dart';
import 'package:quanlygom/request/product/CreateProductRequest.dart';
import 'package:quanlygom/request/product/UpdateProductRequest.dart';

class ProductService {
  final String baseUrl;
  final String token;

  ProductService(this.baseUrl, this.token);

  Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  // GET list
  Future<List<Product>> fetchProducts() async {
    final res = await http.get(
      Uri.parse('$baseUrl/products?page=1&size=20'),
      headers: headers,
    );

    final jsonData = jsonDecode(res.body);

    final List list = jsonData['data']['content']; // ⚠️ nhớ check items/content
    return list.map((e) => Product.fromJson(e)).toList();
  }

  // CREATE
  Future<bool> createProduct(CreateProductRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/products'),
        headers: headers,
        body: jsonEncode({
          "name": request.name,
          "categoryId": request.categoryId,
          "currentPrice": request.currentPrice,
          "stockQuantity": request.stockQuantity,
        }),
      );

      // Trả về true nếu thành công (200 hoặc 201)
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print('Error creating product: $e');
      return false;
    }
  }

  // UPDATE
  Future<bool> updateProduct(UpdateProductRequest product) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/products/${product.id}'),
        headers: headers,
        body: jsonEncode({
          "name": product.name,
          "categoryId": product.categoryId,
          "currentPrice": product.currentPrice,
          "stockQuantity": product.stockQuantity,
        }),
      );

      // Usually, PUT requests return 200 (OK) or 204 (No Content)
      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        print('Update failed with status: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Catch network errors (like no internet)
      print('Error updating product: $e');
      return false;
    }
  }

  // DELETE
  Future<void> deleteProduct(String id) async {
    await http.delete(Uri.parse('$baseUrl/products/$id'), headers: headers);
  }
}
