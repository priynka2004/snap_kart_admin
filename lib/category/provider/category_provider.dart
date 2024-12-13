import 'dart:io';
import 'package:flutter/material.dart';
import '../model/add_category_model.dart';
import '../service/category_service.dart';
import '../../service/app_util.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> categoryList = [];
  String? errorMessage;


  Future<void> fetchCategories() async {
    try {
      categoryList = await CategoryService.fetchCategories();
      errorMessage = null;
      notifyListeners();
    } catch (e) {
      errorMessage = e is SocketException
          ? 'No Internet connection. Please try again later.'
          : e.toString();
      notifyListeners();
    }
  }

  Future<void> addCategory(Category category) async {
    try {
      bool success = await CategoryService.addCategory(category);
      if (success) {
        categoryList.add(category);
        AppUtil.showToast('Category added successfully');
      }
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      AppUtil.showToast('Failed to add category: $errorMessage');
    }
  }


  Future<void> deleteCategory(String sId) async {
    try {
      bool isSuccess = await CategoryService.deleteCategory(sId);
      if (isSuccess) {
        categoryList.removeWhere((category) => category.sId == sId);
        notifyListeners();
      } else {
        throw Exception('Failed to delete category.');
      }
    } catch (e) {
      print('Error deleting category: $e');
    }
  }




  Future<bool> updateCategory(String categoryId, String name, String description) async {
    try {
      bool success = await CategoryService.updateCategory(categoryId, name, description);
      if (success) {
        int index = categoryList.indexWhere((category) => category.sId == categoryId);
        if (index != -1) {
          categoryList[index] = Category(sId: categoryId, name: name,);
        }
        notifyListeners();
        return true;
      } else {
        errorMessage = 'Failed to update category';
        notifyListeners();
        return false;
      }
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

}


