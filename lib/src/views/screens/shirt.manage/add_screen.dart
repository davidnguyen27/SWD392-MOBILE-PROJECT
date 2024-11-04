import 'package:flutter/material.dart';
import 'package:t_shirt_football_project/src/ui/shirt.manage/form_add.dart';

class AddShirtScreen extends StatefulWidget {
  const AddShirtScreen({super.key});

  @override
  _AddShirtScreenState createState() => _AddShirtScreenState();
}

class _AddShirtScreenState extends State<AddShirtScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Shirt'),
        backgroundColor: Colors.blue,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: AddShirtForm(), // Gọi lại AddForm
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}
