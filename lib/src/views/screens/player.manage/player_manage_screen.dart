import 'package:flutter/material.dart';
import 'package:t_shirt_football_project/src/models/player.dart';
import 'package:t_shirt_football_project/src/services/player_service.dart';
import 'package:t_shirt_football_project/src/ui/player.manage/player_card.dart';
import 'package:t_shirt_football_project/src/views/screens/player.manage/detail_screen.dart';

class PlayerManageScreen extends StatefulWidget {
  const PlayerManageScreen({super.key});

  @override
  _PlayerManageScreenState createState() => _PlayerManageScreenState();
}

class _PlayerManageScreenState extends State<PlayerManageScreen> {
  late Future<List<Player>> _players;

  @override
  void initState() {
    super.initState();
    _players = PlayerService.fetchPlayers();
    _loadPlayers();
  }

  Future<void> _loadPlayers() async {
    setState(() {
      _players = PlayerService.fetchPlayers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Management'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<Player>>(
        future: _players,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final players = snapshot.data!;
            return ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                final player = players[index];
                return GestureDetector(
                  onTap: () async {
                    // Điều hướng với player.id
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerDetailsScreen(
                          playerId: player.id, // Truyền id của player
                        ),
                      ),
                    );

                    if (result == true) {
                      _loadPlayers();
                    }
                  },
                  child: PlayerCardItem(
                    playerName: player.fullName,
                    clubName: player.clubName,
                    nationality: player.nationality,
                    birthday: player.birthday,
                    height: player.height,
                    weight: player.weight,
                    isActive: player.status,
                    player: player,
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No players available'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/season-add');
          if (result == true) {
            _loadPlayers();
          }
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
