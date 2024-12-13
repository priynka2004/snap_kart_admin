import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snap_kart_admin/auth/provider/auth_provider.dart';
import 'package:snap_kart_admin/auth/provider/splash_provider.dart';
import 'package:snap_kart_admin/auth/service/auth_service.dart';
import 'package:snap_kart_admin/auth/view/splash_screen.dart';
import 'package:snap_kart_admin/cart/provider/cart_provider.dart'; // Import CartProvider
import 'package:snap_kart_admin/category/provider/category_provider.dart';
import 'package:snap_kart_admin/category/service/category_service.dart';
import 'package:snap_kart_admin/order/provider/order_provider.dart';
import 'package:snap_kart_admin/product/provider/product_provider.dart';
import 'package:snap_kart_admin/product/service/product_service.dart';
import 'package:snap_kart_admin/cart/service/cart_service.dart';
import 'package:snap_kart_admin/profile/provider/profile_provider.dart';
import 'package:snap_kart_admin/profile/service/profile_service.dart';

import 'order/service/Order_service.dart'; // Import CartService

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            AuthService authService = AuthService();
            return AuthProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            ProductService productService = ProductService();
            return ProductProvider(productService);
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return CategoryProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return SplashProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            CartService cartService = CartService();
            return CartProvider(cartService);
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            OrderService orderService = OrderService();
            return OrderProvider(orderService);
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            ProfileService profileService = ProfileService();
            return ProfileProvider();
          },
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
