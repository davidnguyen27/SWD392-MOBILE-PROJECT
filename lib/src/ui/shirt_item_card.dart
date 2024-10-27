import 'package:flutter/material.dart';

class ShirtItemCard extends StatelessWidget {
  final String name;
  final String id;
  final String date;
  final String imageUrl;
  final String price;
  final String playerName;

  const ShirtItemCard({
    super.key,
    required this.name,
    required this.id,
    required this.date,
    required this.imageUrl,
    required this.price,
    required this.playerName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text('ID: $id'),
            Text('Date: $date'),
            Text('Price: \$$price'),
            Text('Player: $playerName'),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // Thực hiện hành động khi nhấn vào nút Manage
              },
              child: const Text(
                'Manage',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
