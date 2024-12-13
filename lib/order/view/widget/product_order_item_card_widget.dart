import 'package:flutter/material.dart';
import 'package:snap_kart_admin/order/model/product_order_item_model.dart';

class ProductOrderItemCard extends StatelessWidget {
  final ProductOrderItem item;

  const ProductOrderItemCard({
    required this.item,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Quantity',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  ' ${item.quantity}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Price',
                ),
                Text(
                  '₹${item.price.toStringAsFixed(2)}',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Discount',
                ),
                Text(
                  ' ₹${item.discountAmount.toStringAsFixed(2)}',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total ',
                  style: TextStyle(
                    fontSize: 16,
                    color: item.totalPrice == 'Delivered'
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
                Text(
                  ' ${item.totalPrice}',
                  style: TextStyle(
                    fontSize: 16,
                    color: item.totalPrice == 'Delivered'
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
