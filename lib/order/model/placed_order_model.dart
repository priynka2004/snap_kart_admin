import 'package:snap_kart_admin/order/model/product_order_item_model.dart';
import 'package:snap_kart_admin/profile/model/shipping_address_model.dart';



class OrderResponse {
  List<ProductOrderItem> items;
  ShippingAddress shippingAddress;

  OrderResponse({
    required this.items,
    required this.shippingAddress,
  });


  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      items: (json['items'] as List<dynamic>)
          .map((item) => ProductOrderItem.fromJson(item))
          .toList(),
      shippingAddress: ShippingAddress.fromJson(json['shippingAddress']),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'shippingAddress': shippingAddress.toJson(),
    };
  }
}






