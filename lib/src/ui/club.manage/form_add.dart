import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:t_shirt_football_project/src/services/club_service.dart';
import 'package:t_shirt_football_project/src/services/storage_service.dart';

class AddClubForm extends StatefulWidget {
  const AddClubForm({super.key});

  @override
  _AddClubFormState createState() => _AddClubFormState();
}

class _AddClubFormState extends State<AddClubForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _establishedYearController =
      TextEditingController();
  final TextEditingController _stadiumController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  String? _uploadedImageUrl;
  final bool _status = true;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_selectedImage == null) return;

    final storageService = Provider.of<StorageService>(context, listen: false);
    final fileName = '${_nameController.text}_logo';
    final downloadUrl =
        await storageService.uploadImage(_selectedImage!, fileName);

    if (downloadUrl != null) {
      setState(() {
        _uploadedImageUrl = downloadUrl;
      });
    }
  }

  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _establishedYearController.text =
            "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _onSave() async {
    await _uploadImage();
    try {
      await ClubService.createClub(
        name: _nameController.text,
        country: _countryController.text,
        establishedYear: DateTime.parse(_establishedYearController.text),
        stadiumName: _stadiumController.text,
        description: _descriptionController.text,
        clubLogo: _uploadedImageUrl ?? '',
        status: _status,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Club added successfully')),
      );
      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add club: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUploading = Provider.of<StorageService>(context).isUploading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 50,
              backgroundImage:
                  _selectedImage != null ? FileImage(_selectedImage!) : null,
              child: _selectedImage == null && !isUploading
                  ? const Icon(Icons.camera_alt, size: 40)
                  : isUploading
                      ? CircularProgressIndicator()
                      : null,
            ),
          ),
        ),
        const SizedBox(height: 20),
        _buildEditableField(label: 'Club Name', controller: _nameController),
        const SizedBox(height: 10),
        _buildEditableField(label: 'Country', controller: _countryController),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: _pickDate,
          child: AbsorbPointer(
            child: _buildEditableField(
              label: 'Established Date',
              controller: _establishedYearController,
            ),
          ),
        ),
        const SizedBox(height: 10),
        _buildEditableField(label: 'Stadium', controller: _stadiumController),
        const SizedBox(height: 10),
        _buildEditableField(
          label: 'Description',
          controller: _descriptionController,
          maxLines: 3,
        ),
        const SizedBox(height: 30),
        Center(
          child: ElevatedButton(
            onPressed: _onSave,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: Colors.green,
            ),
            child: const Text(
              'Save',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          ),
        ),
      ],
    );
  }
}
