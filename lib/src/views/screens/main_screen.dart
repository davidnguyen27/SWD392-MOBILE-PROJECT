import 'package:flutter/material.dart';
import 'package:t_shirt_football_project/src/views/components/custom_footer.dart';
import 'package:t_shirt_football_project/src/views/screens/home_screen.dart';
import 'package:t_shirt_football_project/src/views/screens/payment_screen.dart';
import 'package:t_shirt_football_project/src/views/screens/profile_screen.dart';
import 'package:t_shirt_football_project/src/views/screens/test_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0; // Biến lưu trạng thái cho footer

  // List screens
  final List<Widget> _screens = [
    const HomeScreen(),
    const PaymentScreen(),
    const CryptoScreen(),
    const ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index; // Cập nhật chỉ số màn hình đang được hiển thị
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens, // Các màn hình được giữ trạng thái
      ),
      bottomNavigationBar: CustomFooter(
        currentIndex: _currentIndex,
        onTap: _onTabTapped, // routes all screen
      ),
    );
  }
}
