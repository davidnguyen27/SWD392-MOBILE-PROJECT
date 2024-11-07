import 'package:intl/intl.dart';

class Payment {
  final int id;
  final int userId;
  final String userUserName;
  final String orderId;
  final DateTime date;
  final int amount;
  final String method;
  final String description;
  final bool status;

  Payment({
    required this.id,
    required this.userId,
    required this.userUserName,
    required this.orderId,
    required this.date,
    required this.amount,
    required this.method,
    required this.description,
    required this.status,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    DateTime parsedDate;
    String dateString = json['date'];

    try {
      if (dateString.length == 14) {
        int year = int.parse(dateString.substring(0, 4));
        int month = int.parse(dateString.substring(4, 6));
        int day = int.parse(dateString.substring(6, 8));
        int hour = int.parse(dateString.substring(8, 10));
        int minute = int.parse(dateString.substring(10, 12));
        int second = int.parse(dateString.substring(12, 14));
        parsedDate = DateTime(year, month, day, hour, minute, second);
      } else if (dateString.contains('/')) {
        parsedDate = DateFormat("dd/MM/yyyy HH:mm:ss").parse(dateString);
      } else {
        parsedDate = DateTime.parse(dateString);
      }
    } catch (e) {
      parsedDate = DateTime.now();
    }

    return Payment(
      id: json['id'],
      userId: json['userId'],
      userUserName: json['userUserName'],
      orderId: json['orderId'],
      date: parsedDate,
      amount: json['amount'],
      method: json['method'],
      description: json['description'],
      status: json['status'],
    );
  }
}
