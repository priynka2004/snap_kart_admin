


import 'package:snap_kart_admin/cart/model/cart_item_model.dart';


class CartResponse {
  String? user;
  int? subtotal;
  num? totalDiscount;
  List<CartItem>? items;

  CartResponse({this.user, this.subtotal, this.totalDiscount, this.items});

  CartResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    subtotal = json['subtotal'];
    totalDiscount = json['totalDiscount'];
    if (json['items'] != null) {
      items = <CartItem>[];
      json['items'].forEach((v) {
        items!.add(new CartItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['subtotal'] = this.subtotal;
    data['totalDiscount'] = this.totalDiscount;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

