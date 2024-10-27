import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ui/profile_ui.dart';
import '../../providers/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = true; // Trạng thái tải dữ liệu

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser(); // Gọi API lấy thông tin người dùng khi mở tab Profile
  }

  Future<void> _fetchCurrentUser() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.getCurrentUser(); // Gọi API
    } catch (e) {
      print('Error fetching user: $e');
      // Xử lý lỗi nếu cần
    } finally {
      setState(() {
        _isLoading = false; // Cập nhật trạng thái khi dữ liệu được tải xong
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    if (_isLoading) {
      // Hiển thị vòng quay tải khi đang lấy dữ liệu
      return const Center(child: CircularProgressIndicator());
    }

    if (user == null) {
      return const Center(
        child: Text('User data is not available'),
      );
    }

    return Scaffold(
      body: buildProfileScreen(context),
    );
  }
}
