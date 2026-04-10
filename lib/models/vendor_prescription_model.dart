// lib/models/quote_model.dart

class QuoteModel {
  final String prescriptionId;
  final String prescriptionUrl;
  final String notes;
  final String status;
  final double proposedAmount;
  final String proposedDescription;
  final double deliveryCharge;
  final double platformFee;
  final double totalAmount;
  final PharmacyModel pharmacy;
  final String? orderId;
  final DateTime quoteSentAt;
  final DateTime createdAt;

  QuoteModel({
    required this.prescriptionId,
    required this.prescriptionUrl,
    required this.notes,
    required this.status,
    required this.proposedAmount,
    required this.proposedDescription,
    required this.deliveryCharge,
    required this.platformFee,
    required this.totalAmount,
    required this.pharmacy,
    this.orderId,
    required this.quoteSentAt,
    required this.createdAt,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      prescriptionId: json['prescriptionId'] ?? '',
      prescriptionUrl: json['prescriptionUrl'] ?? '',
      notes: json['notes'] ?? '',
      status: json['status'] ?? '',
      proposedAmount: (json['proposedAmount'] ?? 0).toDouble(),
      proposedDescription: json['proposedDescription'] ?? '',
      deliveryCharge: (json['deliveryCharge'] ?? 0).toDouble(),
      platformFee: (json['platformFee'] ?? 0).toDouble(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      pharmacy: PharmacyModel.fromJson(json['pharmacy'] ?? {}),
      orderId: json['orderId'],
      quoteSentAt: DateTime.parse(json['quoteSentAt']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class PharmacyModel {
  final String id;
  final String name;
  final String vendorName;
  final String image;
  final String address;

  PharmacyModel({
    required this.id,
    required this.name,
    required this.vendorName,
    required this.image,
    required this.address,
  });

  factory PharmacyModel.fromJson(Map<String, dynamic> json) {
    return PharmacyModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      vendorName: json['vendorName'] ?? '',
      image: json['image'] ?? '',
      address: json['address'] ?? '',
    );
  }
}

class QuoteResponseModel {
  final bool success;
  final String message;
  final String status;
  final OrderModel? order;

  QuoteResponseModel({
    required this.success,
    required this.message,
    required this.status,
    this.order,
  });

  factory QuoteResponseModel.fromJson(Map<String, dynamic> json) {
    return QuoteResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      order: json['order'] != null ? OrderModel.fromJson(json['order']) : null,
    );
  }
}

class OrderModel {
  final String id;
  final double totalAmount;
  final String status;
  final String orderId;

  OrderModel({
    required this.id,
    required this.totalAmount,
    required this.status,
    required this.orderId,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'] ?? '',
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      status: json['status'] ?? '',
      orderId: json['orderId'] ?? '',
    );
  }
}