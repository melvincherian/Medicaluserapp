

// // class PharmacyLocation {
// //   final String type;
// //   final List<double> coordinates;

// //   PharmacyLocation({
// //     required this.type,
// //     required this.coordinates,
// //   });

// //   factory PharmacyLocation.fromJson(Map<String, dynamic> json) {
// //     return PharmacyLocation(
// //       type: json['type'] ?? '',
// //       coordinates: List<double>.from(json['coordinates'] ?? []),
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'type': type,
// //       'coordinates': coordinates,
// //     };
// //   }
// // }

// // class PharmacyCategory {
// //   final String name;
// //   final String image;
// //   final String id;

// //   PharmacyCategory({
// //     required this.name,
// //     required this.image,
// //     required this.id,
// //   });

// //   factory PharmacyCategory.fromJson(Map<String, dynamic> json) {
// //     return PharmacyCategory(
// //       name: json['name'] ?? '',
// //       image: json['image'] ?? '',
// //       id: json['_id'] ?? '',
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'name': name,
// //       'image': image,
// //       '_id': id,
// //     };
// //   }
// // }

// // class Pharmacy {
// //   final PharmacyLocation location;
// //   final String id;
// //   final String name;
// //   final String image;
// //   final double latitude;
// //   final double longitude;
// //   final String address;
// //   final String createdAt;
// //   final String updatedAt;
// //   final int version;
// //   final List<PharmacyCategory> categories;
// //   final List<dynamic> products; // You can create a Product model later if needed

// //   Pharmacy({
// //     required this.location,
// //     required this.id,
// //     required this.name,
// //     required this.image,
// //     required this.latitude,
// //     required this.longitude,
// //     required this.address,
// //     required this.createdAt,
// //     required this.updatedAt,
// //     required this.version,
// //     required this.categories,
// //     required this.products,
// //   });

// //   factory Pharmacy.fromJson(Map<String, dynamic> json) {
// //     return Pharmacy(
// //       location: PharmacyLocation.fromJson(json['location'] ?? {}),
// //       id: json['_id'] ?? '',
// //       name: json['name'] ?? '',
// //       image: json['image'] ?? '',
// //       latitude: (json['latitude'] ?? 0.0).toDouble(),
// //       longitude: (json['longitude'] ?? 0.0).toDouble(),
// //       address: json['address'] ?? '',
// //       createdAt: json['createdAt'] ?? '',
// //       updatedAt: json['updatedAt'] ?? '',
// //       version: json['__v'] ?? 0,
// //       categories: (json['categories'] as List<dynamic>? ?? [])
// //           .map((category) => PharmacyCategory.fromJson(category))
// //           .toList(),
// //       products: json['products'] ?? [],
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'location': location.toJson(),
// //       '_id': id,
// //       'name': name,
// //       'image': image,
// //       'latitude': latitude,
// //       'longitude': longitude,
// //       'address': address,
// //       'createdAt': createdAt,
// //       'updatedAt': updatedAt,
// //       '__v': version,
// //       'categories': categories.map((category) => category.toJson()).toList(),
// //       'products': products,
// //     };
// //   }
// // }

// // class PharmacyResponse {
// //   final String message;
// //   final int total;
// //   final List<Pharmacy> pharmacies;

// //   PharmacyResponse({
// //     required this.message,
// //     required this.total,
// //     required this.pharmacies,
// //   });

// //   factory PharmacyResponse.fromJson(Map<String, dynamic> json) {
// //     return PharmacyResponse(
// //       message: json['message'] ?? '',
// //       total: json['total'] ?? 0,
// //       pharmacies: (json['pharmacies'] as List<dynamic>? ?? [])
// //           .map((pharmacy) => Pharmacy.fromJson(pharmacy))
// //           .toList(),
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'message': message,
// //       'total': total,
// //       'pharmacies': pharmacies.map((pharmacy) => pharmacy.toJson()).toList(),
// //     };
// //   }
// // }







// class PharmacyLocation {
//   final String type;
//   final List<double> coordinates;

//   PharmacyLocation({
//     required this.type,
//     required this.coordinates,
//   });

//   factory PharmacyLocation.fromJson(Map<String, dynamic> json) {
//     List<double> coords = [];
//     if (json['coordinates'] != null) {
//       coords = (json['coordinates'] as List)
//           .map((e) => (e is int) ? e.toDouble() : (e as double))
//           .toList();
//     }
    
//     return PharmacyLocation(
//       type: json['type'] ?? '',
//       coordinates: coords,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'type': type,
//       'coordinates': coordinates,
//     };
//   }
// }

// class PharmacyCategory {
//   final String name;
//   final String image;
//   final String id;

//   PharmacyCategory({
//     required this.name,
//     required this.image,
//     required this.id,
//   });

//   factory PharmacyCategory.fromJson(Map<String, dynamic> json) {
//     return PharmacyCategory(
//       name: json['name'] ?? '',
//       image: json['image'] ?? '',
//       id: json['_id'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'image': image,
//       '_id': id,
//     };
//   }
// }

// class PaymentHistory {
//   final String month;
//   final String status;
//   final double amount;
//   final String date;
//   final String id;

//   PaymentHistory({
//     required this.month,
//     required this.status,
//     required this.amount,
//     required this.date,
//     required this.id,
//   });

//   factory PaymentHistory.fromJson(Map<String, dynamic> json) {
//     return PaymentHistory(
//       month: json['month'] ?? '',
//       status: json['status'] ?? '',
//       amount: (json['amount'] is int) 
//           ? (json['amount'] as int).toDouble() 
//           : (json['amount'] ?? 0.0).toDouble(),
//       date: json['date'] ?? '',
//       id: json['_id'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'month': month,
//       'status': status,
//       'amount': amount,
//       'date': date,
//       '_id': id,
//     };
//   }
// }

// class Notification {
//   final String orderId;
//   final String status;
//   final String message;
//   final String timestamp;
//   final bool read;
//   final String id;

//   Notification({
//     required this.orderId,
//     required this.status,
//     required this.message,
//     required this.timestamp,
//     required this.read,
//     required this.id,
//   });

//   factory Notification.fromJson(Map<String, dynamic> json) {
//     return Notification(
//       orderId: json['orderId'] ?? '',
//       status: json['status'] ?? '',
//       message: json['message'] ?? '',
//       timestamp: json['timestamp'] ?? '',
//       read: json['read'] ?? false,
//       id: json['_id'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'orderId': orderId,
//       'status': status,
//       'message': message,
//       'timestamp': timestamp,
//       'read': read,
//       '_id': id,
//     };
//   }
// }

// class RevenueByMonth {
//   final double amount;
//   final String status;

//   RevenueByMonth({
//     required this.amount,
//     required this.status,
//   });

//   factory RevenueByMonth.fromJson(Map<String, dynamic> json) {
//     return RevenueByMonth(
//       amount: (json['amount'] is int) 
//           ? (json['amount'] as int).toDouble() 
//           : (json['amount'] ?? 0.0).toDouble(),
//       status: json['status'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'amount': amount,
//       'status': status,
//     };
//   }
// }

// class Pharmacy {
//   final PharmacyLocation location;
//   final String id;
//   final String name;
//   final String image;
//   final double latitude;
//   final double longitude;
//   final String address;
//   final String vendorName;
//   final String vendorEmail;
//   final String vendorPhone;
//   final String status;
//   final String vendorId;
//   final String password;
//   final String aadhar;
//   final String panCard;
//   final String license;
//   final String aadharFile;
//   final String licenseFile;
//   final String panCardFile;
//   final String createdAt;
//   final String updatedAt;
//   final int version;
//   final List<PharmacyCategory> categories;
//   final List<dynamic> products;
//   final List<dynamic> bankDetails;
//   final List<PaymentHistory> paymentHistory;
//   final List<Notification> notifications;
//   final Map<String, String>? paymentStatus;
//   final Map<String, RevenueByMonth>? revenueByMonth;

//   Pharmacy({
//     required this.location,
//     required this.id,
//     required this.name,
//     required this.image,
//     required this.latitude,
//     required this.longitude,
//     required this.address,
//     required this.vendorName,
//     required this.vendorEmail,
//     required this.vendorPhone,
//     required this.status,
//     required this.vendorId,
//     required this.password,
//     required this.aadhar,
//     required this.panCard,
//     required this.license,
//     required this.aadharFile,
//     required this.licenseFile,
//     required this.panCardFile,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.version,
//     required this.categories,
//     required this.products,
//     required this.bankDetails,
//     required this.paymentHistory,
//     required this.notifications,
//     this.paymentStatus,
//     this.revenueByMonth,
//   });

//   factory Pharmacy.fromJson(Map<String, dynamic> json) {
//     // Helper function to safely convert to double
//     double _toDouble(dynamic value) {
//       if (value == null) return 0.0;
//       if (value is double) return value;
//       if (value is int) return value.toDouble();
//       if (value is String) return double.tryParse(value) ?? 0.0;
//       return 0.0;
//     }

//     // Parse paymentStatus map
//     Map<String, String>? paymentStatusMap;
//     if (json['paymentStatus'] != null) {
//       paymentStatusMap = Map<String, String>.from(json['paymentStatus']);
//     }

//     // Parse revenueByMonth map
//     Map<String, RevenueByMonth>? revenueByMonthMap;
//     if (json['revenueByMonth'] != null) {
//       revenueByMonthMap = {};
//       (json['revenueByMonth'] as Map<String, dynamic>).forEach((key, value) {
//         revenueByMonthMap![key] = RevenueByMonth.fromJson(value);
//       });
//     }

//     return Pharmacy(
//       location: PharmacyLocation.fromJson(json['location'] ?? {}),
//       id: json['_id'] ?? '',
//       name: json['name'] ?? '',
//       image: json['image'] ?? '',
//       latitude: _toDouble(json['latitude']),
//       longitude: _toDouble(json['longitude']),
//       address: json['address'] ?? '',
//       vendorName: json['vendorName'] ?? '',
//       vendorEmail: json['vendorEmail'] ?? '',
//       vendorPhone: json['vendorPhone'] ?? '',
//       status: json['status'] ?? '',
//       vendorId: json['vendorId'] ?? '',
//       password: json['password'] ?? '',
//       aadhar: json['aadhar'] ?? '',
//       panCard: json['panCard'] ?? '',
//       license: json['license'] ?? '',
//       aadharFile: json['aadharFile'] ?? '',
//       licenseFile: json['licenseFile'] ?? '',
//       panCardFile: json['panCardFile'] ?? '',
//       createdAt: json['createdAt'] ?? '',
//       updatedAt: json['updatedAt'] ?? '',
//       version: json['__v'] ?? 0,
//       categories: (json['categories'] as List<dynamic>? ?? [])
//           .map((category) => PharmacyCategory.fromJson(category))
//           .toList(),
//       products: json['products'] ?? [],
//       bankDetails: json['bankDetails'] ?? [],
//       paymentHistory: (json['paymentHistory'] as List<dynamic>? ?? [])
//           .map((payment) => PaymentHistory.fromJson(payment))
//           .toList(),
//       notifications: (json['notifications'] as List<dynamic>? ?? [])
//           .map((notification) => Notification.fromJson(notification))
//           .toList(),
//       paymentStatus: paymentStatusMap,
//       revenueByMonth: revenueByMonthMap,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     Map<String, dynamic>? revenueByMonthJson;
//     if (revenueByMonth != null) {
//       revenueByMonthJson = {};
//       revenueByMonth!.forEach((key, value) {
//         revenueByMonthJson![key] = value.toJson();
//       });
//     }

//     return {
//       'location': location.toJson(),
//       '_id': id,
//       'name': name,
//       'image': image,
//       'latitude': latitude,
//       'longitude': longitude,
//       'address': address,
//       'vendorName': vendorName,
//       'vendorEmail': vendorEmail,
//       'vendorPhone': vendorPhone,
//       'status': status,
//       'vendorId': vendorId,
//       'password': password,
//       'aadhar': aadhar,
//       'panCard': panCard,
//       'license': license,
//       'aadharFile': aadharFile,
//       'licenseFile': licenseFile,
//       'panCardFile': panCardFile,
//       'createdAt': createdAt,
//       'updatedAt': updatedAt,
//       '__v': version,
//       'categories': categories.map((category) => category.toJson()).toList(),
//       'products': products,
//       'bankDetails': bankDetails,
//       'paymentHistory':
//           paymentHistory.map((payment) => payment.toJson()).toList(),
//       'notifications':
//           notifications.map((notification) => notification.toJson()).toList(),
//       if (paymentStatus != null) 'paymentStatus': paymentStatus,
//       if (revenueByMonthJson != null) 'revenueByMonth': revenueByMonthJson,
//     };
//   }
// }

// class PharmacyResponse {
//   final String message;
//   final int total;
//   final List<Pharmacy> pharmacies;

//   PharmacyResponse({
//     required this.message,
//     required this.total,
//     required this.pharmacies,
//   });

//   factory PharmacyResponse.fromJson(Map<String, dynamic> json) {
//     return PharmacyResponse(
//       message: json['message'] ?? '',
//       total: json['total'] ?? 0,
//       pharmacies: (json['pharmacies'] as List<dynamic>? ?? [])
//           .map((pharmacy) => Pharmacy.fromJson(pharmacy))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'message': message,
//       'total': total,
//       'pharmacies': pharmacies.map((pharmacy) => pharmacy.toJson()).toList(),
//     };
//   }
// }














// ================================================================
//               SAFE PARSER HELPERS (GLOBAL FUNCTIONS)
// ================================================================

double parseDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}

int parseInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}

String parseString(dynamic value) {
  if (value == null) return "";
  return value.toString();
}

bool parseBool(dynamic value) {
  if (value == null) return false;
  if (value is bool) return value;
  if (value is int) return value == 1;
  if (value is String) return value.toLowerCase() == "true";
  return false;
}

Map<String, dynamic> parseMap(dynamic value) {
  if (value is Map<String, dynamic>) return value;
  return {};
}

List<T> parseList<T>(dynamic value, T Function(dynamic) parser) {
  if (value is List) {
    return value.map((e) => parser(e)).toList();
  }
  return [];
}

// ================================================================
//                         MODEL CLASSES
// ================================================================

class PharmacyLocation {
  final String type;
  final List<double> coordinates;

  PharmacyLocation({
    required this.type,
    required this.coordinates,
  });

  factory PharmacyLocation.fromJson(Map<String, dynamic> json) {
    return PharmacyLocation(
      type: parseString(json['type']),
      coordinates: parseList(json['coordinates'], (e) => parseDouble(e)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}

// -------------------------------------------------------------

class PharmacyCategory {
  final String name;
  final String image;
  final String id;

  PharmacyCategory({
    required this.name,
    required this.image,
    required this.id,
  });

  factory PharmacyCategory.fromJson(Map<String, dynamic> json) {
    return PharmacyCategory(
      name: parseString(json['name']),
      image: parseString(json['image']),
      id: parseString(json['_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      '_id': id,
    };
  }
}

// -------------------------------------------------------------

class PaymentHistory {
  final String month;
  final String status;
  final double amount;
  final String date;
  final String id;

  PaymentHistory({
    required this.month,
    required this.status,
    required this.amount,
    required this.date,
    required this.id,
  });

  factory PaymentHistory.fromJson(Map<String, dynamic> json) {
    return PaymentHistory(
      month: parseString(json['month']),
      status: parseString(json['status']),
      amount: parseDouble(json['amount']),
      date: parseString(json['date']),
      id: parseString(json['_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'status': status,
      'amount': amount,
      'date': date,
      '_id': id,
    };
  }
}

// -------------------------------------------------------------

class Notification {
  final String orderId;
  final String status;
  final String message;
  final String timestamp;
  final bool read;
  final String id;

  Notification({
    required this.orderId,
    required this.status,
    required this.message,
    required this.timestamp,
    required this.read,
    required this.id,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      orderId: parseString(json['orderId']),
      status: parseString(json['status']),
      message: parseString(json['message']),
      timestamp: parseString(json['timestamp']),
      read: parseBool(json['read']),
      id: parseString(json['_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'status': status,
      'message': message,
      'timestamp': timestamp,
      'read': read,
      '_id': id,
    };
  }
}

// -------------------------------------------------------------

class RevenueByMonth {
  final double amount;
  final String status;

  RevenueByMonth({
    required this.amount,
    required this.status,
  });

  factory RevenueByMonth.fromJson(Map<String, dynamic> json) {
    return RevenueByMonth(
      amount: parseDouble(json['amount']),
      status: parseString(json['status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'status': status,
    };
  }
}

// -------------------------------------------------------------

class Pharmacy {
  final PharmacyLocation location;
  final String id;
  final String name;
  final String image;
  final double latitude;
  final double longitude;
  final String address;
  final String vendorName;
  final String vendorEmail;
  final String vendorPhone;
  final String status;
  final String vendorId;
  final String password;
  final String aadhar;
  final String panCard;
  final String license;
  final String aadharFile;
  final String licenseFile;
  final String panCardFile;
  final String createdAt;
  final String updatedAt;
  final int version;
  final List<PharmacyCategory> categories;
  final List<dynamic> products;
  final List<dynamic> bankDetails;
  final List<PaymentHistory> paymentHistory;
  final List<Notification> notifications;
  final Map<String, String>? paymentStatus;
  final Map<String, RevenueByMonth>? revenueByMonth;

  Pharmacy({
    required this.location,
    required this.id,
    required this.name,
    required this.image,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.vendorName,
    required this.vendorEmail,
    required this.vendorPhone,
    required this.status,
    required this.vendorId,
    required this.password,
    required this.aadhar,
    required this.panCard,
    required this.license,
    required this.aadharFile,
    required this.licenseFile,
    required this.panCardFile,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.categories,
    required this.products,
    required this.bankDetails,
    required this.paymentHistory,
    required this.notifications,
    this.paymentStatus,
    this.revenueByMonth,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      location: PharmacyLocation.fromJson(parseMap(json['location'])),

      id: parseString(json['_id']),
      name: parseString(json['name']),
      image: parseString(json['image']),

      latitude: parseDouble(json['latitude']),
      longitude: parseDouble(json['longitude']),
      address: parseString(json['address']),
      vendorName: parseString(json['vendorName']),
      vendorEmail: parseString(json['vendorEmail']),
      vendorPhone: parseString(json['vendorPhone']),
      status: parseString(json['status']),
      vendorId: parseString(json['vendorId']),
      password: parseString(json['password']),
      aadhar: parseString(json['aadhar']),
      panCard: parseString(json['panCard']),
      license: parseString(json['license']),
      aadharFile: parseString(json['aadharFile']),
      licenseFile: parseString(json['licenseFile']),
      panCardFile: parseString(json['panCardFile']),
      createdAt: parseString(json['createdAt']),
      updatedAt: parseString(json['updatedAt']),
      version: parseInt(json['__v']),

      categories: parseList(
        json['categories'],
        (e) => PharmacyCategory.fromJson(parseMap(e)),
      ),

      products: (json['products'] is List) ? json['products'] : [],

      bankDetails: (json['bankDetails'] is List) ? json['bankDetails'] : [],

      paymentHistory: parseList(
        json['paymentHistory'],
        (e) => PaymentHistory.fromJson(parseMap(e)),
      ),

      notifications: parseList(
        json['notifications'],
        (e) => Notification.fromJson(parseMap(e)),
      ),

      paymentStatus: (json['paymentStatus'] is Map)
          ? Map<String, String>.from(json['paymentStatus'])
          : null,

      revenueByMonth: (json['revenueByMonth'] is Map)
          ? (json['revenueByMonth'] as Map).map(
              (key, value) =>
                  MapEntry(key.toString(), RevenueByMonth.fromJson(parseMap(value))),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location.toJson(),
      '_id': id,
      'name': name,
      'image': image,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'vendorName': vendorName,
      'vendorEmail': vendorEmail,
      'vendorPhone': vendorPhone,
      'status': status,
      'vendorId': vendorId,
      'password': password,
      'aadhar': aadhar,
      'panCard': panCard,
      'license': license,
      'aadharFile': aadharFile,
      'licenseFile': licenseFile,
      'panCardFile': panCardFile,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': version,
      'categories': categories.map((e) => e.toJson()).toList(),
      'products': products,
      'bankDetails': bankDetails,
      'paymentHistory': paymentHistory.map((e) => e.toJson()).toList(),
      'notifications': notifications.map((e) => e.toJson()).toList(),
      if (paymentStatus != null) 'paymentStatus': paymentStatus,
      if (revenueByMonth != null)
        'revenueByMonth': revenueByMonth!.map((k, v) => MapEntry(k, v.toJson())),
    };
  }
}

// -------------------------------------------------------------

class PharmacyResponse {
  final String message;
  final int total;
  final List<Pharmacy> pharmacies;

  PharmacyResponse({
    required this.message,
    required this.total,
    required this.pharmacies,
  });

  factory PharmacyResponse.fromJson(Map<String, dynamic> json) {
    return PharmacyResponse(
      message: parseString(json['message']),
      total: parseInt(json['total']),
      pharmacies: parseList(
        json['pharmacies'],
        (e) => Pharmacy.fromJson(parseMap(e)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'total': total,
      'pharmacies': pharmacies.map((e) => e.toJson()).toList(),
    };
  }
}
