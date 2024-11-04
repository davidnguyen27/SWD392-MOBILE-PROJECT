import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:t_shirt_football_project/src/config/config.dart';
import 'package:t_shirt_football_project/src/models/size.dart';
import 'package:t_shirt_football_project/src/services/token_service.dart';

class SizeService {
  static Future<List<Size>> getAllSizes() async {
    final url = Uri.parse('${AppConfig.apiBaseUrl}/api/size/search');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "pageNum": 1,
        "pageSize": 50,
        "keyWord": "",
        "status": true,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data']['pageData'] as List;
      return data.map((json) => Size.fromJson(json)).toList();
    } else {
      final errResponse = jsonDecode(response.body);
      throw Exception(
          'Error ${errResponse["code"]} code: ${errResponse["message"]}');
    }
  }

  static Future<Size> getSizeDetail(int id) async {
    final url = Uri.parse('${AppConfig.apiBaseUrl}/api/size/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return Size.fromJson(data);
    } else {
      final errResponse = jsonDecode(response.body);
      throw Exception(
          'Error ${errResponse["code"]} code: ${errResponse["message"]}');
    }
  }

  static Future<void> createSize(
      String name, String description, bool status) async {
    String? token = await TokenService.getToken();
    final url = Uri.parse('${AppConfig.apiBaseUrl}/api/size');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode({
        'name': name,
        'description': description,
        'status': status,
      }),
    );

    if (response.statusCode != 201) {
      final errResponse = jsonDecode(response.body);
      throw Exception(
          'Error ${errResponse["status"]} code: ${errResponse["errors"]}');
    }
  }

  static Future<void> updateSize(
      int id, String name, String description, bool status) async {
    String? token = await TokenService.getToken();
    final url = Uri.parse('${AppConfig.apiBaseUrl}/api/size?id=$id');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode({
        'name': name,
        'description': description,
        'status': status,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update size');
    }
  }

  static Future<bool> deleteSize(int id) async {
    String? token = await TokenService.getToken();

    final res = await http.delete(
        Uri.parse(
            '${AppConfig.apiBaseUrl}/api/size/change-status/$id?status=false'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });

    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to deleted season');
    }
  }
}
