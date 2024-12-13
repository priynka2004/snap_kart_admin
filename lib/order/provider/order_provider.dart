import 'package:flutter/cupertino.dart';
import 'package:snap_kart_admin/order/model/order_response_model.dart';
import 'package:snap_kart_admin/order/model/update__order_status_request.dart';


import '../../service/app_util.dart';

import '../model/order_model.dart';
import '../model/placed_order_model.dart';
import '../service/Order_service.dart';

class OrderProvider extends ChangeNotifier{
  OrderService orderService;

  OrderProvider(this.orderService);

  bool isLoading=false;
  String? error;

  List<Order> orderList=[];

  Future placeOrder(OrderResponse orderResponse)async{
    try{
      error=null;
      isLoading=true;
   //   notifyListeners();
      bool isSuccess  = await  orderService.placeOrder(orderResponse);
      if(isSuccess){
        AppUtil.showToast('Order placed successfully');
      }
      isLoading=false;

    }catch(e){
      isLoading =false;
      throw e.toString();
    }
    notifyListeners();
  }

  Future fetchOrders()async{
    try{
      error=null;
      isLoading=true;
      notifyListeners();
      OrderResponseList orderResponseList = await  orderService.fetchOrders();
      orderList = orderResponseList.orders ?? [];
      isLoading=false;

    }catch(e){
      isLoading = false;
      throw e.toString();

    }
    notifyListeners();
  }

  Future updateOrderStatus(UpdateOrderStatusRequest request)async{
    try{
      error=null;
      isLoading=true;
      notifyListeners();
     bool isSuccess = await orderService.updateOrderStatus(request);
      if(isSuccess){
       AppUtil.showToast('Order status updated successfully!');
      }
      isLoading=false;

    }catch(e){
      isLoading = false;
      throw e.toString();

    }
    notifyListeners();
  }
}
