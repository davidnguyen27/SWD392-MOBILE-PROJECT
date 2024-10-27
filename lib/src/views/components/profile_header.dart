import 'package:flutter/material.dart';
import 'package:t_shirt_football_project/src/models/user.dart';

class ProfileHeader extends StatelessWidget {
  final User user;

  const ProfileHeader({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: const BoxDecoration(color: Colors.blue),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(user.imgUrl), // Dùng ảnh từ user
          ),
          const SizedBox(height: 10),
          Text(
            user.userName, // Hiển thị tên từ user
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Text(
            'Personal account',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
