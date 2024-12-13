import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:snap_kart_admin/cart/model/cart_model.dart';
import '../../profile/model/cart_model.dart';
import '../../service/api_endpoint.dart';
import '../../service/storage_service.dart';
import '../model/cart_response_model.dart';



class CartService {

  Future<bool> addToCart(CartModel cartModel) async {
    try {
      String? token = await StorageHelper.getToken();
      final header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'x-api-key': 'aihfj--qwnkqwr--jlkqwnjqw--jnkqwjnqwy',
      };

      Uri uri = Uri.parse(ApiEndpoint.cart);
      print('Headers: $header');
      print('Request Body: ${jsonEncode(cartModel.toJson())}');

      final response = await http.post(
        uri,
        headers: header,
        body: jsonEncode(cartModel.toJson()),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        return true; // Success
      } else {
        final errorResponse = jsonDecode(response.body);
        throw errorResponse['message'] ?? 'Unable to add product to cart';
      }
    } catch (e) {
      print('Error in addToCart: $e');
      return false;
    }
  }

  Future<CartResponse?> fetchCartItems() async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await StorageHelper.getToken()}',
        'x-api-key': 'aihfj--qwnkqwr--jlkqwnjqw--jnkqwjnqwy',
      };

      final response = await http.get(Uri.parse(ApiEndpoint.cart), headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return CartResponse.fromJson(json);
      } else {
        print('Error fetching cart items: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error in fetchCartItems: $e');
      return null;
    }
  }

  Future<bool> deleteCart(String id) async {
    try {
      final token = await StorageHelper.getToken();
      final header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'x-api-key': 'aihfj--qwnkqwr--jlkqwnjqw--jnkqwjnqwy',
      };

      final Uri uri = Uri.parse(ApiEndpoint.deleteCartItem(id));
      print('Attempting to delete cart item with URI: $uri');

      final response = await http.delete(uri, headers: header);
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to delete cart item: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error in deleteCart: $e');
      return false;
    }
  }


  Future<bool> updateToCartQuantity(CartModel cartModel) async {
    try {
      String? token = await StorageHelper.getToken();

      if (token == null) {
        throw 'Token is missing';
      }

      final header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'x-api-key': "aihfj--qwnkqwr--jlkqwnjqw--jnkqwjnqwy",
      };


      Uri uri = Uri.parse(ApiEndpoint.cart);

      final response = await http.post(
        uri,
        headers: header,
        body: jsonEncode(cartModel.toJson()),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        final errorResponse = jsonDecode(response.body);
        throw errorResponse['message'] ?? 'Unknown error occurred';
      }
    } catch (e) {
      print('Error in updateToCartQuantity: $e');
      return false;
    }
  }

  Future<bool> clearCart() async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await StorageHelper.getToken()}',
        'x-api-key': 'aihfj--qwnkqwr--jlkqwnjqw--jnkqwjnqwy',
      };

      final response = await http.delete(Uri.parse(ApiEndpoint.clearCart()), headers: headers);
      return response.statusCode == 200;
    } catch (e) {
      print('Error in clearCart: $e');
      return false;
    }
  }

}