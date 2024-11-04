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
    final dateString = json['date'];
    print(
        'Raw date string from JSON: $dateString'); // Debug: In chuỗi ngày tháng gốc

    DateTime parsedDate;

    // Kiểm tra độ dài của chuỗi để xác định định dạng
    if (dateString.length == 14) {
      // Nếu chuỗi có 14 ký tự, dùng định dạng "yyyyMMddHHmmss"
      parsedDate = DateFormat("yyyyMMddHHmmss").parse(dateString);
    } else if (dateString.length == 19) {
      // Nếu chuỗi có 19 ký tự, dùng định dạng "dd/MM/yyyy HH:mm:ss"
      parsedDate = DateFormat("dd/MM/yyyy HH:mm:ss").parse(dateString);
    } else {
      throw FormatException("Invalid date format: $dateString");
    }

    print('Parsed date: $parsedDate'); // Debug: In ngày đã chuyển đổi

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
