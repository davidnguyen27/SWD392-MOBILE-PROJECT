import 'package:flutter/material.dart';
import 'package:t_shirt_football_project/src/views/screens/main_screen.dart';
import 'package:t_shirt_football_project/src/views/screens/payment_screen.dart';
import 'package:t_shirt_football_project/src/views/screens/profile_screen.dart';
import 'package:t_shirt_football_project/src/views/screens/landing_screen.dart';
import 'package:t_shirt_football_project/src/views/screens/home_screen.dart';
import 'package:t_shirt_football_project/src/views/screens/season.manage/add_screen.dart';
import 'package:t_shirt_football_project/src/views/screens/season.manage/season_manage_screen.dart';
import 'package:t_shirt_football_project/src/views/screens/shirt.manage/add_screen.dart';
import 'package:t_shirt_football_project/src/views/screens/shirt.manage/shirt_manage_screen.dart';
import '../views/screens/test_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/landing': (context) => const LandingScreen(),
    '/main': (context) => const MainScreen(),
    '/home': (context) => const HomeScreen(),
    '/profile': (context) => const ProfileScreen(),
    '/payment': (context) => const PaymentScreen(),
    '/crypto': (context) => const CryptoScreen(),
    '/shirt-manage': (context) => const ShirtManageScreen(),
    '/season-manage': (context) => const SeasonManageScreen(),
    '/season-add': (context) => const AddSeasonScreen(),
    '/shirt-add': (context) => const AddScreen(),
    '/test': (context) => const CryptoScreen(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final routeName = settings.name;
    final routeBuilder = routes[routeName];

    if (routeBuilder != null) {
      return MaterialPageRoute(builder: routeBuilder, settings: settings);
    }

    // If route not found, return default to landing page
    return MaterialPageRoute(
      builder: (context) => const LandingScreen(),
    );
  }
}
