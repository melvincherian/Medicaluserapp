// class UserPrescription {
//   final String id;
//   final String userId;
//   final Pharmacy pharmacy;
//   final String prescriptionUrl;
//   final String notes;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   UserPrescription({
//     required this.id,
//     required this.userId,
//     required this.pharmacy,
//     required this.prescriptionUrl,
//     required this.notes,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory UserPrescription.fromJson(Map<String, dynamic> json) {
//     return UserPrescription(
//       id: json['_id'] ?? '',
//       userId: json['userId'] ?? '',
//       pharmacy: Pharmacy.fromJson(json['pharmacyId'] ?? {}),
//       prescriptionUrl: json['prescriptionUrl'] ?? '',
//       notes: json['notes'] ?? '',
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'userId': userId,
//       'pharmacyId': pharmacy.toJson(),
//       'prescriptionUrl': prescriptionUrl,
//       'notes': notes,
//       'createdAt': createdAt.toIso8601String(),
//       'updatedAt': updatedAt.toIso8601String(),
//     };
//   }

//   // Helper method to format date
//   String get formattedDate {
//     return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
//   }

//   // Helper method to format time
//   String get formattedTime {
//     final hour = createdAt.hour.toString().padLeft(2, '0');
//     final minute = createdAt.minute.toString().padLeft(2, '0');
//     return '$hour:$minute';
//   }

//   // Helper method to get relative time (e.g., "2 days ago")
//   String get relativeTime {
//     final now = DateTime.now();
//     final difference = now.difference(createdAt);

//     if (difference.inDays > 0) {
//       return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
//     } else if (difference.inHours > 0) {
//       return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
//     } else if (difference.inMinutes > 0) {
//       return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
//     } else {
//       return 'Just now';
//     }
//   }
// }

// class Pharmacy {
//   final String id;
//   final String name;
//   final String? image;

//   Pharmacy({
//     required this.id,
//     required this.name,
//     this.image,
//   });

//   factory Pharmacy.fromJson(Map<String, dynamic> json) {
//     return Pharmacy(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? '',
//       image: json['image'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'name': name,
//       'image': image,
//     };
//   }
// }














class UserPrescription {
  final String id;
  final String prescriptionId;
  final String prescriptionUrl;
  final String notes;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Pharmacy pharmacy;
  final double? proposedAmount;
  final String? proposedDescription;
  final double? deliveryCharge;
  final double? platformFee;
  final double? totalAmount;
  final String? orderId;
  final bool requiresAction;

  UserPrescription({
    required this.id,
    required this.prescriptionId,
    required this.prescriptionUrl,
    required this.notes,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.pharmacy,
    this.proposedAmount,
    this.proposedDescription,
    this.deliveryCharge,
    this.platformFee,
    this.totalAmount,
    this.orderId,
    required this.requiresAction,
  });

  factory UserPrescription.fromJson(Map<String, dynamic> json) {
    return UserPrescription(
      id: json['_id'] ?? '',
      prescriptionId: json['prescriptionId'] ?? json['_id'] ?? '',
      prescriptionUrl: json['prescriptionUrl'] ?? '',
      notes: json['notes'] ?? '',
      status: json['status'] ?? 'Pending',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      pharmacy: Pharmacy.fromJson(json['pharmacy'] ?? {}),
      proposedAmount: json['proposedAmount'] != null
          ? (json['proposedAmount'] as num).toDouble()
          : null,
      proposedDescription: json['proposedDescription'],
      deliveryCharge: json['deliveryCharge'] != null
          ? (json['deliveryCharge'] as num).toDouble()
          : null,
      platformFee: json['platformFee'] != null
          ? (json['platformFee'] as num).toDouble()
          : null,
      totalAmount: json['totalAmount'] != null
          ? (json['totalAmount'] as num).toDouble()
          : null,
      orderId: json['orderId'],
      requiresAction: json['requiresAction'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'prescriptionId': prescriptionId,
      'prescriptionUrl': prescriptionUrl,
      'notes': notes,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'pharmacy': pharmacy.toJson(),
      'proposedAmount': proposedAmount,
      'proposedDescription': proposedDescription,
      'deliveryCharge': deliveryCharge,
      'platformFee': platformFee,
      'totalAmount': totalAmount,
      'orderId': orderId,
      'requiresAction': requiresAction,
    };
  }

  // Whether the user can accept/reject this prescription
  bool get canRespond => status == 'QuoteAccepted' && orderId == null;

  // Whether a quote has been provided by the pharmacy
  bool get hasQuote => proposedAmount != null;

  String get formattedDate {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }

  String get formattedTime {
    final hour = createdAt.hour.toString().padLeft(2, '0');
    final minute = createdAt.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String get relativeTime {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }
}

class Pharmacy {
  final String id;
  final String name;
  final String vendorName;
  final String image;
  final String address;
  final double latitude;
  final double longitude;

  Pharmacy({
    required this.id,
    required this.name,
    required this.vendorName,
    required this.image,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    final coordinates = json['location']?['coordinates'] as List<dynamic>?;
    return Pharmacy(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      vendorName: json['vendorName'] ?? '',
      image: json['image'] ?? '',
      address: json['address'] ?? '',
      latitude: coordinates != null ? (coordinates[1] as num).toDouble() : 0.0,
      longitude: coordinates != null ? (coordinates[0] as num).toDouble() : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'vendorName': vendorName,
      'image': image,
      'address': address,
      'location': {
        'type': 'Point',
        'coordinates': [longitude, latitude],
      },
    };
  }
}