import 'package:flutter/material.dart';
import '../../ui/home_ui.dart'; // Import Home UI

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildHomeScreen(context), // Gọi UI từ home_ui.dart
    );
  }
}
