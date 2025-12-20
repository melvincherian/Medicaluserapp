// // ignore_for_file: deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'dart:convert';
// import 'package:medical_user_app/models/user_model.dart';
// import 'package:medical_user_app/utils/shared_preferences_helper.dart';

// class PeriodicDetail extends StatefulWidget {
//   const PeriodicDetail({super.key});

//   @override
//   State<PeriodicDetail> createState() => _PeriodicDetailState();
// }

// class _PeriodicDetailState extends State<PeriodicDetail> {
//   List<Map<String, dynamic>> orders = [];
//   bool isLoading = true;
//   bool hasError = false;
//   String errorMessage = '';
//   User? currentUser;

//   @override
//   void initState() {
//     super.initState();
//     _initializeAndFetchOrders();
//   }

//   Future<void> _initializeAndFetchOrders() async {
//     try {
//       // Get current user from SharedPreferences
//       currentUser = await SharedPreferencesHelper.getUser();

//       if (currentUser == null || currentUser!.id.isEmpty) {
//         setState(() {
//           hasError = true;
//           errorMessage = 'User not found. Please login again.';
//           isLoading = false;
//         });
//         return;
//       }

//       await _fetchPeriodicOrders();
//     } catch (e) {
//       setState(() {
//         hasError = true;
//         errorMessage = 'Failed to initialize: $e';
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> _fetchPeriodicOrders() async {
//     try {
//       setState(() {
//         isLoading = true;
//         hasError = false;
//       });

//       final String? token = await SharedPreferencesHelper.getToken();

//       final response = await http.get(
//         Uri.parse(
//             'http://31.97.206.144:7021/api/users/preodicorders/${currentUser!.id}'),
//         headers: {
//           'Content-Type': 'application/json',
//           if (token != null) 'Authorization': 'Bearer $token',
//         },
//       );

//       print('periodic response status code: ${response.statusCode}');
//       print('periodic response body: ${response.body}');

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);

//         if (data['success'] == true) {
//           setState(() {
//             orders = List<Map<String, dynamic>>.from(data['orders'] ?? []);
//             isLoading = false;
//           });
//         } else {
//           throw Exception('API returned success: false');
//         }
//       } else {
//         throw Exception(
//             'Failed to load orders. Status: ${response.statusCode}');
//       }
//     } catch (e) {
//       setState(() {
//         hasError = true;
//         errorMessage = 'Failed to fetch orders: $e';
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> _onRefresh() async {
//     await _fetchPeriodicOrders();
//   }

//   Color _getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'pending':
//         return Colors.orange;
//       case 'accepted':
//         return Colors.blue;
//       case 'rejected':
//         return Colors.red;
//       case 'delivered':
//         return Colors.green;
//       case 'rider assigned':
//         return Colors.purple;
//       default:
//         return Colors.grey;
//     }
//   }

//   IconData _getStatusIcon(String status) {
//     switch (status.toLowerCase()) {
//       case 'pending':
//         return Icons.schedule;
//       case 'accepted':
//         return Icons.check_circle_outline;
//       case 'rejected':
//         return Icons.cancel_outlined;
//       case 'delivered':
//         return Icons.check_circle;
//       case 'rider assigned':
//         return Icons.person_pin_circle;
//       default:
//         return Icons.info_outline;
//     }
//   }

//   String _formatDate(String dateString) {
//     if (dateString.isEmpty || dateString == "Invalid Date") {
//       return 'Date not available';
//     }

//     try {
//       DateTime date;

//       // Handle different possible date formats
//       if (dateString.contains('T')) {
//         // ISO format: 2024-01-15T10:30:00.000Z
//         date = DateTime.parse(dateString);
//       } else if (dateString.contains('/')) {
//         // Format: dd/MM/yyyy or MM/dd/yyyy
//         final parts = dateString.split('/');
//         if (parts.length == 3) {
//           // Assuming dd/MM/yyyy format
//           date = DateTime(
//             int.parse(parts[2]), // year
//             int.parse(parts[1]), // month
//             int.parse(parts[0]), // day
//           );
//         } else {
//           throw FormatException('Invalid date format');
//         }
//       } else if (dateString.contains('-') && dateString.length == 10) {
//         // Format: yyyy-MM-dd
//         date = DateTime.parse(dateString);
//       } else {
//         // Try parsing as is
//         date = DateTime.parse(dateString);
//       }

//       // Format the date nicely
//       final DateFormat formatter = DateFormat('dd MMM yyyy');
//       return formatter.format(date);
//     } catch (e) {
//       print('Date parsing error for "$dateString": $e');

//       // Try alternative parsing methods
//       try {
//         List<DateFormat> formats = [
//           DateFormat('yyyy-MM-dd'),
//           DateFormat('dd/MM/yyyy'),
//           DateFormat('MM/dd/yyyy'),
//           DateFormat('yyyy-MM-dd HH:mm:ss'),
//           DateFormat('dd-MM-yyyy'),
//         ];

//         for (DateFormat format in formats) {
//           try {
//             final date = format.parse(dateString);
//             return DateFormat('dd MMM yyyy').format(date);
//           } catch (e) {
//             continue;
//           }
//         }
//       } catch (e) {
//         print('All date parsing attempts failed: $e');
//       }

//       // If all parsing fails, return a user-friendly message
//       return 'Date not specified';
//     }
//   }

//   double _calculateTotal(Map<String, dynamic> order) {
//     // Use the total from API response if available
//     if (order['total'] != null) {
//       return order['total'].toDouble();
//     }

//     // Fallback calculation if total is not provided
//     double itemsTotal = 0.0;
//     final orderItems = order['orderItems'] as List<dynamic>? ?? [];
//     for (var item in orderItems) {
//       // If price is not available, you might need to fetch it or use a default
//       itemsTotal += (item['quantity'] ?? 1) * 50.0; // Using 50 as default price
//     }

//     final deliveryCharge = (order['deliveryCharge'] ?? 0).toDouble();
//     final platformCharge = (order['platformCharge'] ?? 0).toDouble();

//     return itemsTotal + deliveryCharge + platformCharge;
//   }

//   Widget _buildOrderCard(Map<String, dynamic> order) {
//     final currentStatus = order['status'] ?? 'Unknown';
//     final orderItems = order['orderItems'] as List<dynamic>? ?? [];
//     final deliveryAddress =
//         order['deliveryAddress'] as Map<String, dynamic>? ?? {};
//     final deliveryDate = order['deliveryDate'] ?? '';

//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: ExpansionTile(
//         leading: Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: _getStatusColor(currentStatus).withOpacity(0.1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Icon(
//             _getStatusIcon(currentStatus),
//             color: _getStatusColor(currentStatus),
//             size: 24,
//           ),
//         ),
//         title: Text(
//           'Order #${order['_id'].toString().substring(order['_id'].toString().length - 8)}',
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//           ),
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 4),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: _getStatusColor(currentStatus).withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(
//                 currentStatus,
//                 style: TextStyle(
//                   color: _getStatusColor(currentStatus),
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               'Delivery: ${_formatDate(deliveryDate)}',
//               style: TextStyle(
//                 color: Colors.grey[600],
//                 fontSize: 12,
//               ),
//             ),
//           ],
//         ),
//         trailing: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               '₹${_calculateTotal(order).toStringAsFixed(0)}',
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//                 color: Colors.green,
//               ),
//             ),
//             Text(
//               '${orderItems.length} item${orderItems.length > 1 ? 's' : ''}',
//               style: TextStyle(
//                 color: Colors.grey[600],
//                 fontSize: 12,
//               ),
//             ),
//           ],
//         ),
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Order Items Section
//                 const Text(
//                   'Items Ordered',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 ...orderItems.map((item) => Container(
//                       margin: const EdgeInsets.only(bottom: 8),
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[50],
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Row(
//                         children: [
//                           // Medicine Image
//                           Container(
//                             width: 50,
//                             height: 50,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               color: Colors.blue[100],
//                             ),
//                             child: item['image'] != null &&
//                                     item['image'].isNotEmpty
//                                 ? ClipRRect(
//                                     borderRadius: BorderRadius.circular(8),
//                                     child: Image.network(
//                                       item['image'],
//                                       fit: BoxFit.cover,
//                                       errorBuilder:
//                                           (context, error, stackTrace) {
//                                         return const Icon(
//                                             Icons.medical_services,
//                                             color: Colors.blue);
//                                       },
//                                     ),
//                                   )
//                                 : const Icon(Icons.medical_services,
//                                     color: Colors.blue),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   item['name'] ?? 'Unknown Medicine',
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 2),
//                                 Text(
//                                   'Medicine ID: ${item['medicineId']?.toString().substring((item['medicineId']?.toString().length ?? 8) - 6) ?? 'N/A'}',
//                                   style: TextStyle(
//                                     color: Colors.grey[600],
//                                     fontSize: 11,
//                                   ),
//                                 ),
//                                 Text(
//                                   'Qty: ${item['quantity'] ?? 1}',
//                                   style: TextStyle(
//                                     color: Colors.grey[700],
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     )),

//                 const SizedBox(height: 16),

//                 // Plan Type
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.purple[50],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(Icons.schedule, color: Colors.purple[600], size: 20),
//                       const SizedBox(width: 8),
//                       Text(
//                         'Plan Type: ${order['planType'] ?? 'Not specified'}',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.purple[700],
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 16),

//                 // Delivery Address
//                 const Text(
//                   'Delivery Address',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[50],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Icon(Icons.location_on,
//                           color: Colors.red, size: 20),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: Text(
//                           '${deliveryAddress['house'] ?? ''}, ${deliveryAddress['street'] ?? ''}, ${deliveryAddress['city'] ?? ''}, ${deliveryAddress['state'] ?? ''} - ${deliveryAddress['pincode'] ?? ''}, ${deliveryAddress['country'] ?? ''}',
//                           style: const TextStyle(fontSize: 14),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 16),

//                 // Payment Information
//                 const Text(
//                   'Payment Details',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[50],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Column(
//                     children: [
//                       const Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [],
//                       ),
//                       const SizedBox(height: 4),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             'Total Amount:',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             '₹${_calculateTotal(order).toStringAsFixed(0)}',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.green,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Notes (if available)
//                 if (order['notes'] != null &&
//                     order['notes'].toString().isNotEmpty) ...[
//                   const SizedBox(height: 16),
//                   const Text(
//                     'Notes',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.amber[50],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(
//                       order['notes'].toString(),
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 ],

//                 // Voice Note (if available)
//                 if (order['voiceNoteUrl'] != null &&
//                     order['voiceNoteUrl'].toString().isNotEmpty) ...[
//                   const SizedBox(height: 16),
//                   const Text(
//                     'Voice Note',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.blue[50],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(Icons.voice_chat, color: Colors.blue[600]),
//                         const SizedBox(width: 8),
//                         const Expanded(
//                           child: Text(
//                             'Voice note available',
//                             style: TextStyle(fontSize: 14),
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             // Handle voice note playback
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text(
//                                     'Voice note playback feature coming soon'),
//                               ),
//                             );
//                           },
//                           icon: Icon(Icons.play_arrow, color: Colors.blue[600]),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.receipt_long_outlined,
//             size: 80,
//             color: Colors.grey[400],
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'No Periodic Orders',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey[600],
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'You don\'t have any periodic orders yet.',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[500],
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 24),
//         ],
//       ),
//     );
//   }

//   Widget _buildErrorState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.error_outline,
//             size: 80,
//             color: Colors.red[400],
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'Something went wrong',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey[700],
//             ),
//           ),
//           const SizedBox(height: 8),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 32),
//             child: Text(
//               errorMessage,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           const SizedBox(height: 24),
//           ElevatedButton.icon(
//             onPressed: _onRefresh,
//             icon: const Icon(Icons.refresh),
//             label: const Text('Try Again'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue,
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Periodic Orders',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             icon: const Icon(Icons.arrow_back_ios)),
//         backgroundColor: Colors.blue[500],
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white),
//         actions: [
//           IconButton(
//             onPressed: _onRefresh,
//             icon: const Icon(Icons.refresh),
//             tooltip: 'Refresh Orders',
//           ),
//         ],
//       ),
//       body: isLoading
//           ? const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(),
//                   SizedBox(height: 16),
//                   Text(
//                     'Loading your periodic orders...',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : hasError
//               ? _buildErrorState()
//               : orders.isEmpty
//                   ? _buildEmptyState()
//                   : RefreshIndicator(
//                       onRefresh: _onRefresh,
//                       child: Column(
//                         children: [
//                           // Orders Summary Header
//                           Container(
//                             width: double.infinity,
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 colors: [Colors.blue[500]!, Colors.blue[600]!],
//                                 begin: Alignment.topLeft,
//                                 end: Alignment.bottomRight,
//                               ),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Total Orders: ${orders.length}',
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   currentUser != null
//                                       ? 'Welcome, ${currentUser!.name}'
//                                       : '',
//                                   style: const TextStyle(
//                                     color: Colors.white70,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           // Orders List
//                           Expanded(
//                             child: ListView.builder(
//                               padding:
//                                   const EdgeInsets.only(top: 8, bottom: 16),
//                               itemCount: orders.length,
//                               itemBuilder: (context, index) {
//                                 return _buildOrderCard(orders[index]);
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:medical_user_app/models/user_model.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';

class PeriodicDetail extends StatefulWidget {
  const PeriodicDetail({super.key});

  @override
  State<PeriodicDetail> createState() => _PeriodicDetailState();
}

class _PeriodicDetailState extends State<PeriodicDetail> {
  List<Map<String, dynamic>> orders = [];
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';
  User? currentUser;

  @override
  void initState() {
    super.initState();
    _initializeAndFetchOrders();
  }

  Future<void> _initializeAndFetchOrders() async {
    try {
      currentUser = await SharedPreferencesHelper.getUser();

      if (currentUser == null || currentUser!.id.isEmpty) {
        setState(() {
          hasError = true;
          errorMessage = 'User not found. Please login again.';
          isLoading = false;
        });
        return;
      }

      await _fetchPeriodicOrders();
    } catch (e) {
      setState(() {
        hasError = true;
        errorMessage = 'Failed to initialize: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _fetchPeriodicOrders() async {
    try {
      setState(() {
        isLoading = true;
        hasError = false;
      });

      final String? token = await SharedPreferencesHelper.getToken();

      final response = await http.get(
        Uri.parse(
            'http://31.97.206.144:7021/api/users/preodicorders/${currentUser!.id}'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      print('periodic response status code: ${response.statusCode}');
      print('periodic response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['success'] == true) {
          setState(() {
            orders = List<Map<String, dynamic>>.from(data['orders'] ?? []);
            isLoading = false;
          });
        } else {
          throw Exception('API returned success: false');
        }
      } else {
        throw Exception(
            'Failed to load orders. Status: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        hasError = true;
        errorMessage = 'Failed to fetch orders: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _cancelOrder(String orderId) async {
    try {
      final String? token = await SharedPreferencesHelper.getToken();

      final response = await http.put(
        Uri.parse(
            'http://31.97.206.144:7021/api/users/cancelpreodicorder/${currentUser!.id}/$orderId'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      print('Cancel order response status: ${response.statusCode}');
      print('Cancel order response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Order cancelled successfully'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
          // Refresh the orders list
          await _fetchPeriodicOrders();
        } else {
          throw Exception(data['message'] ?? 'Failed to cancel order');
        }
      } else {
        throw Exception(
            'Failed to cancel order. Status: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error cancelling order: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _showCancelConfirmationDialog(
      String orderId, String orderNumber) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancel Order'),
          content: Text('Are you sure you want to cancel Order #$orderNumber?'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _cancelOrder(orderId);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Yes, Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onRefresh() async {
    await _fetchPeriodicOrders();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
        return Colors.blue;
      case 'rejected':
        return Colors.red;
      case 'delivered':
        return Colors.green;
      case 'rider assigned':
        return Colors.purple;
      case 'cancelled':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.schedule;
      case 'accepted':
        return Icons.check_circle_outline;
      case 'rejected':
        return Icons.cancel_outlined;
      case 'delivered':
        return Icons.check_circle;
      case 'rider assigned':
        return Icons.person_pin_circle;
      case 'cancelled':
        return Icons.block;
      default:
        return Icons.info_outline;
    }
  }

  bool _canCancelOrder(String status) {
    // Allow cancellation only for pending and accepted orders
    final lowerStatus = status.toLowerCase();
    return lowerStatus == 'pending' || lowerStatus == 'accepted';
  }

  String _formatDate(String dateString) {
    if (dateString.isEmpty || dateString == "Invalid Date") {
      return 'Date not available';
    }

    try {
      DateTime date;

      if (dateString.contains('T')) {
        date = DateTime.parse(dateString);
      } else if (dateString.contains('/')) {
        final parts = dateString.split('/');
        if (parts.length == 3) {
          date = DateTime(
            int.parse(parts[2]),
            int.parse(parts[1]),
            int.parse(parts[0]),
          );
        } else {
          throw FormatException('Invalid date format');
        }
      } else if (dateString.contains('-') && dateString.length == 10) {
        date = DateTime.parse(dateString);
      } else {
        date = DateTime.parse(dateString);
      }

      final DateFormat formatter = DateFormat('dd MMM yyyy');
      return formatter.format(date);
    } catch (e) {
      print('Date parsing error for "$dateString": $e');

      try {
        List<DateFormat> formats = [
          DateFormat('yyyy-MM-dd'),
          DateFormat('dd/MM/yyyy'),
          DateFormat('MM/dd/yyyy'),
          DateFormat('yyyy-MM-dd HH:mm:ss'),
          DateFormat('dd-MM-yyyy'),
        ];

        for (DateFormat format in formats) {
          try {
            final date = format.parse(dateString);
            return DateFormat('dd MMM yyyy').format(date);
          } catch (e) {
            continue;
          }
        }
      } catch (e) {
        print('All date parsing attempts failed: $e');
      }

      return 'Date not specified';
    }
  }

  double _calculateTotal(Map<String, dynamic> order) {
    if (order['total'] != null) {
      return order['total'].toDouble();
    }

    double itemsTotal = 0.0;
    final orderItems = order['orderItems'] as List<dynamic>? ?? [];
    for (var item in orderItems) {
      itemsTotal += (item['quantity'] ?? 1) * 50.0;
    }

    final deliveryCharge = (order['deliveryCharge'] ?? 0).toDouble();
    final platformCharge = (order['platformCharge'] ?? 0).toDouble();

    return itemsTotal + deliveryCharge + platformCharge;
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final currentStatus = order['status'] ?? 'Unknown';
    final orderItems = order['orderItems'] as List<dynamic>? ?? [];
    final deliveryAddress =
        order['deliveryAddress'] as Map<String, dynamic>? ?? {};
    final deliveryDate = order['deliveryDate'] ?? '';
    final orderId = order['_id'] ?? '';
    final orderNumber = orderId.toString().substring(
        orderId.toString().length > 8 ? orderId.toString().length - 8 : 0);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _getStatusColor(currentStatus).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getStatusIcon(currentStatus),
            color: _getStatusColor(currentStatus),
            size: 24,
          ),
        ),
        title: Text(
          'Order #$orderNumber',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor(currentStatus).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                currentStatus,
                style: TextStyle(
                  color: _getStatusColor(currentStatus),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Delivery: ${_formatDate(deliveryDate)}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '₹${order['totalAmount']}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.green,
              ),
            ),

            // Text(
            //   '₹${_calculateTotal(order).toStringAsFixed(0)}',
            //   style: const TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 16,
            //     color: Colors.green,
            //   ),
            // ),
            Text(
              '${orderItems.length} item${orderItems.length > 1 ? 's' : ''}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order Items Section
                const Text(
                  'Items Ordered',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                ...orderItems.map((item) => Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.blue[100],
                            ),
                            child: item['image'] != null &&
                                    item['image'].isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      item['image'],
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(
                                            Icons.medical_services,
                                            color: Colors.blue);
                                      },
                                    ),
                                  )
                                : const Icon(Icons.medical_services,
                                    color: Colors.blue),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'] ?? 'Unknown Medicine',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Medicine ID: ${item['medicineId']?.toString().substring((item['medicineId']?.toString().length ?? 8) - 6) ?? 'N/A'}',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  'Qty: ${item['quantity'] ?? 1}',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),

                const SizedBox(height: 16),

                // Plan Type
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.schedule, color: Colors.purple[600], size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Plan Type: ${order['planType'] ?? 'Not specified'}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple[700],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Delivery Address
                const Text(
                  'Delivery Address',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.red, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${deliveryAddress['house'] ?? ''}, ${deliveryAddress['street'] ?? ''}, ${deliveryAddress['city'] ?? ''}, ${deliveryAddress['state'] ?? ''} - ${deliveryAddress['pincode'] ?? ''}, ${deliveryAddress['country'] ?? ''}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Payment Information
                const Text(
                  'Payment Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Amount:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          // Text(
                          //   '₹${_calculateTotal(order).toStringAsFixed(0)}',
                          //   style: const TextStyle(
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.green,
                          //     fontSize: 16,
                          //   ),
                          // ),

                          Text(
                            '₹${order['totalAmount']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                // Notes (if available)
                if (order['notes'] != null &&
                    order['notes'].toString().isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const Text(
                    'Notes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.amber[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      order['notes'].toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],

                // Voice Note (if available)
                if (order['voiceNoteUrl'] != null &&
                    order['voiceNoteUrl'].toString().isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const Text(
                    'Voice Note',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.voice_chat, color: Colors.blue[600]),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Voice note available',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Voice note playback feature coming soon'),
                              ),
                            );
                          },
                          icon: Icon(Icons.play_arrow, color: Colors.blue[600]),
                        ),
                      ],
                    ),
                  ),
                ],

                // Cancel Order Button
                if (_canCancelOrder(currentStatus)) ...[
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showCancelConfirmationDialog(orderId, orderNumber);
                      },
                      icon: const Icon(Icons.cancel_outlined),
                      label: const Text(
                        'Cancel Order',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No Periodic Orders',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You don\'t have any periodic orders yet.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon(
          //   Icons.error_outline,
          //   size: 80,
          //   color: Colors.red[400],
          // ),
          const SizedBox(height: 16),
          Text(
            'No periodic orders found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          // const SizedBox(height: 8),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 32),
          //   child: Text(
          //     errorMessage,
          //     style: TextStyle(
          //       fontSize: 14,
          //       color: Colors.grey[600],
          //     ),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          const SizedBox(height: 24),
          // ElevatedButton.icon(
          //   onPressed: _onRefresh,
          //   icon: const Icon(Icons.refresh),
          //   label: const Text('Try Again'),
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.blue,
          //     foregroundColor: Colors.white,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Periodic Orders',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(builder: (context) => const MainLayout()),
                //   (route) => false, // Removes all previous routes
                // );
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: Colors.black,
              ),
            ),
          ),
        ),
        backgroundColor: Color(0xFF5931DD),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: _onRefresh,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh Orders',
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Loading your periodic orders...',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : hasError
              ? _buildErrorState()
              : orders.isEmpty
                  ? _buildEmptyState()
                  : RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: Column(
                        children: [
                          // Orders Summary Header
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.blue[500]!, Colors.blue[600]!],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Orders: ${orders.length}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  currentUser != null
                                      ? 'Welcome, ${currentUser!.name}'
                                      : '',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Orders List
                          Expanded(
                            child: ListView.builder(
                              padding:
                                  const EdgeInsets.only(top: 8, bottom: 16),
                              itemCount: orders.length,
                              itemBuilder: (context, index) {
                                return _buildOrderCard(orders[index]);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
    );
  }
}
