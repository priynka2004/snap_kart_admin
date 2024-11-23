import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snap_kart_admin/auth/model/user_model.dart';
import 'package:snap_kart_admin/service/storage_service.dart';


import '../service/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  String? errorMessage;
  AuthService? authService;
  bool isLoading = false;

  Future<void> login(UserModel user) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final response = await AuthService().loginUser(user);

      if (response.containsKey('token')) {
        String token = response['token'];
        await StorageHelper.saveToken(token);

        notifyListeners();
      } else {
        throw Exception("Unexpected response: $response");
      }
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUpUser(UserModel user) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final response = await AuthService().signUp(user);

      if (response.containsKey('message') &&
          response['message'] == "User created successfully") {
        errorMessage = null;
        notifyListeners();
      } else if (response.containsKey('message')) {
        throw Exception(response['message']);
      } else {
        throw Exception("Unexpected response: $response");
      }
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Future<void> logout() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('authToken');
  //   notifyListeners();
  // }

  Future<void> logout() async {
    try {
      await StorageHelper.clearToken();


      var isAuthenticated = false;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      print("Error during logout: $errorMessage");
    }
  }

}
