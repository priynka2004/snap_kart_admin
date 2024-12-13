import 'package:flutter/cupertino.dart';
import '../model/profile_updated_model.dart';
import '../service/profile_service.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileService _profileService = ProfileService();
  ProfileUpdated? _profile;
  String? _errorMessage;

  ProfileUpdated? get profile => _profile;
  String? get errorMessage => _errorMessage;

  void setProfile(ProfileUpdated profile) {
    _profile = profile;
    notifyListeners();
  }

  Future<bool> updateProfile(ProfileUpdated updatedProfile) async {
    final success = await _profileService.updateProfile(updatedProfile);
    if (success) {
      _profile = updatedProfile;
      notifyListeners();
    } else {
      _errorMessage = 'Failed to update profile';
    }
    return success;
  }


  Future<void> fetchProfile() async {
    try {

      final profile = await _profileService.fetchProfile();
      if (profile != null) {
        _profile = profile;
        notifyListeners();
      } else {
        _errorMessage = 'Failed to fetch profile';
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
