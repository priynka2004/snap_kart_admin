class ProductOrderItem {
  String product;
  String name;
  int quantity;
  num price;
  num discountAmount;
  int totalPrice;
  String? id;

  ProductOrderItem({
    required this.product,
    required this.name,
    required this.quantity,
    required this.price,
    required this.discountAmount,
    required this.totalPrice,
    this.id,
  });


  factory ProductOrderItem.fromJson(Map<String, dynamic> json) {
    return ProductOrderItem(
      product: json['product'] ?? '',
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: json['price'] ?? 0,
      discountAmount: json['discountAmount'] ?? 0,
      totalPrice: json['totalPrice'] ?? 0,
      id: json['_id'] ?? '',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'name': name,
      'quantity': quantity,
      'price': price,
      'discountAmount': discountAmount,
      'totalPrice': totalPrice,
      '_id': id,
    };
  }
}