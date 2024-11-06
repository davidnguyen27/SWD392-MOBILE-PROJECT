import 'package:flutter/material.dart';
import 'package:t_shirt_football_project/src/models/order.dart';
import 'package:t_shirt_football_project/src/services/order_service.dart';

class OrderManageScreen extends StatefulWidget {
  const OrderManageScreen({super.key});

  @override
  _OrderManageScreenState createState() => _OrderManageScreenState();
}

class _OrderManageScreenState extends State<OrderManageScreen> {
  final OrderService _orderService = OrderService();
  List<Order> _orders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    try {
      final orders = await _orderService.fetchOrders(1, 50, '', 2);
      print("Fetched Orders: $orders");

      if (mounted) {
        setState(() {
          _orders = orders;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      print('Failed to fetch orders: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Management'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                final order = _orders[index];
                return OrderCard(order: order);
              },
            ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${order.id}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Customer Name: ${order.userName}'),
            const SizedBox(height: 8),
            Text('Total Price: \$${order.totalPrice}'),
          ],
        ),
      ),
    );
  }
}
