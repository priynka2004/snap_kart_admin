import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:snap_kart_admin/order/model/order_model.dart';
import 'package:snap_kart_admin/order/model/order_status.dart';
import 'package:snap_kart_admin/order/model/update__order_status_request.dart';
import 'package:snap_kart_admin/order/provider/order_provider.dart';
import 'package:snap_kart_admin/order/view/order_detail_screen.dart';

class OrderCard extends StatefulWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  String? selectedOrderStatus;

  @override
  void initState() {
    selectedOrderStatus = widget.order.orderStatus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order #${widget.order.orderNumber}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Items',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  '${widget.order.items.length}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Placed on',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  ' ${DateFormat('dd MMM yyyy').format(DateTime.parse(widget.order.createdAt))}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton(
                    value: selectedOrderStatus,
                    items: orderStatusList.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      selectedOrderStatus = value;
                      widget.order.orderStatus = selectedOrderStatus!;
                      setState(() {});

                      final orderProvider =
                          Provider.of<OrderProvider>(context, listen: false);
                      orderProvider.updateOrderStatus(UpdateOrderStatusRequest(
                          widget.order.orderNumber, selectedOrderStatus!));
                    }),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return OrderDetailScreen(widget.order.items);
                    }));
                  },   style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  elevation: 3,
                ),
                  child: const Text(
                    'View Details',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
