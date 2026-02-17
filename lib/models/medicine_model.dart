// // class MedicineModel {
// //   final String id;
// //   final String name;
// //   final List<String> images;
// //   final int price;
// //   final String description;

// //   MedicineModel({
// //     required this.id,
// //     required this.name,
// //     required this.images,
// //     required this.price,
// //     required this.description,
// //   });

// //   factory MedicineModel.fromJson(Map<String, dynamic> json) {
// //     return MedicineModel(
// //       id: json['medicineId'],
// //       name: json['name'],
// //       images: List<String>.from(json['images']),
// //       price: json['price'],
// //       description: json['description'],
// //     );
// //   }
// // }


















// // class MedicineModel {
// //   final String id;
// //   final String name;
// //   final List<String> images;
// //   final int price;
// //   final String description;

// //   MedicineModel({
// //     required this.id,
// //     required this.name,
// //     required this.images,
// //     required this.price,
// //     required this.description,
// //   });

// //   factory MedicineModel.fromJson(Map<String, dynamic> json) {
// //     return MedicineModel(
// //       // Handle different possible field names and null values
// //       id: (json['medicineId'] ?? json['id'] ?? json['_id'] ?? '').toString(),
// //       name: (json['name'] ?? json['medicine_name'] ?? 'Unknown Medicine').toString(),
// //       images: _parseImages(json['images'] ?? json['image'] ?? []),
// //       price: _parsePrice(json['price'] ?? 0),
// //       description: (json['description'] ?? json['desc'] ?? 'No description available').toString(),
// //     );
// //   }

// //   // Helper method to safely parse images
// //   static List<String> _parseImages(dynamic images) {
// //     if (images == null) return [];
    
// //     if (images is List) {
// //       return images
// //           .map((img) => img?.toString() ?? '')
// //           .where((img) => img.isNotEmpty)
// //           .toList();
// //     } else if (images is String) {
// //       return images.isEmpty ? [] : [images];
// //     }
    
// //     return [];
// //   }

// //   // Helper method to safely parse price
// //   static int _parsePrice(dynamic price) {
// //     if (price == null) return 0;
    
// //     if (price is int) return price;
// //     if (price is double) return price.toInt();
// //     if (price is String) {
// //       try {
// //         return int.parse(price.replaceAll(RegExp(r'[^\d]'), ''));
// //       } catch (e) {
// //         return 0;
// //       }
// //     }
    
// //     return 0;
// //   }

// //   // Optional: Add a method to create a MedicineModel with default values for testing
// //   factory MedicineModel.empty() {
// //     return MedicineModel(
// //       id: '',
// //       name: 'Unknown Medicine',
// //       images: [],
// //       price: 0,
// //       description: 'No description available',
// //     );
// //   }
// // }



















// // class PharmacyLocation {
// //   final String type;
// //   final List<double> coordinates;

// //   PharmacyLocation({
// //     required this.type,
// //     required this.coordinates,
// //   });

// //   factory PharmacyLocation.fromJson(Map<String, dynamic> json) {
// //     return PharmacyLocation(
// //       type: json['type']?.toString() ?? 'Point',
// //       coordinates: _parseCoordinates(json['coordinates']),
// //     );
// //   }

// //   static List<double> _parseCoordinates(dynamic coords) {
// //     if (coords is List) {
// //       return coords.map((coord) => (coord as num).toDouble()).toList();
// //     }
// //     return [0.0, 0.0];
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'type': type,
// //       'coordinates': coordinates,
// //     };
// //   }
// // }

// // class Pharmacy {
// //   final PharmacyLocation location;
// //   final String id;
// //   final String name;

// //   Pharmacy({
// //     required this.location,
// //     required this.id,
// //     required this.name,
// //   });

// //   factory Pharmacy.fromJson(Map<String, dynamic> json) {
// //     return Pharmacy(
// //       location: PharmacyLocation.fromJson(json['location'] ?? {}),
// //       id: json['_id']?.toString() ?? '',
// //       name: json['name']?.toString() ?? 'Unknown Pharmacy',
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'location': location.toJson(),
// //       '_id': id,
// //       'name': name,
// //     };
// //   }
// // }

// // class MedicineModel {
// //   final String medicineId;
// //   final String name;
// //   final List<String> images;
// //   final int price;
// //   final String description;
// //   final Pharmacy pharmacy;

// //   MedicineModel({
// //     required this.medicineId,
// //     required this.name,
// //     required this.images,
// //     required this.price,
// //     required this.description,
// //     required this.pharmacy,
// //   });

// //   factory MedicineModel.fromJson(Map<String, dynamic> json) {
// //     return MedicineModel(
// //       medicineId: json['medicineId']?.toString() ?? '',
// //       name: json['name']?.toString() ?? 'Unknown Medicine',
// //       images: _parseImages(json['images']),
// //       price: _parsePrice(json['price']),
// //       description: json['description']?.toString() ?? 'No description available',
// //       pharmacy: Pharmacy.fromJson(json['pharmacy'] ?? {}),
// //     );
// //   }

// //   // Helper method to safely parse images
// //   static List<String> _parseImages(dynamic images) {
// //     if (images == null) return [];
    
// //     if (images is List) {
// //       return images
// //           .map((img) => img?.toString() ?? '')
// //           .where((img) => img.isNotEmpty)
// //           .toList();
// //     } else if (images is String) {
// //       return images.isEmpty ? [] : [images];
// //     }
    
// //     return [];
// //   }

// //   // Helper method to safely parse price
// //   static int _parsePrice(dynamic price) {
// //     if (price == null) return 0;
    
// //     if (price is int) return price;
// //     if (price is double) return price.toInt();
// //     if (price is String) {
// //       try {
// //         return int.parse(price.replaceAll(RegExp(r'[^\d]'), ''));
// //       } catch (e) {
// //         return 0;
// //       }
// //     }
    
// //     return 0;
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'medicineId': medicineId,
// //       'name': name,
// //       'images': images,
// //       'price': price,
// //       'description': description,
// //       'pharmacy': pharmacy.toJson(),
// //     };
// //   }

// //   // Optional: Add a method to create a MedicineModel with default values for testing
// //   factory MedicineModel.empty() {
// //     return MedicineModel(
// //       medicineId: '',
// //       name: 'Unknown Medicine',
// //       images: [],
// //       price: 0,
// //       description: 'No description available',
// //       pharmacy: Pharmacy(
// //         location: PharmacyLocation(type: 'Point', coordinates: [0.0, 0.0]),
// //         id: '',
// //         name: 'Unknown Pharmacy',
// //       ),
// //     );
// //   }
// // }

// // // Response wrapper class for the complete API response
// // class MedicineResponse {
// //   final String message;
// //   final int total;
// //   final List<MedicineModel> medicines;

// //   MedicineResponse({
// //     required this.message,
// //     required this.total,
// //     required this.medicines,
// //   });

// //   factory MedicineResponse.fromJson(Map<String, dynamic> json) {
// //     return MedicineResponse(
// //       message: json['message']?.toString() ?? '',
// //       total: json['total'] ?? 0,
// //       medicines: (json['medicines'] as List<dynamic>? ?? [])
// //           .map((medicine) => MedicineModel.fromJson(medicine))
// //           .toList(),
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'message': message,
// //       'total': total,
// //       'medicines': medicines.map((medicine) => medicine.toJson()).toList(),
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
//     return PharmacyLocation(
//       type: json['type']?.toString() ?? 'Point',
//       coordinates: _parseCoordinates(json['coordinates']),
//     );
//   }

//   static List<double> _parseCoordinates(dynamic coords) {
//     if (coords is List) {
//       return coords.map((coord) => (coord as num).toDouble()).toList();
//     }
//     return [0.0, 0.0];
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'type': type,
//       'coordinates': coordinates,
//     };
//   }
// }

// class Pharmacy {
//   final PharmacyLocation address;
//   final String id;
//   final String name;
//   final String image; // Added image field

//   Pharmacy({
//     required this.address,
//     required this.id,
//     required this.name,
//     required this.image, // Added image parameter
//   });

//   factory Pharmacy.fromJson(Map<String, dynamic> json) {
//     return Pharmacy(
//       address: PharmacyLocation.fromJson(json['address'] ?? {}),
//       id: json['_id']?.toString() ?? '',
//       name: json['name']?.toString() ?? 'Unknown Pharmacy',
//       image: json['image']?.toString() ?? '', // Added image parsing
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'address': address.toJson(),
//       '_id': id,
//       'name': name,
//       'image': image, // Added image to JSON
//     };
//   }

//   // Helper getters to access latitude and longitude easily
//   // double get latitude {
//   //   if (address.coordinates.length >= 2) {
//   //     return address.coordinates[1]; // Latitude is usually at index 1
//   //   }
//   //   return 0.0;
//   // }

//   double get longitude {
//     if (address.coordinates.length >= 2) {
//       return address.coordinates[0]; // Longitude is usually at index 0
//     }
//     return 0.0;
//   }
// }

// class MedicineModel {
//   final String medicineId;
//   final String name;
//   final List<String> images;
//   final int price;
//   final String description;
//   final String?categoryName;
//   final Pharmacy pharmacy;

//   MedicineModel({
//     required this.medicineId,
//     required this.name,
//     required this.images,
//     required this.price,
//     required this.description,
//     required this.pharmacy,
//     this.categoryName
//   });

//   factory MedicineModel.fromJson(Map<String, dynamic> json) {
//     return MedicineModel(
//       medicineId: json['medicineId']?.toString() ?? '',
//       name: json['name']?.toString() ?? 'Unknown Medicine',
//       images: _parseImages(json['images']),
//       price: _parsePrice(json['price']),
//       description: json['description']?.toString() ?? 'No description available',
//       pharmacy: Pharmacy.fromJson(json['pharmacy'] ?? {}),
//        categoryName: json['categoryName']?.toString() ?? 'Uncategorized', // Added
//     );
//   }

//   // Helper method to safely parse images
//   static List<String> _parseImages(dynamic images) {
//     if (images == null) return [];
    
//     if (images is List) {
//       return images
//           .map((img) => img?.toString() ?? '')
//           .where((img) => img.isNotEmpty)
//           .toList();
//     } else if (images is String) {
//       return images.isEmpty ? [] : [images];
//     }
    
//     return [];
//   }

//   // Helper method to safely parse price
//   static int _parsePrice(dynamic price) {
//     if (price == null) return 0;
    
//     if (price is int) return price;
//     if (price is double) return price.toInt();
//     if (price is String) {
//       try {
//         return int.parse(price.replaceAll(RegExp(r'[^\d]'), ''));
//       } catch (e) {
//         return 0;
//       }
//     }
    
//     return 0;
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'medicineId': medicineId,
//       'name': name,
//       'images': images,
//       'price': price,
//       'description': description,
//       'pharmacy': pharmacy.toJson(),
//       'categoryName':categoryName
//     };
//   }

//   // Optional: Add a method to create a MedicineModel with default values for testing
//   factory MedicineModel.empty() {
//     return MedicineModel(
//       medicineId: '',
//       name: 'Unknown Medicine',
//       images: [],
//       price: 0,
//       categoryName: '',
//       description: 'No description available',
//       pharmacy: Pharmacy(
//         address: PharmacyLocation(type: 'Point', coordinates: [0.0, 0.0]),
//         id: '',
//         name: 'Unknown Pharmacy',
//         image: '',
        
//          // Added default image
//       ),
//     );
//   }
// }

// // Response wrapper class for the complete API response
// class MedicineResponse {
//   final String message;
//   final int total;
//   final List<MedicineModel> medicines;

//   MedicineResponse({
//     required this.message,
//     required this.total,
//     required this.medicines,
//   });

//   factory MedicineResponse.fromJson(Map<String, dynamic> json) {
//     return MedicineResponse(
//       message: json['message']?.toString() ?? '',
//       total: json['total'] ?? 0,
//       medicines: (json['medicines'] as List<dynamic>? ?? [])
//           .map((medicine) => MedicineModel.fromJson(medicine))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'message': message,
//       'total': total,
//       'medicines': medicines.map((medicine) => medicine.toJson()).toList(),
//     };
//   }
// }

















class PharmacyLocation {
  final String type;
  final List<double> coordinates;

  PharmacyLocation({
    required this.type,
    required this.coordinates,
  });

  factory PharmacyLocation.fromJson(Map<String, dynamic> json) {
    return PharmacyLocation(
      type: json['type']?.toString() ?? 'Point',
      coordinates: _parseCoordinates(json['coordinates']),
    );
  }

  static List<double> _parseCoordinates(dynamic coords) {
    if (coords is List) {
      return coords.map((coord) => (coord as num).toDouble()).toList();
    }
    return [0.0, 0.0];
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}

class Pharmacy {
  final PharmacyLocation? location; // Made optional since JSON doesn't have coordinates
  final String id;
  final String name;
  final String image;
  final String address; // Added address field

  Pharmacy({
    this.location, // Made optional
    required this.id,
    required this.name,
    required this.image,
    required this.address, // Added address parameter
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      location: json['location'] != null 
          ? PharmacyLocation.fromJson(json['location']) 
          : null, // Handle case when location coordinates are not provided
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Unknown Pharmacy',
      image: json['image']?.toString() ?? '',
      address: json['address']?.toString() ?? 'Unknown Address', // Added address parsing
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (location != null) 'location': location!.toJson(), // Only include if not null
      '_id': id,
      'name': name,
      'image': image,
      'address': address, // Added address to JSON
    };
  }

  // Helper getters to access latitude and longitude easily (only if location exists)
  double get latitude {
    if (location != null && location!.coordinates.length >= 2) {
      return location!.coordinates[1]; // Latitude is usually at index 1
    }
    return 0.0;
  }

  double get longitude {
    if (location != null && location!.coordinates.length >= 2) {
      return location!.coordinates[0]; // Longitude is usually at index 0
    }
    return 0.0;
  }
}

class MedicineModel {
  final String medicineId;
  final String name;
  final List<String> images;
  final int price;
  final double? mrp;
  // final int? mrp; //
  final String description;
  final String? categoryName;
  final Pharmacy pharmacy;

  MedicineModel({
    required this.medicineId,
    required this.name,
    required this.images,
    required this.price,
    this.mrp, // Added MRP parameter
    required this.description,
    required this.pharmacy,
    this.categoryName,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      medicineId: json['medicineId']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Unknown Medicine',
      images: _parseImages(json['images']),
      price: _parsePrice(json['price']),
      mrp: _parseMrp(json['mrp']), // Added MRP parsing with separate method
      description: json['description']?.toString() ?? 'No description available',
      pharmacy: Pharmacy.fromJson(json['pharmacy'] ?? {}),
      categoryName: json['categoryName']?.toString(),
    );
  }

  // Helper method to safely parse images
  static List<String> _parseImages(dynamic images) {
    if (images == null) return [];
    
    if (images is List) {
      return images
          .map((img) => img?.toString() ?? '')
          .where((img) => img.isNotEmpty)
          .toList();
    } else if (images is String) {
      return images.isEmpty ? [] : [images];
    }
    
    return [];
  }

  // Helper method to safely parse price (required field, returns 0 if invalid)
  static int _parsePrice(dynamic price) {
    if (price == null) return 0;
    
    if (price is int) return price;
    if (price is double) return price.toInt();
    if (price is String) {
      try {
        return int.parse(price.replaceAll(RegExp(r'[^\d]'), ''));
      } catch (e) {
        return 0;
      }
    }
    
    return 0;
  }

  // Helper method to safely parse MRP (optional field, returns null if invalid)
  // static int? _parseMrp(dynamic price) {
  //   if (price == null) return null;
    
  //   if (price is int) return price;
  //   if (price is double) return price.toInt();
  //   if (price is String) {
  //     try {
  //       return int.parse(price.replaceAll(RegExp(r'[^\d]'), ''));
  //     } catch (e) {
  //       return null;
  //     }
  //   }
    
  //   return null;
  // }



// static int _parseMrp(dynamic price) {
//     if (price == null) return 0;
    
//     if (price is int) return price;
//     if (price is double) return price.toInt();
//     if (price is String) {
//       try {
//         return int.parse(price.replaceAll(RegExp(r'[^\d]'), ''));
//       } catch (e) {
//         return 0;
//       }
//     }
    
//     return 0;
//   }


static double? _parseMrp(dynamic price) {
  if (price == null) return null;

  if (price is int) return price.toDouble();
  if (price is double) return price;

  if (price is String) {
    return double.tryParse(price);
  }

  return null;
}


  Map<String, dynamic> toJson() {
    return {
      'medicineId': medicineId,
      'name': name,
      'images': images,
      'price': price,
      'mrp': mrp,
      'description': description,
      'pharmacy': pharmacy.toJson(),
      if (categoryName != null) 'categoryName': categoryName,
    };
  }

  // Optional: Add a method to create a MedicineModel with default values for testing
  factory MedicineModel.empty() {
    return MedicineModel(
      medicineId: '',
      name: 'Unknown Medicine',
      images: [],
      price: 0,
      categoryName: '',
      description: 'No description available',
      pharmacy: Pharmacy(
        location: PharmacyLocation(type: 'Point', coordinates: [0.0, 0.0]),
        id: '',
        name: 'Unknown Pharmacy',
        image: '',
        address: 'Unknown Address', // Added default address
      ),
    );
  }
}

// Response wrapper class for the complete API response
class MedicineResponse {
  final String message;
  final int total;
  final List<MedicineModel> medicines;

  MedicineResponse({
    required this.message,
    required this.total,
    required this.medicines,
  });

  factory MedicineResponse.fromJson(Map<String, dynamic> json) {
    return MedicineResponse(
      message: json['message']?.toString() ?? '',
      total: json['total'] ?? 0,
      medicines: (json['medicines'] as List<dynamic>? ?? [])
          .map((medicine) => MedicineModel.fromJson(medicine))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'total': total,
      'medicines': medicines.map((medicine) => medicine.toJson()).toList(),
    };
  }
}