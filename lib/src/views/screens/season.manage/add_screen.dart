import 'package:flutter/material.dart';
import 'package:t_shirt_football_project/src/ui/season.manage/form_add.dart';

class AddSeasonScreen extends StatefulWidget {
  const AddSeasonScreen({super.key});

  @override
  _AddSeasonScreenState createState() => _AddSeasonScreenState();
}

class _AddSeasonScreenState extends State<AddSeasonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Season'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: AddSeasonForm(),
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}
