import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:snap_kart_admin/category/model/add_category_model.dart';
import '../../core/app_constant.dart';
import '../../service/api_endpoint.dart';
import '../../service/storage_service.dart';

class CategoryService {

  Future<List<Category>> fetchCategory() async {
    String url = ApiEndpoint.getCategory;
    final response = await http
        .get(Uri.parse(url), headers: {'x-api-key': AppConstant.apikey});
    if (response.statusCode == 200) {
      final maplist = jsonDecode(response.body);
      List<Category> categoryList = [];
      for (int a = 0; a < maplist.length; a++) {
        final map = maplist[a];
        Category category = Category.fromJson(map);
        categoryList.add(category);
      }
      return categoryList;
    } else {
      throw 'No Available Category';
    }
  }

  Future<bool> addCategory(Category category) async {
    String? token = await StorageHelper.getToken();
    String url = ApiEndpoint.addCategory;
    String jsoncategory = jsonEncode(category.toJson());
    final response =
        await http.post(Uri.parse(url), body: jsoncategory, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'x-api-key': AppConstant.apikey
    });
    if (response.statusCode == 201) {
      return true;
    } else {
      throw 'Something Went Wrong';
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      String url = ApiEndpoint.deleteProduct;
      final response = await http
          .get(Uri.parse(url), headers: {'x-api-key': AppConstant.apikey});

      if (response.statusCode == 200) {
        print('Category deleted successfully');
      } else {
        print('Error deleting category with ID $id.'
            'Body: ${response.body}');
        throw Exception('Failed to delete category with ID $id');
      }
    } catch (e) {
      print('Error deleting category: $e');
      throw Exception('Error deleting category: $e');
    }
  }
}
