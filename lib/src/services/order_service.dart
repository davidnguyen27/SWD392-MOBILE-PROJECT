import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:t_shirt_football_project/src/config/config.dart';
import 'package:t_shirt_football_project/src/services/token_service.dart';

class OrderService {
  Future fetchOrders(
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
          return responseData['data'];
        } else {
          return 'API call unsuccessful: ${responseData['message']}';
        }
      } else {
        return 'Failed to fetch orders: ${response.statusCode}';
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }
}
