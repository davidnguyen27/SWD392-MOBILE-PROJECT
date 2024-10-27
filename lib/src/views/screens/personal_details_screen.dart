import 'dart:ui'; // Để sử dụng BackdropFilter
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:t_shirt_football_project/src/models/user.dart';
import 'package:t_shirt_football_project/src/providers/auth_provider.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  _PersonalDetailsScreenState createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _dobController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  String _selectedGender = 'Male';
  bool _isLoading = true; // Trạng thái tải dữ liệu

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _dobController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();

    _fetchCurrentUser(); // Gọi API để lấy thông tin người dùng
  }

  Future<void> _fetchCurrentUser() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.getCurrentUser();
      setState(() {
        // Gán dữ liệu người dùng vào các controller sau khi dữ liệu được tải thành công
        _nameController.text = authProvider.user?.userName ?? '';
        _emailController.text = authProvider.user?.email ?? '';
        _dobController.text = authProvider.user?.dob != null
            ? DateFormat('dd/MM/yyyy').format(authProvider.user!.dob)
            : '';
        _phoneController.text = authProvider.user?.phoneNumber ?? '';
        _addressController.text = authProvider.user?.address ?? '';
        _selectedGender = authProvider.user?.gender ?? 'Male';

        _isLoading = false; // Đã hoàn tất tải dữ liệu
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal details'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          // Nội dung chính của trang
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Personal',
                    style: TextStyle(color: Colors.grey, fontSize: 16)),
                const SizedBox(height: 10),
                buildTextField(Icons.person, 'Name', _nameController),
                const SizedBox(height: 10),
                buildTextField(Icons.email, 'Email', _emailController),
                const SizedBox(height: 10),
                buildTextField(Icons.calendar_today, 'Date of Birth',
                    _dobController), // Date of birth hiển thị dưới dạng chuỗi
                const SizedBox(height: 10),
                buildTextField(Icons.phone, 'Phone Number', _phoneController),
                const SizedBox(height: 20),
                const Text('Address',
                    style: TextStyle(color: Colors.grey, fontSize: 16)),
                const SizedBox(height: 10),
                buildDropdown(Icons.person, _selectedGender, 'Gender',
                    ['Male', 'Female', 'Other']),
                const SizedBox(height: 10),
                buildTextField(Icons.home, 'Address', _addressController,
                    isAddress: true),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    try {
                      final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
                      final dobDateTime =
                          dateFormat.parseStrict(_dobController.text);

                      authProvider.updateUserDetails(
                        authProvider.user!.id.toString(),
                        User(
                            id: authProvider.user!.id,
                            email: _emailController.text,
                            token: authProvider.user!.token,
                            password: '',
                            userName: _nameController.text,
                            dob: dobDateTime,
                            address: _addressController.text,
                            phoneNumber: _phoneController.text,
                            gender: _selectedGender,
                            imgUrl: authProvider.user!.imgUrl,
                            roleName: authProvider.user!.roleName),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Profile updated successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } catch (e) {
                      print("Invalid date format: $e");
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Invalid Date Format'),
                            content: const Text(
                                'Please enter the date in dd/MM/yyyy format.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text('SAVE'),
                ),
              ],
            ),
          ),

          // Hiệu ứng loading mờ khi dữ liệu đang tải
          if (_isLoading)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.1), // Nền mờ với màu xám nhạt
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildTextField(
      IconData icon, String placeholder, TextEditingController controller,
      {bool isAddress = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: placeholder,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  Widget buildDropdown(
      IconData icon, String value, String label, List<String> options) {
    return InputDecorator(
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          items: options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedGender = newValue!;
            });
          },
        ),
      ),
    );
  }
}
