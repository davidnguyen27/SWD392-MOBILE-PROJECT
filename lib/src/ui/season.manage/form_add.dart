import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:t_shirt_football_project/src/services/season_service.dart'; // Để định dạng ngày

class AddSeasonForm extends StatefulWidget {
  const AddSeasonForm({super.key});

  @override
  _AddSeasonFormState createState() => _AddSeasonFormState();
}

class _AddSeasonFormState extends State<AddSeasonForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  // Hàm để chọn ngày
  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
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

  // Hàm xử lý khi nhấn nút "Add Season"
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_startDate == null || _endDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please select both start and end dates')),
        );
        return;
      }

      try {
        // Gọi API để tạo season mới
        await SeasonService.createSeason(
          name: _nameController.text,
          startDate: _startDate!,
          endDate: _endDate!,
          description: _descriptionController.text,
        );

        // Trở về màn hình trước và trả về kết quả là true
        Navigator.pop(context, true);
      } catch (e) {
        // Hiển thị lỗi nếu không thành công
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add season: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Field nhập tên season
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Season Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.event_note),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter season name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // Field nhập mô tả
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.description),
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter description';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // Chọn ngày bắt đầu
            ListTile(
              title: Text(
                _startDate == null
                    ? 'Select Start Date'
                    : 'Start Date: ${DateFormat('dd/MM/yyyy').format(_startDate!)}',
                style: const TextStyle(fontSize: 16),
              ),
              trailing: const Icon(Icons.calendar_today, color: Colors.blue),
              onTap: () => _pickDate(context, true),
            ),
            const Divider(),

            // Chọn ngày kết thúc
            ListTile(
              title: Text(
                _endDate == null
                    ? 'Select End Date'
                    : 'End Date: ${DateFormat('dd/MM/yyyy').format(_endDate!)}',
                style: const TextStyle(fontSize: 16),
              ),
              trailing: const Icon(Icons.calendar_today, color: Colors.blue),
              onTap: () => _pickDate(context, false),
            ),
            const Divider(),

            const SizedBox(height: 20),

            // Nút Submit
            Center(
              child: ElevatedButton(
                onPressed: _submitForm, // Gọi hàm xử lý khi nhấn nút
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Add Season',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
