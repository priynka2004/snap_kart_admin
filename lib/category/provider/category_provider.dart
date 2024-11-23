import 'package:flutter/material.dart';
import 'package:snap_kart_admin/category/model/add_category_model.dart';

import '../../service/app_util.dart';
import '../service/category_service.dart';


class CategoryProvider extends ChangeNotifier {

  List<Category> categoryList = [];


  CategoryService categoryService;
  String? errorMessage;

  CategoryProvider(this.categoryService);

  Future fetchCategory() async {
    try {
      categoryList = await categoryService.fetchCategory();
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }Future addCategory(Category category) async {
    try {
      bool success = await categoryService.addCategory(category);
      if (success) {
        notifyListeners();
        AppUtil.showToast('Category Add Successfully');
      }
    } catch (e) {
      notifyListeners();
      AppUtil.showToast(e.toString());
    }
  }
  Future<void> deleteAllCategories() async {
    try {
      CategoryService().deleteCategory;
      categoryList.clear();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete all categories');
    }
  }

}