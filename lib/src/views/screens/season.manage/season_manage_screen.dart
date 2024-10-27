import 'package:flutter/material.dart';
import 'package:t_shirt_football_project/src/models/season.dart';
import 'package:t_shirt_football_project/src/services/season_service.dart';
import 'package:t_shirt_football_project/src/ui/season.manage/season_card_item.dart';
import 'package:t_shirt_football_project/src/views/screens/season.manage/details_screen.dart';

class SeasonManageScreen extends StatefulWidget {
  const SeasonManageScreen({super.key});

  @override
  _SeasonManageScreenState createState() => _SeasonManageScreenState();
}

class _SeasonManageScreenState extends State<SeasonManageScreen> {
  late Future<List<Season>> _seasons;

  @override
  void initState() {
    super.initState();
    _seasons = SeasonService.getAllSeasons();
    _loadSeasons();
  }

  Future<void> _loadSeasons() async {
    setState(() {
      _seasons = SeasonService.getAllSeasons();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seasons Management'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<Season>>(
        future: _seasons,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final seasons = snapshot.data!;
            return ListView.builder(
              itemCount: seasons.length,
              itemBuilder: (context, index) {
                final season = seasons[index];
                return GestureDetector(
                  onTap: () async {
                    // Điều hướng với season.id
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeasonDetailsScreen(
                          seasonId: season.id, // Truyền id của season
                        ),
                      ),
                    );

                    if (result == true) {
                      _loadSeasons();
                    }
                  },
                  child: SeasonCardItem(
                    seasonName: season.name,
                    startDate: season.startDate,
                    endDate: season.endDate,
                    description: season.description,
                    isActive: season.status,
                    season: season,
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No seasons available'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/season-add');
          if (result == true) {
            _loadSeasons();
          }
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
