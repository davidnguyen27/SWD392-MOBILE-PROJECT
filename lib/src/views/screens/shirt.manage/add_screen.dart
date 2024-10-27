import 'package:flutter/material.dart';
import '../../../ui/shirt.manage/form_add.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
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
          child: AddForm(), // Gọi lại AddForm
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}
