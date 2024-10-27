import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:t_shirt_football_project/src/config/config.dart';
import 'package:t_shirt_football_project/src/models/shirt.dart';

class ShirtService {
  static Future<List<Shirt>> getShirts() async {
    final response = await http.post(
      Uri.parse('${AppConfig.apiBaseUrl}/api/shirt/search'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {"pageNum": 1, "pageSize": 50, "keyWord": "", "status": 1}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data']['pageData'] as List?;
      return data != null
          ? data.map((json) => Shirt.fromJson(json)).toList()
          : [];
    } else {
      throw Exception('Failed to load shirts');
    }
  }

  static Future<void> createShirt({
    required String name,
    required String playerName,
    required String typeShirt,
    required int shirtNumber,
    required double price,
    required String description,
    required String urlImg,
  }) async {
    final response = await http.post(
      Uri.parse('${AppConfig.apiBaseUrl}/api/shirt/create'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": name,
        "playerName": playerName,
        "typeShirt": typeShirt,
        "shirtNumber": shirtNumber,
        "price": price,
        "description": description,
        "urlImg": urlImg,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create new shirt');
    }
  }
}
