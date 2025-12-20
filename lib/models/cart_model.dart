// // models/cart_model.dart
// class CartModel {
//   final List<CartItem> items;
//   final int totalItems;
//   final double subTotal;
//   final double platformFee;
//   final double deliveryCharge;
//   final double totalPayable;

//   CartModel({
//     required this.items,
//     required this.totalItems,
//     required this.subTotal,
//     required this.platformFee,
//     required this.deliveryCharge,
//     required this.totalPayable,
//   });

//   factory CartModel.fromJson(Map<String, dynamic> json) {
//     return CartModel(
//       items: (json['items'] as List?)
//           ?.map((item) => CartItem.fromJson(item as Map<String, dynamic>))
//           .toList() ?? [],
//       totalItems: json['totalItems'] ?? 0,
//       subTotal: (json['subTotal'] ?? 0).toDouble(),
//       platformFee: (json['platformFee'] ?? 0).toDouble(),
//       deliveryCharge: (json['deliveryCharge'] ?? 0).toDouble(),
//       totalPayable: (json['totalPayable'] ?? 0).toDouble(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'items': items.map((item) => item.toJson()).toList(),
//       'totalItems': totalItems,
//       'subTotal': subTotal,
//       'platformFee': platformFee,
//       'deliveryCharge': deliveryCharge,
//       'totalPayable': totalPayable,
//     };
//   }

//   CartModel copyWith({
//     List<CartItem>? items,
//     int? totalItems,
//     double? subTotal,
//     double? platformFee,
//     double? deliveryCharge,
//     double? totalPayable,
//   }) {
//     return CartModel(
//       items: items ?? this.items,
//       totalItems: totalItems ?? this.totalItems,
//       subTotal: subTotal ?? this.subTotal,
//       platformFee: platformFee ?? this.platformFee,
//       deliveryCharge: deliveryCharge ?? this.deliveryCharge,
//       totalPayable: totalPayable ?? this.totalPayable,
//     );
//   }

//   // Empty cart factory
//   factory CartModel.empty() {
//     return CartModel(
//       items: [],
//       totalItems: 0,
//       subTotal: 0.0,
//       platformFee: 0.0,
//       deliveryCharge: 0.0,
//       totalPayable: 0.0,
//     );
//   }
// }

// class CartItem {
//   final String id;
//   final String medicineId;
//   final String name;
//   final String description;
//   final double price;
//   final List<String> images;
//   final int quantity;
//   final double total;

//   CartItem({
//     required this.id,
//     required this.medicineId,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.images,
//     required this.quantity,
//     required this.total,
//   });

//   factory CartItem.fromJson(Map<String, dynamic> json) {
//     return CartItem(
//       id: json['_id'] ?? '',
//       medicineId: json['medicineId'] ?? '',
//       name: json['name'] ?? '',
//       description: json['description'] ?? '',
//       price: (json['price'] ?? 0).toDouble(),
//       images: (json['images'] as List?)?.cast<String>() ?? [],
//       quantity: json['quantity'] ?? 0,
//       total: (json['total'] ?? 0).toDouble(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'medicineId': medicineId,
//       'name': name,
//       'description': description,
//       'price': price,
//       'images': images,
//       'quantity': quantity,
//       'total': total,
//     };
//   }

//   CartItem copyWith({
//     String? id,
//     String? medicineId,
//     String? name,
//     String? description,
//     double? price,
//     List<String>? images,
//     int? quantity,
//     double? total,
//   }) {
//     return CartItem(
//       id: id ?? this.id,
//       medicineId: medicineId ?? this.medicineId,
//       name: name ?? this.name,
//       description: description ?? this.description,
//       price: price ?? this.price,
//       images: images ?? this.images,
//       quantity: quantity ?? this.quantity,
//       total: total ?? this.total,
//     );
//   }
// }









// ignore_for_file: unnecessary_this

// models/cart_model.dart
class CartModel {
  final List<CartItem> items;
  final int totalItems;
  final double subTotal;
  final double platformFee;
  final double deliveryCharge;
  final double totalPayable;

  CartModel({
    required this.items, 
    required this.totalItems,
    required this.subTotal,
    required this.platformFee,
    required this.deliveryCharge,
    required this.totalPayable,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      items: (json['items'] as List?)
          ?.map((item) => CartItem.fromJson(item as Map<String, dynamic>))
          .toList() ?? [],
      totalItems: json['totalItems'] ?? 0,
      subTotal: (json['subTotal'] ?? 0).toDouble(),
      platformFee: (json['platformFee'] ?? 0).toDouble(),
      deliveryCharge: (json['deliveryCharge'] ?? 0).toDouble(),
      totalPayable: (json['totalPayable'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'totalItems': totalItems,
      'subTotal': subTotal,
      'platformFee': platformFee,
      'deliveryCharge': deliveryCharge,
      'totalPayable': totalPayable,
    };
  }

  CartModel copyWith({
    List<CartItem>? items,
    int? totalItems,
    double? subTotal,
    double? platformFee,
    double? deliveryCharge,
    double? totalPayable,
  }) {
    return CartModel(
      items: items ?? this.items,
      totalItems: totalItems ?? this.totalItems,
      subTotal: subTotal ?? this.subTotal,
      platformFee: platformFee ?? this.platformFee,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      totalPayable: totalPayable ?? this.totalPayable,
    );
  }

  factory CartModel.empty() {
    return CartModel(
      items: [],
      totalItems: 0,
      subTotal: 0.0,
      platformFee: 0.0,
      deliveryCharge: 0.0,
      totalPayable: 0.0,
    );
  }
}

class CartItem {
  final String medicineId;
  final String name;
   final double price;
  final List<String> images;
  final String description;
  final Pharmacy pharmacy;
  final int quantity;
  final double totalPrice;

  CartItem({
    required this.medicineId,
    required this.name,
    required this.images,
    required this.price,
    required this.description,
    required this.pharmacy,
    required this.quantity,
    required this.totalPrice,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      medicineId: json['medicineId'] ?? '',
      name: json['name'] ?? '',
       price: (json['price'] ?? 0).toDouble(),
      images: (json['images'] as List?)?.cast<String>() ?? [],
      description: json['description'] ?? '',
      pharmacy: Pharmacy.fromJson(json['pharmacy'] ?? {}),
      quantity: json['quantity'] ?? 0,
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medicineId': medicineId,
      'name': name,
      'price': price,
      'images': images,
      'description': description,
      'pharmacy': pharmacy.toJson(),
      'quantity': quantity,
      'totalPrice': totalPrice,
    };
  }

  CartItem copyWith({
    String? medicineId,
    String? name,
    List<String>? images,
    String? description,
    Pharmacy? pharmacy,
    int? quantity,
    double? totalPrice,
  }) {
    return CartItem(
      medicineId: medicineId ?? this.medicineId,
      name: name ?? this.name,
      price: price ?? this.price,
      images: images ?? this.images,
      description: description ?? this.description,
      pharmacy: pharmacy ?? this.pharmacy,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  double get unitPrice => quantity > 0 ? totalPrice / quantity : 0.0;
}

class Pharmacy {
  final String id;
  final String name;
  final Location location;

  Pharmacy({
    required this.id,
    required this.name,
    required this.location,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      location: Location.fromJson(json['location'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'location': location.toJson(),
    };
  }
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'] ?? 'Point',
      coordinates: (json['coordinates'] as List?)?.cast<double>() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }

  double get longitude => coordinates.isNotEmpty ? coordinates[0] : 0.0;
  double get latitude => coordinates.length > 1 ? coordinates[1] : 0.0;
}