import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:t_shirt_football_project/src/config/config.dart';
import '../models/user.dart';
import '../repositories/auth_repository.dart';
import '../services/token_service.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;

class AuthProvider with ChangeNotifier {
  firebaseAuth.User? firebaseUser;

  User? _user;
  String? _token;
  bool _isLoading = false;
  String? _errorMessage;

  final AuthRepository _authRepository = AuthRepository();
  // final TokenService _tokenService = TokenService();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final firebaseAuth.FirebaseAuth _firebaseAuth =
      firebaseAuth.FirebaseAuth.instance;

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
    _setLoading(true);
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // Nếu người dùng hủy đăng nhập
        _setLoading(false);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Xác thực với Firebase
      final firebaseAuth.AuthCredential credential =
          firebaseAuth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Đăng nhập với Firebase và lấy Firebase ID token
      final firebaseAuth.UserCredential authResult =
          await _firebaseAuth.signInWithCredential(credential);
      final String? idToken = await authResult.user?.getIdToken();

      // Kiểm tra và log giá trị idToken
      if (idToken != null) {
        print("Firebase ID Token: $idToken");

        // Gửi idToken này tới API của bạn
        _user = await _authRepository.loginWithGoogleId(idToken);

        if (_user != null) {
          // Đăng nhập thành công
          _token = _user!.token;
          await TokenService.saveToken(_token!);
          await getCurrentUser();
        } else {
          _errorMessage = 'Google Login failed.';
        }
      } else {
        _errorMessage = 'Failed to get Firebase ID Token.';
      }
    } catch (e) {
      _errorMessage = 'Error during Google login: $e';
    } finally {
      _setLoading(false);
    }
    notifyListeners();
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
    notifyListeners();
  }
}
