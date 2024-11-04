import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:t_shirt_football_project/src/models/player.dart';
import 'package:t_shirt_football_project/src/views/screens/player.manage/detail_screen.dart';

class PlayerCardItem extends StatelessWidget {
  final String playerName;
  final String clubName;
  final String nationality;
  final DateTime birthday;
  final double height;
  final int weight;
  final bool isActive;
  final Player player;

  const PlayerCardItem({
    super.key,
    required this.playerName,
    required this.clubName,
    required this.nationality,
    required this.birthday,
    required this.height,
    required this.weight,
    required this.isActive,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedBirthday = DateFormat('dd/MM/yyyy').format(birthday);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayerDetailsScreen(
              playerId: player.id,
            ),
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
                        playerName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Club: $clubName',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Nationality: $nationality',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Birthday: $formattedBirthday',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Height: ${height}m, Weight: ${weight}kg',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    isActive ? Icons.check_circle : Icons.cancel,
                    color: isActive ? Colors.green : Colors.red,
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
