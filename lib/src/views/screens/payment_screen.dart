import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:t_shirt_football_project/src/models/payment.dart';
import 'package:t_shirt_football_project/src/services/payment_service.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  Future<List<Payment>> fetchPayments() async {
    final payments = await PaymentService.getAllPayments();
    return payments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment Management',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 10,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.blueGrey[50],
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Payment>>(
          future: fetchPayments(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print('Error loading payments: ${snapshot.error}');
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No payments found'));
            } else {
              final payments = snapshot.data!;
              return ListView.builder(
                itemCount: payments.length,
                itemBuilder: (context, index) {
                  final payment = payments[index];
                  final formattedDate =
                      DateFormat('yyyy-MM-dd HH:mm:ss').format(payment.date);
                  final formattedAmount =
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                          .format(payment.amount);

                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            payment.userUserName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Order ID: ${payment.orderId}'),
                          Text('Date: $formattedDate'),
                          Text(
                              'Amount: $formattedAmount'), // Hiển thị số tiền theo định dạng VND
                          Text('Method: ${payment.method}'),
                          Text('Description: ${payment.description}'),
                          const SizedBox(height: 8),
                          Text(
                            payment.status
                                ? 'Status: Completed'
                                : 'Status: Pending',
                            style: TextStyle(
                              color: payment.status ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
