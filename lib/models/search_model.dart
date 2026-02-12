// class Medicine {
//   final String medicineId;
//   final String name;
//   final List<String> images;
//   final int price;
//   final int mrp;
//   final String description;
//   final String categoryName;
//   final Pharmacy pharmacy;

//   Medicine({
//     required this.medicineId,
//     required this.name,
//     required this.images,
//     required this.price,
//     required this.mrp,
//     required this.description,
//     required this.categoryName,
//     required this.pharmacy,
//   });

//   factory Medicine.fromJson(Map<String, dynamic> json) {
//     return Medicine(
//       medicineId: json['medicineId'] ?? '',
//       name: json['name'] ?? '',
//       images: List<String>.from(json['images'] ?? []),
//       price: json['price'] ?? 0,
//       mrp: json['mrp'] ?? 0,
//       description: json['description'] ?? '',
//       categoryName: json['categoryName'] ?? '',
//       pharmacy: Pharmacy.fromJson(json['pharmacy'] ?? {}),
//     );
//   }
// }

// class Pharmacy {
//   final String id;
//   final String name;
//   final Location location;

//   Pharmacy({
//     required this.id,
//     required this.name,
//     required this.location,
//   });

//   factory Pharmacy.fromJson(Map<String, dynamic> json) {
//     return Pharmacy(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? '',
//       location: Location.fromJson(json['location'] ?? {}),
//     );
//   }
// }

// class Location {
//   final String type;
//   final List<double> coordinates;

//   Location({
//     required this.type,
//     required this.coordinates,
//   });

//   factory Location.fromJson(Map<String, dynamic> json) {
//     return Location(
//       type: json['type'] ?? '',
//       coordinates: List<double>.from(json['coordinates'] ?? []),
//     );
//   }
// }

// class ApiResponse {
//   final String message;
//   final int total;
//   final List<Medicine> medicines;

//   ApiResponse({
//     required this.message,
//     required this.total,
//     required this.medicines,
//   });

//   factory ApiResponse.fromJson(Map<String, dynamic> json) {
//     return ApiResponse(
//       message: json['message'] ?? '',
//       total: json['total'] ?? 0,
//       medicines: (json['medicines'] as List? ?? [])
//           .map((medicine) => Medicine.fromJson(medicine))
//           .toList(),
//     );
//   }
// }














import 'dart:convert';

class ApiResponse {
  final String message;
  final int total;
  final List<Medicine> medicines;

  ApiResponse({
    required this.message,
    required this.total,
    required this.medicines,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json['message'] ?? '',
      total: json['total'] ?? 0,
      medicines: (json['medicines'] as List<dynamic>?)
              ?.map((item) => Medicine.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class Medicine {
  final String medicineId;
  final String name;
  final List<String> images;
  final double price;
  final double mrp;
  final String description;
  final String categoryName;
  final Pharmacy pharmacy;

  Medicine({
    required this.medicineId,
    required this.name,
    required this.images,
    required this.price,
    required this.mrp,
    required this.description,
    required this.categoryName,
    required this.pharmacy,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      medicineId: json['medicineId'] ?? '',
      name: json['name'] ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((item) => item.toString())
              .toList() ??
          [],
      // Fix: Convert to double to handle both int and double from API
      price: (json['price'] is int) 
          ? (json['price'] as int).toDouble() 
          : (json['price'] as double? ?? 0.0),
      mrp: (json['mrp'] is int) 
          ? (json['mrp'] as int).toDouble() 
          : (json['mrp'] as double? ?? 0.0),
      description: json['description'] ?? '',
      categoryName: json['categoryName'] ?? '',
      pharmacy: Pharmacy.fromJson(json['pharmacy'] as Map<String, dynamic>? ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medicineId': medicineId,
      'name': name,
      'images': images,
      'price': price,
      'mrp': mrp,
      'description': description,
      'categoryName': categoryName,
      'pharmacy': pharmacy.toJson(),
    };
  }
}

class Pharmacy {
  final String id;
  final String name;
  final String image;

  Pharmacy({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'image': image,
    };
  }
}