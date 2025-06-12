import 'package:auto_mate/core/database/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? name;
  String? phone;
  bool isAuthenticated = false;
  bool hasInitialized = false;
  bool hasCompletedOnboarding = false;

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    // Check if onboarding was completed
    hasCompletedOnboarding = prefs.getBool('onboarding_done') ?? false;

    // Load user data from SQLite
    final user = await DBHelper.getUser();
    if (user != null) {
      name = user['name'];
      phone = user['phone'];
      isAuthenticated = true;
    } else {
      isAuthenticated = false;
    }

    hasInitialized = true;
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
    hasCompletedOnboarding = true;
    notifyListeners();
  }

  Future<void> login(String userName, String userPhone) async {
    await DBHelper.insertUser(userName, userPhone);
    name = userName;
    phone = userPhone;
    isAuthenticated = true;
    notifyListeners();
  }

  Future<void> logout() async {
    await DBHelper.clearUser();
    name = null;
    phone = null;
    isAuthenticated = false;
    notifyListeners();
  }
}
