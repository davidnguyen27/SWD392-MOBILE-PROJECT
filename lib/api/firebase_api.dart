import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:t_shirt_football_project/src/models/order.dart';
import 'package:t_shirt_football_project/src/services/order_service.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Timer? _pollingTimer;
  final Set<String> _notifiedOrderIds = {}; // Lưu trữ các orderId đã thông báo

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
  }

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    // Yêu cầu quyền từ người dùng
    NotificationSettings settings =
        await _firebaseMessaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }

    // Lấy token FCM
    final fCMToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fCMToken');

    // Đăng ký xử lý thông báo nền
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    // Đăng ký xử lý thông báo foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message while app is in the foreground');
      if (message.notification != null) {
        print('Notification Title: ${message.notification!.title}');
        print('Notification Body: ${message.notification!.body}');
      }
    });

    // Bắt đầu polling để kiểm tra đơn hàng mới
    startPolling(flutterLocalNotificationsPlugin);
  }

  // Hàm polling API để kiểm tra đơn hàng có status = 2
  void startPolling(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    _pollingTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      await checkOrdersWithStatus2(flutterLocalNotificationsPlugin);
    });
  }

  // Hàm kiểm tra đơn hàng mới và gửi thông báo nếu có
  Future<void> checkOrdersWithStatus2(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    // Sử dụng OrderService để lấy danh sách đơn hàng
    final List<Order> orders = await OrderService().fetchOrders(1, 50, '', 2);

    if (orders.isNotEmpty) {
      for (var order in orders) {
        final String orderId = order.id;
        final String userName = order.userName;
        final int status = order.status;

        // Kiểm tra nếu order chưa được thông báo và status = 2
        if (status == 2 && !_notifiedOrderIds.contains(orderId)) {
          // Gửi thông báo và thêm orderId vào danh sách đã thông báo
          await _showLocalNotification(
              flutterLocalNotificationsPlugin, userName, orderId);
          _notifiedOrderIds.add(orderId);
        }
      }
    }
  }

  // Hàm hiển thị thông báo cục bộ khi có đơn hàng mới
  Future<void> _showLocalNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      String userName,
      String orderId) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'order_channel',
      'Order Notifications',
      channelDescription: 'Notification channel for new orders',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      icon: 'ic_notification', // Tên của icon trong `res/drawable`
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'New Order from $userName!',
      'You have a new order with ID: $orderId',
      platformChannelSpecifics,
    );
  }
}
