import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class AuthService {
  final String username = 'abc';
  final String password = '123';
  final String baseUrl = "https://e-commerce-server-zc33.onrender.com/api/users";


  Future<Map<String, dynamic>> signUp(UserModel user) async {
    final url = Uri.parse("$baseUrl/register");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(user.toJson()),
      );

      if ( response.statusCode == 201) {

        return jsonDecode(response.body);
      } else {
        throw 'Unable to create user';
      }
    } catch (e) {
      throw " $e";
    }
  }


  Future<Map<String, dynamic>> loginUser(UserModel user) async {
    final url = Uri.parse("$baseUrl/login");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {

        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to login user: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error during login: $e");
    }
  }



  Future<void> logout() async {
    await _simulateNetworkDelay();

     final prefs = await SharedPreferences.getInstance();
     await prefs.clear();


  }
   Future<void> _simulateNetworkDelay() async {
     await Future.delayed(const Duration(seconds: 2));
   }

}
