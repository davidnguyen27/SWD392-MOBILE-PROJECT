import 'package:flutter/material.dart';

class ReusableListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final IconData trailingIcon;
  final Function() onTap;

  const ReusableListTile({
    required this.icon,
    required this.title,
    this.trailingIcon = Icons.arrow_forward_ios, // trailing mặc định là mũi tên
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title),
      trailing: Icon(trailingIcon, size: 16),
      onTap: onTap,
    );
  }
}
