import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_shirt_football_project/src/providers/auth_provider.dart';
import '../views/screens/personal_details_screen.dart';
import '../views/components/profile_header.dart';
import '../views/components/reusable_list_tile.dart';

Widget buildProfileScreen(BuildContext context) {
  return Consumer<AuthProvider>(
    builder: (context, authProvider, child) {
      final user = authProvider.user;

      if (user == null) {
        return const Center(
            child:
                CircularProgressIndicator()); // Hiển thị vòng quay tải khi dữ liệu chưa sẵn sàng
      }

      return SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(user: user), // Sử dụng component ProfileHeader
            const SizedBox(height: 20),
            ReusableListTile(
              icon: Icons.person,
              title: 'Personal details',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PersonalDetailsScreen()),
                );
              },
            ),
            ReusableListTile(
              icon: Icons.logout,
              title: 'Log out',
              onTap: () async {
                await Provider.of<AuthProvider>(context, listen: false)
                    .logout();
                Navigator.pushReplacementNamed(context, '/landing');
              },
            ),
          ],
        ),
      );
    },
  );
}
