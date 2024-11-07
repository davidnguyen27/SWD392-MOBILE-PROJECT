import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import thư viện intl
import 'package:t_shirt_football_project/src/services/dashboard_service.dart';
import 'package:t_shirt_football_project/src/models/dashboard.dart';

class CryptoScreen extends StatelessWidget {
  const CryptoScreen({super.key});

  // Hàm định dạng tiền VND
  String formatCurrency(int value) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<DashboardData?>(
          future: DashboardService().fetchDashboardData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Failed to load data'));
            } else if (snapshot.hasData) {
              final data = snapshot.data!;
              return GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildDashboardCard(
                    title: 'Total sales',
                    value: formatCurrency(
                        data.totalSalesAmount), // Định dạng tiền VND
                    icon: Icons.money,
                  ),
                  _buildDashboardCard(
                    title: 'Clubs',
                    value: data.clubCount.toString(),
                    icon: Icons.sports_soccer,
                  ),
                  _buildDashboardCard(
                    title: 'Sessions',
                    value: data.sessionCount.toString(),
                    icon: Icons.schedule,
                  ),
                  _buildDashboardCard(
                    title: 'Players',
                    value: data.playerCount.toString(),
                    icon: Icons.person,
                  ),
                  _buildDashboardCard(
                    title: 'Shirts',
                    value: data.shirtCount.toString(),
                    icon: Icons.checkroom,
                  ),
                  _buildDashboardCard(
                    title: 'Types of Shirts',
                    value: data.typeShirtCount.toString(),
                    icon: Icons.category,
                  ),
                  _buildDashboardCard(
                    title: 'Orders',
                    value: data.orderCount.toString(),
                    icon: Icons.shopping_cart,
                  ),
                ],
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
