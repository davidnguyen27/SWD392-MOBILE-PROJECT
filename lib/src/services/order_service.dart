import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:t_shirt_football_project/src/config/config.dart';
import 'package:t_shirt_football_project/src/models/order.dart';
import 'package:t_shirt_football_project/src/services/token_service.dart';

class OrderService {
  Future<List<Order>> fetchOrders(
      int pageNum, int pageSize, String orderId, int status) async {
    String? token = await TokenService.getToken();
    final url = Uri.parse('${AppConfig.apiBaseUrl}/api/order/search');

    final body = jsonEncode({
      "pageNum": pageNum,
      "pageSize": pageSize,
      "orderId": orderId,
      "status": status,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['success'] == true) {
          // Trích xuất dữ liệu từ `pageData`
          final List<dynamic> orderList = responseData['data']['pageData'];
          return orderList.map((order) => Order.fromJson(order)).toList();
        } else {
          throw Exception('API call unsuccessful: ${responseData['message']}');
        }
      } else {
        throw Exception('Failed to fetch orders: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  static Future<Order> getOrder(int id) async {
    String? token = await TokenService.getToken();
    final url = Uri.parse('${AppConfig.apiBaseUrl}/api/order/$id');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return Order.fromJson(data);
    } else {
      final errResponse = jsonDecode(response.body);
      throw Exception(
          'Error ${errResponse["code"]} code: ${errResponse["message"]}');
    }
  }
}
