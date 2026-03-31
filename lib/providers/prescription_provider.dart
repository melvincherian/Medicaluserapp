// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:medical_user_app/services/prescription_service.dart';

// class PrescriptionProvider extends ChangeNotifier {
//   // State variables
//   bool _isLoading = false;
//   String? _errorMessage;
//   String? _successMessage;
//   File? _selectedPrescriptionFile;
//   String? _notes;
//   List<Map<String, dynamic>> _sentPrescriptions = [];

//   // Getters
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   String? get successMessage => _successMessage;
//   File? get selectedPrescriptionFile => _selectedPrescriptionFile;
//   String? get notes => _notes;
//   List<Map<String, dynamic>> get sentPrescriptions => _sentPrescriptions;

//   // Clear messages
//   void clearMessages() {
//     _errorMessage = null;
//     _successMessage = null;
//     notifyListeners();
//   }

//   // Set prescription file
//   void setPrescriptionFile(File? file) {
//     _selectedPrescriptionFile = file;
//     clearMessages();

//     // Validate file if selected
//     if (file != null && !PrescriptionService.validatePrescriptionFile(file)) {
//       _errorMessage = 'Invalid file. Please select a valid image (JPG, PNG) or PDF file under 10MB.';
//     }

//     notifyListeners();
//   }

//   // Set notes
//   void setNotes(String notes) {
//     _notes = notes.trim().isEmpty ? null : notes.trim();
//     notifyListeners();
//   }

//   // Get file size as string
//   String? getFileSize() {
//     if (_selectedPrescriptionFile == null) return null;
//     return PrescriptionService.getFileSize(_selectedPrescriptionFile!);
//   }

//   // Get file name
//   String? getFileName() {
//     if (_selectedPrescriptionFile == null) return null;
//     return _selectedPrescriptionFile!.path.split('/').last;
//   }

//   // Validate prescription data
//   bool validatePrescriptionData() {
//     clearMessages();

//     if (_selectedPrescriptionFile == null) {
//       _errorMessage = 'Please select a prescription file';
//       notifyListeners();
//       return false;
//     }

//     if (!PrescriptionService.validatePrescriptionFile(_selectedPrescriptionFile!)) {
//       _errorMessage = 'Invalid file format or size. Please select a valid image (JPG, PNG) or PDF file under 10MB.';
//       notifyListeners();
//       return false;
//     }

//     return true;
//   }

//   // Send prescription to pharmacy
//   Future<bool> sendPrescription({
//     required String userId,
//     required String pharmacyId,
//     String? pharmacyName,
//   }) async {
//     if (!validatePrescriptionData()) {
//       return false;
//     }

//     _isLoading = true;
//     _errorMessage = null;
//     _successMessage = null;
//     notifyListeners();

//     try {
//       final result = await PrescriptionService.sendPrescription(
//         userId: userId,
//         pharmacyId: pharmacyId,
//         prescriptionFile: _selectedPrescriptionFile!,
//         notes: _notes,
//       );

//       if (result['success']) {
//         _successMessage = result['message'];

//         // Add to sent prescriptions list
//         _sentPrescriptions.insert(0, {
//           'id': DateTime.now().millisecondsSinceEpoch.toString(),
//           'pharmacyId': pharmacyId,
//           'pharmacyName': pharmacyName ?? 'Unknown Pharmacy',
//           'fileName': getFileName(),
//           'fileSize': getFileSize(),
//           'notes': _notes,
//           'sentAt': DateTime.now(),
//           'status': 'sent',
//         });

//         // Clear form data after successful submission
//         clearForm();

//         _isLoading = false;
//         notifyListeners();
//         return true;
//       } else {
//         _errorMessage = result['message'];
//         _isLoading = false;
//         notifyListeners();
//         return false;
//       }
//     } catch (e) {
//       _errorMessage = 'An unexpected error occurred. Please try again.';
//       _isLoading = false;
//       notifyListeners();
//       return false;
//     }
//   }

//   // Clear form data
//   void clearForm() {
//     _selectedPrescriptionFile = null;
//     _notes = null;
//     clearMessages();
//     notifyListeners();
//   }

//   // Remove prescription from sent list
//   void removeSentPrescription(String id) {
//     _sentPrescriptions.removeWhere((prescription) => prescription['id'] == id);
//     notifyListeners();
//   }

//   // Update prescription status
//   void updatePrescriptionStatus(String id, String status) {
//     final index = _sentPrescriptions.indexWhere((prescription) => prescription['id'] == id);
//     if (index != -1) {
//       _sentPrescriptions[index]['status'] = status;
//       _sentPrescriptions[index]['updatedAt'] = DateTime.now();
//       notifyListeners();
//     }
//   }

//   // Get prescription by ID
//   Map<String, dynamic>? getPrescriptionById(String id) {
//     try {
//       return _sentPrescriptions.firstWhere((prescription) => prescription['id'] == id);
//     } catch (e) {
//       return null;
//     }
//   }

//   // Get prescriptions by pharmacy
//   List<Map<String, dynamic>> getPrescriptionsByPharmacy(String pharmacyId) {
//     return _sentPrescriptions
//         .where((prescription) => prescription['pharmacyId'] == pharmacyId)
//         .toList();
//   }

//   // Get prescriptions count by status
//   int getPrescriptionsCountByStatus(String status) {
//     return _sentPrescriptions
//         .where((prescription) => prescription['status'] == status)
//         .length;
//   }

//   // Clear all sent prescriptions
//   void clearSentPrescriptions() {
//     _sentPrescriptions.clear();
//     notifyListeners();
//   }

//   // Dispose method
//   @override
//   void dispose() {
//     // Clear any resources if needed
//     super.dispose();
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medical_user_app/models/pharmacy_model.dart';
import 'package:medical_user_app/models/user_model.dart';
import 'package:medical_user_app/services/prescription_service.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';

class PrescriptionProvider extends ChangeNotifier {
  // Loading states
  bool _isLoading = false;
  bool _isSubmittingPrescription = false;
  bool _isSubmittingQuery = false;
  bool _isLoadingPharmacies = false;

  // Data
  List<Pharmacy> _pharmacies = [];
  Pharmacy? _selectedPharmacy;
  File? _prescriptionFile;
  String _notes = '';
  User? _currentUser;

  // Error handling
  String? _errorMessage;
  String? _successMessage;

  // Form controllers
  final TextEditingController notesController = TextEditingController();
  final TextEditingController queryController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Getters
  bool get isLoading => _isLoading;
  bool get isSubmittingPrescription => _isSubmittingPrescription;
  bool get isSubmittingQuery => _isSubmittingQuery;
  bool get isLoadingPharmacies => _isLoadingPharmacies;

  List<Pharmacy> get pharmacies => _pharmacies;
  Pharmacy? get selectedPharmacy => _selectedPharmacy;
  File? get prescriptionFile => _prescriptionFile;
  String get notes => _notes;
  User? get currentUser => _currentUser;

  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  bool get canSubmitPrescription =>
      _prescriptionFile != null &&
      _selectedPharmacy != null &&
      _currentUser != null &&
      !_isSubmittingPrescription;

  bool get canSubmitQuery =>
      queryController.text.isNotEmpty &&
      emailController.text.isNotEmpty &&
      phoneController.text.isNotEmpty &&
      _currentUser != null &&
      !_isSubmittingQuery;

  // Initialize provider
  Future<void> initialize() async {
    _setLoading(true);
    _clearMessages();

    try {
      await _loadCurrentUser();
      await loadPharmacies();
      _initializeControllers();
    } catch (e) {
      _setError('Failed to initialize: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Load current user
  Future<void> _loadCurrentUser() async {
    try {
      _currentUser = await SharedPreferencesHelper.getUser();
      if (_currentUser != null) {
        emailController.text =
            _currentUser!.mobile; // Use mobile as default email
        phoneController.text = _currentUser!.mobile;
      }
    } catch (e) {
      print('Error loading current user: $e');
    }
  }

  // Initialize form controllers
  void _initializeControllers() {
    notesController.addListener(() {
      _notes = notesController.text;
      notifyListeners();
    });
  }

  // Load all pharmacies
  Future<void> loadPharmacies() async {
    _setLoadingPharmacies(true);
    _clearMessages();

    try {
      final result = await PrescriptionService.getAllPharmacies();

      if (result['success']) {
        final responseData = result['data'];
        if (responseData['pharmacies'] != null) {
          final pharmacyResponse = PharmacyResponse.fromJson(responseData);
          _pharmacies = pharmacyResponse.pharmacies;
          _setSuccess('Pharmacies loaded successfully');
        } else {
          _setError('No pharmacies found');
        }
      } else {
        _setError(result['message'] ?? 'Failed to load pharmacies');
      }
    } catch (e) {
      _setError('Error loading pharmacies: $e');
    } finally {
      _setLoadingPharmacies(false);
    }
  }

  // Select pharmacy
  void selectPharmacy(Pharmacy pharmacy) {
    _selectedPharmacy = pharmacy;
    _clearMessages();
    notifyListeners();
  }

  // Clear selected pharmacy
  void clearSelectedPharmacy() {
    _selectedPharmacy = null;
    notifyListeners();
  }

  // Set prescription file
  void setPrescriptionFile(File file) {
    if (PrescriptionService.validatePrescriptionFile(file)) {
      _prescriptionFile = file;
      _clearMessages();
      _setSuccess('Prescription file selected');
    } else {
      _setError(
          'Invalid file. Please select a valid image or PDF file (max 10MB)');
    }
    notifyListeners();
  }

  // Remove prescription file
  void removePrescriptionFile() {
    _prescriptionFile = null;
    _clearMessages();
    notifyListeners();
  }

  // Submit prescription
  Future<bool> submitPrescription() async {
    if (!canSubmitPrescription) {
      _setError('Please select a pharmacy and prescription file');
      return false;
    }

    _setSubmittingPrescription(true);
    _clearMessages();

    try {
      final result = await PrescriptionService.sendPrescription(
        userId: _currentUser!.id,
        pharmacyId: _selectedPharmacy!.id,
        prescriptionFile: _prescriptionFile!,
        notes: _notes.isNotEmpty ? _notes : null,
      );

      print('useeeeeeeeeeeeeeeeeeeeeid ${_currentUser!.id}');
      print('pharmacyiddddddddddddddd ${selectedPharmacy!.id}');

      print('prescriptionfileeeeeeeeeeeeeeeeeee ${_prescriptionFile}');

      print('notesssssssssssssssssssssssss ${_notes}');

      if (result['success']) {
        _setSuccess(result['message'] ?? 'Prescription sent successfully');
        _resetPrescriptionForm();
        return true;
      } else {
        _setError(result['message'] ?? 'Failed to send prescription');
        return false;
      }
    } catch (e) {
      _setError('Error sending prescription: $e');
      return false;
    } finally {
      _setSubmittingPrescription(false);
    }
  }

  // Submit query
  Future<bool> submitQuery() async {
    if (!canSubmitQuery) {
      _setError('Please fill all required fields');
      return false;
    }

    _setSubmittingQuery(true);
    _clearMessages();

    try {
      final result = await PrescriptionService.submitQuery(
        userId: _currentUser!.id,
        query: queryController.text,
        email: emailController.text,
        phone: phoneController.text,
      );

      if (result['success']) {
        _setSuccess(result['message'] ?? 'Query submitted successfully');
        _resetQueryForm();
        return true;
      } else {
        _setError(result['message'] ?? 'Failed to submit query');
        return false;
      }
    } catch (e) {
      _setError('Error submitting query: $e');
      return false;
    } finally {
      _setSubmittingQuery(false);
    }
  }

  // Reset prescription form
  void _resetPrescriptionForm() {
    _prescriptionFile = null;
    _selectedPharmacy = null;
    notesController.clear();
    _notes = '';
  }

  // Reset query form
  void _resetQueryForm() {
    queryController.clear();
  }

  // Search pharmacies
  List<Pharmacy> searchPharmacies(String query) {
    if (query.isEmpty) return _pharmacies;

    return _pharmacies
        .where((pharmacy) =>
            pharmacy.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // Get pharmacy distance (placeholder - implement with location service)
  String getPharmacyDistance(Pharmacy pharmacy) {
    // TODO: Implement actual distance calculation
    return '${(pharmacy.latitude + pharmacy.longitude).abs().toStringAsFixed(1)} km';
  }

  // Utility methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setLoadingPharmacies(bool loading) {
    _isLoadingPharmacies = loading;
    notifyListeners();
  }

  void _setSubmittingPrescription(bool submitting) {
    _isSubmittingPrescription = submitting;
    notifyListeners();
  }

  void _setSubmittingQuery(bool submitting) {
    _isSubmittingQuery = submitting;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    _successMessage = null;
    notifyListeners();
  }

  void _setSuccess(String message) {
    _successMessage = message;
    _errorMessage = null;
    notifyListeners();
  }

  void _clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }

  void clearMessages() {
    _clearMessages();
  }

  @override
  void dispose() {
    notesController.dispose();
    queryController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
