import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:t_shirt_football_project/src/config/config.dart';
import '../models/user.dart';
import '../repositories/auth_repository.dart';
import '../services/token_service.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  User? _user;
  String? _token;
  bool _isLoading = false;
  String? _errorMessage;

  final AuthRepository _authRepository = AuthRepository();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> login(String email, String password) async {
    _setLoading(true);
    try {
      _user = await _authRepository.login(email, password);
      _token = await TokenService.getToken();
      _errorMessage = null; // Xóa thông báo lỗi khi thành công

      if (_token != null && _token!.isNotEmpty) {
        await getCurrentUser();
        if (_user != null) {
          if (_user?.roleName != 'Manager') {
            _errorMessage =
                'Access denied. You are not allowed to login with this role.';
            _user = null; // Xóa user để ngăn đăng nhập
          }
        }
      }
    } catch (e) {
      _user = null;
      _errorMessage = e.toString(); // Hiển thị thông báo lỗi từ Exception
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // Người dùng hủy đăng nhập
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final String? idToken = googleAuth.idToken;

      if (idToken != null) {
        final response = await http.post(
          Uri.parse(
              '${AppConfig.apiBaseUrl}/api/user/loginmail?googleId=$idToken'),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> decodedBody = jsonDecode(response.body);

          // Kiểm tra và cập nhật `user` và `token`
          _user = User.fromJson(decodedBody['data']['user']);
          _token = decodedBody['data']['token'];
          await TokenService.saveToken(_token!);
          _errorMessage = null; // Đặt lại lỗi nếu có
          await getCurrentUser();
        } else {
          print(
              "Failed to login with backend. Status code: ${response.statusCode}");
        }
      } else {
        print('Failed to retrieve ID token.');
      }
    } catch (e) {
      print("Error during Google login: $e");
    }
  }

  Future<void> getCurrentUser() async {
    _setLoading(true);
    try {
      _token ??= await TokenService.getToken();

      if (_token == null || _token!.isEmpty) {
        throw Exception('Token not available');
      }

      final response = await http.get(
        Uri.parse('${AppConfig.apiBaseUrl}/api/user/current-user'),
        headers: {'Authorization': 'Bearer $_token'},
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw Exception('Request timeout');
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedBody = jsonDecode(response.body);
        final data = decodedBody['data'];

        _user = User.fromJson(data);
        _errorMessage = null; // Clear error message on success
      } else {
        _errorMessage = 'Failed to get current user.';
      }
    } catch (e) {
      _errorMessage = e.toString();
      _user = null;
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  Future<void> updateUserDetails(String userId, User updatedUser) async {
    _setLoading(true);
    try {
      _token ??= await TokenService.getToken();

      if (_token == null || _token!.isEmpty) {
        throw Exception('Token not available');
      }

      final response = await http.put(
        Uri.parse('${AppConfig.apiBaseUrl}/api/user/$userId'),
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(updatedUser.toJson()),
      );

      if (response.statusCode == 200) {
        _user = updatedUser;
        _errorMessage = null; // Clear error message on success
      } else {
        final responseBody = jsonDecode(response.body);
        _errorMessage =
            responseBody['message'] ?? 'Failed to update user details.';
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _user = null;
    _token = null;
    await TokenService.removeToken();
    await _googleSignIn.signOut();
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    // notifyListeners();
  }
}
