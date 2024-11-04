import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:t_shirt_football_project/src/models/player.dart';
import 'package:t_shirt_football_project/src/services/player_service.dart';

class PlayerDetailsScreen extends StatefulWidget {
  final int playerId;

  const PlayerDetailsScreen({super.key, required this.playerId});

  @override
  PlayerDetailsScreenState createState() => PlayerDetailsScreenState();
}

class PlayerDetailsScreenState extends State<PlayerDetailsScreen> {
  late Future<Player> _playerDetail;

  @override
  void initState() {
    super.initState();
    _playerDetail = PlayerService.getPlayer(widget.playerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Details'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<Player>(
        future: _playerDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final player = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Full Name Field
                  ListTile(
                    leading: const Icon(Icons.person, color: Colors.blueAccent),
                    title: Text(
                      'Full Name: ${player.fullName}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(),

                  // Club Name Field
                  ListTile(
                    leading: const Icon(Icons.sports_soccer,
                        color: Colors.blueAccent),
                    title: Text(
                      'Club Name: ${player.clubName}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(),

                  // Birthday Field
                  ListTile(
                    leading: const Icon(Icons.cake, color: Colors.blueAccent),
                    title: Text(
                      'Birthday: ${DateFormat('dd/MM/yyyy').format(player.birthday)}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(),

                  // Nationality Field
                  ListTile(
                    leading: const Icon(Icons.flag, color: Colors.blueAccent),
                    title: Text(
                      'Nationality: ${player.nationality}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(),

                  // Height Field
                  ListTile(
                    leading: const Icon(Icons.height, color: Colors.blueAccent),
                    title: Text(
                      'Height: ${player.height} cm',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(),

                  // Weight Field
                  ListTile(
                    leading: const Icon(Icons.fitness_center,
                        color: Colors.blueAccent),
                    title: Text(
                      'Weight: ${player.weight} kg',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Player not found'));
          }
        },
      ),
    );
  }
}
