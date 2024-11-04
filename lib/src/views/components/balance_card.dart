import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;
  final List<BoxShadow> boxShadow;

  const BalanceCard({
    required this.title,
    required this.amount,
    required this.color,
    required this.boxShadow,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: boxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.7)),
          ),
          const SizedBox(height: 8),
          Text(
            amount,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
