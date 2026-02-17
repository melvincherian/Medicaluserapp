
import 'dart:convert';
import 'package:medical_user_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _keyToken = 'auth_token';
  static const String _keyUser = 'user_data';
  static const String _keyIsLoggedIn = 'is_logged_in';

  static SharedPreferences? _prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Save auth token
  static Future<bool> saveToken(String token) async {
    try {
      await init();
      if (token.isEmpty) {
        print('Warning: Attempting to save empty token');
        return false;
      }
      final result = await _prefs!.setString(_keyToken, token);
      print('Token saved: $result');
      return result;
    } catch (e) {
      print('Error saving token: $e');
      return false;
    }
  }

  // Get auth token
  static Future<String?> getToken() async {
    try {
      await init();
      final token = _prefs!.getString(_keyToken);
      print('Retrieved token: ${token != null ? 'Found' : 'Not found'}');
      return token;
    } catch (e) {
      print('Error getting token: $e');
      return null;
    }
  }

  // Save user data
  static Future<bool> saveUser(User user) async {
    try {
      print('=== SAVE USER CALLED ===');
      print('User object received: ${user.toString()}');
      
      await init();
      print('SharedPreferences initialized');
      
      // Validate user data before saving
      if (user.id.isEmpty || user.name.isEmpty) {
        print('ERROR: User has empty required fields - ID: "${user.id}", Name: "${user.name}"');
        print('Full user data: ID="${user.id}", Name="${user.name}", Mobile="${user.mobile}", Code="${user.code}"');
      }
      
      final userMap = user.toJson();
      print('User converted to Map: $userMap');
      
      String userJson = json.encode(userMap);
      print('User converted to JSON string: $userJson');
      print('JSON string length: ${userJson.length}');
      
      print('About to call _prefs!.setString with key: $_keyUser');
      final result = await _prefs!.setString(_keyUser, userJson);
      print('SharedPreferences.setString returned: $result');
      
      // Verify the save by immediately reading it back
      final verifyJson = _prefs!.getString(_keyUser);
      print('Immediate verification read: $verifyJson');
      
      if (verifyJson != userJson) {
        print('ERROR: Verification failed! Saved data does not match!');
        print('Expected: $userJson');
        print('Got: $verifyJson');
        return false;
      }
      
      print('=== SAVE USER COMPLETED SUCCESSFULLY ===');
      return result;
    } catch (e) {
      print('=== ERROR IN SAVE USER ===');
      print('Error saving user: $e');
      print('Error type: ${e.runtimeType}');
      print('Stack trace: ${StackTrace.current}');
      print('=== END ERROR ===');
      return false;
    }
  }

  // Get user data
  static Future<User?> getUser() async {
    try {
      await init();
      String? userJson = _prefs!.getString(_keyUser);
      print('Retrieved user JSON: $userJson');
      
      if (userJson == null || userJson.isEmpty) {
        print('No user data found in SharedPreferences');
        return null;
      }

      try {
        Map<String, dynamic> userMap = json.decode(userJson);
        print('Decoded user map: $userMap');
        
        // Validate required fields exist
        if (!userMap.containsKey('id') || !userMap.containsKey('name')) {
          print('Error: User data missing required fields');
          return null;
        }
        
        final user = User.fromJson(userMap);
        print('Created user object: ${user.name} (ID: ${user.id})');
        return user;
      } catch (jsonError) {
        print('Error parsing user JSON: $jsonError');
        // Clear corrupted data
        await _prefs!.remove(_keyUser);
        print('Cleared corrupted user data');
        return null;
      }
    } catch (e) {
      print('Error getting user: $e');
      print('Stack trace: ${StackTrace.current}');
      return null;
    }
  }

  // Save login status
  static Future<bool> setLoggedIn(bool isLoggedIn) async {
    try {
      await init();
      final result = await _prefs!.setBool(_keyIsLoggedIn, isLoggedIn);
      print('Login status saved: $result (value: $isLoggedIn)');
      return result;
    } catch (e) {
      print('Error saving login status: $e');
      return false;
    }
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    try {
      await init();
      final result = _prefs!.getBool(_keyIsLoggedIn) ?? false;
      print('Is logged in: $result');
      return result;
    } catch (e) {
      print('Error checking login status: $e');
      return false;
    }
  }

  // Save complete auth data with validation
  static Future<bool> saveAuthData({
    required String token,
    required User user,
  }) async {
    try {
      print('=== STARTING SAVE AUTH DATA ===');
      print('Method called with:');
      print('- Token length: ${token.length}');
      print('- Token preview: ${token.substring(0, 20)}...');
      print('- User: ${user.toString()}');
      
      await init();
      print('SharedPreferences initialized for auth data save');
      
      // Validate inputs
      if (token.isEmpty) {
        print('ERROR: Cannot save empty token');
        return false;
      }
      
      if (user.id.isEmpty || user.name.isEmpty) {
        print('ERROR: User has empty required fields');
        print('User ID: "${user.id}" (empty: ${user.id.isEmpty})');
        print('User name: "${user.name}" (empty: ${user.name.isEmpty})');
        return false;
      }
      
      print('Input validation passed, proceeding with saves...');
      
      // Save data sequentially to ensure each step succeeds
      print('Step 1: Saving token...');
      final tokenSaved = await saveToken(token);
      print('Token save result: $tokenSaved');
      if (!tokenSaved) {
        print('ABORT: Failed to save token');
        return false;
      }
      
      print('Step 2: Saving user...');
      final userSaved = await saveUser(user);
      print('User save result: $userSaved');
      if (!userSaved) {
        print('ABORT: Failed to save user');
        return false;
      }
      
      print('Step 3: Setting login status...');
      final loginStatusSaved = await setLoggedIn(true);
      print('Login status save result: $loginStatusSaved');
      if (!loginStatusSaved) {
        print('ABORT: Failed to save login status');
        return false;
      }
      
      print('=== ALL AUTH DATA SAVED SUCCESSFULLY ===');
      
      // Final verification
      print('=== FINAL VERIFICATION ===');
      await debugAuthData();
      
      return true;
    } catch (e) {
      print('=== CRITICAL ERROR IN SAVE AUTH DATA ===');
      print('Error: $e');
      print('Error type: ${e.runtimeType}');
      print('Stack trace: ${StackTrace.current}');
      print('=== END CRITICAL ERROR ===');
      return false;
    }
  }

  // Clear all auth data (logout)
  static Future<bool> clearAuthData() async {
    try {
      await init();
      print('=== Clearing auth data ===');
      
      final results = await Future.wait([
        _prefs!.remove(_keyToken),
        _prefs!.remove(_keyUser),
        _prefs!.setBool(_keyIsLoggedIn, false),
      ]);
      
      final success = results.every((result) => result);
      print('Auth data cleared: $success');
      
      // Verify clearing
      if (success) {
        await debugAuthData();
      }
      
      return success;
    } catch (e) {
      print('Error clearing auth data: $e');
      return false;
    }
  }


  // Add this method to your SharedPreferencesHelper class
static Future<bool> clearUser() async {
  try {
    await init();
    print('=== Clearing user data ===');
    final result = await _prefs!.remove(_keyUser);
    print('User data cleared: $result');
    return result;
  } catch (e) {
    print('Error clearing user data: $e');
    return false;
  }
}

  // Get complete auth data
  static Future<Map<String, dynamic>> getAuthData() async {
    try {
      await init();
      print('=== Getting complete auth data ===');
      
      final token = await getToken();
      final user = await getUser();
      final loggedIn = await isLoggedIn();

      final authData = {
        'token': token,
        'user': user,
        'isLoggedIn': loggedIn,
      };
      
      print('Complete auth data retrieved:');
      print('- Token: ${token != null ? 'Present' : 'Null'}');
      print('- User: ${user != null ? '${user.name} (${user.id})' : 'Null'}');
      print('- Logged in: $loggedIn');
      
      return authData;
    } catch (e) {
      print('Error getting auth data: $e');
      return {
        'token': null,
        'user': null,
        'isLoggedIn': false,
      };
    }
  }

  // Debug method to check auth-related data only
  static Future<void> debugAuthData() async {
    try {
      await init();
      print('=== AUTH DATA DEBUG ===');
      print('Token: ${_prefs!.getString(_keyToken) ?? 'NULL'}');
      print('User JSON: ${_prefs!.getString(_keyUser) ?? 'NULL'}');
      print('Is Logged In: ${_prefs!.getBool(_keyIsLoggedIn) ?? false}');
      print('=== END AUTH DEBUG ===');
    } catch (e) {
      print('Error in auth debug: $e');
    }
  }

  // Debug method to check all stored data
  static Future<void> debugAllData() async {
    try {
      await init();
      final keys = _prefs!.getKeys();
      print('=== ALL SHARED PREFERENCES DATA ===');
      for (String key in keys) {
        final value = _prefs!.get(key);
        print('$key: $value');
      }
      print('=== END DEBUG DATA ===');
    } catch (e) {
      print('Error in debug: $e');
    }
  }

  // Helper method to validate if auth data is complete and valid
  static Future<bool> validateAuthData() async {
    try {
      final authData = await getAuthData();
      final token = authData['token'] as String?;
      final user = authData['user'] as User?;
      final isLoggedIn = authData['isLoggedIn'] as bool;

      final isValid = token != null && 
                      token.isNotEmpty && 
                      user != null && 
                      user.id.isNotEmpty && 
                      user.name.isNotEmpty && 
                      isLoggedIn;

      print('Auth data validation result: $isValid');
      if (!isValid) {
        print('Validation failed:');
        print('- Token valid: ${token != null && token.isNotEmpty}');
        print('- User valid: ${user != null && user.id.isNotEmpty && user.name.isNotEmpty}');
        print('- Is logged in: $isLoggedIn');
      }

      return isValid;
    } catch (e) {
      print('Error validating auth data: $e');
      return false;
    }
  }

  // Method to trace all operations on user data
  static Future<void> traceUserDataOperations() async {
    try {
      await init();
      print('=== USER DATA TRACE ===');
      
      // Check if user key exists at all
      final keys = _prefs!.getKeys();
      final hasUserKey = keys.contains(_keyUser);
      print('SharedPreferences contains user key "$_keyUser": $hasUserKey');
      
      if (hasUserKey) {
        final userData = _prefs!.getString(_keyUser);
        print('Raw user data: $userData');
        print('User data type: ${userData.runtimeType}');
        print('User data length: ${userData?.length ?? 0}');
      } else {
        print('User key not found in SharedPreferences');
        print('Available keys: $keys');
      }
      
      print('=== END USER DATA TRACE ===');
    } catch (e) {
      print('Error in trace: $e');
    }
  }

  // Force clear and re-save method for testing
  static Future<bool> forceSaveUser(User user) async {
    try {
      await init();
      print('=== FORCE SAVE USER ===');
      
      // First, clear any existing user data
      final clearResult = await _prefs!.remove(_keyUser);
      print('Cleared existing user data: $clearResult');
      
      // Verify it's cleared
      final afterClear = _prefs!.getString(_keyUser);
      print('After clear, user data: $afterClear');
      
      // Now save the new user
      final userJson = json.encode(user.toJson());
      print('Saving user JSON: $userJson');
      
      final saveResult = await _prefs!.setString(_keyUser, userJson);
      print('Save result: $saveResult');
      
      // Immediate verification
      final verification = _prefs!.getString(_keyUser);
      print('Verification: $verification');
      
      print('=== END FORCE SAVE ===');
      return saveResult;
    } catch (e) {
      print('Error in force save: $e');
      return false;
    }
  }
}