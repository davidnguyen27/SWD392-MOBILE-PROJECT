import 'package:flutter/material.dart';
import 'package:t_shirt_football_project/src/views/components/balance_card.dart';
import 'package:t_shirt_football_project/src/views/components/invoice_history_chart.dart';
import 'package:t_shirt_football_project/src/views/components/sms_history_chart.dart';

Widget buildHomeScreen(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFe3edf7),
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipOval(
            child: Image.asset(
              './lib/assets/images/profile_img.webp',
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          const Text(
            "Dashboard",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
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
                // Phần số dư với thẻ
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BalanceCard(
                      title: "Balance",
                      amount: "\$150",
                      color: Colors.orangeAccent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orangeAccent.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 5,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    BalanceCard(
                      title: "SMS Balance",
                      amount: "125 SMS",
                      color: Colors.greenAccent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 5,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Biểu đồ lịch sử hóa đơn
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: const InvoiceHistoryChart(),
                ),
                const SizedBox(height: 20),
                // Biểu đồ lịch sử SMS
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: const SmsHistoryChart(),
                ),
                const SizedBox(height: 20),
                // Phần sự kiện
                const Text(
                  "Manage Shop",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 10),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Chuyển sang màn hình quản lý áo
                        Navigator.pushNamed(context, '/shirt-manage');
                      },
                      child: buildEventCard(
                        color: const Color(0xFFF48FB1),
                        icon: Icons.checkroom,
                        label: "Shirt Manage",
                      ),
                    ),
                    buildEventCard(
                      color: const Color(0xFF42a5f5),
                      icon: Icons.category,
                      label: "Type Shirt Manage",
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/season-manage');
                      },
                      child: buildEventCard(
                        color: const Color(0xFFba68c8),
                        icon: Icons.calendar_today,
                        label: "Season Manage",
                      ),
                    ),
                    buildEventCard(
                      color: const Color(0xFF66bb6a),
                      icon: Icons.shopping_cart,
                      label: "Order Manage",
                    ),
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
  required Color color,
  required IconData icon,
  required String label,
}) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(15),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
