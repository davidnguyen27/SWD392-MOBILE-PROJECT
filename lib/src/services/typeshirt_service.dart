import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:t_shirt_football_project/src/config/config.dart';

class TypeShirtService {
  static Future<List<String>> getAllTypeShirts() async {
    final response = await http.post(
      Uri.parse('${AppConfig.apiBaseUrl}/api/typeshirt/search'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "pageNum": 1,
        "pageSize": 50,
        "keyWord": "",
        "status": true,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'] as List?;
      return data != null ? data.cast<String>() : [];
    } else {
      throw Exception('Failed to load type shirts');
    }
  }
}
