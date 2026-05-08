import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quanlygom/models/customer/customer.dart';
import 'package:quanlygom/request/customer/CreateCustomerRequest.dart';
import 'package:quanlygom/request/customer/UpdateCustomerRequest.dart';

class CustomerService {
  final String baseUrl;
  final String token;

  CustomerService(this.baseUrl, this.token);

  Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  // GET LIST (pagination)
  Future<List<Customer>> getCustomers({int page = 1, int size = 20}) async {
    try {
      final res = await http.get(
        Uri.parse('$baseUrl/customers?page=$page&size=$size'),
        headers: headers,
      );

      final jsonData = jsonDecode(res.body);
      final List list = jsonData['data']['content'];

      return list.map((e) => Customer.fromJson(e)).toList();
    } catch (e) {
      print('Error getCustomers: $e');
      return [];
    }
  }

  // CREATE
  Future<bool> createCustomer(CreateCustomerRequest request) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/customers'),
        headers: headers,
        body: jsonEncode(request.toJson()),
      );

      return res.statusCode == 200 || res.statusCode == 201;
    } catch (e) {
      print('Error createCustomer: $e');
      return false;
    }
  }

  // UPDATE
  Future<bool> updateCustomer(UpdateCustomerRequest request) async {
    try {
      final res = await http.put(
        Uri.parse('$baseUrl/customers/${request.id}'),
        headers: headers,
        body: jsonEncode(request.toJson()),
      );

      return res.statusCode == 200 || res.statusCode == 204;
    } catch (e) {
      print('Error updateCustomer: $e');
      return false;
    }
  }

  // DELETE
  Future<bool> deleteCustomer(String id) async {
    try {
      final res = await http.delete(
        Uri.parse('$baseUrl/customers/$id'),
        headers: headers,
      );

      return res.statusCode == 200 || res.statusCode == 204;
    } catch (e) {
      print('Error deleteCustomer: $e');
      return false;
    }
  }
}
