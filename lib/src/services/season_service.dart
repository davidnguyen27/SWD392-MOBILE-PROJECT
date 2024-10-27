import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:t_shirt_football_project/src/config/config.dart';
import 'package:t_shirt_football_project/src/models/season.dart';
import 'package:t_shirt_football_project/src/services/token_service.dart';

class SeasonService {
  static Future<List<Season>> getAllSeasons() async {
    final response = await http.post(
      Uri.parse('${AppConfig.apiBaseUrl}/api/session/search'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "pageNum": 1,
        "pageSize": 50,
        "keyWord": "",
        "status": true,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List<dynamic> seasonList = data['data']['pageData'] ?? [];

      // Chuyển đổi từ List<dynamic> sang List<Season>
      return seasonList.map((json) => Season.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load seasons');
    }
  }

  static Future<Season> getSeason(int id) async {
    String? token = await TokenService.getToken();

    final res = await http.get(
      Uri.parse('${AppConfig.apiBaseUrl}/api/session/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      final data = json['data'];

      return Season.fromJson(data);
    } else if (res.statusCode == 401 || res.statusCode == 403) {
      throw Exception(
          'Unauthorized: You do not have the required permissions.');
    } else {
      throw Exception('Failed to get season');
    }
  }

  static Future<void> createSeason({
    required String name,
    required DateTime startDate,
    required DateTime endDate,
    required String description,
  }) async {
    String? token =
        await TokenService.getToken(); // Lấy token từ SharedPreferences

    if (token == null) {
      throw Exception('Token not found');
    }
    final response = await http.post(
      Uri.parse('${AppConfig.apiBaseUrl}/api/session'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Token được kiểm tra ở đây
      },
      body: jsonEncode({
        'name': name,
        'startDdate': startDate.toIso8601String(),
        'endDdate': endDate.toIso8601String(),
        'description': description,
        'status': true,
      }),
    );

    if (response.statusCode == 201) {
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      throw Exception(
          'Unauthorized: You do not have the required permissions.');
    } else {
      throw Exception('Failed to create season');
    }
  }

  static Future<bool> deleteSeason(int id) async {
    String? token = await TokenService.getToken();

    final res = await http.delete(
        Uri.parse(
            '${AppConfig.apiBaseUrl}/api/session/change-status/$id?status=false'),
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

  static Future<bool> updateSeason(Season season) async {
    String? token = await TokenService.getToken();

    final res = await http.put(
      Uri.parse('${AppConfig.apiBaseUrl}/api/session?id=${season.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(season.toJson()),
    );

    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update season');
    }
  }
}
