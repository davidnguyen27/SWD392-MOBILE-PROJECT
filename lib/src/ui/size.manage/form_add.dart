import 'package:flutter/material.dart';
import 'package:t_shirt_football_project/src/services/size_service.dart';

class AddSizeForm extends StatefulWidget {
  const AddSizeForm({super.key});

  @override
  _AddSizeFormState createState() => _AddSizeFormState();
}

class _AddSizeFormState extends State<AddSizeForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final bool _status = true;

  Future<void> _onAddSize() async {
    if (_formKey.currentState!.validate()) {
      try {
        await SizeService.createSize(
          _nameController.text,
          _descriptionController.text,
          _status,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Size added successfully')),
        );
        Navigator.pushReplacementNamed(context, '/home');
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add size: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Size Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the size name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _onAddSize,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Add Size',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
