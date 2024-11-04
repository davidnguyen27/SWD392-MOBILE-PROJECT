import 'package:firebase_core/firebase_core.dart';
import 'package:t_shirt_football_project/src/services/storage_service.dart';
import 'api/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/providers/auth_provider.dart';
import 'src/routes/routes.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider<StorageService>(create: (_) => StorageService()),
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
