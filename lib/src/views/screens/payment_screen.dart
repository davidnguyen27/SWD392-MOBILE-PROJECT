import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:t_shirt_football_project/src/models/payment.dart';
import 'package:t_shirt_football_project/src/services/payment_service.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

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
        backgroundColor: Colors.blueGrey[900],
        elevation: 10,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.blueGrey[50],
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Payment>>(
          future: PaymentService.getAllPayments(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print(
                  'Error loading payments: ${snapshot.error}'); // Debug: In lỗi
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No payments found'));
            } else {
              final payments = snapshot.data!;
              print(
                  'Payments loaded: $payments'); // Debug: In danh sách payments

              final displayDateFormat = DateFormat('yyyy/MM/dd');

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: WidgetStateColor.resolveWith(
                      (states) => Colors.blueGrey[700]!),
                  columnSpacing: 24,
                  columns: const [
                    DataColumn(
                      label: Text(
                        'User Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Order ID',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Date',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Amount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Method',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Description',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Status',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  rows: payments.map((payment) {
                    return DataRow(
                      color: WidgetStateColor.resolveWith(
                        (states) => payment.status
                            ? Colors.green[50]!
                            : Colors.red[50]!,
                      ),
                      cells: [
                        DataCell(
                          Text(
                            payment.userUserName,
                            style: TextStyle(
                                color: Colors.blueGrey[900],
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        DataCell(
                          Text(
                            payment.orderId,
                            style: TextStyle(color: Colors.blueGrey[700]),
                          ),
                        ),
                        DataCell(
                          Text(
                            displayDateFormat.format(payment.date),
                            style: TextStyle(color: Colors.blueGrey[700]),
                          ),
                        ),
                        DataCell(
                          Text(
                            '\$${payment.amount}',
                            style: TextStyle(color: Colors.blueGrey[700]),
                          ),
                        ),
                        DataCell(
                          Text(
                            payment.method,
                            style: TextStyle(color: Colors.blueGrey[700]),
                          ),
                        ),
                        DataCell(
                          Text(
                            payment.description,
                            style: TextStyle(color: Colors.blueGrey[700]),
                          ),
                        ),
                        DataCell(
                          Text(
                            payment.status ? 'Completed' : 'Pending',
                            style: TextStyle(
                              color: payment.status ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
