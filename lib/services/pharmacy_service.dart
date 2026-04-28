import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/models/pharmacy_category_model.dart';

class PharmacyService {
  static const String baseUrl = 'https://api.simcurarx.com/api';

  // Get medicines from a specific pharmacy with optional category filter
  Future<PharmacyMedicinesResponse> getMedicinesByPharmacy({
    required String pharmacyId,
    String? category,
  }) async {
    print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk$category');
    try {
      String url = '$baseUrl/pharmacy/getmedicines/$pharmacyId';

      print('ttttttttttttttttttttttttttttttttttttttt$url');

      if (category != null && category.isNotEmpty) {
        url += '?category=$category';
      }

      print('daaaaaaaaaaaaaaaaaaaaataaaaaaaaaaaaaaaaaaa$url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 30),
      );

      print('response status codeeeeeeeeeeeeeeeeeeeee${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return PharmacyMedicinesResponse.fromJson(jsonData);
      } else {
        throw HttpException(
          'Failed to fetch medicines. Status code: ${response.statusCode}',
        );
      }
    } on SocketException {
      throw const SocketException(
        'No internet connection. Please check your network settings.',
      );
    } on HttpException {
      rethrow;
    } on FormatException {
      throw const FormatException(
        'Invalid response format from server.',
      );
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // Get all medicines from a pharmacy (without category filter)
  Future<PharmacyMedicinesResponse> getAllMedicinesByPharmacy(
    String pharmacyId,
  ) async {
    return getMedicinesByPharmacy(pharmacyId: pharmacyId);
  }

  // Get medicines by category from a pharmacy
  Future<PharmacyMedicinesResponse> getMedicinesByCategory({
    required String pharmacyId,
    required String category,
  }) async {
    return getMedicinesByPharmacy(
      pharmacyId: pharmacyId,
      category: category,
    );
  }

  // Search medicines in a pharmacy
  Future<PharmacyMedicinesResponse> searchMedicinesInPharmacy({
    required String pharmacyId,
    required String searchQuery,
  }) async {
    try {
      final response = await getMedicinesByPharmacy(pharmacyId: pharmacyId);

      // Filter medicines based on search query
      final filteredMedicines = response.medicines.where((medicine) {
        return medicine.name
                .toLowerCase()
                .contains(searchQuery.toLowerCase()) ||
            medicine.description
                .toLowerCase()
                .contains(searchQuery.toLowerCase()) ||
            medicine.categoryName
                .toLowerCase()
                .contains(searchQuery.toLowerCase());
      }).toList();

      return PharmacyMedicinesResponse(
        message: 'Medicines filtered successfully',
        pharmacy: response.pharmacy,
        categoryFilter: 'search: $searchQuery',
        totalMedicines: filteredMedicines.length,
        medicines: filteredMedicines,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Get medicine categories available in a pharmacy
  Future<List<String>> getAvailableCategories(String pharmacyId) async {
    try {
      final response = await getAllMedicinesByPharmacy(pharmacyId);

      final categories = <String>{};
      for (final medicine in response.medicines) {
        categories.add(medicine.categoryName);
      }

      return categories.toList()..sort();
    } catch (e) {
      rethrow;
    }
  }

  // Get medicines by price range
  Future<PharmacyMedicinesResponse> getMedicinesByPriceRange({
    required String pharmacyId,
    required double minPrice,
    required double maxPrice,
    String? category,
  }) async {
    try {
      final response = await getMedicinesByPharmacy(
        pharmacyId: pharmacyId,
        category: category,
      );

      final filteredMedicines = response.medicines.where((medicine) {
        return medicine.price >= minPrice && medicine.price <= maxPrice;
      }).toList();

      return PharmacyMedicinesResponse(
        message: 'Medicines filtered by price range successfully',
        pharmacy: response.pharmacy,
        categoryFilter: category ?? 'all',
        totalMedicines: filteredMedicines.length,
        medicines: filteredMedicines,
      );
    } catch (e) {
      rethrow;
    }
  }
}
