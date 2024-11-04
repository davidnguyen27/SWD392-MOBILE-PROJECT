import 'package:flutter/material.dart';
import 'package:t_shirt_football_project/src/models/club.dart';
import 'package:t_shirt_football_project/src/views/screens/club.manage/details_screen.dart';

class ClubItemCard extends StatelessWidget {
  final String name;
  final int id;
  final String country;
  final String establishedYear;
  final String clubLogo;
  final String stadiumName;
  final String description;
  final Club club;

  const ClubItemCard({
    super.key,
    required this.name,
    required this.id,
    required this.country,
    required this.establishedYear,
    required this.clubLogo,
    required this.stadiumName,
    required this.description,
    required this.club,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClubDetailScreen(
              clubId: club.id,
            ),
          ),
        );
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0),
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(clubLogo),
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
              Text('Club Name: $name'),
              Text('Date: $establishedYear'),
              Text('Country: $country'),
              Text('Stadium: $description'),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // Thực hiện hành động khi nhấn vào nút Manage
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Manage $name')),
                  );
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
      ),
    );
  }
}
