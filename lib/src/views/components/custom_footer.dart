import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomFooter({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.black, // Color for selected item
      unselectedItemColor: Colors.grey, // Color for unselected items
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 30), // Adjust size to match the design
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.payment, size: 30),
          label: 'Payment',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.monetization_on, size: 30),
          label: 'Crypto',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, size: 30),
          label: 'Profile',
        ),
      ],
    );
  }
}
