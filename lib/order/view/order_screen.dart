import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:snap_kart_admin/order/view/widget/order_card_widget.dart';
import '../provider/order_provider.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {

  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      fetchOrders();
    });
    super.initState();
  }

  Future fetchOrders()async{

    final orderProvider = Provider.of<OrderProvider>(context,listen: false);
    orderProvider.fetchOrders();
  }

  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: GestureDetector( onTap: () {
          Navigator.pop(context);
        },child:const Icon(Icons.arrow_back_ios,color: Colors.white,)),
        title: const Text('My Orders',style: TextStyle(color: Colors.white),),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, orderProvider, child) {
          if (orderProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (orderProvider.error != null) {
            return Center(
              child: Text('Error: ${orderProvider.error}'),
            );
          }
          final orders = orderProvider.orderList;

          if (orders.isEmpty) {
            return const Center(
              child: Text('No orders found.'),
            );
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return OrderCard(order: order);
            },
          );
        },
      ),
    );
  }
}


