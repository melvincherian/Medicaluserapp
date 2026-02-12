// // order_service.dart
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:medical_user_app/constant/api_constants.dart';
// import 'package:medical_user_app/models/order_model.dart';
// import 'package:medical_user_app/utils/shared_preferences_helper.dart';

// class OrderService {
//   static const String _logTag = 'OrderService';

//   // Create a new order
//   static Future<OrderResponse?> createOrder({
//     required String userId,
//     required CreateOrderRequest orderRequest,
//   }) async {
//     try {
//       print('$_logTag: Creating order for user: $userId');
//       print('$_logTag: Order request: ${orderRequest.toString()}');

//       final token = await SharedPreferencesHelper.getToken();
//       if (token == null || token.isEmpty) {
//         print('$_logTag: No auth token found');
//         return null;
//       }

//       final url = ApiConstants.createOrder.replaceAll(':userId', userId);
//       print('$_logTag: API URL: $url');

//       final response = await http.post(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: json.encode(orderRequest.toJson()),
//       );

//       print('$_logTag: Response status: ${response.statusCode}');
//       print('$_logTag: Response body: ${response.body}');

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         return OrderResponse.fromJson(data);
//       } else {
//         print('$_logTag: Failed to create order - Status: ${response.statusCode}');
//         return null;
//       }
//     } catch (e, stackTrace) {
//       print('$_logTag: Error creating order: $e');
//       print('$_logTag: Stack trace: $stackTrace');
//       return null;
//     }
//   }



// static Future<List<OrderModel>> getCurrentOrders(String userId) async {
//   try {
//     print('$_logTag: Fetching current orders for user: $userId');

//     final token = await SharedPreferencesHelper.getToken();
//     if (token == null || token.isEmpty) {
//       print('$_logTag: No auth token found');
//       return [];
//     }

//     final url = ApiConstants.getmyOrder.replaceAll(':userId', userId);
//     print('$_logTag: API URL: $url');

//     final response = await http.get(
//       Uri.parse(url),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//     );

//     print('$_logTag: Response status: ${response.statusCode}');
//     print('$_logTag: Response body: ${response.body}');

//     if (response.statusCode == 200) {
//       final dynamic responseData = json.decode(response.body);
//       List<dynamic>? ordersData;
      
//       if (responseData is Map<String, dynamic>) {
//         final data = responseData;
//         if (data.containsKey('orders')) {
//           ordersData = data['orders'] as List<dynamic>?;
//         } else if (data.containsKey('data')) {
//           ordersData = data['data'] as List<dynamic>?;
//         } else if (data.containsKey('bookings')) {
//           ordersData = data['bookings'] as List<dynamic>?;
//         } else {
//           // If the entire response is a single order (as a map)
//           ordersData = [data];
//         }
//       } else if (responseData is List) {
//         ordersData = responseData;
//       }

//       if (ordersData != null) {
//         final orders = ordersData
//             .map((orderJson) => OrderModel.fromJson(orderJson))
//             .toList();
        
//         // Filter for ongoing orders
//         final ongoingOrders = orders
//             .where((order) => order.isOngoing)
//             .toList();
        
//         print('$_logTag: Found ${ongoingOrders.length} ongoing orders');
//         return ongoingOrders;
//       } else {
//         print('$_logTag: No orders data found in response');
//         return [];
//       }
//     } else {
//       print('$_logTag: Failed to fetch current orders - Status: ${response.statusCode}');
//       return [];
//     }
//   } catch (e, stackTrace) {
//     print('$_logTag: Error fetching current orders: $e');
//     print('$_logTag: Stack trace: $stackTrace');
//     return [];
//   }
// }
//   // Get current/ongoing orders
//   // static Future<List<OrderModel>> getCurrentOrders(String userId) async {
//   //   try {
//   //     print('$_logTag: Fetching current orders for user: $userId');

//   //     final token = await SharedPreferencesHelper.getToken();
//   //     if (token == null || token.isEmpty) {
//   //       print('$_logTag: No auth token found');
//   //       return [];
//   //     }

//   //     final url = ApiConstants.getmyOrder.replaceAll(':userId', userId);
//   //     print('$_logTag: API URL: $url');

//   //     final response = await http.get(
//   //       Uri.parse(url),
//   //       headers: {
//   //         'Content-Type': 'application/json',
//   //         'Authorization': 'Bearer $token',
//   //       },
//   //     );

//   //     print('$_logTag: Response status: ${response.statusCode}');
//   //     print('$_logTag: Response body: ${response.body}');

//   //     if (response.statusCode == 200) {
//   //       final Map<String, dynamic> data = json.decode(response.body);
        
//   //       // Handle different API response structures
//   //       List<dynamic>? ordersData;
        
//   //       if (data.containsKey('orders')) {
//   //         ordersData = data['orders'] as List<dynamic>?;
//   //       } else if (data.containsKey('data')) {
//   //         ordersData = data['data'] as List<dynamic>?;
//   //       } else if (data.containsKey('bookings')) {
//   //         ordersData = data['bookings'] as List<dynamic>?;
//   //       } else if (data is List) {
//   //         ordersData = data;
//   //       }

//   //       if (ordersData != null) {
//   //         final orders = ordersData
//   //             .map((orderJson) => OrderModel.fromJson(orderJson))
//   //             .toList();
          
//   //         // Filter for ongoing orders
//   //         final ongoingOrders = orders
//   //             .where((order) => order.isOngoing)
//   //             .toList();
          
//   //         print('$_logTag: Found ${ongoingOrders.length} ongoing orders');
//   //         return ongoingOrders;
//   //       } else {
//   //         print('$_logTag: No orders data found in response');
//   //         return [];
//   //       }
//   //     } else {
//   //       print('$_logTag: Failed to fetch current orders - Status: ${response.statusCode}');
//   //       return [];
//   //     }
//   //   } catch (e, stackTrace) {
//   //     print('$_logTag: Error fetching current orders: $e');
//   //     print('$_logTag: Stack trace: $stackTrace');
//   //     return [];
//   //   }
//   // }

//   // Get previous/completed orders
//   // static Future<List<OrderModel>> getPreviousOrders(String userId) async {
//   //   try {
//   //     print('$_logTag: Fetching previous orders for user: $userId');

//   //     final token = await SharedPreferencesHelper.getToken();
//   //     if (token == null || token.isEmpty) {
//   //       print('$_logTag: No auth token found');
//   //       return [];
//   //     }

//   //     final url = ApiConstants.previousOrder.replaceAll(':userId', userId);
//   //     print('$_logTag: API URL: $url');

//   //     final response = await http.get(
//   //       Uri.parse(url),
//   //       headers: {
//   //         'Content-Type': 'application/json',
//   //         'Authorization': 'Bearer $token',
//   //       },
//   //     );

//   //     print('$_logTag: Response status: ${response.statusCode}');
//   //     print('$_logTag: Response body: ${response.body}');

//   //     if (response.statusCode == 200) {
//   //       final Map<String, dynamic> data = json.decode(response.body);
        
//   //       // Handle different API response structures
//   //       List<dynamic>? ordersData;
        
//   //       if (data.containsKey('orders')) {
//   //         ordersData = data['orders'] as List<dynamic>?;
//   //       } else if (data.containsKey('data')) {
//   //         ordersData = data['data'] as List<dynamic>?;
//   //       } else if (data.containsKey('previousBookings')) {
//   //         ordersData = data['previousBookings'] as List<dynamic>?;
//   //       } else if (data is List) {
//   //         ordersData = data;
//   //       }

//   //       if (ordersData != null) {
//   //         final orders = ordersData
//   //             .map((orderJson) => OrderModel.fromJson(orderJson))
//   //             .toList();
          
//   //         print('$_logTag: Found ${orders.length} previous orders');
//   //         return orders;
//   //       } else {
//   //         print('$_logTag: No previous orders data found in response');
//   //         return [];
//   //       }
//   //     } else {
//   //       print('$_logTag: Failed to fetch previous orders - Status: ${response.statusCode}');
//   //       return [];
//   //     }
//   //   } catch (e, stackTrace) {
//   //     print('$_logTag: Error fetching previous orders: $e');
//   //     print('$_logTag: Stack trace: $stackTrace');
//   //     return [];
//   //   }
//   // }

// static Future<List<OrderModel>> getPreviousOrders(String userId) async {
//   try {
//     print('$_logTag: Fetching previous orders for user: $userId');

//     final token = await SharedPreferencesHelper.getToken();
//     if (token == null || token.isEmpty) {
//       print('$_logTag: No auth token found');
//       return [];
//     }

//     final url = ApiConstants.previousOrder.replaceAll(':userId', userId);
//     print('$_logTag: API URL: $url');

//     final response = await http.get(
//       Uri.parse(url),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//     );

//     print('$_logTag: Response status: ${response.statusCode}');
//     print('$_logTag: Response body: ${response.body}');

//     if (response.statusCode == 200) {
//       final dynamic responseData = json.decode(response.body);
//       List<dynamic>? ordersData;
      
//       if (responseData is Map<String, dynamic>) {
//         final data = responseData;
//         if (data.containsKey('orders')) {
//           ordersData = data['orders'] as List<dynamic>?;
//         } else if (data.containsKey('data')) {
//           ordersData = data['data'] as List<dynamic>?;
//         } else if (data.containsKey('previousBookings')) {
//           ordersData = data['previousBookings'] as List<dynamic>?;
//         } else {
//           // If the entire response is a single order (as a map)
//           ordersData = [data];
//         }
//       } else if (responseData is List) {
//         ordersData = responseData;
//       }

//       if (ordersData != null) {
//         final orders = ordersData
//             .map((orderJson) => OrderModel.fromJson(orderJson))
//             .toList();
        
//         print('$_logTag: Found ${orders.length} previous orders');
//         return orders;
//       } else {
//         print('$_logTag: No previous orders data found in response');
//         return [];
//       }
//     } else {
//       print('$_logTag: Failed to fetch previous orders - Status: ${response.statusCode}');
//       return [];
//     }
//   } catch (e, stackTrace) {
//     print('$_logTag: Error fetching previous orders: $e');
//     print('$_logTag: Stack trace: $stackTrace');
//     return [];
//   }
// }


//   // Delete a previous order
//   static Future<bool> deletePreviousOrder({
//     required String userId,
//     required String orderId,
//   }) async {
//     try {
//       print('$_logTag: Deleting order: $orderId for user: $userId');

//       final token = await SharedPreferencesHelper.getToken();
//       if (token == null || token.isEmpty) {
//         print('$_logTag: No auth token found');
//         return false;
//       }

//       final url = ApiConstants.deletePreviousOrder
//           .replaceAll(':userId', userId)
//           .replaceAll(':orderId', orderId);
//       print('$_logTag: API URL: $url');

//       final response = await http.delete(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );

//       print('$_logTag: Response status: ${response.statusCode}');
//       print('$_logTag: Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         print('$_logTag: Order deleted successfully');
//         return true;
//       } else {
//         print('$_logTag: Failed to delete order - Status: ${response.statusCode}');
//         return false;
//       }
//     } catch (e, stackTrace) {
//       print('$_logTag: Error deleting order: $e');
//       print('$_logTag: Stack trace: $stackTrace');
//       return false;
//     }
//   }

//   // Get all orders (current + previous)
//   static Future<List<OrderModel>> getAllOrders(String userId) async {
//     try {
//       print('$_logTag: Fetching all orders for user: $userId');

//       final currentOrders = await getCurrentOrders(userId);
//       final previousOrders = await getPreviousOrders(userId);

//       final allOrders = [...currentOrders, ...previousOrders];
      
//       // Sort by creation date (newest first)
//       allOrders.sort((a, b) => b.createdAt.compareTo(a.createdAt));

//       print('$_logTag: Total orders found: ${allOrders.length}');
//       return allOrders;
//     } catch (e, stackTrace) {
//       print('$_logTag: Error fetching all orders: $e');
//       print('$_logTag: Stack trace: $stackTrace');
//       return [];
//     }
//   }

//   // Re-order (create new order based on previous order)
//   static Future<OrderResponse?> reorder({
//     required String userId,
//     required OrderModel previousOrder,
//     required String addressId,
//     String? notes,
//     String paymentMethod = 'Cash on Delivery',
//   }) async {
//     try {
//       print('$_logTag: Re-ordering order: ${previousOrder.id}');

//       // Create a new order request based on the previous order
//       final orderRequest = CreateOrderRequest(
//         addressId: addressId,
//         notes: notes ?? previousOrder.notes,
//         voiceNoteUrl: '',
//         paymentMethod: paymentMethod,
//       );

//       return await createOrder(
//         userId: userId,
//         orderRequest: orderRequest,
//       );
//     } catch (e, stackTrace) {
//       print('$_logTag: Error re-ordering: $e');
//       print('$_logTag: Stack trace: $stackTrace');
//       return null;
//     }
//   }

//   // Cancel an ongoing order
//   static Future<bool> cancelOrder({
//     required String userId,
//     required String orderId,
//   }) async {
//     try {
//       print('$_logTag: Cancelling order: $orderId for user: $userId');

//       final token = await SharedPreferencesHelper.getToken();
//       if (token == null || token.isEmpty) {
//         print('$_logTag: No auth token found');
//         return false;
//       }

//       // Note: API endpoint for cancellation might be different
//       // Using delete endpoint as fallback, adjust if needed
//       final url = ApiConstants.deletePreviousOrder
//           .replaceAll(':userId', userId)
//           .replaceAll(':orderId', orderId);
//       print('$_logTag: API URL: $url');

//       final response = await http.put(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: json.encode({'status': 'Cancelled'}),
//       );

//       print('$_logTag: Response status: ${response.statusCode}');
//       print('$_logTag: Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         print('$_logTag: Order cancelled successfully');
//         return true;
//       } else {
//         print('$_logTag: Failed to cancel order - Status: ${response.statusCode}');
//         return false;
//       }
//     } catch (e, stackTrace) {
//       print('$_logTag: Error cancelling order: $e');
//       print('$_logTag: Stack trace: $stackTrace');
//       return false;
//     }
//   }

//   // Helper method to validate order data
//   static bool validateOrderRequest(CreateOrderRequest request) {
//     if (request.addressId.isEmpty) {
//       print('$_logTag: Validation failed - Address ID is required');
//       return false;
//     }

//     if (request.paymentMethod.isEmpty) {
//       print('$_logTag: Validation failed - Payment method is required');
//       return false;
//     }

//     return true;
//   }

//   // Get order by ID
//   static Future<OrderModel?> getOrderById({
//     required String userId,
//     required String orderId,
//   }) async {
//     try {
//       print('$_logTag: Fetching order by ID: $orderId for user: $userId');

//       final allOrders = await getAllOrders(userId);
//       final order = allOrders.firstWhere(
//         (order) => order.id == orderId,
//         orElse: () => throw StateError('Order not found'),
//       );

//       print('$_logTag: Order found: ${order.id}');
//       return order;
//     } catch (e) {
//       print('$_logTag: Order not found or error: $e');
//       return null;
//     }
//   }
// }

























// order_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/constant/api_constants.dart';
import 'package:medical_user_app/models/order_model.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';

class OrderService {
  static const String _logTag = 'OrderService';

  // Create a new order
  static Future<OrderResponse?> createOrder({
    required String userId,
    required CreateOrderRequest orderRequest,
  }) async {
    try {

       print('dattttaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa $orderRequest');

      print('$_logTag: Creating order for user: $userId');
      print('$_logTag: Order request: ${orderRequest.toString()}');

      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) {
        print('$_logTag: No auth token found');
        return null;
      }

      final url = ApiConstants.createOrder.replaceAll(':userId', userId);
      print('$_logTag: API URL: $url');

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(orderRequest.toJson()),
      );

      print('$_logTag: Response status: ${response.statusCode}');
      print('$_logTag: Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        return OrderResponse.fromJson(data);
      } else {
        print('$_logTag:Failed to create order - Status: ${response.statusCode}');
        return null;
      }
    } catch (e, stackTrace) {
      print('$_logTag: Error creating order: $e');
      print('$_logTag: Stack trace: $stackTrace');
      return null;
    }
  }

  // Get current/ongoing orders with improved error handling
  static Future<List<OrderModel>> getCurrentOrders(String userId) async {
    try {
      print('$_logTag: Fetching current orders for user: $userId');

      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) {
        print('$_logTag: No auth token found');
        return [];
      }

      final url = ApiConstants.getmyOrder.replaceAll(':userId', userId);
      print('$_logTag: API URL: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('$_logTag: Response statusss: ${response.statusCode}');
      print('$_logTag: Response body: ${response.body}');

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        List<dynamic>? ordersData;
        
        if (responseData is Map<String, dynamic>) {
          final data = responseData;
          if (data.containsKey('orders')) {
            ordersData = data['orders'] as List<dynamic>?;
          } else if (data.containsKey('data')) {
            ordersData = data['data'] as List<dynamic>?;
          } else if (data.containsKey('bookings')) {
            ordersData = data['bookings'] as List<dynamic>?;
          } else {
            // If the entire response is a single order (as a map)
            ordersData = [data];
          }
        } else if (responseData is List) {
          ordersData = responseData;
        }

        if (ordersData != null) {
          final List<OrderModel> orders = [];
          
          for (var orderJson in ordersData) {
            try {
              // Ensure orderJson is a Map
              if (orderJson is Map<String, dynamic>) {
                final order = OrderModel.fromJson(orderJson);
                orders.add(order);
              } else {
                print('$_logTag: Skipping invalid order data: $orderJson');
              }
            } catch (e) {
              print('$_logTag: Error parsing individual order: $e');
              print('$_logTag: Order JSON: $orderJson');
              // Continue with other orders instead of failing completely
              continue;
            }
          }
          
          // Filter for ongoing orders
          final ongoingOrders = orders
              .where((order) => order.isOngoing)
              .toList();
          
          print('$_logTag: Found ${ongoingOrders.length} ongoing orders');
          return ongoingOrders;
        } else {
          print('$_logTag: No orders data found in response');
          return [];
        }
      } else {
        print('$_logTag: Failed to fetch current orders - Status: ${response.statusCode}');
        return [];
      }
    } catch (e, stackTrace) {
      print('$_logTag: Error fetching current orders: $e');
      print('$_logTag: Stack trace: $stackTrace');
      return [];
    }
  }

  // Get previous/completed orders with improved error handling
  static Future<List<OrderModel>> getPreviousOrders(String userId) async {
    try {
      print('$_logTag: Fetching previous orders for user: $userId');

      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) {
        print('$_logTag: No auth token found');
        return [];
      }


      print('user iddddddddddddddddddddddddd $userId');

      final url = ApiConstants.previousOrder.replaceAll(':userId', userId);
      print('$_logTag: API URL: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('$_logTag: Response status: ${response.statusCode}');
      print('$_logTag: Response body: ${response.body}');

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        List<dynamic>? ordersData;
        
        if (responseData is Map<String, dynamic>) {
          final data = responseData;
          if (data.containsKey('orders')) {
            ordersData = data['orders'] as List<dynamic>?;
          } else if (data.containsKey('data')) {
            ordersData = data['data'] as List<dynamic>?;
          } else if (data.containsKey('previousBookings')) {
            ordersData = data['previousBookings'] as List<dynamic>?;
          } else {
            // If the entire response is a single order (as a map)
            ordersData = [data];
          }
        } else if (responseData is List) {
          ordersData = responseData;
        }

        if (ordersData != null) {
          final List<OrderModel> orders = [];
          
          for (var orderJson in ordersData) {
            try {
              // Ensure orderJson is a Map
              if (orderJson is Map<String, dynamic>) {
                final order = OrderModel.fromJson(orderJson);
                orders.add(order);
              } else {
                print('$_logTag: Skipping invalid order data: $orderJson');
              }
            } catch (e) {
              print('$_logTag: Error parsing individual previous order: $e');
              print('$_logTag: Order JSON: $orderJson');
              // Continue with other orders instead of failing completely
              continue;
            }
          }
          
          print('$_logTag: Found ${orders.length} previous orders');
          return orders;
        } else {
          print('$_logTag: No previous orders data found in response');
          return [];
        }
      } else {
        print('$_logTag: Failed to fetch previous orders - Status: ${response.statusCode}');
        return [];
      }
    } catch (e, stackTrace) {
      print('$_logTag: Error fetching previous orders: $e');
      print('$_logTag: Stack trace: $stackTrace');
      return [];
    }
  }

  // Delete a previous order
  static Future<bool> deletePreviousOrder({
    required String userId,
    required String orderId,
  }) async {
    try {
      print('$_logTag: Deleting order: $orderId for user: $userId');

      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) {
        print('$_logTag: No auth token found');
        return false;
      }

      final url = ApiConstants.deletePreviousOrder
          .replaceAll(':userId', userId)
          .replaceAll(':orderId', orderId);
      print('$_logTag: API URL: $url');

      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('$_logTag: Response status: ${response.statusCode}');
      print('$_logTag: Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        print('$_logTag: Order deleted successfully');
        return true;
      } else {
        print('$_logTag: Failed to delete order - Status: ${response.statusCode}');
        return false;
      }
    } catch (e, stackTrace) {
      print('$_logTag: Error deleting order: $e');
      print('$_logTag: Stack trace: $stackTrace');
      return false;
    }
  }

  // Get all orders (current + previous)
  static Future<List<OrderModel>> getAllOrders(String userId) async {
    try {
      print('$_logTag: Fetching all orders for user: $userId');

      // Fetch both current and previous orders concurrently
      final results = await Future.wait([
        getCurrentOrders(userId),
        getPreviousOrders(userId),
      ]);

      final currentOrders = results[0];
      final previousOrders = results[1];
      
      final allOrders = [...currentOrders, ...previousOrders];
      
      // Sort by creation date (newest first)
      allOrders.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      print('$_logTag: Total orders found: ${allOrders.length}');
      return allOrders;
    } catch (e, stackTrace) {
      print('$_logTag: Error fetching all orders: $e');
      print('$_logTag: Stack trace: $stackTrace');
      return [];
    }
  }

  // Re-order (create new order based on previous order)
  static Future<OrderResponse?> reorder({
    required String userId,
    required OrderModel previousOrder,
    required String addressId,
    String? notes,
    String paymentMethod = 'Cash on Delivery',
  }) async {
    try {
      print('$_logTag: Re-ordering order: ${previousOrder.id}');

      // Create a new order request based on the previous order
      final orderRequest = CreateOrderRequest(
        addressId: addressId,
        notes: notes ?? previousOrder.notes,
        voiceNoteUrl: previousOrder.voiceNoteUrl ?? '',
        paymentMethod: paymentMethod,
      );

      return await createOrder(
        userId: userId,
        orderRequest: orderRequest,
      );
    } catch (e, stackTrace) {
      print('$_logTag: Error re-ordering: $e');
      print('$_logTag: Stack trace: $stackTrace');
      return null;
    }
  }

  // Cancel an ongoing order
  // static Future<bool> cancelOrder({
  //   required String userId,
  //   required String orderId,
  // }) async {
  //   try {
  //     print('$_logTag: Cancelling order: $orderId for user: $userId');

  //     final token = await SharedPreferencesHelper.getToken();
  //     if (token == null || token.isEmpty) {
  //       print('$_logTag: No auth token found');
  //       return false;
  //     }

  //     // Check if there's a specific cancel endpoint in your API constants
  //     // For now, using a PUT request to update status
  //     final url = ApiConstants.getmyOrder
  //         .replaceAll(':userId', userId) + '/$orderId/cancel';
  //     print('$_logTag: API URL: $url');

  //     final response = await http.put(
  //       Uri.parse(url),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //       body: json.encode({'status': 'Cancelled'}),
  //     );

  //     print('$_logTag: Response status: ${response.statusCode}');
  //     print('$_logTag: Response body: ${response.body}');

  //     if (response.statusCode == 200 || response.statusCode == 204) {
  //       print('$_logTag: Order cancelled successfully');
  //       return true;
  //     } else {
  //       print('$_logTag: Failed to cancel order - Status: ${response.statusCode}');
  //       // If the cancel endpoint doesn't exist, try alternative approach
  //       if (response.statusCode == 404) {
  //         print('$_logTag: Cancel endpoint not found, trying alternative...');
  //         return await _alternativeCancelOrder(userId, orderId);
  //       }
  //       return false;
  //     }
  //   } catch (e, stackTrace) {
  //     print('$_logTag: Error cancelling order: $e');
  //     print('$_logTag: Stack trace: $stackTrace');
  //     return false;
  //   }
  // }



    static Future<bool> cancelOrder({
    required String userId,
    required String orderId,
    String? cancelReason,
  }) async {
    try {
      print('$_logTag: Cancelling order: $orderId for user: $userId');

      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) {
        print('$_logTag: No auth token found');
        return false;
      }

      // Use the correct cancel order API endpoint from ApiConstants
      final url = ApiConstants.cancelOrder
          .replaceAll(':userId', userId)
          .replaceAll(':orderId', orderId);
      print('$_logTag: API URL: $url');

      // Prepare request body with optional cancel reason
      final Map<String, dynamic> requestBody = {};
      if (cancelReason != null && cancelReason.isNotEmpty) {
        requestBody['cancelReason'] = cancelReason;
        requestBody['status'] = 'Cancelled';
      } else {
        requestBody['status'] = 'Cancelled';
      }

      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(requestBody),
      );

      print('$_logTag: Response statusssss for cancel orderrrrrrrrrr: ${response.statusCode}');
      print('$_logTag: Response bodyyyyyyyyyyyyyyyyyyyyyyy for cancel orderrr: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        print('$_logTag: Order cancelled successfully');
        return true;
      } else if (response.statusCode == 404) {
        print('$_logTag: Order not found or already cancelled');
        return false;
      } else if (response.statusCode == 400) {
        print('$_logTag: Bad request - Order might not be cancellable');
        return false;
      } else {
        print('$_logTag: Failed to cancel order - Status: ${response.statusCode}');
        // Try to get error message from response
        try {
          final errorData = json.decode(response.body);
          if (errorData is Map<String, dynamic> && errorData.containsKey('message')) {
            print('$_logTag: Server error message: ${errorData['message']}');
          }
        } catch (e) {
          print('$_logTag: Could not parse error response');
        }
        return false;
      }
    } catch (e, stackTrace) {
      print('$_logTag: Error cancelling order: $e');
      print('$_logTag: Stack trace: $stackTrace');
      return false;
    }
  }

  // Alternative cancel method if the main cancel endpoint doesn't exist
  // static Future<bool> _alternativeCancelOrder(String userId, String orderId) async {
  //   try {
  //     // This is a fallback - you might want to adjust based on your API
  //     print('$_logTag: Attempting alternative cancel method');
      
  //     // If you have an update order endpoint, use it here
  //     // Otherwise, this might need to be implemented differently
  //     return false; // Return false for now since we don't have the exact endpoint
  //   } catch (e) {
  //     print('$_logTag: Alternative cancel failed: $e');
  //     return false;
  //   }
  // }



  static Future<Map<String, dynamic>?> cancelOrderWithResponse({
    required String userId,
    required String orderId,
    String? cancelReason,
  }) async {
    try {
      print('$_logTag: Cancelling order with response: $orderId for user: $userId');

      final token = await SharedPreferencesHelper.getToken();
      if (token == null || token.isEmpty) {
        print('$_logTag: No auth token found');
        return {
          'success': false,
          'message': 'Authentication token not found',
        };
      }

      final url = ApiConstants.cancelOrder
          .replaceAll(':userId', userId)
          .replaceAll(':orderId', orderId);
      print('$_logTag: API URL: $url');

      final Map<String, dynamic> requestBody = {
        'status': 'Cancelled',
      };
      
      if (cancelReason != null && cancelReason.isNotEmpty) {
        requestBody['cancelReason'] = cancelReason;
      }

      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(requestBody),
      );

      print('$_logTag: Response statusssss code for cancel orderrrrr: ${response.statusCode}');
      print('$_logTag: Response bodyyyyyyyyyyyy for cancel orderrrrrrrrrr: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        // Try to parse response body for additional information
        Map<String, dynamic> responseData = {
          'success': true,
          'message': 'Order cancelled successfully',
        };

        if (response.body.isNotEmpty) {
          try {
            final parsedData = json.decode(response.body);
            if (parsedData is Map<String, dynamic>) {
              responseData.addAll(parsedData);
            }
          } catch (e) {
            print('$_logTag: Could not parse success response body');
          }
        }

        return responseData;
      } else {
        // Handle error cases
        String errorMessage = 'Failed to cancel order';
        Map<String, dynamic> errorData = {
          'success': false,
          'statusCode': response.statusCode,
        };

        try {
          final parsedError = json.decode(response.body);
          if (parsedError is Map<String, dynamic>) {
            errorMessage = parsedError['message'] ?? 
                          parsedError['error'] ?? 
                          errorMessage;
            errorData.addAll(parsedError);
          }
        } catch (e) {
          print('$_logTag: Could not parse error response');
        }

        errorData['message'] = errorMessage;
        
        // Specific error handling based on status codes
        switch (response.statusCode) {
          case 404:
            errorData['message'] = 'Order not found or already processed';
            break;
          case 400:
            errorData['message'] = 'Order cannot be cancelled at this stage';
            break;
          case 403:
            errorData['message'] = 'You are not authorized to cancel this order';
            break;
          case 409:
            errorData['message'] = 'Order is already cancelled or completed';
            break;
        }

        return errorData;
      }
    } catch (e, stackTrace) {
      print('$_logTag: Error cancelling order with response: $e');
      print('$_logTag: Stack trace: $stackTrace');
      return {
        'success': false,
        'message': 'Network error occurred while cancelling order',
        'error': e.toString(),
      };
    }
  }



  static Future<bool> canCancelOrder({
    required String userId,
    required String orderId,
  }) async {
    try {
      // Get the specific order details first
      final orders = await getCurrentOrders(userId);
      final order = orders.where((o) => o.id == orderId).firstOrNull;
      
      if (order == null) {
        print('$_logTag: Order not found in current orders');
        return false;
      }

      // Check if order status allows cancellation
      final cancellableStatuses = [
        'pending',
        'confirmed',
        'processing',
        'placed',
        'accepted',
      ];

      final nonCancellableStatuses = [
        'cancelled',
        'completed',
        'delivered',
        'shipped',
        'out_for_delivery',
        'failed',
      ];

      final currentStatus = order.status.toLowerCase();
      
      if (nonCancellableStatuses.contains(currentStatus)) {
        print('$_logTag: Order cannot be cancelled - Status: ${order.status}');
        return false;
      }

      if (cancellableStatuses.contains(currentStatus)) {
        print('$_logTag: Order can be cancelled - Status: ${order.status}');
        return true;
      }

      // If status is not in predefined lists, assume it can be cancelled
      // (this handles custom statuses that might be cancellable)
      print('$_logTag: Unknown status, assuming cancellable - Status: ${order.status}');
      return true;

    } catch (e) {
      print('$_logTag: Error checking if order can be cancelled: $e');
      return false;
    }
  }


  // Helper method to validate order data
  static bool validateOrderRequest(CreateOrderRequest request) {
    if (request.addressId.isEmpty) {
      print('$_logTag: Validation failed - Address ID is required');
      return false;
    }

    if (request.paymentMethod.isEmpty) {
      print('$_logTag: Validation failed - Payment method is required');
      return false;
    }

    return true;
  }

  // Get order by ID
  static Future<OrderModel?> getOrderById({
    required String userId,
    required String orderId,
  }) async {
    try {
      print('$_logTag: Fetching order by ID: $orderId for user: $userId');

      final allOrders = await getAllOrders(userId);
      final order = allOrders.firstWhere(
        (order) => order.id == orderId,
        orElse: () => throw StateError('Order not found'),
      );

      print('$_logTag: Order found: ${order.id}');
      return order;
    } catch (e) {
      print('$_logTag: Order not found or error: $e');
      return null;
    }
  }

  // Debug method to safely print order JSON structure
  static void debugOrderJson(Map<String, dynamic> orderJson) {
    print('$_logTag: === ORDER JSON DEBUG ===');
    print('$_logTag: Keys: ${orderJson.keys.toList()}');
    
    orderJson.forEach((key, value) {
      print('$_logTag: $key: ${value.runtimeType} = $value');
    });
    
    print('$_logTag: === END DEBUG ===');
  }

  
}