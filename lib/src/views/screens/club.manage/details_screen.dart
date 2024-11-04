import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:t_shirt_football_project/src/models/club.dart';
import 'package:t_shirt_football_project/src/services/club_service.dart';
import 'package:t_shirt_football_project/src/services/storage_service.dart';

class ClubDetailScreen extends StatefulWidget {
  final int clubId;

  const ClubDetailScreen({super.key, required this.clubId});

  @override
  _ClubDetailScreenState createState() => _ClubDetailScreenState();
}

class _ClubDetailScreenState extends State<ClubDetailScreen> {
  late Future<Club> _futureClubDetail;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _establishedYearController =
      TextEditingController();
  final TextEditingController _stadiumController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  File? _selectedImage;
  String? _uploadedImageUrl;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _futureClubDetail = ClubService.fetchClubDetail(widget.clubId).then((club) {
      _setTextControllers(club);
      return club;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _countryController.dispose();
    _establishedYearController.dispose();
    _stadiumController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _setTextControllers(Club club) {
    _nameController.text = club.name;
    _countryController.text = club.country;
    _establishedYearController.text = club.establishedYear.year.toString();
    _stadiumController.text = club.stadiumName;
    _descriptionController.text = club.description;
    _uploadedImageUrl = club.clubLogo;
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage() async {
    if (_selectedImage == null) return _uploadedImageUrl;

    final storageService = Provider.of<StorageService>(context, listen: false);
    final fileName = '${_nameController.text}_clubLogo';
    final downloadUrl =
        await storageService.uploadImage(_selectedImage!, fileName);

    if (downloadUrl != null) {
      setState(() {
        _uploadedImageUrl = downloadUrl;
      });
    }
    return downloadUrl;
  }

  Future<void> _updateClub() async {
    final imageUrl = await _uploadImage();
    // Chuẩn bị dữ liệu cập nhật club
    final clubData = {
      'name': _nameController.text,
      'country': _countryController.text,
      'establishedYear': '${_establishedYearController.text}-01-01',
      'stadiumName': _stadiumController.text,
      'description': _descriptionController.text,
      'clubLogo': imageUrl, // URL ảnh đã tải lên Firebase
    };

    try {
      await ClubService.updateClub(widget.clubId, clubData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Club updated successfully')),
      );
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update club: $e')),
      );
    }
  }

  Future<void> _onDelete() async {
    // Hiển thị hộp thoại xác nhận xóa
    final confirmDelete = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Confirm Deletion'),
              content: const Text(
                  'Are you sure you want to delete this club? This action cannot be undone.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false), // Hủy
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(true), // Xác nhận xóa
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;

    // Xóa club nếu người dùng xác nhận
    if (confirmDelete) {
      try {
        await ClubService.deleteClub(widget.clubId);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Club deleted successfully')),
        );
        Navigator.pushReplacementNamed(context, '/home');
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete club: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Club Profile'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<Club>(
        future: _futureClubDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final club = snapshot.data!;
            _setTextControllers(club);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: _selectedImage != null
                            ? FileImage(_selectedImage!) as ImageProvider
                            : (_uploadedImageUrl != null &&
                                    _uploadedImageUrl!.isNotEmpty
                                ? NetworkImage(_uploadedImageUrl!)
                                : null),
                        child: (_selectedImage == null &&
                                (_uploadedImageUrl == null ||
                                    _uploadedImageUrl!.isEmpty))
                            ? const Icon(Icons.add_a_photo, size: 50)
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildEditableField(
                    label: 'Club Name',
                    controller: _nameController,
                  ),
                  const SizedBox(height: 10),
                  _buildEditableField(
                    label: 'Country',
                    controller: _countryController,
                  ),
                  const SizedBox(height: 10),
                  _buildEditableField(
                    label: 'Established Year',
                    controller: _establishedYearController,
                    isNumber: true,
                  ),
                  const SizedBox(height: 10),
                  _buildEditableField(
                    label: 'Stadium',
                    controller: _stadiumController,
                  ),
                  const SizedBox(height: 10),
                  _buildEditableField(
                    label: 'Description',
                    controller: _descriptionController,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _onDelete,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5,
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.delete, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Delete',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _updateClub, // Gọi hàm cập nhật
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5,
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.update, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Update',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('No details available'));
        },
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    bool isNumber = false,
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
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
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
