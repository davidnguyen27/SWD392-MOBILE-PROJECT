import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:t_shirt_football_project/src/config/config.dart';
import 'package:t_shirt_football_project/src/models/club.dart';
import 'package:t_shirt_football_project/src/services/token_service.dart';

class ClubService {
  static Future<List<Club>> fetchClubs(
      int pageNum, int pageSize, String keyWord, bool status) async {
    final url = Uri.parse('${AppConfig.apiBaseUrl}/api/club/search');
    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "pageNum": pageNum,
        "pageSize": pageSize,
        "keyWord": keyWord,
        "status": status,
      }),
    );

    if (res.statusCode == 200) {
      final data = json.decode(res.body)['data']['pageData'] as List;
      return data.map((json) => Club.fromJson(json)).toList();
    } else {
      final errResponse = jsonDecode(res.body);
      throw Exception(
          'Error ${errResponse["code"]} code: ${errResponse["message"]}');
    }
  }

  static Future<void> createClub(
      {required String name,
      required String country,
      required DateTime establishedYear,
      required String stadiumName,
      required String clubLogo,
      required String description,
      required bool status}) async {
    String? token = await TokenService.getToken();
    final response = await http.post(
      Uri.parse('${AppConfig.apiBaseUrl}/api/club'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'name': name,
        'country': country,
        'establishedYear': establishedYear.toIso8601String(),
        'stadiumName': stadiumName,
        'clubLogo': clubLogo,
        'description': description,
        'status': status,
      }),
    );

    if (response.statusCode == 200) {
      final resData = jsonDecode(response.body);
      return resData['message'];
    } else if (response.statusCode != 201) {
      final errResponse = jsonDecode(response.body);
      throw Exception(
          'Error ${errResponse["status"]} code: ${errResponse["errors"]}');
    }
  }

  static Future<Club> fetchClubDetail(int id) async {
    final url = Uri.parse('${AppConfig.apiBaseUrl}/api/club/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return Club.fromJson(data);
    } else {
      final errResponse = jsonDecode(response.body);
      throw Exception(
          'Error ${errResponse["code"]} code: ${errResponse["message"]}');
    }
  }

  static Future<void> updateClub(
      int clubId, Map<String, dynamic> clubData) async {
    String? token = await TokenService.getToken();
    final response = await http.put(
      Uri.parse('${AppConfig.apiBaseUrl}/api/club?id=$clubId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(clubData),
    );

    if (response.statusCode == 200) {
      final resMessage = jsonDecode(response.body);
      return resMessage['message'];
    } else {
      throw Exception('Failed to update club');
    }
  }

  static Future<void> deleteClub(int id) async {
    String? token = await TokenService.getToken();
    final url = Uri.parse('${AppConfig.apiBaseUrl}/api/club/$id?status=false');
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print("Club deleted successfully");
    } else if (response.statusCode == 401) {
      final errResponse = jsonDecode(response.body);
      throw Exception(
          'Error ${errResponse["code"]} code: ${errResponse["message"]}');
    }
  }
}
