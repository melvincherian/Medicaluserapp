// services/notification_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/constant/api_constants.dart';
import 'package:medical_user_app/models/notification_model.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';

class NotificationService {
  Future<List<NotificationModel>> fetchNotifications(String userId) async {
    try {
      final token = await SharedPreferencesHelper.getToken();
      final url = ApiConstants.getNotifications.replaceAll(':userId', userId);

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print(
          'notification statussss codeeeeeeeeeeeeeeeeeeeeee ${response.statusCode}');
      print('notification bodyyyyyyyyyyyyyyyyyyyyyyy ${response.body}');

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final List<dynamic> notificationsJson = body['notifications'] ?? [];
        return notificationsJson
            .map((json) => NotificationModel.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Failed to load notifications (Status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Error fetching notifications: $e');
    }
  }

Future<bool> deleteNotification(String userId, String notificationId) async {
  try {
    final token = await SharedPreferencesHelper.getToken();
    final url = ApiConstants.deletenotification
        .replaceAll(':userId', userId)
        .replaceAll(':notificationId', notificationId);

    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );


    print('Notification id for single delete notification id $notificationId');

    print('Delete notification status code: ${response.statusCode}');
    print('Delete notification body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else {
      throw Exception(
          'Failed to delete notification (Status: ${response.statusCode})');
    }
  } catch (e) {
    print('Error deleting notification: $e');
    throw Exception('Error deleting notification: $e');
  }
}



Future<bool> deleteAllNotifications(String userId, List<String> notificationIds) async {
  try {
    final token = await SharedPreferencesHelper.getToken();
    final url = ApiConstants.deleteallnotification.replaceAll(':userId', userId);

    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'notificationIds': notificationIds,
      }),
    );

    print('notification idddddddsssssssssssssssss $notificationIds');

    print('Delete all notifications status code: ${response.statusCode}');
    print('Delete all notifications body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else {
      throw Exception(
          'Failed to delete all notifications (Status: ${response.statusCode})');
    }
  } catch (e) {
    print('Error deleting all notifications: $e');
    throw Exception('Error deleting all notifications: $e');
  }
}




}
