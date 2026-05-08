import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quanlygom/models/order/order.dart';
import 'package:quanlygom/request/order/CreateOrderRequest.dart';

class OrderService {
  final String baseUrl;
  final String token;

  OrderService(this.baseUrl, this.token);

  Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  // CREATE ORDER
  Future<Order?> createOrder(CreateOrderRequest request) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/orders'),
        headers: headers,
        body: jsonEncode(request.toJson()),
      );

      print("--- DEBUG CREATE ORDER ---");
      print("Status Code: ${res.statusCode}");
      print("Response Body: ${res.body}");
      print("--------------------------");

      if (res.statusCode == 200 || res.statusCode == 201) {
        final jsonData = jsonDecode(res.body);
        return Order.fromJson(jsonData['data']);
      }

      return null;
    } catch (e) {
      print('Error createOrder: $e');
      return null;
    }
  }

  // GET LIST
  Future<List<Order>> getOrders() async {
    try {
      final res = await http.get(
        Uri.parse('$baseUrl/orders'),
        headers: headers,
      );

      final jsonData = jsonDecode(res.body);
      final List list = jsonData['data']['content'];

      return list.map((e) => Order.fromJson(e)).toList();
    } catch (e) {
      print('Error getOrders: $e');
      return [];
    }
  }
}
