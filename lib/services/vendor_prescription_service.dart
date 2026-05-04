import 'dart:convert';
import 'package:http/http.dart' as http;

class DeliveryChargeBreakdown {
  final double baseFare;
  final double baseDistanceKm;
  final double additionalChargePerKm;
  final double distanceKm;
  final double extraDistanceKm;
  final double additionalCharge;

  DeliveryChargeBreakdown({
    required this.baseFare,
    required this.baseDistanceKm,
    required this.additionalChargePerKm,
    required this.distanceKm,
    required this.extraDistanceKm,
    required this.additionalCharge,
  });

  factory DeliveryChargeBreakdown.fromJson(Map<String, dynamic> json) {
    return DeliveryChargeBreakdown(
      baseFare: (json['baseFare'] ?? 0).toDouble(),
      baseDistanceKm: (json['baseDistanceKm'] ?? 0).toDouble(),
      additionalChargePerKm: (json['additionalChargePerKm'] ?? 0).toDouble(),
      distanceKm: (json['distanceKm'] ?? 0).toDouble(),
      extraDistanceKm: (json['extraDistanceKm'] ?? 0).toDouble(),
      additionalCharge: (json['additionalCharge'] ?? 0).toDouble(),
    );
  }
}

class DeliveryAddress {
  final String house;
  final String street;
  final String city;
  final String state;
  final String pincode;
  final String country;

  DeliveryAddress({
    required this.house,
    required this.street,
    required this.city,
    required this.state,
    required this.pincode,
    required this.country,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
    return DeliveryAddress(
      house: json['house'] ?? '',
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      pincode: json['pincode'] ?? '',
      country: json['country'] ?? '',
    );
  }

  String get fullAddress =>
      '$house, $street, $city, $state - $pincode, $country';
}

class OrderItem {
  final String medicineId;
  final String name;
  final int quantity;
  final double price;
  final List<String> images;
  final String dosage;
  final String instructions;

  OrderItem({
    required this.medicineId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.images,
    required this.dosage,
    required this.instructions,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      medicineId: json['medicineId'] ?? '',
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      images: List<String>.from(json['images'] ?? []),
      dosage: json['dosage'] ?? '',
      instructions: json['instructions'] ?? '',
    );
  }
}

class OrderPreview {
  final String prescriptionId;
  final String vendorId;
  final String userId;
  final String pharmacyName;
  final String pharmacyImage;
  final String pharmacyAddress;
  final String pharmacyPhone;
  final DeliveryAddress deliveryAddress;
  final List<OrderItem> orderItems;
  final double subTotal;
  final double platformFee;
  final double deliveryCharge;
  final DeliveryChargeBreakdown deliveryChargeBreakdown;
  final double totalAmount;
  final String notes;
  final String paymentMethod;
  final String paymentStatus;
  final String prescriptionUrl;

  OrderPreview({
    required this.prescriptionId,
    required this.vendorId,
    required this.userId,
    required this.pharmacyName,
    required this.pharmacyImage,
    required this.pharmacyAddress,
    required this.pharmacyPhone,
    required this.deliveryAddress,
    required this.orderItems,
    required this.subTotal,
    required this.platformFee,
    required this.deliveryCharge,
    required this.deliveryChargeBreakdown,
    required this.totalAmount,
    required this.notes,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.prescriptionUrl,
  });

  factory OrderPreview.fromJson(Map<String, dynamic> json) {
    return OrderPreview(
      prescriptionId: json['prescriptionId'] ?? '',
      vendorId: json['vendorId'] ?? '',
      userId: json['userId'] ?? '',
      pharmacyName: json['pharmacyName'] ?? '',
      pharmacyImage: json['pharmacyImage'] ?? '',
      pharmacyAddress: json['pharmacyAddress'] ?? '',
      pharmacyPhone: json['pharmacyPhone'] ?? '',
      deliveryAddress: DeliveryAddress.fromJson(json['deliveryAddress'] ?? {}),
      orderItems: (json['orderItems'] as List<dynamic>? ?? [])
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      subTotal: (json['subTotal'] ?? 0).toDouble(),
      platformFee: (json['platformFee'] ?? 0).toDouble(),
      deliveryCharge: (json['deliveryCharge'] ?? 0).toDouble(),
      deliveryChargeBreakdown: DeliveryChargeBreakdown.fromJson(
          json['deliveryChargeBreakdown'] ?? {}),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      notes: json['notes'] ?? '',
      paymentMethod: json['paymentMethod'] ?? '',
      paymentStatus: json['paymentStatus'] ?? '',
      prescriptionUrl: json['prescriptionUrl'] ?? '',
    );
  }
}

class PrescriptionPreview {
  final String notificationId;
  final String prescriptionId;
  final String vendorId;
  final OrderPreview orderPreview;
  final String message;
  final DateTime timestamp;
  final bool read;

  PrescriptionPreview({
    required this.notificationId,
    required this.prescriptionId,
    required this.vendorId,
    required this.orderPreview,
    required this.message,
    required this.timestamp,
    required this.read,
  });

  factory PrescriptionPreview.fromJson(Map<String, dynamic> json) {
    return PrescriptionPreview(
      notificationId: json['notificationId'] ?? '',
      prescriptionId: json['prescriptionId'] ?? '',
      vendorId: json['vendorId'] ?? '',
      orderPreview: OrderPreview.fromJson(json['orderPreview'] ?? {}),
      message: json['message'] ?? '',
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
      read: json['read'] ?? false,
    );
  }
}

class PrescriptionPreviewResult {
  final bool success;
  final String message;
  final int count;
  final List<PrescriptionPreview> previews;

  PrescriptionPreviewResult({
    required this.success,
    required this.message,
    required this.count,
    required this.previews,
  });
}

class ConfirmOrderResult {
  final bool success;
  final String message;

  ConfirmOrderResult({required this.success, required this.message});
}

class PrescriptionPreviewService {
  static const String _baseUrl = 'https://api.simcurarx.com/api';

  // Fetch pending prescription order previews for a user
  Future<PrescriptionPreviewResult> fetchPrescriptionPreviews({
    required String userId,
    required String token,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl/users/prescription-previews/$userId');

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      print(
          'Response status code for get vendor prescriptionnnnnnnn ${response.statusCode}');
      print(
          'Response bodyyyyyyyyyyy for get vendor prescriptionnnnnnnn ${response.body}');

      if (response.statusCode == 200 && data['success'] == true) {
        final previewsList = (data['previews'] as List<dynamic>? ?? [])
            .map((p) => PrescriptionPreview.fromJson(p))
            .toList();

        return PrescriptionPreviewResult(
          success: true,
          message: data['message'] ?? '',
          count: data['count'] ?? 0,
          previews: previewsList,
        );
      } else {
        return PrescriptionPreviewResult(
          success: false,
          message: data['message'] ?? 'Failed to fetch prescription previews',
          count: 0,
          previews: [],
        );
      }
    } catch (e) {
      print('Error fetching prescription previews: $e');
      return PrescriptionPreviewResult(
        success: false,
        message: 'An error occurred: $e',
        count: 0,
        previews: [],
      );
    }
  }

  // Confirm or reject a prescription order
  Future<ConfirmOrderResult> confirmPrescriptionOrder({
    required String userId,
    required String prescriptionId,
    required bool accept,
    required String token,
  }) async {
    try {
      final action = accept ? 'confirm' : 'reject';

      final uri = Uri.parse(
        '$_baseUrl/users/confirm-prescription-order/$userId/$prescriptionId',
      );

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'action': action}),
      );

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      print(
          'Response status code for accept or reject precription orderrrrrrrrrr ${response.statusCode}');
      print(
          'Response bodyyyyyyyyyyyyyyyy for accept or reject precription orderrrrrrrrrr ${response.body}');
      print('acccccccccccctionnnnnnnnnnnnnn $action');

      // if (response.statusCode == 200 && data['success'] == true) {
      //   return ConfirmOrderResult(
      //     success: true,
      //     message: data['message'] ?? 'Order ${accept ? 'confirmed' : 'rejected'} successfully',
      //   );
      // }

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          data['success'] == true) {
        return ConfirmOrderResult(
          success: true,
          message: data['message'] ??
              'Order ${accept ? 'confirmed' : 'rejected'} successfully',
        );
      } else {
        return ConfirmOrderResult(
          success: false,
          message: data['message'] ??
              'Failed to ${accept ? 'confirm' : 'reject'} order',
        );
      }
    } catch (e) {
      print('Error confirming prescription order: $e');
      return ConfirmOrderResult(
        success: false,
        message: 'An error occurred: $e',
      );
    }
  }
}
