import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:t_shirt_football_project/src/config/config.dart';
import 'package:t_shirt_football_project/src/models/dashboard.dart';
import 'package:t_shirt_football_project/src/services/token_service.dart';

class DashboardService {
  Future<DashboardData?> fetchDashboardData() async {
    try {
      String? token = await TokenService.getToken();
      final response = await http.get(
        Uri.parse(
            '${AppConfig.apiBaseUrl}/api/dashboard/dashboard-admin-manager'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return DashboardData.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load dashboard data');
      }
    } catch (e) {
      throw Exception('Faild to load dashboard data');
    }
  }
}
