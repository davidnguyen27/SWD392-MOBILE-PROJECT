import 'package:flutter/material.dart';
import 'package:t_shirt_football_project/src/models/dashboard.dart';
import 'package:t_shirt_football_project/src/services/dashboard_service.dart';
import '../../ui/home_ui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<DashboardData?> fetchDashboardData() {
    final dashboardService = DashboardService();
    return dashboardService.fetchDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DashboardData?>(
          future: fetchDashboardData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Failed to load dashboard data'));
            } else if (snapshot.hasData) {
              final dashboardData = snapshot.data!;
              // Giờ sẽ in ra dữ liệu thực tế
              return buildHomeScreen(context, dashboardData);
            } else {
              return const Center(child: Text('No data available'));
            }
          }),
    );
  }
}
