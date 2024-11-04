import 'package:flutter/material.dart';
import 'package:t_shirt_football_project/src/models/size.dart';
import 'package:t_shirt_football_project/src/services/size_service.dart';

class SizeDetailScreen extends StatefulWidget {
  final int sizeId;

  const SizeDetailScreen({super.key, required this.sizeId});

  @override
  SizeDetailScreenState createState() => SizeDetailScreenState();
}

class SizeDetailScreenState extends State<SizeDetailScreen> {
  late Future<Size> _futureSizeDetail;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _futureSizeDetail = SizeService.getSizeDetail(widget.sizeId);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _setTextControllers(Size size) {
    _nameController.text = size.name;
    _descriptionController.text = size.description;
  }

  Future<void> _onUpdate() async {
    final confirmUpdate = await _showUpdateConfirmationDialog();
    if (confirmUpdate) {
      try {
        await SizeService.updateSize(
          widget.sizeId,
          _nameController.text,
          _descriptionController.text,
          true, // Truyền mặc định status là true
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Size updated successfully')),
        );
        Navigator.pushReplacementNamed(context, '/home');
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update size: $error')),
        );
      }
    }
  }

  Future<void> _onDelete() async {
    final confirmDelete = await _showDeleteConfirmationDialog();
    if (confirmDelete) {
      try {
        await SizeService.deleteSize(widget.sizeId);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Size deleted successfully')),
        );
        Navigator.pushReplacementNamed(context, '/home');
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete size: $error')),
        );
      }
    }
  }

  Future<bool> _showUpdateConfirmationDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Confirm Update'),
              content: const Text('Are you sure you want to update this size?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Update',
                      style: TextStyle(color: Colors.blue)),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<bool> _showDeleteConfirmationDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Confirm Deletion'),
              content: const Text(
                  'Are you sure you want to delete this size? This action cannot be undone.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child:
                      const Text('Delete', style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Size Profile'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<Size>(
        future: _futureSizeDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final size = snapshot.data!;
            _setTextControllers(size);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildEditableField(
                    label: 'Size Name',
                    controller: _nameController,
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
                          mainAxisSize: MainAxisSize.min,
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
                        onPressed: _onUpdate,
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
                          mainAxisSize: MainAxisSize.min,
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
