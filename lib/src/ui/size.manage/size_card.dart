import 'package:flutter/material.dart';
import 'package:t_shirt_football_project/src/models/size.dart';
import 'package:t_shirt_football_project/src/views/screens/size.manage/details_screen.dart';

class SizeCardItem extends StatelessWidget {
  final String name;
  final String description;
  final bool status;
  final Size size;

  const SizeCardItem({
    super.key,
    required this.name,
    required this.description,
    required this.status,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SizeDetailScreen(sizeId: size.id),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    status ? Icons.check_circle : Icons.cancel,
                    color: status ? Colors.green : Colors.red,
                    size: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
