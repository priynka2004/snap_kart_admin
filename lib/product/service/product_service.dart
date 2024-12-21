import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:snap_kart_admin/core/app_constant.dart';
import 'package:snap_kart_admin/service/api_endpoint.dart';
import 'package:snap_kart_admin/service/storage_service.dart';
import '../model/add_product_model.dart';


class ProductService {
  Future<List<ProductModel>> fetchProducts() async {
    String url = ApiEndpoint.getProduct;
    final response = await http
        .get(Uri.parse(url), headers: {'x-api-key':  AppConstant.apikey});
    if (response.statusCode == 200) {
      final maplist = jsonDecode(response.body);
      List<ProductModel> productList = [];
      for (int a = 0; a < maplist.length; a++) {
        final map = maplist[a];
        ProductModel product = ProductModel.fromJson(map);
        productList.add(product);
      }
      return productList;
    } else {
      throw 'Unavailable product';
    }
  }

  Future<bool> addProduct(ProductModel product) async {
    try {
      String? token = await StorageHelper.getToken();
      if (token == null || token.isEmpty) {
        print("Token is null or empty");
        return false;
      }


      final header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'x-api-key': AppConstant.apikey,
      };

      String url = ApiEndpoint.addProduct;
      Uri uri = Uri.parse(url);
      final response = await http.post(
        uri,
        body: jsonEncode(product.toJson()),
        headers: header,
      );

      if (response.statusCode == 201) {
        return true;
      } else if (response.statusCode == 401) {
        throw 'Unauthorized: Invalid or expired token.';
      } else {
        throw 'Failed with status code: ${response.statusCode}';
      }
    } catch (e) {
      print('Add product failed: $e');
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    String? token = await StorageHelper.getToken();
    final header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'x-api-key':  AppConstant.apikey,
    };
    String url =
    ApiEndpoint.deleteProduct(id);
    Uri uri = Uri.parse(url);

    try {
      final response = await http.delete(uri, headers: header);

      if (response.statusCode == 200) {
        return true;
      } else {
        throw 'Failed to delete product: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Error deleting product: $e';
    }
  }

  Future<bool> updateProducs(ProductModel updatedProduct) async {
    String? token = await StorageHelper.getToken();
    if (token == null || token.isEmpty) {
      throw 'Authentication token is missing.';
    }

    final headers = {
      'Content-Type': 'application/json',
     // 'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjczNWEwYjAyZTI3OTJhNmI2MDMwOWI2IiwidXNlcm5hbWUiOiJ0ZXN0dXNlciJ9LCJpYXQiOjE3MzI5ODE5NDAsImV4cCI6MTczMjk4NTU0MH0.ab8yqs_0A7ek13ra6jWWXhZVs8BJzFwum5JHE94WK2M',
      'x-api-key': AppConstant.apikey,
      'Authorization': 'Bearer $token',
    };

    String url = ApiEndpoint.updateProduct(updatedProduct.id!);
    Uri uri = Uri.parse(url);

    final body = updatedProduct.toJson();

    try {
      final response = await http.put(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        throw 'Invalid or expired token.';
      } else {
        throw 'Failed to update product: ${response.body}';
      }
    } catch (e) {
      throw 'Error updating product: $e';
    }
  }

}