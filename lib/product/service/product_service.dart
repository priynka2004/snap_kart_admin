import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:snap_kart_admin/core/app_constant.dart';
import 'package:snap_kart_admin/product/model/product_model.dart';
import 'package:snap_kart_admin/service/api_endpoint.dart';
import 'package:snap_kart_admin/service/storage_service.dart';

class ProductService {
  Future<List<Product>> fetchProducts() async {
    String url = ApiEndpoint.addProduct;

    final response = await http.get(
      Uri.parse(url),
      headers: {'x-api-key': 'aihfj--qwnkqwr--jlkqwnjqw--jnkqwjnqwy'},
    );

    if (response.statusCode == 200) {
      try {
        final List<dynamic> mapList = jsonDecode(response.body);

        if (mapList.isEmpty) {
          return [];
        }

        return mapList
            .map((map) => Product.fromJson(map as Map<String, dynamic>))
            .toList();
      } catch (e) {
        throw 'Error parsing product data: $e';
      }
    } else {
      throw 'Unable to fetch products. Status code: ${response.statusCode}';
    }
  }

  Future<bool> addProduct(Product product) async {
    try {
      String url = ApiEndpoint.addProduct;
      Uri uri = Uri.parse(url);

      String? token = await StorageHelper.getToken();

      if (token == null) {}

      final headers = {
        'x-api-key': AppConstant.apikey,
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final body = jsonEncode(product.toJson());
      final response = await http.post(
        uri,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        print(
            'Failed to add product: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error in ProductService.addProduct: $e');
      return false;
    }
  }

  Future<bool> deleteProduct(String productId) async {
    try {
      String url = '${ApiEndpoint.deleteProduct}/$productId';
      Uri uri = Uri.parse(url);

      String? token = await StorageHelper.getToken();

      final headers = {
        'x-api-key': AppConstant.apikey,
        'Authorization': 'Bearer $token',
      };

      final response = await http.delete(uri, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 204) {
        print('Product deleted successfully');
        return true;
      } else {
        print(
            'Failed to delete product:${response.body}');
        return false;
      }
    } catch (e) {
      print('Error in ProductService.deleteProduct: $e');
      return false;
    }
  }
}
