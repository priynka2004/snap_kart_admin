import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snap_kart_admin/auth/provider/auth_provider.dart';
import 'package:snap_kart_admin/auth/provider/splash_provider.dart';
import 'package:snap_kart_admin/auth/service/auth_service.dart';
import 'package:snap_kart_admin/auth/view/login_screen.dart';
import 'package:snap_kart_admin/auth/view/splash_screen.dart';
import 'package:snap_kart_admin/category/service/category_service.dart';
import 'package:snap_kart_admin/product/provider/product_provider.dart';
import 'package:snap_kart_admin/product/service/product_service.dart';


import 'category/provider/category_provider.dart';

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
            return CategoryProvider(CategoryService());
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return SplashProvider();
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
