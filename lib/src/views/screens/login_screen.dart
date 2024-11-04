import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 100), // Khoảng cách từ trên cùng
              // Container chứa logo và hiệu ứng mờ nền
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          color: Colors.white.withOpacity(0.0),
                        ),
                      ),
                    ),
                  ),
                  // Logo tròn
                  ClipOval(
                    child: Image.asset(
                      './lib/assets/images/logo.webp',
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                'Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 40),

              // Input Email
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.email),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(18.0),
                ),
              ),
              const SizedBox(height: 20),

              // Input Password
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(18.0),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (value) {}),
                      const Text("Remember me"),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // handle forgot password
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.indigo),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Button Login
              ElevatedButton(
                onPressed: () async {
                  // Gọi phương thức login trong authProvider
                  await authProvider.login(
                      emailController.text, passwordController.text);

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    // Navigate if login success
                    if (authProvider.user != null) {
                      Navigator.pushReplacementNamed(context, '/main');
                    } else if (authProvider.errorMessage != null) {
                      // Hiển thị modal thông báo khi đăng nhập thất bại
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Login Failed'),
                            content: Text(authProvider.errorMessage ??
                                'Invalid email or password. Please try again.'),
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
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.black26,
                  elevation: 5,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF512DA8), Color(0xFF1976D2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),

              // Button Login with Google
              ElevatedButton.icon(
                onPressed: () async {
                  // Gọi phương thức loginWithGoogle trong authProvider
                  await authProvider.loginWithGoogle();

                  // Navigate if login success
                  if (authProvider.user != null) {
                    Navigator.pushReplacementNamed(context, '/main');
                  } else if (authProvider.errorMessage != null) {
                    // Hiển thị modal thông báo khi đăng nhập thất bại
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Login Failed'),
                          content: Text(authProvider.errorMessage ??
                              'Google login failed. Please try again.'),
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
                icon: const Icon(Icons.login),
                label: const Text('Login with Google'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Điều khoản và điều kiện
              const Text(
                'By creating or logging into an account you are agreeing with our Terms and Conditions and Privacy Statement',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFE3F2FD), // Màu nền sáng hơn
    );
  }
}
