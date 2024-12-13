import 'package:flutter/material.dart';
import 'package:snap_kart_admin/order/view/widget/product_order_item_card_widget.dart';

import '../model/product_order_item_model.dart';

class OrderDetailScreen extends StatelessWidget {
  OrderDetailScreen(this.productItemList, {super.key});

  List<ProductOrderItem> productItemList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: GestureDetector( onTap: () {
          Navigator.pop(context);
        },child:const Icon(Icons.arrow_back_ios,color: Colors.white,)),
        title: const Text('Order Details',style: TextStyle(color: Colors.white),),
      ),
      body: productItemList.isEmpty
      ? const Center(
        child: Text('No items in this order.'),
      )
          :ListView.builder(
        itemCount: productItemList.length,
          itemBuilder: (context,index){
          final item =productItemList[index];
          return ProductOrderItemCard(item:item);
          },
      )
    );
  }
}
