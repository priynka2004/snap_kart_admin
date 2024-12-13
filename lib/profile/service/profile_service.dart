import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/app_constant.dart';
import '../model/profile_updated_model.dart';
import '../../service/api_endpoint.dart';
import '../../service/storage_service.dart';


class ProfileService {

  Future<bool> updateProfile(ProfileUpdated profile) async {
    String? token = await StorageHelper.getToken();
    if (token == null) {
      print('Error: Token is null.');
      return false;
    }


    final headers = {
      'Content-Type': 'application/json',
      'x-api-key': "aihfj--qwnkqwr--jlkqwnjqw--jnkqwjnqwy",
      'Authorization': 'Bearer $token',
    };

    String url = ApiEndpoint.profileUpdate;
    Uri uri = Uri.parse(url);

    try {
      final response = await http.put(
        uri,
        headers: headers,
        body: jsonEncode(profile.toJson()),
      );

      if (response.statusCode == 200) {
        print('Profile updated successfully');
        return true;
      } else if (response.statusCode == 401) {
        print('Unauthorized: ${response.body}');
        // Handle token refresh or prompt user to re-login
        return false;
      } else {
        print('Failed to update profile: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error updating profile: $e');
      return false;
    }
  }


  Future<ProfileUpdated?> fetchProfile() async {
    String? token = await StorageHelper.getToken();
    if (token == null) {
      print('Error: Token is null.');
      return null;
    }

    final headers = {
      'Content-Type': 'application/json',
      'x-api-key': AppConstant.apikey,
      'Authorization': 'Bearer $token',
    };

    String url = ApiEndpoint.profileUpdate;
    Uri uri = Uri.parse(url);

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return ProfileUpdated.fromJson(jsonResponse);
      } else {
        print('Failed to fetch profile: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error fetching profile: $e');
      return null;
    }
  }
}
