
// providers/notification_provider.dart
import 'package:flutter/material.dart';
import 'package:medical_user_app/models/notification_model.dart';
import 'package:medical_user_app/services/notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationService _notificationService = NotificationService();

  List<NotificationModel> _notifications = [];
  bool _isLoading = false;
  String? _error;

  List<NotificationModel> get notifications => _notifications;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadNotifications(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _notifications = await _notificationService.fetchNotifications(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteNotification(String userId, String notificationId) async {
    try {
      _error = null;
            bool success = await _notificationService.deleteNotification(
        userId, 
        notificationId
      );

      if (success) {
        _notifications.removeWhere((notification) => notification.id == notificationId);
        notifyListeners();
        return true;
      }
      
      return false;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}