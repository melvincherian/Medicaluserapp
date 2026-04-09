// import 'package:flutter/material.dart';
// import 'package:medical_user_app/services/periodic_plan_service.dart';
// import 'package:medical_user_app/utils/shared_preferences_helper.dart';

// class PeriodicPlanProvider extends ChangeNotifier {
//   bool _isLoading = false;
//   String? _error;
//   List<Map<String, dynamic>> _periodicPlans = [];

//   // Getters
//   bool get isLoading => _isLoading;
//   String? get error => _error;
//   List<Map<String, dynamic>> get periodicPlans => _periodicPlans;

//   // Clear error
//   void clearError() {
//     _error = null;
//     notifyListeners();
//   }

//   // Create a periodic plan
//   Future<bool> createPeriodicPlan({
//     required String planType,
//     required List<Map<String, dynamic>> medications,
//     required List<DateTime> deliveryDates,
//     String? notes,
//     String? voiceNoteUrl,
//   }) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       // Get current user
//       final user = await SharedPreferencesHelper.getUser();
//       if (user == null) {
//         _error = 'User not found. Please login again.';
//         _isLoading = false;
//         notifyListeners();
//         return false;
//       }

//       // Prepare order items from medications
//       List<Map<String, dynamic>> orderItems = [];

//       for (var medication in medications) {
//         // Extract medicine ID from medication data
//         String? medicineId;

//         // Try to get medicineId from different possible fields
//         if (medication.containsKey('medicineId')) {
//           medicineId = medication['medicineId'];
//         } else if (medication.containsKey('id')) {
//           medicineId = medication['id'];
//         } else if (medication.containsKey('_id')) {
//           medicineId = medication['_id'];
//         }

//         if (medicineId != null && medicineId.isNotEmpty) {
//           orderItems.add({
//             'medicineId': medicineId,
//             'quantity': medication['count'] ?? 1,
//           });
//         } else {
//           // If no medicineId found, create a mock one for testing
//           // In production, this should be handled properly
//           print('Warning: No medicineId found for medication: ${medication['name']}');
//           orderItems.add({
//             'medicineId': 'mock_id_${DateTime.now().millisecondsSinceEpoch}',
//             'quantity': medication['count'] ?? 1,
//           });
//         }
//       }

//       // Convert delivery dates to strings
//       List<String> deliveryDateStrings = deliveryDates
//           .map((date) => '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}')
//           .toList();

//       // Call the service
//       final result = await PeriodicPlanService.createPeriodicPlan(
//         userId: user.id,
//         planType: planType,
//         orderItems: orderItems,
//         deliveryDates: deliveryDateStrings,
//         notes: notes,
//         voiceNoteUrl: voiceNoteUrl,
//       );

//       if (result['success'] == true) {
//         // Refresh the periodic plans list
//         await getUserPeriodicPlans();

//         _isLoading = false;
//         notifyListeners();
//         return true;
//       } else {
//         _error = result['message'] ?? 'Failed to create periodic plan';
//         _isLoading = false;
//         notifyListeners();
//         return false;
//       }
//     } catch (e) {
//       _error = 'An error occurred: ${e.toString()}';
//       _isLoading = false;
//       notifyListeners();
//       return false;
//     }
//   }

//   // Get user's periodic plans
//   Future<void> getUserPeriodicPlans() async {
//     try {
//       final user = await SharedPreferencesHelper.getUser();
//       if (user == null) {
//         _error = 'User not found. Please login again.';
//         notifyListeners();
//         return;
//       }

//       final result = await PeriodicPlanService.getUserPeriodicPlans(user.id);

//       if (result['success'] == true) {
//         _periodicPlans = List<Map<String, dynamic>>.from(result['data'] ?? []);
//       } else {
//         _error = result['message'] ?? 'Failed to get periodic plans';
//       }

//       notifyListeners();
//     } catch (e) {
//       _error = 'An error occurred: ${e.toString()}';
//       notifyListeners();
//     }
//   }

//   // Helper method to validate medication data
//   bool validateMedicationData(List<Map<String, dynamic>> medications) {
//     if (medications.isEmpty) {
//       _error = 'No medications selected';
//       return false;
//     }

//     for (var medication in medications) {
//       if (medication['count'] == null || medication['count'] <= 0) {
//         _error = 'Invalid quantity for ${medication['name']}';
//         return false;
//       }
//     }

//     return true;
//   }

//   // Helper method to validate delivery dates
//   bool validateDeliveryDates(List<DateTime> dates) {
//     if (dates.isEmpty) {
//       _error = 'No delivery date selected';
//       return false;
//     }

//     final now = DateTime.now();
//     for (var date in dates) {
//       if (date.isBefore(DateTime(now.year, now.month, now.day))) {
//         _error = 'Delivery date cannot be in the past';
//         return false;
//       }
//     }

//     return true;
//   }

//   // Reset provider state
//   void reset() {
//     _isLoading = false;
//     _error = null;
//     _periodicPlans.clear();
//     notifyListeners();
//   }
// }




import 'package:flutter/material.dart';
import 'package:medical_user_app/services/periodic_plan_service.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';
class PeriodicPlanProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  List<Map<String, dynamic>> _periodicPlans = [];

  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Map<String, dynamic>> get periodicPlans => _periodicPlans;

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Create a periodic plan
  Future<bool> createPeriodicPlan({
    required String planType,
    required List<Map<String, dynamic>> medications,
    required List<DateTime> deliveryDates,
    String? notes,
    String? voiceNoteUrl,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Get current user
      final user = await SharedPreferencesHelper.getUser();
      if (user == null) {
        _error = 'User not found. Please login again.';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Prepare order items from medications with enhanced data
      List<Map<String, dynamic>> orderItems = [];
      double totalAmount = 0.0;

      for (var medication in medications) {
        // Extract medicine ID from medication data
        String? medicineId;

        // Try to get medicineId from different possible fields
        if (medication.containsKey('medicineId')) {
          medicineId = medication['medicineId'];
        } else if (medication.containsKey('id')) {
          medicineId = medication['id'];
        } else if (medication.containsKey('_id')) {
          medicineId = medication['_id'];
        }

        if (medicineId != null && medicineId.isNotEmpty) {
          // Parse price - handle different price formats
          double price = 0.0;
          if (medication.containsKey('price') && medication['price'] != null) {
            String priceStr = medication['price'].toString();
            // Remove currency symbols and parse
            priceStr = priceStr.replaceAll(RegExp(r'[^\d.]'), '');
            price = double.tryParse(priceStr) ?? 0.0;
          }

          int quantity = medication['count'] ?? 1;
          double itemTotal = price * quantity;
          totalAmount += itemTotal;

          orderItems.add({
            'medicineId': medicineId,
            'quantity': quantity,
            'price': price, // Add price to order items
            'name': medication['name'] ?? '', // Add medicine name
            'subtotal': itemTotal, // Calculate subtotal for each item
          });
        } else {
          // Handle missing medicineId case
          print(
              'Warning: No medicineId found for medication: ${medication['name']}');
          _error = 'Invalid medicine data found. Please try again.';
          _isLoading = false;
          notifyListeners();
          return false;
        }
      }

      // Validate that we have valid order items
      if (orderItems.isEmpty) {
        _error = 'No valid medicines found to create plan.';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Convert delivery dates to strings
      List<String> deliveryDateStrings = deliveryDates
          .map((date) =>
              '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}')
          .toList();

      // Call the service with enhanced data
      final result = await PeriodicPlanService.createPeriodicPlan(
        userId: user.id,
        planType: planType,
        orderItems: orderItems, 
        deliveryDates: deliveryDateStrings,
        notes: notes,
        voiceNoteUrl: voiceNoteUrl,
        totalAmount: totalAmount, 
      );

      print('user idddddddddddddddddddddd ${user.id}');
      print('plan tytpeeeeeeeeeeeeeeeeeee $planType');
      print('order iteeeeeeeeeeeeeeemsss $orderItems');
      print('dateeeeeeeeeeeeeeeeeeee $deliveryDateStrings');
      print('notessssssssssssssssssssssssss $notes');
      print('voiceeeeeeeeeeeeeeeeeeee $voiceNoteUrl');
      print('total amountttttttttttttttt $totalAmount');

      if (result['success'] == true) {
        // Refresh the periodic plans list
        // await getUserPeriodicPlans();

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = result['message'] ?? 'Failed to create periodic plan';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'An error occurred: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Get user's periodic plans
  // Future<void> getUserPeriodicPlans() async {
  //   try {
  //     final user = await SharedPreferencesHelper.getUser();
  //     if (user == null) {
  //       _error = 'User not found. Please login again.';
  //       notifyListeners();
  //       return;
  //     }

  //     final result = await PeriodicPlanService.getUserPeriodicPlans(user.id);

  //     if (result['success'] == true) {
  //       _periodicPlans = List<Map<String, dynamic>>.from(result['data'] ?? []);
  //     } else {
  //       _error = result['message'] ?? 'Failed to get periodic plans';
  //     }

  //     notifyListeners();
  //   } catch (e) {
  //     _error = 'An error occurred: ${e.toString()}';
  //     notifyListeners();
  //   }
  // }

  // Helper method to validate medication data
  bool validateMedicationData(List<Map<String, dynamic>> medications) {
    if (medications.isEmpty) {
      _error = 'No medications selected';
      return false;
    }

    for (var medication in medications) {
      if (medication['count'] == null || medication['count'] <= 0) {
        _error = 'Invalid quantity for ${medication['name']}';
        return false;
      }

      // Validate medicine ID exists
      String? medicineId;
      if (medication.containsKey('medicineId')) {
        medicineId = medication['medicineId'];
      } else if (medication.containsKey('id')) {
        medicineId = medication['id'];
      } else if (medication.containsKey('_id')) {
        medicineId = medication['_id'];
      }

      if (medicineId == null || medicineId.isEmpty) {
        _error = 'Invalid medicine ID for ${medication['name']}';
        return false;
      }
    }

    return true;
  }

  // Helper method to validate delivery dates
  bool validateDeliveryDates(List<DateTime> dates) {
    if (dates.isEmpty) {
      _error = 'No delivery date selected';
      return false;
    }

    final now = DateTime.now();
    for (var date in dates) {
      if (date.isBefore(DateTime(now.year, now.month, now.day))) {
        _error = 'Delivery date cannot be in the past';
        return false;
      }
    }

    return true;
  }

  // Reset provider state
  void reset() {
    _isLoading = false;
    _error = null;
    _periodicPlans.clear();
    notifyListeners();
  }
}
