// import 'package:http/http.dart' as http;
// import 'package:medical_user_app/constant/api_constants.dart';
// import 'package:medical_user_app/models/auth_response.dart';
// import 'dart:convert';


// class AuthService {
 

//   // Register user
//   static Future<AuthResponse> register({
//     required String name,
//     required String mobile,
//   }) async {
//     try {
//       final url = Uri.parse(ApiConstants.register);
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({
//           'name': name,
//           'mobile': mobile,
//         }),
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final data = json.decode(response.body);
//         return AuthResponse.fromJson(data);
//       } else {
//         throw Exception('Registration failed: ${response.body}');
//       }
//     } catch (e) {
//       throw Exception('Network error during registration: $e');
//     }
//   }

//   // Login user
//   static Future<AuthResponse> login({
//     required String mobile,
//   }) async {
//     try {
//       print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr${mobile}");

//       final url = Uri.parse(ApiConstants.login);
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({
//           'mobile': mobile,
//         }),
//       );

//       print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr${response.body}");

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         return AuthResponse.fromJson(data);
//       } else {
//         throw Exception('Login failed: ${response.body}');
//       }
//     } catch (e) {
//       throw Exception('Network error during login: $e');
//     }
//   }
// }



















import 'package:http/http.dart' as http;
import 'package:medical_user_app/constant/api_constants.dart';
import 'package:medical_user_app/models/auth_response.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';
import 'dart:convert';

class AuthService {
  static const String _tag = "AuthService";

  // Register user
  static Future<AuthResponse> register({
    required String name,
    required String mobile,
    required String email,
    String? fcmToken,  
  }) async {
    try {
      print('[$_tag] Starting registration for $mobile');
      
      // Validate inputs
      if (name.isEmpty || mobile.isEmpty) {
        throw Exception('Name and mobile cannot be empty');
      }

      final url = Uri.parse(ApiConstants.register);
      print('[$_tag] Register URL: $url');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'name': name.trim(),
          'mobile': mobile.trim(),
          'email':email.trim(),
            if (fcmToken != null) 'fcmToken': fcmToken, 
        }),
      ).timeout(const Duration(seconds: 30));

      print('[$_tag] Registration response: ${response.statusCode}');
      print('[$_tag] Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final data = json.decode(response.body);
          final authResponse = AuthResponse.fromJson(data);
          
          // Save auth data if response contains token and user
          if (authResponse.token != null && authResponse.user != null) {
            await SharedPreferencesHelper.saveAuthData(
              token: authResponse.token!,
              user: authResponse.user!,
            );
            print('[$_tag] Auth data saved successfully');
          } else {
            print('[$_tag] Warning: Missing token or user in response');
          }
          
          return authResponse;
        } catch (e) {
          throw Exception('Failed to parse response: $e');
        }
      } else {
        // Try to parse error message
        try {
          final errorData = json.decode(response.body);
          final errorMsg = errorData['message'] ?? response.body;
          throw Exception('Registration failed: $errorMsg');
        } catch (_) {
          throw Exception('Registration failed with status ${response.statusCode}');
        }
      }
    } on http.ClientException catch (e) {
      throw Exception('Network error: ${e.message}');
    } on FormatException catch (e) {
      throw Exception('Data parsing error: $e');
    } catch (e) {
      throw Exception('Unexpected error during registration: $e');
    }
  }

  // Login user
  static Future<AuthResponse> login({
    required String mobile,
    String? fcmToken, 
  }) async {
    try {
      print('[$_tag] Starting login for $mobile');
      
      // Validate input
      if (mobile.isEmpty) {
        throw Exception('Mobile number cannot be empty');
      }

      final url = Uri.parse(ApiConstants.login);
      print('[$_tag] Login URL: $url');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'mobile': mobile.trim(),
           if (fcmToken != null) 'fcmToken': fcmToken,
        }),
      ).timeout(const Duration(seconds: 30));

      print('[$_tag] Login response: ${response.statusCode}');
      print('[$_tag] Response body: ${response.body}');

      if (response.statusCode == 200) {
        try {
          final data = json.decode(response.body);
          final authResponse = AuthResponse.fromJson(data);
          
          // Save auth data if response contains token and user
          if (authResponse.token != null && authResponse.user != null) {
            await SharedPreferencesHelper.saveAuthData(
              token: authResponse.token!,
              user: authResponse.user!,
            );
            print('[$_tag] Auth data saved successfully');
          } else {
            print('[$_tag] Warning: Missing token or user in response');
          }
          
          return authResponse;
        } catch (e) {
          throw Exception('Failed to parse login response: $e');
        }
      } else {
        // Try to parse error message
        try {
          final errorData = json.decode(response.body);
          final errorMsg = errorData['message'] ?? response.body;
          throw Exception('Login failed: $errorMsg');
        } catch (_) {
          throw Exception('Login failed with status ${response.statusCode}');
        }
      }
    } on http.ClientException catch (e) {
      throw Exception('Network error: ${e.message}');
    } on FormatException catch (e) {
      throw Exception('Data parsing error: $e');
    } catch (e) {
      throw Exception('Unexpected error during login: $e');
    }
  }

  // Verify OTP and save auth data
  
  

  // Logout - Clear all auth data
  static Future<bool> logout() async {
    try {
      print('[$_tag] Logging out user');
      final success = await SharedPreferencesHelper.clearAuthData();
      print('[$_tag] Logout ${success ? 'successful' : 'failed'}');
      return success;
    } catch (e) {
      print('[$_tag] Error during logout: $e');
      return false;
    }
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    try {
      final loggedIn = await SharedPreferencesHelper.isLoggedIn();
      print('[$_tag] User is ${loggedIn ? '' : 'not '}logged in');
      return loggedIn;
    } catch (e) {
      print('[$_tag] Error checking login status: $e');
      return false;
    }
  }

  // Get current auth data
  static Future<Map<String, dynamic>> getAuthData() async {
    try {
      final authData = await SharedPreferencesHelper.getAuthData();
      print('[$_tag] Retrieved auth data: ${authData['user'] != null ? 'exists' : 'null'}');
      return authData;
    } catch (e) {
      print('[$_tag] Error getting auth data: $e');
      return {
        'token': null,
        'user': null,
        'isLoggedIn': false,
      };
    }
  }
}