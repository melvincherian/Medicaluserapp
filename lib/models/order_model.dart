// // order_model.dart
// class OrderModel {
//   final String id;
//   final String userId;
//   final DeliveryAddress deliveryAddress;
//   final List<OrderItem> orderItems;
//   final List<StatusTimeline> statusTimeline;
//   final double totalAmount;
//   final String notes;
//   final String? voiceNoteUrl;
//   final String paymentMethod;
//   final String status;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   OrderModel({
//     required this.id,
//     required this.userId,
//     required this.deliveryAddress,
//     required this.orderItems,
//     required this.statusTimeline,
//     required this.totalAmount,
//     required this.notes,
//     this.voiceNoteUrl,
//     required this.paymentMethod,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   // Helper property to check if order is ongoing
//   bool get isOngoing {
//     final ongoingStatuses = ['pending', 'confirmed', 'processing', 'shipped', 'out_for_delivery'];
//     return ongoingStatuses.contains(status.toLowerCase());
//   }

//   factory OrderModel.fromJson(Map<String, dynamic> json) {
//     try {
//       // Debug print to see the structure
//       print('OrderModel.fromJson - Raw JSON keys: ${json.keys.toList()}');

//       return OrderModel(
//         id: _getString(json, 'id') ??
//             _getString(json, '_id') ??
//             _getString(json, 'bookingId') ??
//             DateTime.now().millisecondsSinceEpoch.toString(),

//         userId: _getString(json, 'userId') ??
//                 _getString(json, 'user_id') ??
//                 _getString(json, 'customerId') ?? '',

//         deliveryAddress: _parseDeliveryAddress(json),
//         orderItems: _parseOrderItems(json),
//         statusTimeline: _parseStatusTimeline(json),

//         totalAmount: _getDouble(json, 'totalAmount') ??
//                     _getDouble(json, 'total_amount') ??
//                     _getDouble(json, 'total') ??
//                     _getDouble(json, 'amount') ?? 0.0,

//         notes: _getString(json, 'notes') ??
//                _getString(json, 'description') ??
//                _getString(json, 'remarks') ?? '',

//         voiceNoteUrl: _getString(json, 'voiceNoteUrl') ??
//                      _getString(json, 'voice_note_url') ??
//                      _getString(json, 'audioUrl'),

//         paymentMethod: _getString(json, 'paymentMethod') ??
//                       _getString(json, 'payment_method') ??
//                       _getString(json, 'paymentType') ??
//                       'Cash on Delivery',

//         status: _getString(json, 'status') ??
//                 _getString(json, 'orderStatus') ??
//                 _getString(json, 'booking_status') ??
//                 'pending',

//         createdAt: _parseDateTime(json, 'createdAt') ??
//                    _parseDateTime(json, 'created_at') ??
//                    _parseDateTime(json, 'bookingDate') ??
//                    DateTime.now(),

//         updatedAt: _parseDateTime(json, 'updatedAt') ??
//                    _parseDateTime(json, 'updated_at') ??
//                    _parseDateTime(json, 'modifiedAt') ??
//                    DateTime.now(),
//       );
//     } catch (e, stackTrace) {
//       print('Error in OrderModel.fromJson: $e');
//       print('Stack trace: $stackTrace');
//       print('JSON data: $json');
//       rethrow;
//     }
//   }

//   // Helper methods for safe JSON parsing
//   static String? _getString(Map<String, dynamic> json, String key) {
//     final value = json[key];
//     if (value == null) return null;
//     if (value is String) return value;
//     if (value is Map || value is List) return null; // Don't convert objects to strings
//     return value.toString();
//   }

//   static double? _getDouble(Map<String, dynamic> json, String key) {
//     final value = json[key];
//     if (value == null) return null;
//     if (value is double) return value;
//     if (value is int) return value.toDouble();
//     if (value is String) {
//       try {
//         return double.parse(value);
//       } catch (e) {
//         return null;
//       }
//     }
//     return null;
//   }

//   static DateTime? _parseDateTime(Map<String, dynamic> json, String key) {
//     final value = json[key];
//     if (value == null) return null;

//     try {
//       if (value is String) {
//         return DateTime.parse(value);
//       }
//       if (value is int) {
//         return DateTime.fromMillisecondsSinceEpoch(value);
//       }
//     } catch (e) {
//       print('Error parsing DateTime for key $key: $e');
//     }
//     return null;
//   }

//   static DeliveryAddress _parseDeliveryAddress(Map<String, dynamic> json) {
//     try {
//       // Try different possible keys for address
//       Map<String, dynamic>? addressData;

//       if (json['deliveryAddress'] is Map) {
//         addressData = Map<String, dynamic>.from(json['deliveryAddress']);
//       } else if (json['delivery_address'] is Map) {
//         addressData = Map<String, dynamic>.from(json['delivery_address']);
//       } else if (json['address'] is Map) {
//         addressData = Map<String, dynamic>.from(json['address']);
//       } else if (json['shippingAddress'] is Map) {
//         addressData = Map<String, dynamic>.from(json['shippingAddress']);
//       }

//       if (addressData != null) {
//         return DeliveryAddress.fromJson(addressData);
//       } else {
//         // Create default address if no address data found
//         return DeliveryAddress(
//           id: 'default',
//           street: _getString(json, 'address') ?? 'Unknown Address',
//           city: _getString(json, 'city') ?? 'Unknown City',
//           state: _getString(json, 'state') ?? 'Unknown State',
//           pincode: _getString(json, 'pincode') ?? '000000',
//           isDefault: true,
//         );
//       }
//     } catch (e) {
//       print('Error parsing delivery address: $e');
//       return DeliveryAddress(
//         id: 'default',
//         street: 'Unknown Address',
//         city: 'Unknown City',
//         state: 'Unknown State',
//         pincode: '000000',
//         isDefault: true,
//       );
//     }
//   }

//   static List<OrderItem> _parseOrderItems(Map<String, dynamic> json) {
//     try {
//       List<dynamic>? itemsData;

//       if (json['orderItems'] is List) {
//         itemsData = json['orderItems'];
//       } else if (json['order_items'] is List) {
//         itemsData = json['order_items'];
//       } else if (json['items'] is List) {
//         itemsData = json['items'];
//       } else if (json['medicines'] is List) {
//         itemsData = json['medicines'];
//       } else if (json['products'] is List) {
//         itemsData = json['products'];
//       }

//       if (itemsData != null) {
//         return itemsData
//             .where((item) => item is Map)
//             .map((item) => OrderItem.fromJson(Map<String, dynamic>.from(item)))
//             .toList();
//       } else {
//         // Create a default item if no items found
//         return [
//           OrderItem(
//             id: 'default',
//             name: _getString(json, 'medicineName') ??
//                   _getString(json, 'medicine_name') ??
//                   _getString(json, 'productName') ??
//                   'Medicine',
//             quantity: _getDouble(json, 'quantity')?.toInt() ?? 1,
//             price: _getDouble(json, 'price') ?? 0.0,
//           ),
//         ];
//       }
//     } catch (e) {
//       print('Error parsing order items: $e');
//       return [
//         OrderItem(
//           id: 'default',
//           name: 'Medicine',
//           quantity: 1,
//           price: 0.0,
//         ),
//       ];
//     }
//   }

//   static List<StatusTimeline> _parseStatusTimeline(Map<String, dynamic> json) {
//     try {
//       List<dynamic>? timelineData;

//       if (json['statusTimeline'] is List) {
//         timelineData = json['statusTimeline'];
//       } else if (json['status_timeline'] is List) {
//         timelineData = json['status_timeline'];
//       } else if (json['timeline'] is List) {
//         timelineData = json['timeline'];
//       } else if (json['history'] is List) {
//         timelineData = json['history'];
//       }

//       if (timelineData != null) {
//         return timelineData
//             .where((item) => item is Map)
//             .map((item) => StatusTimeline.fromJson(Map<String, dynamic>.from(item)))
//             .toList();
//       } else {
//         // Create default timeline based on current status
//         final status = _getString(json, 'status') ?? 'pending';
//         final createdAt = _parseDateTime(json, 'createdAt') ?? DateTime.now();

//         return [
//           StatusTimeline(
//             id: '1',
//             status: status,
//             message: 'Order $status',
//             timestamp: createdAt,
//           ),
//         ];
//       }
//     } catch (e) {
//       print('Error parsing status timeline: $e');
//       return [
//         StatusTimeline(
//           id: '1',
//           status: 'pending',
//           message: 'Order created',
//           timestamp: DateTime.now(),
//         ),
//       ];
//     }
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'userId': userId,
//       'deliveryAddress': deliveryAddress.toJson(),
//       'orderItems': orderItems.map((item) => item.toJson()).toList(),
//       'statusTimeline': statusTimeline.map((status) => status.toJson()).toList(),
//       'totalAmount': totalAmount,
//       'notes': notes,
//       'voiceNoteUrl': voiceNoteUrl,
//       'paymentMethod': paymentMethod,
//       'status': status,
//       'createdAt': createdAt.toIso8601String(),
//       'updatedAt': updatedAt.toIso8601String(),
//     };
//   }
// }

// class DeliveryAddress {
//   final String id;
//   final String street;
//   final String city;
//   final String state;
//   final String pincode;
//   final bool isDefault;
//   final String? landmark;

//   DeliveryAddress({
//     required this.id,
//     required this.street,
//     required this.city,
//     required this.state,
//     required this.pincode,
//     required this.isDefault,
//     this.landmark,
//   });

//   factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
//     return DeliveryAddress(
//       id: json['id']?.toString() ??
//           json['_id']?.toString() ??
//           json['addressId']?.toString() ??
//           'default',
//       street: json['street']?.toString() ??
//               json['address']?.toString() ??
//               json['fullAddress']?.toString() ?? '',
//       city: json['city']?.toString() ?? '',
//       state: json['state']?.toString() ?? '',
//       pincode: json['pincode']?.toString() ??
//                json['zipCode']?.toString() ??
//                json['postalCode']?.toString() ?? '',
//       isDefault: json['isDefault'] == true || json['is_default'] == true,
//       landmark: json['landmark']?.toString(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'street': street,
//       'city': city,
//       'state': state,
//       'pincode': pincode,
//       'isDefault': isDefault,
//       'landmark': landmark,
//     };
//   }

//   @override
//   String toString() {
//     return '$street, $city, $state - $pincode';
//   }
// }

// class OrderItem {
//   final String id;
//   final String name;
//   final int quantity;
//   final double price;
//   final String? imageUrl;
//   final String? description;

//   OrderItem({
//     required this.id,
//     required this.name,
//     required this.quantity,
//     required this.price,
//     this.imageUrl,
//     this.description,
//   });

//   factory OrderItem.fromJson(Map<String, dynamic> json) {
//     return OrderItem(
//       id: json['id']?.toString() ??
//           json['_id']?.toString() ??
//           json['medicineId']?.toString() ??
//           json['productId']?.toString() ??
//           DateTime.now().millisecondsSinceEpoch.toString(),
//       name: json['name']?.toString() ??
//             json['medicineName']?.toString() ??
//             json['productName']?.toString() ??
//             'Medicine',
//       quantity: (json['quantity'] ?? 1) is int
//           ? json['quantity']
//           : int.tryParse(json['quantity']?.toString() ?? '1') ?? 1,
//       price: (json['price'] ?? 0.0) is double
//           ? json['price']
//           : double.tryParse(json['price']?.toString() ?? '0.0') ?? 0.0,
//       imageUrl: json['imageUrl']?.toString() ??
//                 json['image_url']?.toString() ??
//                 json['image']?.toString(),
//       description: json['description']?.toString(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'quantity': quantity,
//       'price': price,
//       'imageUrl': imageUrl,
//       'description': description,
//     };
//   }
// }

// class StatusTimeline {
//   final String id;
//   final String status;
//   final String message;
//   final DateTime timestamp;

//   StatusTimeline({
//     required this.id,
//     required this.status,
//     required this.message,
//     required this.timestamp,
//   });

//   factory StatusTimeline.fromJson(Map<String, dynamic> json) {
//     return StatusTimeline(
//       id: json['id']?.toString() ??
//           json['_id']?.toString() ??
//           DateTime.now().millisecondsSinceEpoch.toString(),
//       status: json['status']?.toString() ?? 'pending',
//       message: json['message']?.toString() ??
//                json['description']?.toString() ??
//                json['note']?.toString() ?? '',
//       timestamp: _parseDateTime(json['timestamp']) ??
//                 _parseDateTime(json['createdAt']) ??
//                 _parseDateTime(json['date']) ??
//                 DateTime.now(),
//     );
//   }

//   static DateTime _parseDateTime(dynamic value) {
//     if (value == null) return DateTime.now();

//     try {
//       if (value is String) {
//         return DateTime.parse(value);
//       }
//       if (value is int) {
//         return DateTime.fromMillisecondsSinceEpoch(value);
//       }
//     } catch (e) {
//       print('Error parsing DateTime: $e');
//     }
//     return DateTime.now();
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'status': status,
//       'message': message,
//       'timestamp': timestamp.toIso8601String(),
//     };
//   }
// }

// // Request/Response models
// class CreateOrderRequest {
//   final String addressId;
//   final String notes;
//   final String voiceNoteUrl;
//   final String paymentMethod;

//   CreateOrderRequest({
//     required this.addressId,
//     this.notes = '',
//     this.voiceNoteUrl = '',
//     this.paymentMethod = 'Cash on Delivery',
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'addressId': addressId,
//       'notes': notes,
//       'voiceNoteUrl': voiceNoteUrl,
//       'paymentMethod': paymentMethod,
//     };
//   }

//   @override
//   String toString() {
//     return 'CreateOrderRequest{addressId: $addressId, notes: $notes, paymentMethod: $paymentMethod}';
//   }
// }

// class OrderResponse {
//   final OrderModel order;
//   final String message;
//   final bool success;

//   OrderResponse({
//     required this.order,
//     required this.message,
//     this.success = true,
//   });

//   factory OrderResponse.fromJson(Map<String, dynamic> json) {
//     try {
//       // Handle different response structures
//       Map<String, dynamic>? orderData;

//       if (json['order'] is Map) {
//         orderData = Map<String, dynamic>.from(json['order']);
//       } else if (json['data'] is Map) {
//         orderData = Map<String, dynamic>.from(json['data']);
//       } else if (json['booking'] is Map) {
//         orderData = Map<String, dynamic>.from(json['booking']);
//       } else {
//         // If the entire response is the order data
//         orderData = json;
//       }

//       return OrderResponse(
//         order: OrderModel.fromJson(orderData!),
//         message: json['message']?.toString() ?? 'Order created successfully',
//         success: json['success'] == true || json['status'] == 'success',
//       );
//     } catch (e) {
//       print('Error parsing OrderResponse: $e');
//       rethrow;
//     }
//   }
// }

// // order_model.dart
// class OrderModel {
//   final String id;
//   final String userId;
//   final DeliveryAddress deliveryAddress;
//   final List<OrderItem> orderItems;
//   final List<StatusTimeline> statusTimeline;
//   final double totalAmount;
//   final String notes;
//   final String? voiceNoteUrl;
//   final String paymentMethod;
//   final String status;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   OrderModel({
//     required this.id,
//     required this.userId,
//     required this.deliveryAddress,
//     required this.orderItems,
//     required this.statusTimeline,
//     required this.totalAmount,
//     required this.notes,
//     this.voiceNoteUrl,
//     required this.paymentMethod,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   // Helper property to check if order is ongoing
//   bool get isOngoing {
//     final ongoingStatuses = ['pending', 'confirmed', 'processing', 'shipped', 'out_for_delivery'];
//     return ongoingStatuses.contains(status.toLowerCase());
//   }

//   factory OrderModel.fromJson(Map<String, dynamic> json) {
//     try {
//       // Debug print to see the structure
//       print('OrderModel.fromJson - Raw JSON keys: ${json.keys.toList()}');

//       return OrderModel(
//         id: _getString(json, 'id') ??
//             _getString(json, '_id') ??
//             _getString(json, 'bookingId') ??
//             DateTime.now().millisecondsSinceEpoch.toString(),

//         userId: _getString(json, 'userId') ??
//                 _getString(json, 'user_id') ??
//                 _getString(json, 'customerId') ?? '',

//         deliveryAddress: _parseDeliveryAddress(json),
//         orderItems: _parseOrderItems(json),
//         statusTimeline: _parseStatusTimeline(json),

//         totalAmount: _getDouble(json, 'totalAmount') ??
//                     _getDouble(json, 'total_amount') ??
//                     _getDouble(json, 'total') ??
//                     _getDouble(json, 'amount') ?? 0.0,

//         notes: _getString(json, 'notes') ??
//                _getString(json, 'description') ??
//                _getString(json, 'remarks') ?? '',

//         voiceNoteUrl: _getString(json, 'voiceNoteUrl') ??
//                      _getString(json, 'voice_note_url') ??
//                      _getString(json, 'audioUrl'),

//         paymentMethod: _getString(json, 'paymentMethod') ??
//                       _getString(json, 'payment_method') ??
//                       _getString(json, 'paymentType') ??
//                       'Cash on Delivery',

//         status: _getString(json, 'status') ??
//                 _getString(json, 'orderStatus') ??
//                 _getString(json, 'booking_status') ??
//                 'pending',

//         createdAt: _parseDateTime(json, 'createdAt') ??
//                    _parseDateTime(json, 'created_at') ??
//                    _parseDateTime(json, 'bookingDate') ??
//                    DateTime.now(),

//         updatedAt: _parseDateTime(json, 'updatedAt') ??
//                    _parseDateTime(json, 'updated_at') ??
//                    _parseDateTime(json, 'modifiedAt') ??
//                    DateTime.now(),
//       );
//     } catch (e, stackTrace) {
//       print('Error in OrderModel.fromJson: $e');
//       print('Stack trace: $stackTrace');
//       print('JSON data: $json');
//       rethrow;
//     }
//   }

//   // Helper methods for safe JSON parsing
//   static String? _getString(Map<String, dynamic> json, String key) {
//     final value = json[key];
//     if (value == null) return null;
//     if (value is String) return value;
//     if (value is Map || value is List) return null; // Don't convert objects to strings
//     return value.toString();
//   }

//   static double? _getDouble(Map<String, dynamic> json, String key) {
//     final value = json[key];
//     if (value == null) return null;
//     if (value is double) return value;
//     if (value is int) return value.toDouble();
//     if (value is String) {
//       try {
//         return double.parse(value);
//       } catch (e) {
//         return null;
//       }
//     }
//     return null;
//   }

//   static DateTime? _parseDateTime(Map<String, dynamic> json, String key) {
//     final value = json[key];
//     if (value == null) return null;

//     try {
//       if (value is String) {
//         return DateTime.parse(value);
//       }
//       if (value is int) {
//         return DateTime.fromMillisecondsSinceEpoch(value);
//       }
//     } catch (e) {
//       print('Error parsing DateTime for key $key: $e');
//     }
//     return null;
//   }

//   static DeliveryAddress _parseDeliveryAddress(Map<String, dynamic> json) {
//     try {
//       // Try different possible keys for address
//       Map<String, dynamic>? addressData;

//       if (json['deliveryAddress'] is Map) {
//         addressData = Map<String, dynamic>.from(json['deliveryAddress']);
//       } else if (json['delivery_address'] is Map) {
//         addressData = Map<String, dynamic>.from(json['delivery_address']);
//       } else if (json['address'] is Map) {
//         addressData = Map<String, dynamic>.from(json['address']);
//       } else if (json['shippingAddress'] is Map) {
//         addressData = Map<String, dynamic>.from(json['shippingAddress']);
//       }

//       if (addressData != null) {
//         return DeliveryAddress.fromJson(addressData);
//       } else {
//         // Create default address if no address data found
//         return DeliveryAddress(
//           id: 'default',
//           street: _getString(json, 'address') ?? 'Unknown Address',
//           city: _getString(json, 'city') ?? 'Unknown City',
//           state: _getString(json, 'state') ?? 'Unknown State',
//           pincode: _getString(json, 'pincode') ?? '000000',
//           isDefault: true,
//         );
//       }
//     } catch (e) {
//       print('Error parsing delivery address: $e');
//       return DeliveryAddress(
//         id: 'default',
//         street: 'Unknown Address',
//         city: 'Unknown City',
//         state: 'Unknown State',
//         pincode: '000000',
//         isDefault: true,
//       );
//     }
//   }

//   static List<OrderItem> _parseOrderItems(Map<String, dynamic> json) {
//     try {
//       List<dynamic>? itemsData;

//       if (json['orderItems'] is List) {
//         itemsData = json['orderItems'];
//       } else if (json['order_items'] is List) {
//         itemsData = json['order_items'];
//       } else if (json['items'] is List) {
//         itemsData = json['items'];
//       } else if (json['medicines'] is List) {
//         itemsData = json['medicines'];
//       } else if (json['products'] is List) {
//         itemsData = json['products'];
//       }

//       if (itemsData != null) {
//         return itemsData
//             .where((item) => item is Map)
//             .map((item) => OrderItem.fromJson(Map<String, dynamic>.from(item)))
//             .toList();
//       } else {
//         // Create a default item if no items found
//         return [
//           OrderItem(
//             id: 'default',
//             name: _getString(json, 'medicineName') ??
//                   _getString(json, 'medicine_name') ??
//                   _getString(json, 'productName') ??
//                   'Medicine',
//             quantity: _getDouble(json, 'quantity')?.toInt() ?? 1,
//             price: _getDouble(json, 'price') ?? 0.0,
//           ),
//         ];
//       }
//     } catch (e) {
//       print('Error parsing order items: $e');
//       return [
//         OrderItem(
//           id: 'default',
//           name: 'Medicine',
//           quantity: 1,
//           price: 0.0,
//         ),
//       ];
//     }
//   }

//   static List<StatusTimeline> _parseStatusTimeline(Map<String, dynamic> json) {
//     try {
//       List<dynamic>? timelineData;

//       if (json['statusTimeline'] is List) {
//         timelineData = json['statusTimeline'];
//       } else if (json['status_timeline'] is List) {
//         timelineData = json['status_timeline'];
//       } else if (json['timeline'] is List) {
//         timelineData = json['timeline'];
//       } else if (json['history'] is List) {
//         timelineData = json['history'];
//       }

//       if (timelineData != null) {
//         return timelineData
//             .where((item) => item is Map)
//             .map((item) => StatusTimeline.fromJson(Map<String, dynamic>.from(item)))
//             .toList();
//       } else {
//         // Create default timeline based on current status
//         final status = _getString(json, 'status') ?? 'pending';
//         final createdAt = _parseDateTime(json, 'createdAt') ?? DateTime.now();

//         return [
//           StatusTimeline(
//             id: '1',
//             status: status,
//             message: 'Order $status',
//             timestamp: createdAt,
//           ),
//         ];
//       }
//     } catch (e) {
//       print('Error parsing status timeline: $e');
//       return [
//         StatusTimeline(
//           id: '1',
//           status: 'pending',
//           message: 'Order created',
//           timestamp: DateTime.now(),
//         ),
//       ];
//     }
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'userId': userId,
//       'deliveryAddress': deliveryAddress.toJson(),
//       'orderItems': orderItems.map((item) => item.toJson()).toList(),
//       'statusTimeline': statusTimeline.map((status) => status.toJson()).toList(),
//       'totalAmount': totalAmount,
//       'notes': notes,
//       'voiceNoteUrl': voiceNoteUrl,
//       'paymentMethod': paymentMethod,
//       'status': status,
//       'createdAt': createdAt.toIso8601String(),
//       'updatedAt': updatedAt.toIso8601String(),
//     };
//   }
// }

// class DeliveryAddress {
//   final String id;
//   final String street;
//   final String city;
//   final String state;
//   final String pincode;
//   final bool isDefault;
//   final String? landmark;
//   final String? house;
//   final String? country;

//   DeliveryAddress({
//     required this.id,
//     required this.street,
//     required this.city,
//     required this.state,
//     required this.pincode,
//     required this.isDefault,
//     this.landmark,
//     this.house,
//     this.country,
//   });

//   factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
//     return DeliveryAddress(
//       id: json['id']?.toString() ??
//           json['_id']?.toString() ??
//           json['addressId']?.toString() ??
//           'default',
//       street: json['street']?.toString() ??
//               json['address']?.toString() ??
//               json['fullAddress']?.toString() ?? '',
//       city: json['city']?.toString() ?? '',
//       state: json['state']?.toString() ?? '',
//       pincode: json['pincode']?.toString() ??
//                json['zipCode']?.toString() ??
//                json['postalCode']?.toString() ?? '',
//       isDefault: json['isDefault'] == true || json['is_default'] == true,
//       landmark: json['landmark']?.toString(),
//       house: json['house']?.toString(),
//       country: json['country']?.toString(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'street': street,
//       'city': city,
//       'state': state,
//       'pincode': pincode,
//       'isDefault': isDefault,
//       'landmark': landmark,
//       'house': house,
//       'country': country,
//     };
//   }

//   @override
//   String toString() {
//     final parts = <String>[];
//     if (house?.isNotEmpty == true) parts.add(house!);
//     if (street.isNotEmpty) parts.add(street);
//     parts.add(city);
//     parts.add(state);
//     parts.add(pincode);
//     return parts.join(', ');
//   }
// }

// class OrderItem {
//   final String id;
//   final String name;
//   final int quantity;
//   final double price;
//   final String? imageUrl;
//   final String? description;

//   OrderItem({
//     required this.id,
//     required this.name,
//     required this.quantity,
//     required this.price,
//     this.imageUrl,
//     this.description,
//   });

//   factory OrderItem.fromJson(Map<String, dynamic> json) {
//     // Handle nested medicineId structure
//     Map<String, dynamic>? medicineData;
//     if (json['medicineId'] is Map) {
//       medicineData = Map<String, dynamic>.from(json['medicineId']);
//     }

//     return OrderItem(
//       id: json['id']?.toString() ??
//           json['_id']?.toString() ??
//           medicineData?['_id']?.toString() ??
//           json['medicineId']?.toString() ??
//           json['productId']?.toString() ??
//           DateTime.now().millisecondsSinceEpoch.toString(),

//       name: json['name']?.toString() ??
//             medicineData?['name']?.toString() ??
//             json['medicineName']?.toString() ??
//             json['productName']?.toString() ??
//             'Medicine',

//       quantity: (json['quantity'] ?? 1) is int
//           ? json['quantity']
//           : int.tryParse(json['quantity']?.toString() ?? '1') ?? 1,

//       // Try to get price from multiple possible locations
//       price: _getItemPrice(json, medicineData),

//       imageUrl: medicineData?['images'] is List && (medicineData!['images'] as List).isNotEmpty
//           ? (medicineData['images'] as List).first?.toString()
//           : json['imageUrl']?.toString() ??
//             json['image_url']?.toString() ??
//             json['image']?.toString(),

//       description: medicineData?['description']?.toString() ??
//                   json['description']?.toString(),
//     );
//   }

//   // Helper method to safely extract price from different locations
//   static double _getItemPrice(Map<String, dynamic> json, Map<String, dynamic>? medicineData) {
//     // Try different price sources in order of preference
//     double? price;

//     // 1. Direct price field
//     price = _getDoubleValue(json['price']);
//     if (price != null) return price;

//     // 2. Price from medicineData
//     if (medicineData != null) {
//       price = _getDoubleValue(medicineData['price']);
//       if (price != null) return price;
//     }

//     // 3. Other possible price fields
//     price = _getDoubleValue(json['unitPrice']) ??
//             _getDoubleValue(json['cost']) ??
//             _getDoubleValue(json['amount']);

//     return price ?? 0.0;
//   }

//   // Helper method to safely convert various types to double
//   static double? _getDoubleValue(dynamic value) {
//     if (value == null) return null;
//     if (value is double) return value;
//     if (value is int) return value.toDouble();
//     if (value is String) {
//       try {
//         return double.parse(value);
//       } catch (e) {
//         return null;
//       }
//     }
//     return null;
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'quantity': quantity,
//       'price': price,
//       'imageUrl': imageUrl,
//       'description': description,
//     };
//   }
// }

// class StatusTimeline {
//   final String id;
//   final String status;
//   final String message;
//   final DateTime timestamp;

//   StatusTimeline({
//     required this.id,
//     required this.status,
//     required this.message,
//     required this.timestamp,
//   });

//   factory StatusTimeline.fromJson(Map<String, dynamic> json) {
//     return StatusTimeline(
//       id: json['id']?.toString() ??
//           json['_id']?.toString() ??
//           DateTime.now().millisecondsSinceEpoch.toString(),
//       status: json['status']?.toString() ?? 'pending',
//       message: json['message']?.toString() ??
//                json['description']?.toString() ??
//                json['note']?.toString() ?? '',
//       timestamp: _parseDateTime(json['timestamp']) ??
//                 _parseDateTime(json['createdAt']) ??
//                 _parseDateTime(json['date']) ??
//                 DateTime.now(),
//     );
//   }

//   static DateTime _parseDateTime(dynamic value) {
//     if (value == null) return DateTime.now();

//     try {
//       if (value is String) {
//         return DateTime.parse(value);
//       }
//       if (value is int) {
//         return DateTime.fromMillisecondsSinceEpoch(value);
//       }
//     } catch (e) {
//       print('Error parsing DateTime: $e');
//     }
//     return DateTime.now();
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'status': status,
//       'message': message,
//       'timestamp': timestamp.toIso8601String(),
//     };
//   }
// }

// // Request/Response models
// class CreateOrderRequest {
//   final String addressId;
//   final String notes;
//   final String voiceNoteUrl;
//   final String paymentMethod;
//   final String ?transactionId;

//   CreateOrderRequest({
//     required this.addressId,
//     this.notes = '',
//     this.transactionId,
//     this.voiceNoteUrl = '',
//     this.paymentMethod = 'Cash on Delivery',
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'addressId': addressId,
//       'notes': notes,
//       'voiceNoteUrl': voiceNoteUrl,
//       'paymentMethod': paymentMethod,
//     };
//   }

//   @override
//   String toString() {
//     return 'CreateOrderRequest{addressId: $addressId, notes: $notes, paymentMethod: $paymentMethod}';
//   }
// }

// class OrderResponse {
//   final OrderModel order;
//   final String message;
//   final bool success;

//   OrderResponse({
//     required this.order,
//     required this.message,
//     this.success = true,
//   });

//   factory OrderResponse.fromJson(Map<String, dynamic> json) {
//     try {
//       // Handle different response structures
//       Map<String, dynamic>? orderData;

//       if (json['order'] is Map) {
//         orderData = Map<String, dynamic>.from(json['order']);
//       } else if (json['data'] is Map) {
//         orderData = Map<String, dynamic>.from(json['data']);
//       } else if (json['booking'] is Map) {
//         orderData = Map<String, dynamic>.from(json['booking']);
//       } else {
//         // If the entire response is the order data
//         orderData = json;
//       }

//       return OrderResponse(
//         order: OrderModel.fromJson(orderData!),
//         message: json['message']?.toString() ?? 'Order created successfully',
//         success: json['success'] == true || json['status'] == 'success',
//       );
//     } catch (e) {
//       print('Error parsing OrderResponse: $e');
//       rethrow;
//     }
//   }
// }

// order_model.dart
class OrderModel {
  final String id;
  final String userId;
  final DeliveryAddress deliveryAddress;
  final List<OrderItem> orderItems;
  final List<StatusTimeline> statusTimeline;
  final double totalAmount;
  final String notes;
  final String? voiceNoteUrl;
  final String paymentMethod;
  final String status;
  final String? assignedRider;
  final String? assignedRiderStatus;
  final String? transactionId;
  final String? couponCode;
  final String? paymentStatus;
  final String? razorpayOrder;
  final bool isReordered;
  final bool isPrescriptionOrder;
  final double deliveryCharge;
  final double platformCharge;
  final List<String> deliveryProof;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? version;

  OrderModel({
    required this.id,
    required this.userId,
    required this.deliveryAddress,
    required this.orderItems,
    required this.statusTimeline,
    required this.totalAmount,
    required this.notes,
    this.voiceNoteUrl,
    required this.paymentMethod,
    required this.status,
    this.assignedRider,
    this.assignedRiderStatus,
    this.transactionId,
    this.paymentStatus,
    this.couponCode,
    this.isPrescriptionOrder = false,
    this.razorpayOrder,
    this.isReordered = false,
    this.deliveryCharge = 0.0,
    this.platformCharge = 0.0,
    this.deliveryProof = const [],
    required this.createdAt,
    required this.updatedAt,
    this.version,
  });

  // Helper property to check if order is ongoing
  // bool get isOngoing {
  //   final ongoingStatuses = ['pending', 'confirmed', 'processing', 'shipped', 'out_for_delivery', 'rider assigned'];
  //   return ongoingStatuses.contains(status.toLowerCase());
  // }

  // Helper property to check if order is ongoing
  bool get isOngoing {
    final ongoingStatuses = [
      'pending',
      'confirmed',
      'processing',
      'shipped',
      'out_for_delivery',
      'rider assigned',
      'accepted',
      'pickedup',
      'cancelled' // Add this line
    ];
    return ongoingStatuses.contains(status.toLowerCase());
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    try {
      // Debug print to see the structure
      print('OrderModel.fromJson - Raw JSON keys: ${json.keys.toList()}');

      return OrderModel(
        id: _getString(json, 'id') ??
            _getString(json, '_id') ??
            _getString(json, 'bookingId') ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        userId: _getString(json, 'userId') ??
            _getString(json, 'user_id') ??
            _getString(json, 'customerId') ??
            '',
        deliveryAddress: _parseDeliveryAddress(json),
        orderItems: _parseOrderItems(json),
        statusTimeline: _parseStatusTimeline(json),
        totalAmount: _getDouble(json, 'totalAmount') ??
            _getDouble(json, 'total_amount') ??
            _getDouble(json, 'total') ??
            _getDouble(json, 'amount') ??
            0.0,
        notes: _getString(json, 'notes') ??
            _getString(json, 'description') ??
            _getString(json, 'remarks') ??
            '',
        voiceNoteUrl: _getString(json, 'voiceNoteUrl') ??
            _getString(json, 'voice_note_url') ??
            _getString(json, 'audioUrl'),
        paymentMethod: _getString(json, 'paymentMethod') ??
            _getString(json, 'payment_method') ??
            _getString(json, 'paymentType') ??
            'Cash on Delivery',
        status: _getString(json, 'status') ??
            _getString(json, 'orderStatus') ??
            _getString(json, 'booking_status') ??
            'pending',
        assignedRider: _getString(json, 'assignedRider') ??
            _getString(json, 'assigned_rider') ??
            _getString(json, 'riderId'),
        assignedRiderStatus: _getString(json, 'assignedRiderStatus') ??
            _getString(json, 'assigned_rider_status') ??
            _getString(json, 'riderStatus'),
        transactionId: _getString(json, 'transactionId') ??
            _getString(json, 'transaction_id'),
        couponCode:
            _getString(json, 'couponCode') ?? _getString(json, 'coupon_code'),
        paymentStatus: _getString(json, 'paymentStatus') ??
            _getString(json, 'payment_status'),
        razorpayOrder: _getString(json, 'razorpayOrder') ??
            _getString(json, 'razorpay_order'),
        isReordered: json['isReordered'] == true ||
            json['is_reordered'] == true ||
            json['reordered'] == true,
        isPrescriptionOrder:
            json['isPrescriptionOrder'] == true || // Add this line
                json['is_prescription_order'] == true ||
                json['prescriptionOrder'] == true,
        deliveryCharge: _getDouble(json, 'deliveryCharge') ??
            _getDouble(json, 'delivery_charge') ??
            _getDouble(json, 'shippingCharge') ??
            0.0,
        platformCharge: _getDouble(json, 'platformCharge') ??
            _getDouble(json, 'platform_charge') ??
            _getDouble(json, 'serviceFee') ??
            0.0,
        deliveryProof: _parseDeliveryProof(json),
        createdAt: _parseDateTime(json, 'createdAt') ??
            _parseDateTime(json, 'created_at') ??
            _parseDateTime(json, 'bookingDate') ??
            DateTime.now(),
        updatedAt: _parseDateTime(json, 'updatedAt') ??
            _parseDateTime(json, 'updated_at') ??
            _parseDateTime(json, 'modifiedAt') ??
            DateTime.now(),
        version: json['__v'] is int ? json['__v'] : null,
      );
    } catch (e, stackTrace) {
      print('Error in OrderModel.fromJson: $e');
      print('Stack trace: $stackTrace');
      print('JSON data: $json');
      rethrow;
    }
  }

  // Helper methods for safe JSON parsing
  static String? _getString(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value == null) return null;
    if (value is String) return value;
    if (value is Map || value is List)
      return null; // Don't convert objects to strings
    return value.toString();
  }

  static double? _getDouble(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      try {
        return double.parse(value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  static DateTime? _parseDateTime(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value == null) return null;

    try {
      if (value is String) {
        return DateTime.parse(value);
      }
      if (value is int) {
        return DateTime.fromMillisecondsSinceEpoch(value);
      }
    } catch (e) {
      print('Error parsing DateTime for key $key: $e');
    }
    return null;
  }

  static List<String> _parseDeliveryProof(Map<String, dynamic> json) {
    try {
      final proofData = json['deliveryProof'] ?? json['delivery_proof'];
      if (proofData is List) {
        return proofData.map((item) => item.toString()).toList();
      }
      return [];
    } catch (e) {
      print('Error parsing delivery proof: $e');
      return [];
    }
  }

  static DeliveryAddress _parseDeliveryAddress(Map<String, dynamic> json) {
    try {
      // Try different possible keys for address
      Map<String, dynamic>? addressData;

      if (json['deliveryAddress'] is Map) {
        addressData = Map<String, dynamic>.from(json['deliveryAddress']);
      } else if (json['delivery_address'] is Map) {
        addressData = Map<String, dynamic>.from(json['delivery_address']);
      } else if (json['address'] is Map) {
        addressData = Map<String, dynamic>.from(json['address']);
      } else if (json['shippingAddress'] is Map) {
        addressData = Map<String, dynamic>.from(json['shippingAddress']);
      }

      if (addressData != null) {
        return DeliveryAddress.fromJson(addressData);
      } else {
        // Create default address if no address data found
        return DeliveryAddress(
          id: 'default',
          street: _getString(json, 'address') ?? 'Unknown Address',
          city: _getString(json, 'city') ?? 'Unknown City',
          state: _getString(json, 'state') ?? 'Unknown State',
          pincode: _getString(json, 'pincode') ?? '000000',
          isDefault: true,
        );
      }
    } catch (e) {
      print('Error parsing delivery address: $e');
      return DeliveryAddress(
        id: 'default',
        street: 'Unknown Address',
        city: 'Unknown City',
        state: 'Unknown State',
        pincode: '000000',
        isDefault: true,
      );
    }
  }

  static List<OrderItem> _parseOrderItems(Map<String, dynamic> json) {
    try {
      List<dynamic>? itemsData;

      if (json['orderItems'] is List) {
        itemsData = json['orderItems'];
      } else if (json['order_items'] is List) {
        itemsData = json['order_items'];
      } else if (json['items'] is List) {
        itemsData = json['items'];
      } else if (json['medicines'] is List) {
        itemsData = json['medicines'];
      } else if (json['products'] is List) {
        itemsData = json['products'];
      }

      if (itemsData != null) {
        return itemsData
            .where((item) => item is Map)
            .map((item) => OrderItem.fromJson(Map<String, dynamic>.from(item)))
            .toList();
      } else {
        // Create a default item if no items found
        return [
          OrderItem(
            id: 'default',
            name: _getString(json, 'medicineName') ??
                _getString(json, 'medicine_name') ??
                _getString(json, 'productName') ??
                'Medicine',
            quantity: _getDouble(json, 'quantity')?.toInt() ?? 1,
            price: _getDouble(json, 'price') ?? 0.0,
          ),
        ];
      }
    } catch (e) {
      print('Error parsing order items: $e');
      return [
        OrderItem(
          id: 'default',
          name: 'Medicine',
          quantity: 1,
          price: 0.0,
        ),
      ];
    }
  }

  static List<StatusTimeline> _parseStatusTimeline(Map<String, dynamic> json) {
    try {
      List<dynamic>? timelineData;

      if (json['statusTimeline'] is List) {
        timelineData = json['statusTimeline'];
      } else if (json['status_timeline'] is List) {
        timelineData = json['status_timeline'];
      } else if (json['timeline'] is List) {
        timelineData = json['timeline'];
      } else if (json['history'] is List) {
        timelineData = json['history'];
      }

      if (timelineData != null) {
        return timelineData
            .where((item) => item is Map)
            .map((item) =>
                StatusTimeline.fromJson(Map<String, dynamic>.from(item)))
            .toList();
      } else {
        // Create default timeline based on current status
        final status = _getString(json, 'status') ?? 'pending';
        final createdAt = _parseDateTime(json, 'createdAt') ?? DateTime.now();

        return [
          StatusTimeline(
            id: '1',
            status: status,
            message: 'Order $status',
            timestamp: createdAt,
          ),
        ];
      }
    } catch (e) {
      print('Error parsing status timeline: $e');
      return [
        StatusTimeline(
          id: '1',
          status: 'pending',
          message: 'Order created',
          timestamp: DateTime.now(),
        ),
      ];
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'deliveryAddress': deliveryAddress.toJson(),
      'orderItems': orderItems.map((item) => item.toJson()).toList(),
      'statusTimeline':
          statusTimeline.map((status) => status.toJson()).toList(),
      'totalAmount': totalAmount,
      'notes': notes,
      'voiceNoteUrl': voiceNoteUrl,
      'paymentMethod': paymentMethod,
      'status': status,
      'assignedRider': assignedRider,
      'assignedRiderStatus': assignedRiderStatus,
      'transactionId': transactionId,
      'couponCode': couponCode,
      'paymentStatus': paymentStatus,
      'razorpayOrder': razorpayOrder,
      'isReordered': isReordered,
      'deliveryCharge': deliveryCharge,
      'platformCharge': platformCharge,
      'deliveryProof': deliveryProof,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      if (version != null) '__v': version,
    };
  }
}

class DeliveryAddress {
  final String id;
  final String street;
  final String city;
  final String state;
  final String pincode;
  final bool isDefault;
  final String? landmark;
  final String? house;
  final String? country;

  DeliveryAddress({
    required this.id,
    required this.street,
    required this.city,
    required this.state,
    required this.pincode,
    required this.isDefault,
    this.landmark,
    this.house,
    this.country,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
    return DeliveryAddress(
      id: json['id']?.toString() ??
          json['_id']?.toString() ??
          json['addressId']?.toString() ??
          'default',
      street: json['street']?.toString() ??
          json['address']?.toString() ??
          json['fullAddress']?.toString() ??
          '',
      city: json['city']?.toString() ?? '',
      state: json['state']?.toString() ?? '',
      pincode: json['pincode']?.toString() ??
          json['zipCode']?.toString() ??
          json['postalCode']?.toString() ??
          '',
      isDefault: json['isDefault'] == true || json['is_default'] == true,
      landmark: json['landmark']?.toString(),
      house: json['house']?.toString(),
      country: json['country']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'street': street,
      'city': city,
      'state': state,
      'pincode': pincode,
      'isDefault': isDefault,
      'landmark': landmark,
      'house': house,
      'country': country,
    };
  }

  @override
  String toString() {
    final parts = <String>[];
    if (house?.isNotEmpty == true) parts.add(house!);
    if (street.isNotEmpty) parts.add(street);
    parts.add(city);
    parts.add(state);
    parts.add(pincode);
    return parts.join(', ');
  }
}

class OrderItem {
  final String id;
  final String name;
  final int quantity;
  final double price;
  final String? imageUrl;
  final String? description;
  final String? medicineId; // Added to match the response structure

  OrderItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    this.imageUrl,
    this.description,
    this.medicineId,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    // Handle nested medicineId structure
    Map<String, dynamic>? medicineData;
    if (json['medicineId'] is Map) {
      medicineData = Map<String, dynamic>.from(json['medicineId']);
    }

    return OrderItem(
      id: json['id']?.toString() ??
          json['_id']?.toString() ??
          medicineData?['_id']?.toString() ??
          json['medicineId']?.toString() ??
          json['productId']?.toString() ??
          DateTime.now().millisecondsSinceEpoch.toString(),

      name: json['name']?.toString() ??
          medicineData?['name']?.toString() ??
          json['medicineName']?.toString() ??
          json['productName']?.toString() ??
          'Medicine',

      quantity: (json['quantity'] ?? 1) is int
          ? json['quantity']
          : int.tryParse(json['quantity']?.toString() ?? '1') ?? 1,

      // Try to get price from multiple possible locations
      price: _getItemPrice(json, medicineData),

      imageUrl: medicineData?['images'] is List &&
              (medicineData!['images'] as List).isNotEmpty
          ? (medicineData['images'] as List).first?.toString()
          : json['imageUrl']?.toString() ??
              json['image_url']?.toString() ??
              json['image']?.toString(),

      description: medicineData?['description']?.toString() ??
          json['description']?.toString(),

      // Store the medicineId for reference
      medicineId: json['medicineId'] is String
          ? json['medicineId']
          : json['medicineId']?['_id']?.toString(),
    );
  }

  // Helper method to safely extract price from different locations
  static double _getItemPrice(
      Map<String, dynamic> json, Map<String, dynamic>? medicineData) {
    // Try different price sources in order of preference
    double? price;

    // 1. Direct price field
    price = _getDoubleValue(json['price']);
    if (price != null) return price;

    // 2. Price from medicineData
    if (medicineData != null) {
      price = _getDoubleValue(medicineData['price']);
      if (price != null) return price;
    }

    // 3. Other possible price fields
    price = _getDoubleValue(json['unitPrice']) ??
        _getDoubleValue(json['cost']) ??
        _getDoubleValue(json['amount']);

    return price ?? 0.0;
  }

  // Helper method to safely convert various types to double
  static double? _getDoubleValue(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      try {
        return double.parse(value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'medicineId': medicineId,
    };
  }
}

class StatusTimeline {
  final String id;
  final String status;
  final String message;
  final DateTime timestamp;

  StatusTimeline({
    required this.id,
    required this.status,
    required this.message,
    required this.timestamp,
  });

  factory StatusTimeline.fromJson(Map<String, dynamic> json) {
    return StatusTimeline(
      id: json['id']?.toString() ??
          json['_id']?.toString() ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      status: json['status']?.toString() ?? 'pending',
      message: json['message']?.toString() ??
          json['description']?.toString() ??
          json['note']?.toString() ??
          '',
      timestamp: _parseDateTime(json['timestamp']) ??
          _parseDateTime(json['createdAt']) ??
          _parseDateTime(json['date']) ??
          DateTime.now(),
    );
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime.now();

    try {
      if (value is String) {
        return DateTime.parse(value);
      }
      if (value is int) {
        return DateTime.fromMillisecondsSinceEpoch(value);
      }
    } catch (e) {
      print('Error parsing DateTime: $e');
    }
    return DateTime.now();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

// Request/Response models
class CreateOrderRequest {
  final String addressId;
  final String notes;
  final String voiceNoteUrl;
  final String paymentMethod;
  final String? transactionId;
  final String? coupouncode;
  final bool isPrescriptionOrder;

  CreateOrderRequest({
    required this.addressId,
    this.notes = '',
    this.transactionId,
    this.voiceNoteUrl = '',
    this.coupouncode,
    this.paymentMethod = 'Cash on Delivery',
    this.isPrescriptionOrder = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'addressId': addressId,
      'notes': notes,
      'voiceNoteUrl': voiceNoteUrl,
      'paymentMethod': paymentMethod,
      if (transactionId != null) 'transactionId': transactionId,
      'couponCode': coupouncode,
      'isPrescriptionOrder': isPrescriptionOrder,
    };
  }

  @override
  String toString() {
    return 'CreateOrderRequest{addressId: $addressId, notes: $notes, paymentMethod: $paymentMethod}';
  }
}

class OrderResponse {
  final OrderModel order;
  final String message;
  final bool success;

  OrderResponse({
    required this.order,
    required this.message,
    this.success = true,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    try {
      // Handle different response structures
      Map<String, dynamic>? orderData;

      if (json['order'] is Map) {
        orderData = Map<String, dynamic>.from(json['order']);
      } else if (json['data'] is Map) {
        orderData = Map<String, dynamic>.from(json['data']);
      } else if (json['booking'] is Map) {
        orderData = Map<String, dynamic>.from(json['booking']);
      } else {
        // If the entire response is the order data
        orderData = json;
      }

      return OrderResponse(
        order: OrderModel.fromJson(orderData!),
        message: json['message']?.toString() ?? 'Order created successfully',
        success: json['success'] == true || json['status'] == 'success',
      );
    } catch (e) {
      print('Error parsing OrderResponse: $e');
      rethrow;
    }
  }
}
