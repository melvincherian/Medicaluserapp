// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:medical_user_app/models/user_model.dart';
// // import 'package:medical_user_app/services/profile_service.dart';
// // import 'package:medical_user_app/utils/shared_preferences_helper.dart';

// // class ProfileProvider with ChangeNotifier {
// //   User? _user;
// //   bool _isLoading = false;
// //   String? _errorMessage;
// //   bool _isUpdating = false;

// //   // Getters
// //   User? get user => _user;
// //   bool get isLoading => _isLoading;
// //   String? get errorMessage => _errorMessage;
// //   bool get isUpdating => _isUpdating;

// //   // Initialize provider with stored user data
// //   Future<void> initializeUser() async {
// //     _setLoading(true);
// //     try {
// //       final storedUser = await SharedPreferencesHelper.getUser();
// //       if (storedUser != null) {
// //         _user = storedUser;
// //         _clearError();
// //         print('User initialized from storage: ${_user?.name}');
// //       } else {
// //         _setError('No user data found');
// //       }
// //     } catch (e) {
// //       _setError('Error initializing user: ${e.toString()}');
// //       print('Error in initializeUser: $e');
// //     }
// //     _setLoading(false);
// //   }

// //   // Fetch user profile from API
// //   Future<bool> fetchUserProfile() async {
// //     if (_user?.id == null) {
// //       _setError('No user ID available');
// //       return false;
// //     }

// //     _setLoading(true);
// //     try {
// //       final result = await ProfileService.getUserProfile(_user!.id);

// //       if (result['success']) {
// //         final userData = result['user'];
// //         _user = User.fromJson(userData);

// //         // Update stored user data
// //         await SharedPreferencesHelper.saveUser(_user!);
// //         _clearError();

// //         print('Profile fetched successfully: ${_user?.name}');
// //         return true;
// //       } else {
// //         _setError(result['message']);
// //         return false;
// //       }
// //     } catch (e) {
// //       _setError('Error fetching profile: ${e.toString()}');
// //       print('Error in fetchUserProfile: $e');
// //       return false;
// //     } finally {
// //       _setLoading(false);
// //     }
// //   }

// //   // Update user profile data
// //   Future<bool> updateUserProfile({
// //     required String name,
// //     required String mobile,
// //   }) async {
// //     if (_user?.id == null) {
// //       _setError('No user ID available');
// //       return false;
// //     }

// //     _setUpdating(true);
// //     try {
// //       final result = await ProfileService.updateUserData(_user!.id, name, mobile);

// //       if (result['success']) {
// //         final userData = result['user'];
// //         _user = User.fromJson(userData);

// //         // Update stored user data
// //         await SharedPreferencesHelper.saveUser(_user!);
// //         _clearError();

// //         print('Profile updated successfully: ${_user?.name}');
// //         return true;
// //       } else {
// //         _setError(result['message']);
// //         return false;
// //       }
// //     } catch (e) {
// //       _setError('Error updating profile: ${e.toString()}');
// //       print('Error in updateUserProfile: $e');
// //       return false;
// //     } finally {
// //       _setUpdating(false);
// //     }
// //   }

// //   // Update profile image
// //   Future<bool> updateProfileImage(File imageFile) async {
// //     if (_user?.id == null) {
// //       _setError('No user ID available');
// //       return false;
// //     }

// //     _setUpdating(true);
// //     try {
// //       final result = await ProfileService.updateProfileImage(_user!.id, imageFile);

// //       if (result['success']) {
// //         final userData = result['user'];
// //         _user = User.fromJson(userData);

// //         // Update stored user data
// //         await SharedPreferencesHelper.saveUser(_user!);
// //         _clearError();

// //         print('Profile image updated successfully');
// //         return true;
// //       } else {
// //         _setError(result['message']);
// //         return false;
// //       }
// //     } catch (e) {
// //       _setError('Error updating profile image: ${e.toString()}');
// //       print('Error in updateProfileImage: $e');
// //       return false;
// //     } finally {
// //       _setUpdating(false);
// //     }
// //   }

// //   // Update complete profile (data + image)
// //   Future<bool> updateCompleteProfile({
// //     required String name,
// //     required String mobile,
// //     File? profileImage,
// //   }) async {
// //     if (_user?.id == null) {
// //       _setError('No user ID available');
// //       return false;
// //     }

// //     _setUpdating(true);
// //     try {
// //       final result = await ProfileService.updateCompleteProfile(
// //         userId: _user!.id,
// //         name: name,
// //         mobile: mobile,
// //         profileImage: profileImage,
// //       );

// //       if (result['success']) {
// //         final userData = result['user'];
// //         _user = User.fromJson(userData);

// //         // Update stored user data
// //         await SharedPreferencesHelper.saveUser(_user!);
// //         _clearError();

// //         print('Complete profile updated successfully: ${_user?.name}');
// //         return true;
// //       } else {
// //         _setError(result['message']);
// //         return false;
// //       }
// //     } catch (e) {
// //       _setError('Error updating complete profile: ${e.toString()}');
// //       print('Error in updateCompleteProfile: $e');
// //       return false;
// //     } finally {
// //       _setUpdating(false);
// //     }
// //   }

// //   // Update user locally (for immediate UI updates)
// //   void updateUserLocally({
// //     String? name,
// //     String? mobile,
// //     String? profileImage,
// //   }) {
// //     if (_user != null) {
// //       _user =User(
// //         id: _user!.id,
// //         name: name ?? _user!.name,
// //         mobile: mobile ?? _user!.mobile,
// //         code: _user!.code,
// //         profileImage: profileImage ?? _user!.profileImage,
// //         createdAt: _user!.createdAt,
// //         updatedAt: DateTime.now(),
// //       );
// //       notifyListeners();
// //     }
// //   }

// //   // Clear error message
// //   void clearError() {
// //     _clearError();
// //   }

// //   // Refresh user data
// //   Future<bool> refreshUserData() async {
// //     return await fetchUserProfile();
// //   }

// //   // Private helper methods
// //   void _setLoading(bool loading) {
// //     _isLoading = loading;
// //     notifyListeners();
// //   }

// //   void _setUpdating(bool updating) {
// //     _isUpdating = updating;
// //     notifyListeners();
// //   }

// //   void _setError(String error) {
// //     _errorMessage = error;
// //     notifyListeners();
// //   }

// //   void _clearError() {
// //     _errorMessage = null;
// //     notifyListeners();
// //   }

// //   // Reset provider state
// //   void reset() {
// //     _user = null;
// //     _isLoading = false;
// //     _isUpdating = false;
// //     _errorMessage = null;
// //     notifyListeners();
// //   }

// //   // Validation methods
// //   bool isValidName(String name) {
// //     return name.trim().isNotEmpty && name.length >= 2;
// //   }

// //   bool isValidMobile(String mobile) {
// //     // Remove any non-digit characters for validation
// //     final cleanMobile = mobile.replaceAll(RegExp(r'[^\d]'), '');
// //     return cleanMobile.length >= 10;
// //   }

// //   bool isValidEmail(String email) {
// //     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
// //     return emailRegex.hasMatch(email.trim());
// //   }

// //   // Get user display name
// //   String getDisplayName() {
// //     return _user?.name ?? 'User';
// //   }

// //   // Get user profile image
// //   String? getProfileImageUrl() {
// //     return _user?.profileImage;
// //   }

// //   // Check if user has profile image
// //   bool hasProfileImage() {
// //     final imageUrl = _user?.profileImage;
// //     return imageUrl != null && imageUrl.isNotEmpty;
// //   }
// // }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:medical_user_app/models/user_model.dart';
// import 'package:medical_user_app/services/profile_service.dart';
// import 'package:medical_user_app/utils/shared_preferences_helper.dart';

// class ProfileProvider with ChangeNotifier {
//   User? _user;
//   bool _isLoading = false;
//   String? _errorMessage;
//   bool _isUpdating = false;

//   // Getters
//   User? get user => _user;
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   bool get isUpdating => _isUpdating;

//   // Initialize provider with stored user data
//   Future<void> initializeUser() async {
//     _setLoading(true);
//     try {
//       final storedUser = await SharedPreferencesHelper.getUser();
//       if (storedUser != null) {
//         _user = storedUser;
//         _clearError();
//         print('User initialized from storage: ${_user?.name}');
//       } else {
//         _setError('No user data found');
//       }
//     } catch (e) {
//       _setError('Error initializing user: ${e.toString()}');
//       print('Error in initializeUser: $e');
//     }
//     _setLoading(false);
//   }

//   // Fetch user profile from API
//   Future<bool> fetchUserProfile() async {
//     if (_user?.id == null) {
//       _setError('No user ID available');
//       return false;
//     }

//     _setLoading(true);
//     try {
//       final result = await ProfileService.getUserProfile(_user!.id);

//       if (result['success']) {
//         final userData = result['user'];
//         _user = User.fromJson(userData);

//         // Update stored user data
//         await SharedPreferencesHelper.saveUser(_user!);
//         _clearError();

//         print('Profile fetched successfully: ${_user?.name}');
//         return true;
//       } else {
//         _setError(result['message']);
//         return false;
//       }
//     } catch (e) {
//       _setError('Error fetching profile: ${e.toString()}');
//       print('Error in fetchUserProfile: $e');
//       return false;
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Update user profile data
//   Future<bool> updateUserProfile({
//     required String name,
//     required String mobile,
//   }) async {
//     if (_user?.id == null) {
//       _setError('No user ID available');
//       return false;
//     }

//     _setUpdating(true);
//     try {
//       final result = await ProfileService.updateUserData(_user!.id, name, mobile);

//       if (result['success']) {
//         final userData = result['user'];
//         final updatedUser = User.fromJson(userData);

//         // Only update if data actually changed to prevent unnecessary rebuilds
//         if (_user?.name != updatedUser.name ||
//             _user?.mobile != updatedUser.mobile ||
//             _user?.profileImage != updatedUser.profileImage) {
//           _user = updatedUser;

//           // Update stored user data
//           await SharedPreferencesHelper.saveUser(_user!);
//           _clearError();

//           print('Profile updated successfully: ${_user?.name}');
//           notifyListeners(); // Notify only when data changes
//         }

//         return true;
//       } else {
//         _setError(result['message']);
//         return false;
//       }
//     } catch (e) {
//       _setError('Error updating profile: ${e.toString()}');
//       print('Error in updateUserProfile: $e');
//       return false;
//     } finally {
//       _setUpdating(false);
//     }
//   }

//   // Update profile image
//   Future<bool> updateProfileImage(File imageFile) async {
//     if (_user?.id == null) {
//       _setError('No user ID available');
//       return false;
//     }

//     _setUpdating(true);
//     try {
//       final result = await ProfileService.updateProfileImage(_user!.id, imageFile);

//       if (result['success']) {
//         final userData = result['user'];
//         final updatedUser = User.fromJson(userData);

//         // Only update if profile image actually changed
//         if (_user?.profileImage != updatedUser.profileImage) {
//           _user = updatedUser;

//           // Update stored user data
//           await SharedPreferencesHelper.saveUser(_user!);
//           _clearError();

//           print('Profile image updated successfully');
//           notifyListeners(); // Notify only when data changes
//         }

//         return true;
//       } else {
//         _setError(result['message']);
//         return false;
//       }
//     } catch (e) {
//       _setError('Error updating profile image: ${e.toString()}');
//       print('Error in updateProfileImage: $e');
//       return false;
//     } finally {
//       _setUpdating(false);
//     }
//   }

//   // Update complete profile (data + image)
//   Future<bool> updateCompleteProfile({
//     required String name,
//     required String mobile,
//     File? profileImage,
//   }) async {
//     if (_user?.id == null) {
//       _setError('No user ID available');
//       return false;
//     }

//     _setUpdating(true);
//     try {
//       final result = await ProfileService.updateCompleteProfile(
//         userId: _user!.id,
//         name: name,
//         mobile: mobile,
//         profileImage: profileImage,
//       );

//       if (result['success']) {
//         final userData = result['user'];
//         final updatedUser = User.fromJson(userData);

//         // Only update if data actually changed
//         if (_user?.name != updatedUser.name ||
//             _user?.mobile != updatedUser.mobile ||
//             _user?.profileImage != updatedUser.profileImage) {
//           _user = updatedUser;

//           // Update stored user data
//           await SharedPreferencesHelper.saveUser(_user!);
//           _clearError();

//           print('Complete profile updated successfully: ${_user?.name}');
//           notifyListeners(); // Notify only when data changes
//         }

//         return true;
//       } else {
//         _setError(result['message']);
//         return false;
//       }
//     } catch (e) {
//       _setError('Error updating complete profile: ${e.toString()}');
//       print('Error in updateCompleteProfile: $e');
//       return false;
//     } finally {
//       _setUpdating(false);
//     }
//   }

//   // Update user locally (for immediate UI updates)
//   void updateUserLocally({
//     String? name,
//     String? mobile,
//     String? profileImage,
//   }) {
//     if (_user != null) {
//       _user = User(
//         id: _user!.id,
//         name: name ?? _user!.name,
//         mobile: mobile ?? _user!.mobile,
//         code: _user!.code,
//         profileImage: profileImage ?? _user!.profileImage,
//         createdAt: _user!.createdAt,
//         updatedAt: DateTime.now(),
//       );
//       notifyListeners();
//     }
//   }

//   // Clear error message
//   void clearError() {
//     _clearError();
//   }

//   // Refresh user data
//   Future<bool> refreshUserData() async {
//     return await fetchUserProfile();
//   }

//   // Private helper methods
//   void _setLoading(bool loading) {
//     if (_isLoading != loading) {
//       _isLoading = loading;
//       notifyListeners();
//     }
//   }

//   void _setUpdating(bool updating) {
//     if (_isUpdating != updating) {
//       _isUpdating = updating;
//       notifyListeners();
//     }
//   }

//   void _setError(String error) {
//     _errorMessage = error;
//     notifyListeners();
//   }

//   void _clearError() {
//     if (_errorMessage != null) {
//       _errorMessage = null;
//       notifyListeners();
//     }
//   }

//   // Reset provider state
//   void reset() {
//     _user = null;
//     _isLoading = false;
//     _isUpdating = false;
//     _errorMessage = null;
//     notifyListeners();
//   }

//   // Validation methods
//   bool isValidName(String name) {
//     return name.trim().isNotEmpty && name.length >= 2;
//   }

//   bool isValidMobile(String mobile) {
//     // Remove any non-digit characters for validation
//     final cleanMobile = mobile.replaceAll(RegExp(r'[^\d]'), '');
//     return cleanMobile.length >= 10;
//   }

//   bool isValidEmail(String email) {
//     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//     return emailRegex.hasMatch(email.trim());
//   }

//   // Get user display name
//   String getDisplayName() {
//     return _user?.name ?? 'User';
//   }

//   // Get user profile image
//   String? getProfileImageUrl() {
//     return _user?.profileImage;
//   }

//   // Check if user has profile image
//   bool hasProfileImage() {
//     final imageUrl = _user?.profileImage;
//     return imageUrl != null && imageUrl.isNotEmpty;
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medical_user_app/models/user_model.dart';
import 'package:medical_user_app/services/profile_service.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';

class ProfileProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isUpdating = false;

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isUpdating => _isUpdating;

  // Initialize provider with stored user data
  Future<void> initializeUser() async {
    _setLoading(true);
    try {
      final storedUser = await SharedPreferencesHelper.getUser();
      if (storedUser != null) {
        _user = storedUser;
        _clearError();
        print('User initialized from storage: ${_user?.name}');
      } else {
        _setError('No user data found');
      }
    } catch (e) {
      _setError('Error initializing user: ${e.toString()}');
      print('Error in initializeUser: $e');
    }
    _setLoading(false);
  }

  // Fetch user profile from API
  Future<bool> fetchUserProfile() async {
    if (_user?.id == null) {
      _setError('No user ID available');
      return false;
    }

    _setLoading(true);
    try {
      final result = await ProfileService.getUserProfile(_user!.id);

      if (result['success']) {
        final userData = result['user'];
        final fetchedUser = User.fromJson(userData);

        // Preserve existing data if API returns empty values
        _user = _mergeUserData(_user!, fetchedUser);

        // Update stored user data
        await SharedPreferencesHelper.saveUser(_user!);
        _clearError();

        print('Profile fetched successfully: ${_user?.name}');
        notifyListeners();
        return true;
      } else {
        _setError(result['message']);
        return false;
      }
    } catch (e) {
      _setError('Error fetching profile: ${e.toString()}');
      print('Error in fetchUserProfile: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Update user profile data
  Future<bool> updateUserProfile({
    required String name,
    required String mobile,
  }) async {
    if (_user?.id == null) {
      _setError('No user ID available');
      return false;
    }

    // Store the input values to preserve them
    final inputName = name.trim();
    final inputMobile = mobile.trim();

    _setUpdating(true);
    try {
      final result = await ProfileService.updateUserData(
          _user!.id, inputName, inputMobile);

      if (result['success']) {
        final userData = result['user'];
        final updatedUser = User.fromJson(userData);

        // Create a merged user that preserves the input values if API returns empty
        final mergedUser = User(
          id: updatedUser.id.isNotEmpty ? updatedUser.id : _user!.id,
          name: updatedUser.name.isNotEmpty ? updatedUser.name : inputName,
          mobile:
              updatedUser.mobile.isNotEmpty ? updatedUser.mobile : inputMobile,
          email: updatedUser.email.isNotEmpty ? updatedUser.email : inputMobile,
          code: updatedUser.code.isNotEmpty ? updatedUser.code : _user!.code,
          profileImage: updatedUser.profileImage ?? _user!.profileImage,
          createdAt: updatedUser.createdAt ?? _user!.createdAt,
          updatedAt: updatedUser.updatedAt ?? DateTime.now(),
        );

        // Only update if data actually changed
        if (_user?.name != mergedUser.name ||
            _user?.mobile != mergedUser.mobile ||
            _user?.profileImage != mergedUser.profileImage) {
          _user = mergedUser;

          // Update stored user data
          await SharedPreferencesHelper.saveUser(_user!);
          _clearError();

          print('Profile updated successfully: ${_user?.name}');
          notifyListeners(); // Notify only when data changes
        }

        return true;
      } else {
        _setError(result['message']);
        return false;
      }
    } catch (e) {
      _setError('Error updating profile: ${e.toString()}');
      print('Error in updateUserProfile: $e');
      return false;
    } finally {
      _setUpdating(false);
    }
  }

  // Update profile image
  Future<bool> updateProfileImage(File imageFile) async {
    if (_user?.id == null) {
      _setError('No user ID available');
      return false;
    }

    _setUpdating(true);
    try {
      final result =
          await ProfileService.updateProfileImage(_user!.id, imageFile);

      if (result['success']) {
        final userData = result['user'];
        final updatedUser = User.fromJson(userData);

        // Merge with existing data to preserve name and mobile
        final mergedUser = _mergeUserData(_user!, updatedUser);

        // Only update if profile image actually changed
        if (_user?.profileImage != mergedUser.profileImage) {
          _user = mergedUser;

          // Update stored user data
          await SharedPreferencesHelper.saveUser(_user!);
          _clearError();

          print('Profile image updated successfully');
          notifyListeners(); // Notify only when data changes
        }

        return true;
      } else {
        _setError(result['message']);
        return false;
      }
    } catch (e) {
      _setError('Error updating profile image: ${e.toString()}');
      print('Error in updateProfileImage: $e');
      return false;
    } finally {
      _setUpdating(false);
    }
  }

  // Update complete profile (data + image)
  Future<bool> updateCompleteProfile({
    required String name,
    required String mobile,
    File? profileImage,
  }) async {
    if (_user?.id == null) {
      _setError('No user ID available');
      return false;
    }

    // Store the input values to preserve them
    final inputName = name.trim();
    final inputMobile = mobile.trim();

    _setUpdating(true);
    try {
      final result = await ProfileService.updateCompleteProfile(
        userId: _user!.id,
        name: inputName,
        mobile: inputMobile,
        profileImage: profileImage,
      );

      if (result['success']) {
        final userData = result['user'];
        final updatedUser = User.fromJson(userData);

        // Create a merged user that preserves the input values if API returns empty
        final mergedUser = User(
          id: updatedUser.id.isNotEmpty ? updatedUser.id : _user!.id,
          name: updatedUser.name.isNotEmpty ? updatedUser.name : inputName,
          mobile:
              updatedUser.mobile.isNotEmpty ? updatedUser.mobile : inputMobile,
          email:
              updatedUser.email.isNotEmpty ? updatedUser.email : _user!.email,
          code: updatedUser.code.isNotEmpty ? updatedUser.code : _user!.code,
          profileImage: updatedUser.profileImage ?? _user!.profileImage,
          createdAt: updatedUser.createdAt ?? _user!.createdAt,
          updatedAt: updatedUser.updatedAt ?? DateTime.now(),
        );

        // Only update if data actually changed
        if (_user?.name != mergedUser.name ||
            _user?.mobile != mergedUser.mobile ||
            _user?.profileImage != mergedUser.profileImage) {
          _user = mergedUser;

          // Update stored user data
          await SharedPreferencesHelper.saveUser(_user!);
          _clearError();

          print('Complete profile updated successfully: ${_user?.name}');
          notifyListeners(); // Notify only when data changes
        }

        return true;
      } else {
        _setError(result['message']);
        return false;
      }
    } catch (e) {
      _setError('Error updating complete profile: ${e.toString()}');
      print('Error in updateCompleteProfile: $e');
      return false;
    } finally {
      _setUpdating(false);
    }
  }

  // Helper method to merge user data, preserving non-empty values from existing user
  User _mergeUserData(User existingUser, User newUser) {
    return User(
      id: newUser.id.isNotEmpty ? newUser.id : existingUser.id,
      name: newUser.name.isNotEmpty ? newUser.name : existingUser.name,
      mobile: newUser.mobile.isNotEmpty ? newUser.mobile : existingUser.mobile,
      email: newUser.email.isNotEmpty ? newUser.email : existingUser.email,
      code: newUser.code.isNotEmpty ? newUser.code : existingUser.code,
      profileImage: newUser.profileImage ?? existingUser.profileImage,
      createdAt: newUser.createdAt ?? existingUser.createdAt,
      updatedAt: newUser.updatedAt ?? existingUser.updatedAt ?? DateTime.now(),
    );
  }

  // Update user locally (for immediate UI updates)
  void updateUserLocally({
    String? name,
    String? mobile,
    String? email,
    String? profileImage,
  }) {
    if (_user != null) {
      _user = User(
        id: _user!.id,
        name: name ?? _user!.name,
        mobile: mobile ?? _user!.mobile,
        email: email ?? _user!.email,
        code: _user!.code,
        profileImage: profileImage ?? _user!.profileImage,
        createdAt: _user!.createdAt,
        updatedAt: DateTime.now(),
      );
      notifyListeners();
    }
  }

  // Clear error message
  void clearError() {
    _clearError();
  }

  // Refresh user data
  Future<bool> refreshUserData() async {
    return await fetchUserProfile();
  }

  // Private helper methods
  void _setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }

  void _setUpdating(bool updating) {
    if (_isUpdating != updating) {
      _isUpdating = updating;
      notifyListeners();
    }
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      notifyListeners();
    }
  }

  // Reset provider state
  void reset() {
    _user = null;
    _isLoading = false;
    _isUpdating = false;
    _errorMessage = null;
    notifyListeners();
  }

  // Validation methods
  bool isValidName(String name) {
    return name.trim().isNotEmpty && name.length >= 2;
  }

  bool isValidMobile(String mobile) {
    // Remove any non-digit characters for validation
    final cleanMobile = mobile.replaceAll(RegExp(r'[^\d]'), '');
    return cleanMobile.length >= 10;
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email.trim());
  }

  // Get user display name
  String getDisplayName() {
    return _user?.name ?? 'User';
  }

  // Get user profile image
  String? getProfileImageUrl() {
    return _user?.profileImage;
  }

  // Check if user has profile image
  bool hasProfileImage() {
    final imageUrl = _user?.profileImage;
    return imageUrl != null && imageUrl.isNotEmpty;
  }

  void clearUser() async {
    _user = null;
    _errorMessage = null;
    _isLoading = false;
    _isUpdating = false;

    // Also remove saved user data from SharedPreferences
    await SharedPreferencesHelper.clearAuthData();

    notifyListeners();
  }
}
