import 'package:flutter/material.dart';
import 'package:medical_user_app/services/vendor_prescription_service.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';


enum PrescriptionPreviewState { idle, loading, loaded, error }

enum ConfirmOrderState { idle, loading, success, error }

class PrescriptionPreviewProvider extends ChangeNotifier {
  final PrescriptionPreviewService _service = PrescriptionPreviewService();

  // ─── Fetch Previews State ──────────────────────────────────────────────────

  PrescriptionPreviewState _fetchState = PrescriptionPreviewState.idle;
  List<PrescriptionPreview> _previews = [];
  int _previewCount = 0;
  String _fetchError = '';

  PrescriptionPreviewState get fetchState => _fetchState;
  List<PrescriptionPreview> get previews => _previews;
  int get previewCount => _previewCount;
  String get fetchError => _fetchError;
  bool get isLoadingPreviews => _fetchState == PrescriptionPreviewState.loading;
  bool get hasPreviews => _previews.isNotEmpty;

  // ─── Confirm / Reject Order State ─────────────────────────────────────────

  ConfirmOrderState _confirmState = ConfirmOrderState.idle;
  String _confirmMessage = '';
  String? _processingPrescriptionId; // tracks which card is in-flight

  ConfirmOrderState get confirmState => _confirmState;
  String get confirmMessage => _confirmMessage;
  String? get processingPrescriptionId => _processingPrescriptionId;
  bool get isConfirming => _confirmState == ConfirmOrderState.loading;

  bool isProcessing(String prescriptionId) =>
      _processingPrescriptionId == prescriptionId &&
      _confirmState == ConfirmOrderState.loading;

  // ─── Fetch Prescription Previews ──────────────────────────────────────────

  Future<void> fetchPrescriptionPreviews() async {
    _fetchState = PrescriptionPreviewState.loading;
    _fetchError = '';
    notifyListeners();

    try {
      final authData = await SharedPreferencesHelper.getAuthData();
      final token = authData['token'] as String?;
      final user = authData['user'];

      if (token == null || token.isEmpty) {
        _fetchState = PrescriptionPreviewState.error;
        _fetchError = 'Authentication token not found. Please log in again.';
        notifyListeners();
        return;
      }

      if (user == null || (user.id as String).isEmpty) {
        _fetchState = PrescriptionPreviewState.error;
        _fetchError = 'User data not found. Please log in again.';
        notifyListeners();
        return;
      }

      final result = await _service.fetchPrescriptionPreviews(
        userId: user.id as String,
        token: token,
      );

      if (result.success) {
        _previews = result.previews;
        _previewCount = result.count;
        _fetchState = PrescriptionPreviewState.loaded;
      } else {
        _fetchError = result.message;
        _fetchState = PrescriptionPreviewState.error;
      }
    } catch (e) {
      _fetchError = 'Unexpected error: $e';
      _fetchState = PrescriptionPreviewState.error;
    }

    notifyListeners();
  }

  // ─── Confirm or Reject Order ───────────────────────────────────────────────

  Future<bool> confirmOrder({
    required String prescriptionId,
    required bool accept,
    VoidCallback? onSuccess,
    void Function(String error)? onError,
  }) async {
    _confirmState = ConfirmOrderState.loading;
    _processingPrescriptionId = prescriptionId;
    _confirmMessage = '';
    notifyListeners();

    try {
      final authData = await SharedPreferencesHelper.getAuthData();
      final token = authData['token'] as String?;
      final user = authData['user'];

      if (token == null || token.isEmpty) {
        _confirmState = ConfirmOrderState.error;
        _confirmMessage = 'Authentication token not found. Please log in again.';
        _processingPrescriptionId = null;
        notifyListeners();
        onError?.call(_confirmMessage);
        return false;
      }

      if (user == null || (user.id as String).isEmpty) {
        _confirmState = ConfirmOrderState.error;
        _confirmMessage = 'User data not found. Please log in again.';
        _processingPrescriptionId = null;
        notifyListeners();
        onError?.call(_confirmMessage);
        return false;
      }

      final result = await _service.confirmPrescriptionOrder(
        userId: user.id as String,
        prescriptionId: prescriptionId,
        accept: accept,
        token: token,
      );

      if (result.success) {
        _confirmState = ConfirmOrderState.success;
        _confirmMessage = result.message;

        // Remove the confirmed/rejected preview from the local list
        _previews.removeWhere((p) => p.prescriptionId == prescriptionId);
        _previewCount = _previews.length;

        _processingPrescriptionId = null;
        notifyListeners();
        onSuccess?.call();
        return true;
      } else {
        _confirmState = ConfirmOrderState.error;
        _confirmMessage = result.message;
        _processingPrescriptionId = null;
        notifyListeners();
        onError?.call(_confirmMessage);
        return false;
      }
    } catch (e) {
      _confirmState = ConfirmOrderState.error;
      _confirmMessage = 'Unexpected error: $e';
      _processingPrescriptionId = null;
      notifyListeners();
      onError?.call(_confirmMessage);
      return false;
    }
  }

  // ─── Helpers ──────────────────────────────────────────────────────────────

  /// Call on screen init to load fresh data
  Future<void> init() async {
    await fetchPrescriptionPreviews();
  }

  /// Reset confirm state (e.g., after showing a snackbar)
  void resetConfirmState() {
    _confirmState = ConfirmOrderState.idle;
    _confirmMessage = '';
    notifyListeners();
  }

  /// Clear everything (e.g., on logout)
  void clear() {
    _previews = [];
    _previewCount = 0;
    _fetchState = PrescriptionPreviewState.idle;
    _fetchError = '';
    _confirmState = ConfirmOrderState.idle;
    _confirmMessage = '';
    _processingPrescriptionId = null;
    notifyListeners();
  }
}