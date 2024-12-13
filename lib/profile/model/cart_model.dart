// class CartModel {
//   String? productId;
//   String? productName;
//   int? quantity;
//   double? price;
//   String? productImg;
//   double discountAmount;
//
//   CartModel({
//      this.productId,
//      this.productName,
//      this.quantity,
//      this.price,
//      this .productImg,
//      this.discountAmount = 0.0,
//   });
//
//
//   factory CartModel.fromJson(Map<String, dynamic> json) {
//     return CartModel(
//       productId: json['productId'] ?? '', // Ensure null safety
//       productName: json['productName'] ?? '',
//       quantity: json['quantity'] ?? 0,
//       price: (json['price'] ?? 0).toDouble(),
//       productImg: json['productImg'] ?? '',
//       discountAmount: (json['discountAmount'] ?? 0).toDouble(),
//     );
//   }
//
//
//   Map<String, dynamic> toJson() {
//     return {
//       'productId': productId,
//       'productName': productName,
//       'quantity': quantity,
//       'price': price,
//       'productImg': productImg,
//       'discountAmount': discountAmount,
//     };
//   }
// }
