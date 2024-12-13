import 'package:snap_kart_admin/product/model/product_model.dart';

class CartItem {
  Product? product;
  int? quantity;
  String? createdAt;
  String? updatedAt;

  CartItem({this.product, this.quantity, this.createdAt, this.updatedAt});

  CartItem.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ?  Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['quantity'] = this.quantity;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}