import 'package:snap_kart_admin/core/app_constant.dart';
import 'package:snap_kart_admin/service/storage_service.dart';

class ApiEndpoint{
  static const String baseUrls = 'https://e-commerce-server-zc33.onrender.com';
  static const String baseUrl = 'https://e-commerce-server-zc33.onrender.com/api/users/register';

  static const String signUp = '$baseUrl/users/register';

  static const String login = '$baseUrl/users/login';
  static const String product = 'https://e-commerce-server-zc33.onrender.com/api/products';
  static const String updateCategory = 'https://e-commerce-server-zc33.onrender.com/api/categories';
  static const String getCategory = '$baseUrls/api/categories';
  static const String addProduct = '$baseUrls/api/products';
  static const String addCategory = '$baseUrls/api/categories';
  static const String cart = 'https://e-commerce-server-zc33.onrender.com/api/cart';
  static const String addCart = '$baseUrl/api/cart';
  static const String fetchCart = 'https://e-commerce-server-zc33.onrender.com/api/cart';

  static  String deleteCartItem(String id){
    return 'https://e-commerce-server-zc33.onrender.com/api/cart/$id';}

  static  String clearCart(){
    return 'https://e-commerce-server-zc33.onrender.com/api/cart';}

  static const String getProduct = '$baseUrls/api/products';

  static  String deleteProduct(String id){
    return '$baseUrls/api/products/$id';}

  static  String updateProduct(String id){
    return '$baseUrls/api/products/$id';}

  static const String addItem = 'https://e-commerce-server-zc33.onrender.com/api/cart';
  static const String getUser = 'https://e-commerce-server-zc33.onrender.com/api/cart';
  static const String removeItem = 'https://e-commerce-server-zc33.onrender.com/api/cart/:itemId';

  static  String deleteCategory (String id) {
   return 'https://e-commerce-server-zc33.onrender.com/api/categories/$id';
  }

  static const String  order ='https://e-commerce-server-zc33.onrender.com/api/orders';
  static const String  usersOrder ='https://e-commerce-server-zc33.onrender.com/api/orders';

  static  String orderUpdate(String orderId){
    return 'https://e-commerce-server-zc33.onrender.com/api/orders/$orderId';
  }

  // static  String profileUpdate(String profileId){
  //   return 'https://e-commerce-server-zc33.onrender.com/api/orders/67465feef7f18acaad122285';
  // }

  static const String  profileUpdate ='https://e-commerce-server-zc33.onrender.com/api/orders/67465feef7f18acaad122285';

    static Future <Map<String, String>> getHeaders() async{
      String? token = await StorageHelper.getToken();
      return {
        'x-api-key': AppConstant.apikey,
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjczNWEwYjAyZTI3OTJhNmI2MDMwOWI2IiwidXNlcm5hbWUiOiJ0ZXN0dXNlciJ9LCJpYXQiOjE3MzMwNDY3MTcsImV4cCI6MTczMzA1MDMxN30.ARK4tFuIE7fzzyn73quim4hsDHA0w_vGRrX5HTzQlU8',
        'Content-Type': 'application/json',
      };
  }

  }
