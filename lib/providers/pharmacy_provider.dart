// // providers/pharmacy_provider.dart
// import 'package:flutter/material.dart';
// import 'package:medical_user_app/models/pharmacy_category_model.dart';
// import 'package:medical_user_app/services/get_all_pharmacy_service.dart';
// import '../models/pharmacy_model.dart';


// class PharmacyProvider extends ChangeNotifier {
//   List<Pharmacy> _pharmacies = [];
//   List<Pharmacy> _filteredPharmacies = [];
//    List<Medicine> _filteredMedicines = [];
//   bool _isLoading = false;
//   String _errorMessage = '';
//   String _searchQuery = '';

//   // Getters
//   List<Pharmacy> get pharmacies => _pharmacies;
//   List<Pharmacy> get filteredPharmacies => _filteredPharmacies;
//   bool get isLoading => _isLoading;
//   String get errorMessage => _errorMessage;
//   String get searchQuery => _searchQuery;

//   // Fetch all pharmacies
//   Future<void> fetchPharmacies() async {
//     _setLoading(true);
//     _clearError();

//     try {
//       final response = await PharmacyService.getAllPharmacies();
//       _pharmacies = response.pharmacies;
//       _filteredPharmacies = _pharmacies;
//       notifyListeners();
//     } catch (e) {
//       _setError(e.toString());
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Fetch nearby pharmacies based on location
//   Future<void> fetchNearbyPharmacies({
//     required double latitude,
//     required double longitude,
//     double radius = 10.0,
//   }) async {
//     _setLoading(true);
//     _clearError();

//     try {
//       final response = await PharmacyService.getNearbyPharmacies(
//         latitude: latitude,
//         longitude: longitude,
//         radius: radius,
//       );
//       _pharmacies = response.pharmacies;
//       _filteredPharmacies = _pharmacies;
//       notifyListeners();
//     } catch (e) {
//       _setError(e.toString());
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Search pharmacies
//   void searchPharmacies(String query) {
//     _searchQuery = query;
    
//     if (query.isEmpty) {
//       _filteredPharmacies = _pharmacies;
//     } else {
//       _filteredPharmacies = _pharmacies
//           .where((pharmacy) =>
//               pharmacy.name.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     }
    
//     notifyListeners();
//   }

//   // Clear search
//   void clearSearch() {
//     _searchQuery = '';
//     _filteredPharmacies = _pharmacies;
//     notifyListeners();
//   }

//   // Refresh pharmacies
//   Future<void> refreshPharmacies() async {
//     await fetchPharmacies();
//   }

//   // Get pharmacy by ID
//   Pharmacy? getPharmacyById(String id) {
//     try {
//       return _pharmacies.firstWhere((pharmacy) => pharmacy.id == id);
//     } catch (e) {
//       return null;
//     }
//   }

//   // Calculate distance between two points (simple implementation)
//   double calculateDistance(
//     double lat1,
//     double lon1,
//     double lat2,
//     double lon2,
//   ) {
//     // Simple distance calculation (you can use more accurate algorithms)
//     const double earthRadius = 6371; // km
//     double dLat = _degreesToRadians(lat2 - lat1);
//     double dLon = _degreesToRadians(lon2 - lon1);
    
//     double a = (dLat / 2) * (dLat / 2) +
//         (lat1 * (3.14159 / 180)) *
//             (lat2 * (3.14159 / 180)) *
//             (dLon / 2) *
//             (dLon / 2);
//  double c = 2 * ((a.isNaN ? 0.0 : a.clamp(0.0, 1.0)) as double);

    
//     return earthRadius * c;
//   }

//   double _degreesToRadians(double degrees) {
//     return degrees * (3.14159 / 180);
//   }

//   // Sort pharmacies by distance
//   void sortPharmaciesByDistance(double userLat, double userLon) {
//     _filteredPharmacies.sort((a, b) {
//       double distanceA = calculateDistance(userLat, userLon, a.latitude, a.longitude);
//       double distanceB = calculateDistance(userLat, userLon, b.latitude, b.longitude);
//       return distanceA.compareTo(distanceB);
//     });
//     notifyListeners();
//   }
  

//   // Private helper methods
//   void _setLoading(bool loading) {
//     _isLoading = loading;
//     notifyListeners();
//   }

//   void _setError(String error) {
//     _errorMessage = error;
//     notifyListeners();
//   }

//   void _clearError() {
//     _errorMessage = '';
//   }

//   // Clear all data
//   void clearData() {
//     _pharmacies.clear();
//     _filteredPharmacies.clear();
//     _searchQuery = '';
//     _errorMessage = '';
//     _isLoading = false;
//     notifyListeners();
//   }
// }



//commented code is the original one 










// providers/pharmacy_provider.dart
import 'package:flutter/material.dart';
import 'package:medical_user_app/services/get_all_pharmacy_service.dart';
import '../models/pharmacy_model.dart';
import 'dart:math' show sqrt, sin, cos, asin;

class PharmacyProvider extends ChangeNotifier {
  List<Pharmacy> _pharmacies = [];
  List<Pharmacy> _filteredPharmacies = [];
  bool _isLoading = false;
  String _errorMessage = '';
  String _searchQuery = '';

  // Getters
  List<Pharmacy> get pharmacies => _pharmacies;
  List<Pharmacy> get filteredPharmacies => _filteredPharmacies;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;

  // Fetch all pharmacies
  Future<void> fetchPharmacies() async {
    _setLoading(true);
    _clearError();

    try {
      final response = await PharmacyService.getAllPharmacies();
      _pharmacies = response.pharmacies;
      _filteredPharmacies = _pharmacies;
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
      print('Error fetching pharmacies: $e'); // Debug print
    } finally {
      _setLoading(false);
    }
  }

  // Fetch nearby pharmacies based on location
  Future<void> fetchNearbyPharmacies({
    required double latitude,
    required double longitude,
    double radius = 10.0,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final response = await PharmacyService.getNearbyPharmacies(
        latitude: latitude,
        longitude: longitude,
        radius: radius,
      );
      _pharmacies = response.pharmacies;
      _filteredPharmacies = _pharmacies;
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
      print('Error fetching nearby pharmacies: $e'); // Debug print
    } finally {
      _setLoading(false);
    }
  }

  // Search pharmacies
  void searchPharmacies(String query) {
    _searchQuery = query;
    
    if (query.isEmpty) {
      _filteredPharmacies = _pharmacies;
    } else {
      _filteredPharmacies = _pharmacies
          .where((pharmacy) =>
              pharmacy.name.toLowerCase().contains(query.toLowerCase()) ||
              pharmacy.address.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    
    notifyListeners();
  }

  // Clear search
  void clearSearch() {
    _searchQuery = '';
    _filteredPharmacies = _pharmacies;
    notifyListeners();
  }

  // Refresh pharmacies
  Future<void> refreshPharmacies() async {
    await fetchPharmacies();
  }

  // Get pharmacy by ID
  Pharmacy? getPharmacyById(String id) {
    try {
      return _pharmacies.firstWhere((pharmacy) => pharmacy.id == id);
    } catch (e) {
      return null;
    }
  }

  // Calculate distance between two points using Haversine formula
  double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double earthRadius = 6371; // km
    
    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);
    
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    
    double c = 2 * asin(sqrt(a));
    
    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (3.14159265359 / 180);
  }

  // Sort pharmacies by distance
  void sortPharmaciesByDistance(double userLat, double userLon) {
    _filteredPharmacies.sort((a, b) {
      double distanceA = calculateDistance(userLat, userLon, a.latitude, a.longitude);
      double distanceB = calculateDistance(userLat, userLon, b.latitude, b.longitude);
      return distanceA.compareTo(distanceB);
    });
    notifyListeners();
  }

  // Private helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = '';
  }

  // Clear all data
  void clearData() {
    _pharmacies.clear();
    _filteredPharmacies.clear();
    _searchQuery = '';
    _errorMessage = '';
    _isLoading = false;
    notifyListeners();
  }
}