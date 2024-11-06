import 'package:flutter/material.dart';
import 'package:t_shirt_football_project/src/views/screens/club.manage/add_screen.dart';
import 'package:t_shirt_football_project/src/views/screens/club.manage/club_manage_screen.dart';
import 'package:t_shirt_football_project/src/views/screens/main_screen.dart';
import 'package:t_shirt_football_project/src/views/screens/order.manage/order_manage_screen.dart';
import 'package:t_shirt_football_project/src/views/screens/payment_screen.dart';
import 'package:t_shirt_football_project/src/views/screens/player.manage/player_manage_screen.dart';
import 'package:t_shirt_football_project/src/views/screens/profile_screen.dart';
import 'package:t_shirt_football_project/src/views/screens/landing_screen.dart';
import 'package:t_shirt_football_project/src/views/screens/home_screen.dart';
import 'package:t_shirt_football_project/src/views/screens/season.manage/add_screen.dart';
import 'package:t_shirt_football_project/src/views/screens/season.manage/season_manage_screen.dart';
import 'package:t_shirt_football_project/src/views/screens/shirt.manage/add_screen.dart';
import 'package:t_shirt_football_project/src/views/screens/size.manage/add_screen.dart';
import 'package:t_shirt_football_project/src/views/screens/shirt.manage/shirt_manage_screen.dart';
import 'package:t_shirt_football_project/src/views/screens/size.manage/size_manage_screen.dart';
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
    '/club-manage': (context) => const ClubManageScreen(),
    '/player-manage': (context) => const PlayerManageScreen(),
    '/size-manage': (context) => const SizeManageScreen(),
    '/order-manage': (context) => OrderManageScreen(),
    '/season-add': (context) => const AddSeasonScreen(),
    '/club-add': (context) => const AddClubScreen(),
    '/shirt-add': (context) => const AddShirtScreen(),
    '/size-add': (context) => const AddSizeScreen(),
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
