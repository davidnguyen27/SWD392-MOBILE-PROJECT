import 'package:flutter/material.dart';
import 'package:t_shirt_football_project/src/ui/size.manage/form_add.dart';

class AddSizeScreen extends StatefulWidget {
  const AddSizeScreen({super.key});

  @override
  _AddSizeScreenState createState() => _AddSizeScreenState();
}

class _AddSizeScreenState extends State<AddSizeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Size'),
        backgroundColor: Colors.blue,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: AddSizeForm(), // Gọi lại AddForm
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}
