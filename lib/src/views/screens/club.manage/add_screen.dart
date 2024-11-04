import 'package:flutter/material.dart';
import 'package:t_shirt_football_project/src/ui/club.manage/form_add.dart';

class AddClubScreen extends StatefulWidget {
  const AddClubScreen({super.key});

  @override
  _AddClubScreenState createState() => _AddClubScreenState();
}

class _AddClubScreenState extends State<AddClubScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Club'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: AddClubForm(), // Gọi lại AddForm
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}
