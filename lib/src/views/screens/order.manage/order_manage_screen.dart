import 'package:flutter/material.dart';
import 'package:t_shirt_football_project/src/models/order.dart';
import 'package:t_shirt_football_project/src/services/order_service.dart';
import 'package:t_shirt_football_project/src/views/screens/order.manage/order_detail_screen.dart';

class OrderManageScreen extends StatefulWidget {
  const OrderManageScreen({super.key});

  @override
  _OrderManageScreenState createState() => _OrderManageScreenState();
}

class _OrderManageScreenState extends State<OrderManageScreen> {
  final OrderService _orderService = OrderService();
  List<Order> _orders = [];
  bool _isLoading = true;
  int? _selectedStatus = 2; // Đặt trạng thái mặc định là 2

  @override
  void initState() {
    super.initState();
    _fetchOrders(
        _selectedStatus); // Gọi _fetchOrders với trạng thái mặc định là 2
  }

  Future<void> _fetchOrders([int? status]) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final orders = await _orderService.fetchOrders(1, 50, '', status!);
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Order Management'),
            DropdownButton<int>(
              hint: const Icon(Icons.filter_list, color: Colors.white),
              value: _selectedStatus,
              dropdownColor: Colors.blue,
              iconEnabledColor: Colors.white,
              onChanged: (int? newStatus) {
                setState(() {
                  _selectedStatus = newStatus;
                });
                _fetchOrders(newStatus); // Gọi _fetchOrders với status mới
              },
              items: const [
                DropdownMenuItem(
                    value: 2,
                    child: Text('Paid', style: TextStyle(color: Colors.white))),
                DropdownMenuItem(
                    value: 3,
                    child: Text('Confirmed',
                        style: TextStyle(color: Colors.white))),
                DropdownMenuItem(
                    value: 4,
                    child: Text('Processing',
                        style: TextStyle(color: Colors.white))),
                DropdownMenuItem(
                    value: 5,
                    child:
                        Text('Shipped', style: TextStyle(color: Colors.white))),
                DropdownMenuItem(
                    value: 7,
                    child: Text('Rejected',
                        style: TextStyle(color: Colors.white))),
              ],
            ),
          ],
        ),
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
            Text('Total Price: ${order.totalPrice}vnđ'),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailScreen(order: order),
                    ),
                  );
                },
                child: const Text('Details'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
