import 'package:firebase_core/firebase_core.dart';
import 'api/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/providers/auth_provider.dart';
import 'src/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MaterialApp(
        title: 'Football T-shirt Management',
        debugShowCheckedModeBanner: false, // Tắt banner debug
        initialRoute: '/landing', // Route mặc định
        onGenerateRoute:
            AppRoutes.generateRoute, // Sử dụng AppRoutes để điều hướng
      ),
    );
  }
}
