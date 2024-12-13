// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:provider/provider.dart';
// import 'package:snap_kart_admin/cart/model/cart_model.dart';
// import 'package:snap_kart_admin/cart/provider/cart_provider.dart';
// import 'package:snap_kart_admin/order/model/product_order_item_model.dart';
// import 'package:snap_kart_admin/order/provider/order_provider.dart';
// import 'package:snap_kart_admin/product/model/product_model.dart';
// import 'package:snap_kart_admin/profile/model/shipping_address_model.dart';
// import 'package:snap_kart_admin/profile/view/add_shipping_address_screen.dart';
// import '../../order/model/placed_order_model.dart';
// import '../model/cart_item_model.dart';
//
// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});
//
//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   @override
//   void initState() {
//     SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//       fetchCartItems();
//     });
//     super.initState();
//   }
//
//   Future fetchCartItems() async {
//     final provider = Provider.of<CartProvider>(context, listen: false);
//     provider.fetchCartItems();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Cart',
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               fetchCartItems();
//             },
//             icon: const Icon(
//               Icons.refresh,
//               color: Colors.white,
//             ),
//             tooltip: 'Refresh',
//           )
//         ],
//         backgroundColor: Colors.blueGrey,
//         leading: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: const Icon(
//               Icons.arrow_back_ios,
//               color: Colors.white,
//             )),
//       ),
//       body: Consumer<CartProvider>(builder: (context, provider, child) {
//         return provider.isLoading
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : ListView(
//                 padding: const EdgeInsets.all(8.0),
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           'Subtotal',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 20),
//                         ),
//                         Text(
//                           (provider.cartResponse?.subtotal ?? 0).toString(),
//                           style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                               color: Colors.black),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           'Total Discount',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 20),
//                         ),
//                         Text(
//                           (provider.cartResponse?.totalDiscount ?? 0)
//                               .toString(),
//                           style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                               color: Colors.black),
//                         ),
//                       ],
//                     ),
//                   ),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: provider.cartResponse?.items?.length ?? 0,
//                     itemBuilder: (context, index) {
//                       CartItem cartItem = provider.cartResponse!.items![index];
//                       return Card(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text(
//                                     'Product',
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold),
//                                   ),
//                                   Text(
//                                     cartItem.product?.name ?? '',
//                                     style: const TextStyle(
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text(
//                                     'Price',
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold),
//                                   ),
//                                   Text(
//                                     (cartItem.product?.price ?? 0.0).toString(),
//                                     style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text(
//                                     'Quantity',
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold),
//                                   ),
//                                   Text(
//                                     cartItem.quantity?.toString() ?? '0',
//                                     style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   IconButton(
//                                     onPressed: () {
//                                       int qty = cartItem.quantity ?? 0;
//                                       if (qty > 0) {
//                                         qty--;
//                                         provider.updateToCartQuantity(
//                                           CartModel(
//                                             productId:
//                                                 cartItem.product?.id ?? '',
//                                             quantity: qty,
//                                           ),
//                                         );
//                                       }
//                                     },
//                                     icon: const Icon(Icons.remove),
//                                   ),
//                                   Text((cartItem.quantity ?? 0).toString()),
//                                   IconButton(
//                                     onPressed: () {
//                                       int qty = cartItem.quantity ?? 0;
//                                       qty++;
//                                       provider.updateToCartQuantity(
//                                         CartModel(
//                                           productId: cartItem.product?.id ?? '',
//                                           quantity: qty,
//                                         ),
//                                       );
//                                     },
//                                     icon: const Icon(Icons.add),
//                                   ),
//                                   const Spacer(),
//                                   IconButton(
//                                     icon: const Icon(Icons.delete,
//                                         color: Colors.black),
//                                     onPressed: () {
//                                       showDialog(
//                                         context: context,
//                                         builder: (BuildContext context) {
//                                           return AlertDialog(
//                                             title: const Text('Confirm Delete'),
//                                             content: const Text(
//                                                 'Are you sure you want to delete this item?'),
//                                             actions: [
//                                               TextButton(
//                                                 child: const Text('Cancel'),
//                                                 onPressed: () {
//                                                   Navigator.of(context).pop();
//                                                 },
//                                               ),
//                                               TextButton(
//                                                 child: const Text('Delete'),
//                                                 onPressed: () {
//                                                   Navigator.of(context).pop();
//                                                   provider.deleteCartItem(
//                                                       cartItem.product?.id ??
//                                                           '');
//                                                   ScaffoldMessenger.of(context)
//                                                       .showSnackBar(
//                                                     const SnackBar(
//                                                       content: Text(
//                                                           'Item deleted successfully'),
//                                                       backgroundColor:
//                                                           Colors.green,
//                                                       duration:
//                                                           Duration(seconds: 2),
//                                                     ),
//                                                   );
//                                                 },
//                                               ),
//                                             ],
//                                           );
//                                         },
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               );
//       }),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ElevatedButton(
//           onPressed: () async {
//             ShippingAddress? shippingAddress = await Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) {
//                 return const AddShippingAddresScreen();
//               }),
//             );
//
//             placeOrder(shippingAddress, context);
//           },
//           style: ElevatedButton.styleFrom(
//             foregroundColor: Colors.white,
//             backgroundColor: Colors.blueGrey,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(30),
//             ),
//             padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 60),
//             elevation: 3,
//           ),
//           child: const Text(
//             'Placed Order',
//             style: TextStyle(
//               fontSize: 16,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> placeOrder(
//       ShippingAddress? shippingAddress, BuildContext context) async {
//     if (shippingAddress != null) {
//       final orderProvider = Provider.of<OrderProvider>(context, listen: false);
//       final cartProvider = Provider.of<CartProvider>(context, listen: false);
//
//       List<CartItem> cartItemList = cartProvider.cartResponse?.items ?? [];
//       if (cartItemList.isEmpty) {
//         print('Cart is empty, cannot place order');
//         return;
//       }
//
//       List<ProductOrderItem> productOrderItemList = [];
//       for (CartItem cartItem in cartItemList) {
//         Product? product = cartItem.product;
//         if (product != null) {
//           productOrderItemList.add(
//             ProductOrderItem(
//               product: product.id!,
//               price: product.price!.toInt(),
//               quantity: cartItem.quantity ?? 1,
//               name: product.name.toString(),
//               totalPrice: cartProvider.cartResponse?.subtotal ?? 0,
//               discountAmount: product.discountAmount ?? 0,
//             ),
//           );
//         }
//       }
//
//       OrderResponse orderModel = OrderResponse(
//         shippingAddress: shippingAddress,
//         items: productOrderItemList,
//       );
//
//       await orderProvider.placeOrder(orderModel);
//
//       if (orderProvider.error == null) {
//         await cartProvider.clearCart();
//       } else {
//         print('Order placement failed: ${orderProvider.error}');
//       }
//     }
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snap_kart_admin/cart/model/cart_item_model.dart';
import 'package:snap_kart_admin/cart/model/cart_model.dart';
import 'package:snap_kart_admin/cart/provider/cart_provider.dart';
import 'package:snap_kart_admin/profile/view/add_shipping_address_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchCartItems();
    });
  }

  Future fetchCartItems() async {
    final provider = Provider.of<CartProvider>(context, listen: false);
    provider.fetchCartItems();
  }

  Future<void> showDeleteDialog(
      CartItem cartItem, CartProvider provider) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item'),
        content: Text(
            'Are you sure you want to delete "${cartItem.product?.name}" from the cart?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              provider.deleteCartItem(cartItem.product?.id ?? '');
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              fetchCartItems();
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            tooltip: 'Refresh',
          )
        ],
        backgroundColor: Colors.blueGrey,
      ),
      body: Consumer<CartProvider>(builder: (context, provider, child) {
        return provider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : LayoutBuilder(
                builder: (context, constraints) {
                  double width = constraints.maxWidth;

                  if (width > 600) {
                    return ListView(
                      padding: const EdgeInsets.all(8.0),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Subtotal',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text(
                                (provider.cartResponse?.subtotal ?? 0)
                                    .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total Discount',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text(
                                (provider.cartResponse?.totalDiscount ?? 0)
                                    .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: width > 1000 ? 4 : 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1.5,
                          ),
                          itemCount: provider.cartResponse?.items?.length ?? 0,
                          itemBuilder: (context, index) {
                            CartItem cartItem =
                                provider.cartResponse!.items![index];
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        cartItem.product?.name ?? '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        (cartItem.product?.price ?? 0.0).toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              int qty = cartItem.quantity ?? 0;
                                              if (qty > 0) {
                                                qty--;
                                                provider.updateToCartQuantity(
                                                  CartModel(
                                                    productId: cartItem.product?.id ?? '',
                                                    quantity: qty,
                                                  ),
                                                );
                                              }
                                            },
                                            icon: const Icon(Icons.remove),
                                          ),
                                          Text(
                                            cartItem.quantity?.toString() ?? '0',
                                            style: const TextStyle(fontSize: 18),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              int qty = cartItem.quantity ?? 0;
                                              qty++;
                                              provider.updateToCartQuantity(
                                                CartModel(
                                                  productId: cartItem.product?.id ?? '',
                                                  quantity: qty,
                                                ),
                                              );
                                            },
                                            icon: const Icon(Icons.add),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDeleteDialog(cartItem, provider);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );

                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AddShippingAddresScreen();
                            }));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Proceeding to checkout!')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: const Text(
                            'Place Order',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: provider.cartResponse?.items?.length ?? 0,
                      itemBuilder: (context, index) {
                        CartItem cartItem =
                            provider.cartResponse!.items![index];
                        return Card(

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Product',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      cartItem.product?.name ?? '',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Price',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      (cartItem.product?.price ?? 0.0)
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Quantity',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      cartItem.quantity?.toString() ?? '0',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        int qty = cartItem.quantity ?? 0;
                                        if (qty > 0) {
                                          qty--;
                                          provider?.updateToCartQuantity(
                                            CartModel(
                                              productId:
                                                  cartItem.product?.id ?? '',
                                              quantity: qty,
                                            ),
                                          );
                                        }
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),
                                    Text(
                                      cartItem.quantity?.toString() ?? '0',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        int qty = cartItem.quantity ?? 0;
                                        qty++;
                                        provider?.updateToCartQuantity(
                                          CartModel(
                                            productId:
                                                cartItem.product?.id ?? '',
                                            quantity: qty,
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.add),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        showDeleteDialog(cartItem, provider);
                                      },
                                      icon: const Icon(Icons.delete,
                                          color: Colors.black),
                                    ),
                                  ],

                                ),

                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              );
      }),
    );
  }
}
