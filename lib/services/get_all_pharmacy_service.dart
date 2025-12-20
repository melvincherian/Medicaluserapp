// services/pharmacy_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/constant/api_constants.dart';
import '../models/pharmacy_model.dart';

class PharmacyService {
  static const Duration _timeoutDuration = Duration(seconds: 30);

  static Future<PharmacyResponse> getAllPharmacies() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.pharmacyService),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(_timeoutDuration);

      print(
          'response status code for getall pharmacies ${response.statusCode}');
      print('response bodyyyyyyyyyyyy for getall pharmacies ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return PharmacyResponse.fromJson(data);
      } else {
        throw Exception(
            'Failed to fetch pharmacies. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching pharmacies: $e');
    }
  }

  /// Fetches nearby pharmacies based on location (if needed in future)
  static Future<PharmacyResponse> getNearbyPharmacies({
    required double latitude,
    required double longitude,
    double radius = 10.0, // in kilometers
  }) async {
    try {
      final queryParams = {
        'lat': latitude.toString(),
        'lng': longitude.toString(),
        'radius': radius.toString(),
      };

      final uri = Uri.parse(ApiConstants.pharmacyService)
          .replace(queryParameters: queryParams);

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(_timeoutDuration);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return PharmacyResponse.fromJson(data);
      } else {
        throw Exception(
            'Failed to fetch nearby pharmacies. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching nearby pharmacies: $e');
    }
  }

  /// Searches pharmacies by name or location
  static Future<List<Pharmacy>> searchPharmacies(String query) async {
    try {
      final response = await getAllPharmacies();

      // Filter pharmacies based on the search query
      final filteredPharmacies = response.pharmacies
          .where((pharmacy) =>
              pharmacy.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      return filteredPharmacies;
    } catch (e) {
      throw Exception('Error searching pharmacies: $e');
    }
  }
}
