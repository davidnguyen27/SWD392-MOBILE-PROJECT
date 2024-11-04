import 'package:t_shirt_football_project/src/models/order_detail.dart';

class Order {
  final String id;
  final int userId;
  final String userName;
  final int totalPrice;
  final int shipPrice;
  final dynamic deposit;
  final String date;
  final bool refundStatus;
  final int status;
  final int newStatus;
  final List<OrderDetail> orderDetails;

  Order({
    required this.id,
    required this.userId,
    required this.userName,
    required this.totalPrice,
    required this.shipPrice,
    this.deposit,
    required this.date,
    required this.refundStatus,
    required this.status,
    required this.newStatus,
    required this.orderDetails,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['userId'],
      userName: json['userName'],
      totalPrice: json['totalPrice'],
      shipPrice: json['shipPrice'],
      deposit: json['deposit'],
      date: json['date'],
      refundStatus: json['refundStatus'],
      status: json['status'],
      newStatus: json['newStatus'],
      orderDetails: (json['orderDetails'] as List)
          .map((item) => OrderDetail.fromJson(item))
          .toList(),
    );
  }
}
