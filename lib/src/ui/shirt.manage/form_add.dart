import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart'; // Thêm import cho TextInputFormatter
import '../../utils/image_utils.dart';

class AddShirtForm extends StatefulWidget {
  const AddShirtForm({super.key});

  @override
  _AddShirtFormState createState() => _AddShirtFormState();
}

class _AddShirtFormState extends State<AddShirtForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _shirtNumberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  File? _image; // Ảnh đã chọn
  final picker = ImagePicker();
  final ImageUtils imageUtils = ImageUtils(); // Khởi tạo ImagePicker

  String? _selectedPlayerName;
  String? _selectedTypeShirt;
  DateTime? _selectedDate;
  String? _imageUrl;

  final List<String> _playerNames = [
    'Messi',
    'Ronaldo',
    'Mbappe',
    'Neymar',
    'Lewandowski'
  ];
  final List<String> _typeShirts = ['Home', 'Away', 'Third'];

  // Chọn ảnh từ thư viện
  Future<void> _pickImage() async {
    File? pickedImage = await imageUtils.pickImage();
    setState(() {
      if (pickedImage != null) {
        _image = pickedImage;
      }
    });
  }

  // Tải ảnh lên Firebase và cập nhật URL
  Future<void> _uploadImage() async {
    if (_image != null) {
      String? downloadURL = await imageUtils.uploadImageToFirebase(_image!);
      setState(() {
        _imageUrl = downloadURL;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shirt Name Field
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Shirt Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the shirt name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Dropdown for Player Name
          DropdownButtonFormField<String>(
            value: _selectedPlayerName,
            decoration: InputDecoration(
              labelText: 'Player Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Bo tròn các cạnh
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 16), // Làm khít nội dung
            ),
            items: _playerNames.map((String player) {
              return DropdownMenuItem<String>(
                value: player,
                child: Text(
                  player,
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedPlayerName = value;
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Please select a player';
              }
              return null;
            },
            dropdownColor: Colors.white, // Màu nền cho menu xổ xuống
            isExpanded: true, // Mở rộng dropdown theo chiều ngang
            icon: const Icon(Icons.arrow_drop_down,
                color: Colors.blue), // Icon của dropdown
            iconSize: 30,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16, // Kích thước chữ
            ),
          ),
          const SizedBox(height: 20),

          // Dropdown for Shirt Type
          DropdownButtonFormField<String>(
            value: _selectedTypeShirt,
            decoration: InputDecoration(
              labelText: 'Shirt Type',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Bo tròn các cạnh
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 16), // Khít nội dung
            ),
            items: _typeShirts.map((String type) {
              return DropdownMenuItem<String>(
                value: type,
                child: Text(
                  type,
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedTypeShirt = value;
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Please select a shirt type';
              }
              return null;
            },
            dropdownColor: Colors.white, // Màu nền cho menu xổ xuống
            icon: const Icon(Icons.arrow_drop_down,
                color: Colors.blue), // Icon của dropdown
            iconSize: 30,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16, // Kích thước chữ
            ),
          ),
          const SizedBox(height: 20),

          // Text field for Shirt Number
          TextFormField(
            controller: _shirtNumberController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ], // Chỉ cho phép nhập số
            decoration: InputDecoration(
              labelText: 'Shirt Number',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the shirt number';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Date Picker for Date
          ListTile(
            title: Text(
              _selectedDate == null
                  ? 'Select Date' // Hiển thị text nếu chưa chọn ngày
                  : 'Selected Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}', // Hiển thị ngày sau khi chọn
              style: const TextStyle(fontSize: 16),
            ),
            trailing: const Icon(Icons.calendar_today, color: Colors.blue),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(), // Ngày bắt đầu khi mở Date Picker
                firstDate: DateTime(2000), // Giới hạn ngày đầu
                lastDate: DateTime(2101), // Giới hạn ngày cuối
              );

              if (pickedDate != null && pickedDate != _selectedDate) {
                setState(() {
                  _selectedDate =
                      pickedDate; // Cập nhật lại trạng thái và hiển thị ngày đã chọn
                });
              }
            },
          ),
          const SizedBox(height: 20),

          // Text field for Description
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

          // Text field for Price
          TextFormField(
            controller: _priceController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ], // Chỉ cho phép nhập số
            decoration: InputDecoration(
              labelText: 'Price',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the price';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Chọn ảnh
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _image != null
                  ? Image.file(_image!, height: 100, width: 100)
                  : const Text('No image selected'),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Browse'),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Upload ảnh
          Center(
            child: ElevatedButton(
              onPressed: _uploadImage,
              child: const Text('Upload Image'),
            ),
          ),

          // Hiển thị URL ảnh đã upload (nếu có)
          if (_imageUrl != null) ...[
            const SizedBox(height: 20),
            const Text('Image uploaded:'),
            Image.network(_imageUrl!, height: 150),
          ],

          const SizedBox(height: 40),

          // Add Shirt Button
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (_formKey.currentState!.validate()) {
                    // Gửi dữ liệu form và upload ảnh
                    Navigator.pop(context);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'Add Shirt',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
