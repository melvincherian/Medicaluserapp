import 'package:flutter/material.dart';
import 'package:medical_user_app/models/auth_response.dart';
import 'package:medical_user_app/providers/profile_provider.dart';
import 'package:medical_user_app/services/auth_service.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

class AuthProvider with ChangeNotifier {
  AuthStatus _status = AuthStatus.initial;
  AuthStatus get status => _status;

  AuthResponse? _authResponse;
  AuthResponse? get authResponse => _authResponse;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Register
  Future<void> register({
    required String name,
    required String mobile,
    required String email,
  }) async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      final response =
          await AuthService.register(name: name, mobile: mobile, email: email);
      _authResponse = response;

      // Save token to shared preferences if needed
      if (response.token != null) {
        await SharedPreferencesHelper.saveToken(response.token!);
      }

      _status = AuthStatus.authenticated;
    } catch (e) {
      _errorMessage = e.toString();
      _status = AuthStatus.error;
    }

    notifyListeners();
  }

  // Login
  Future<void> login({required String mobile}) async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      final response = await AuthService.login(mobile: mobile);
      _authResponse = response;

      if (response.token != null) {
        await SharedPreferencesHelper.saveToken(response.token!);
      }

      _status = AuthStatus.authenticated;
    } catch (e) {
      _errorMessage = e.toString();
      _status = AuthStatus.error;
    }

    notifyListeners();
  }

  // Logout
  // Future<void> logout() async {
  //   await SharedPreferencesHelper.clearAuthData();
  //   _authResponse = null;
  //   _status = AuthStatus.unauthenticated;
  //   notifyListeners();
  // }

  Future<void> logout(BuildContext context) async {
    // Clear saved tokens
    await SharedPreferencesHelper.clearAuthData();

    // Clear profile data
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.clearUser();

    // Clear auth response
    _authResponse = null;
    _status = AuthStatus.unauthenticated;

    notifyListeners();
  }
}
