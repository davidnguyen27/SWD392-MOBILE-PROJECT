import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:t_shirt_football_project/src/models/season.dart';
import 'package:t_shirt_football_project/src/services/season_service.dart';

class SeasonDetailsScreen extends StatefulWidget {
  final int seasonId;

  const SeasonDetailsScreen({super.key, required this.seasonId});

  @override
  SeasonDetailsScreenState createState() => SeasonDetailsScreenState();
}

class SeasonDetailsScreenState extends State<SeasonDetailsScreen> {
  late Future<Season> _seasonDetail;
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _seasonDetail = SeasonService.getSeason(widget.seasonId);

    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? (_startDate ?? DateTime.now())
          : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  Future<void> _updateSeason() async {
    try {
      if (_nameController.text.isEmpty || _descriptionController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fields cannot be empty')),
        );
        return;
      }

      Season updatedSeason = Season(
        id: widget.seasonId,
        name: _nameController.text,
        startDate: _startDate ?? DateTime.now(),
        endDate: _endDate ?? DateTime.now(),
        description: _descriptionController.text,
        status: true,
      );

      // Gọi API để cập nhật season
      bool success = await SeasonService.updateSeason(updatedSeason);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Season updated successfully')),
        );
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update season: $e')),
      );
    }
  }

  Future<void> _confirmDelete() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this season?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _handleDelete(); // Gọi hàm xóa season
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleDelete() async {
    try {
      bool isDeleted = await SeasonService.deleteSeason(widget.seasonId);

      if (isDeleted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Season deleted successfully')),
        );
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Season Details'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<Season>(
        future: _seasonDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final season = snapshot.data!;

            // Set giá trị vào các controller từ season nếu chưa có giá trị
            if (_nameController.text.isEmpty) {
              _nameController.text = season.name;
            }
            if (_descriptionController.text.isEmpty) {
              _descriptionController.text = season.description;
            }
            _startDate ??= season.startDate;
            _endDate ??= season.endDate;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Season Name Field
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Season Name',
                        labelStyle: const TextStyle(
                            color: Colors.blueAccent, fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.event_note,
                            color: Colors.blueAccent),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Description Field
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: const TextStyle(
                            color: Colors.blueAccent, fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.description,
                            color: Colors.blueAccent),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),

                    // Start Date
                    ListTile(
                      title: Text(
                        'Start Date: ${DateFormat('dd/MM/yyyy').format(_startDate!)}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      trailing:
                          const Icon(Icons.calendar_today, color: Colors.blue),
                      onTap: () => _pickDate(context, true),
                    ),
                    const Divider(),

                    // End Date
                    ListTile(
                      title: Text(
                        'End Date: ${DateFormat('dd/MM/yyyy').format(_endDate!)}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      trailing:
                          const Icon(Icons.calendar_today, color: Colors.blue),
                      onTap: () => _pickDate(context, false),
                    ),
                    const Divider(),

                    // Update and Delete buttons with new styling
                    const SizedBox(height: 30), // Spacing above buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _updateSeason,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            backgroundColor:
                                Colors.green, // Màu xanh lá cho nút Update
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Update',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _confirmDelete,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            backgroundColor:
                                Colors.red, // Màu đỏ cho nút Delete
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Delete',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('Season not found'));
          }
        },
      ),
    );
  }
}
