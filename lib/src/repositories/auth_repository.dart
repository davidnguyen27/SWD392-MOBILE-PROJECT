import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/config.dart';
import '../models/user.dart';
import '../services/token_service.dart';

class AuthRepository {
  // final TokenService _tokenService = TokenService();

  Future<User?> login(String email, String password) async {
    final url = Uri.parse('${AppConfig.apiBaseUrl}/api/user/login');

    try {
      // Thực hiện POST request để login
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        // Nếu đăng nhập thành công
        final decodedBody = jsonDecode(response.body);

        // Lấy token từ JSON
        final token = decodedBody['data']['token'] ?? '';

        // Lưu token vào SharedPreferences (hoặc bất kỳ lưu trữ nào)
        await TokenService.saveToken(token);

        // Trả về User object từ 'data'
        // return User.fromJson(decodedBody['data']);
      } else {
        // Nếu status code không phải 200, kiểm tra thông báo lỗi từ JSON
        final decodedBody = jsonDecode(response.body);
        final errorMessage = decodedBody['message'] ?? 'Login failed.';

        // Ném ngoại lệ chứa thông báo lỗi
        return Future.error(errorMessage);
      }
    } catch (e) {
      // Xử lý lỗi chung và trả về thông báo lỗi chi tiết
      return Future.error('Error during login: $e');
    }
    return null;
  }

  Future<User?> loginWithGoogleId(String googleId) async {
    final url = Uri.parse(
        '${AppConfig.apiBaseUrl}/api/user/loginmail?googleId=$googleId');

    // Gọi API với googleId
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final decodedBody = jsonDecode(response.body);
      return User.fromJson(decodedBody['data']);
    } else {
      throw Exception('Failed to login with Google ID');
    }
  }
}
