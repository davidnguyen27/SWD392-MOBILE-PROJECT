import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:t_shirt_football_project/src/config/config.dart';
import 'package:t_shirt_football_project/src/models/payment.dart';
import 'package:t_shirt_football_project/src/services/token_service.dart';

class PaymentService {
  static Future<List<Payment>> getAllPayments() async {
    final String? token = await TokenService.getToken();
    final response = await http.post(
      Uri.parse('${AppConfig.apiBaseUrl}/api/payment/search'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "pageNum": 1,
        "pageSize": 50,
        "keyWord": "",
        "status": true,
      }),
    );

    print(
        'API Response Status Code: ${response.statusCode}'); // Debug: Trạng thái phản hồi
    print(
        'API Response Body: ${response.body}'); // Debug: Nội dung phản hồi từ API

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List<dynamic> paymentList = data['data']['pageData'] ?? [];
      print(
          'Parsed payment list: $paymentList'); // Debug: In danh sách payment đã phân tích

      return paymentList.map((json) => Payment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load payments');
    }
  }
}