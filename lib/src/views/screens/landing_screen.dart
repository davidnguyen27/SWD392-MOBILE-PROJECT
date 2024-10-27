import 'package:flutter/material.dart';
import '../components/custom_button.dart';
import 'login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF64B5F6),
              Color(0xFFBBDEFB),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            // Làm logo tròn và thêm bóng đổ
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 20,
                    offset: const Offset(0, 5), // Bóng đổ dưới logo
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  './lib/assets/images/logo.webp', // Đảm bảo logo ở đúng thư mục assets
                  height: 150, // Tăng kích thước logo
                  width: 150, // Đảm bảo hình vuông để ClipOval làm tròn
                  fit:
                      BoxFit.cover, // Đảm bảo hình ảnh vừa khít trong vòng tròn
                ),
              ),
            ),
            const SizedBox(height: 50),
            // Cải thiện chữ tiêu đề
            const Text(
              "HELLO",
              style: TextStyle(
                fontSize: 45, // Tăng kích thước chữ tiêu đề
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
                letterSpacing: 2.5,
              ),
            ),
            const SizedBox(height: 20),
            // Chỉnh lại font và thêm bóng đổ cho tiêu đề phụ
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Welcome to\n", // Xuống dòng sau từ "Welcome to"
                  ),
                  TextSpan(
                    text: "Football T-shirt Management App",
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
                shadows: [
                  Shadow(
                    blurRadius: 5.0,
                    color: Colors.black12,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Cải thiện nút với góc bo tròn và gradient nổi bật hơn
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF512DA8), Color(0xFF1976D2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: CustomButton(
                  text: "Sign In",
                  backgroundColor: Colors.transparent,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
