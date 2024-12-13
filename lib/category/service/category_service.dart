import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/add_category_model.dart';
import '../../core/app_constant.dart';
import '../../service/api_endpoint.dart';
import '../../service/storage_service.dart';

class CategoryService {

  static Future<List<Category>> fetchCategories() async {
    String url = ApiEndpoint.getCategory;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'x-api-key': AppConstant.apikey},
      );
      print("API Response: ${response.statusCode} - ${response.body}");
      if (response.statusCode == 200) {
        final List<dynamic> mapList = jsonDecode(response.body);
        print("Parsed Categories: ${mapList.length}");
        return mapList.map((e) => Category.fromJson(e)).toList();
      } else {
        throw Exception(
            'No categories found. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print("Failed to fetch categories: $e");
      throw Exception('Failed to fetch categories: $e');
    }
  }



  static Future<bool> addCategory(Category category) async {
    try {
      String? token = await StorageHelper.getToken();
      String url = ApiEndpoint.addCategory;
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(category.toJson()),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'x-api-key': AppConstant.apikey,
        },
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Failed to add category. Response: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to add category: $e');
    }
  }


  static Future<bool> deleteCategory(String id) async {
    try {
      String? token = await StorageHelper.getToken();

      print("Retrieved Token: $token");


      Uri uri = Uri.parse(ApiEndpoint.deleteCategory(id));
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'x-api-key': AppConstant.apikey,
      };

      final response = await http.delete(uri, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        print('API Error: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error deleting category: $e');
      return false;
    }
  }


  static Future<bool> updateCategory(
      String categoryId, String name, String description) async {
    String? token = await StorageHelper.getToken();
    final url = Uri.parse("${ApiEndpoint.updateCategory}/$categoryId");

    final headers = {
      'x-api-key': AppConstant.apikey,
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = jsonEncode({
      'name': name,
      'description': description,
    });

    try {
      final response = await http.put(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw 'Failed to update category: ${response.body}';
      }
    } catch (e) {
      throw 'Error updating category: $e';
    }
  }
}
