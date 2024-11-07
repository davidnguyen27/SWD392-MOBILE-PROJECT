import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_shirt_football_project/src/models/dashboard.dart';
import 'package:t_shirt_football_project/src/providers/auth_provider.dart';

Widget buildHomeScreen(BuildContext context, DashboardData dashboardData) {
  final authProvider = Provider.of<AuthProvider>(context, listen: true);

  return Scaffold(
    backgroundColor: const Color(0xFFe3edf7),
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipOval(
            child: authProvider.user?.imgUrl != null
                ? Image.network(
                    authProvider.user!.imgUrl,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        './lib/assets/images/profile_img.webp',
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      );
                    },
                  )
                : Image.asset(
                    './lib/assets/images/profile_img.webp',
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
          ),
          const Text(
            "Home",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Hành động khi nhấn vào biểu tượng tìm kiếm
            },
          ),
        ],
      ),
    ),
    body: SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFe1f5fe), Color(0xFFbbdefb)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Phần sự kiện
                const Text(
                  "Manage Shop",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 15),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    buildEventCard(
                      context: context,
                      colorGradient: [
                        const Color(0xFFF48FB1),
                        const Color(0xFFAD1457)
                      ],
                      icon: Icons.checkroom,
                      label: "Shirt Manage",
                      onTap: () {
                        Navigator.pushNamed(context, '/shirt-manage');
                      },
                    ),
                    buildEventCard(
                      context: context,
                      colorGradient: [
                        const Color(0xFF42a5f5),
                        const Color(0xFF1e88e5)
                      ],
                      icon: Icons.category,
                      label: "Player Manage",
                      onTap: () {
                        Navigator.pushNamed(context, '/player-manage');
                      },
                    ),
                    buildEventCard(
                      context: context,
                      colorGradient: [
                        const Color(0xFFba68c8),
                        const Color(0xFF8e24aa)
                      ],
                      icon: Icons.calendar_today,
                      label: "Season Manage",
                      onTap: () {
                        Navigator.pushNamed(context, '/season-manage');
                      },
                    ),
                    buildEventCard(
                      context: context,
                      colorGradient: [
                        const Color(0xFF66bb6a),
                        const Color(0xFF388e3c)
                      ],
                      icon: Icons.stadium,
                      label: "Club Manage",
                      onTap: () {
                        Navigator.pushNamed(context, '/club-manage');
                      },
                    ),
                    buildEventCard(
                      context: context,
                      colorGradient: [
                        const Color(0xFFffb74d),
                        const Color(0xFFf57c00)
                      ],
                      icon: Icons.run_circle_rounded,
                      label: "Size Manage",
                      onTap: () {
                        Navigator.pushNamed(context, '/size-manage');
                      },
                    ),
                    buildEventCard(
                      context: context,
                      colorGradient: [
                        const Color(0xFF90caf9),
                        const Color(0xFF42a5f5)
                      ],
                      icon: Icons.check_outlined,
                      label: "Order Manage",
                      onTap: () {
                        Navigator.pushNamed(context, '/order-manage');
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildEventCard({
  required BuildContext context,
  required List<Color> colorGradient,
  required IconData icon,
  required String label,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(15),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colorGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: colorGradient.last.withOpacity(0.4),
            blurRadius: 10,
            spreadRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 36),
            const SizedBox(height: 15),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
