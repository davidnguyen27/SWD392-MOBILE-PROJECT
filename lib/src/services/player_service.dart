import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:t_shirt_football_project/src/config/config.dart';
import 'package:t_shirt_football_project/src/models/player.dart';
import 'package:t_shirt_football_project/src/services/token_service.dart';

class PlayerService {
  static Future<List<Player>> fetchPlayers() async {
    final response = await http.post(
      Uri.parse('${AppConfig.apiBaseUrl}/api/player/search'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "pageNum": 1,
        "pageSize": 50,
        "keyWord": "",
        "status": true,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> playerData = data['data']['pageData'];
      return playerData.map((json) => Player.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load players');
    }
  }

  static Future<Player> getPlayer(int id) async {
    String? token = await TokenService.getToken();

    final res = await http.get(
      Uri.parse('${AppConfig.apiBaseUrl}/api/player/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      final data = json['data'];

      return Player.fromJson(data);
    } else if (res.statusCode == 401 || res.statusCode == 403) {
      throw Exception(
          'Unauthorized: You do not have the required permissions.');
    } else {
      print('Status code: ${res.statusCode}');
      throw Exception('Failed to get Player');
    }
  }
}
