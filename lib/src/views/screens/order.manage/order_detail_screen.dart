import 'package:flutter/material.dart';
import 'package:t_shirt_football_project/src/models/order.dart';
import 'package:t_shirt_football_project/src/services/order_service.dart';

class OrderDetailScreen extends StatefulWidget {
  final Order order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late int _status;

  @override
  void initState() {
    super.initState();
    _status = widget.order.status; // Lấy trạng thái ban đầu của đơn hàng
  }

  Future<void> _updateOrderStatus(int newStatus, BuildContext context) async {
    try {
      bool success = await OrderService.updateOrderStatus(
        widget.order.id,
        widget.order.userId,
        widget.order.totalPrice,
        widget.order.shipPrice,
        widget.order.deposit ?? 0,
        widget.order.date,
        widget.order.refundStatus,
        newStatus,
      );
      if (success) {
        setState(() {
          _status = newStatus;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Order status updated to ${_getStatusText(newStatus)}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update order status: $e')),
      );
    }
  }

  void _rejectOrder(BuildContext context) {
    _updateOrderStatus(7, context); // Cập nhật trạng thái thành 7 khi từ chối
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order has been rejected')),
    );
  }

  String _getStatusText(int status) {
    switch (status) {
      case 2:
        return 'Confirm';
      case 3:
        return 'Processing';
      case 4:
        return 'Shipped';
      case 5:
        return 'Order Completed';
      case 7:
        return 'Rejected';
      default:
        return 'Unknown';
    }
  }

  void _handleStatusChange(BuildContext context) {
    if (_status < 5) {
      int newStatus = _status + 1;
      _updateOrderStatus(newStatus, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${widget.order.id}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Customer Name: ${widget.order.userName}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: widget.order.orderDetails.length,
                itemBuilder: (context, index) {
                  final orderDetail = widget.order.orderDetails[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Item ${index + 1}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Size: ${orderDetail.sizeName}'),
                          Text('Shirt Price: \$${orderDetail.shirtPrice}'),
                          Text('Quantity: ${orderDetail.quantity}'),
                          const SizedBox(height: 8),
                          const Text(
                            'Shirt Name:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(orderDetail.shirtName),
                          const SizedBox(height: 8),
                          const Text(
                            'Description:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(orderDetail.shirtDescription),
                          const SizedBox(height: 16),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.grey, width: 0.5),
                              ),
                              child: Image.network(
                                orderDetail.shirtUrlImg,
                                height: 200,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          orderDetail.comment != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Comment:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(orderDetail.comment!),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Nút Confirm
                  ElevatedButton(
                    onPressed:
                        _status < 5 ? () => _handleStatusChange(context) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _status == 2
                          ? Colors.green
                          : _status == 3
                              ? Colors.orange
                              : _status == 4
                                  ? Colors.blue
                                  : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      elevation: 5,
                    ),
                    child: Text(
                      _getStatusText(_status),
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Nút Reject, chỉ hiện khi status == 2
                  if (_status == 2)
                    ElevatedButton(
                      onPressed: () => _rejectOrder(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        elevation: 5,
                      ),
                      child: const Text(
                        'Reject',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
