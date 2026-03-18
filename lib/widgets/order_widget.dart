// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/widgets/progress_bar.dart';

// // ---------------- Models ----------------
// class OrderStatus {
//   final String status;
//   final String message;
//   final DateTime timestamp;
//   final String id;

//   OrderStatus({
//     required this.status,
//     required this.message,
//     required this.timestamp,
//     required this.id,
//   });

//   factory OrderStatus.fromJson(Map<String, dynamic> json) {
//     return OrderStatus(
//       status: json['status'] ?? '',
//       message: json['message'] ?? '',
//       timestamp: DateTime.parse(json['timestamp']),
//       id: json['_id'] ?? '',
//     );
//   }
// }

// class Medicine {
//   final String name;
//   final double mrp;
//   final String description;
//   final List<String> images;
//   final int quantity;

//   Medicine({
//     required this.name,
//     required this.mrp,
//     required this.description,
//     required this.images,
//     required this.quantity,
//   });

//   factory Medicine.fromJson(Map<String, dynamic> json) {
//     return Medicine(
//       name: json['name'] ?? '',
//       mrp: (json['mrp'] ?? 0).toDouble(),
//       description: json['description'] ?? '',
//       images: List<String>.from(json['images'] ?? []),
//       quantity: json['quantity'] ?? 0,
//     );
//   }
// }

// class OrderStatusResponse {
//   final String message;
//   final List<OrderStatus> statusTimeline;
//   final String? deliveryNote;
//   final List<Medicine> medicines;

//   OrderStatusResponse({
//     required this.message,
//     required this.statusTimeline,
//     this.deliveryNote,
//     required this.medicines,
//   });

//   factory OrderStatusResponse.fromJson(Map<String, dynamic> json) {
//     return OrderStatusResponse(
//       message: json['message'] ?? '',
//       statusTimeline: (json['statusTimeline'] as List<dynamic>?)
//               ?.map((item) => OrderStatus.fromJson(item))
//               .toList() ??
//           [],
//       deliveryNote: json['deliveryNote'],
//       medicines: (json['medicines'] as List<dynamic>?)
//               ?.map((item) => Medicine.fromJson(item))
//               .toList() ??
//           [],
//     );
//   }
// }

// // ---------------- API Service ----------------
// class OrderStatusService {
//   static const String baseUrl = 'http://31.97.206.144:7021/api/users';

//   static Future<OrderStatusResponse?> getOrderStatus(String userId) async {
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/order-status/$userId'),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//         return OrderStatusResponse.fromJson(jsonData);
//       } else {
//         print('Failed to load order status: ${response.statusCode}');
//         return null;
//       }
//     } catch (e) {
//       print('Error fetching order status: $e');
//       return null;
//     }
//   }
// }

// // ---------------- Main Widget ----------------
// class OrderStatusWidget extends StatefulWidget {
//   final String userId;

//   const OrderStatusWidget({
//     Key? key,
//     required this.userId,
//   }) : super(key: key);

//   @override
//   State<OrderStatusWidget> createState() => _OrderStatusWidgetState();
// }

// class _OrderStatusWidgetState extends State<OrderStatusWidget> {
//   OrderStatusResponse? orderData;
//   bool isLoading = true;
//   String? error;
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     _loadOrderStatus();

//     // Poll API every 8 seconds
//     _timer = Timer.periodic(const Duration(seconds: 8), (timer) {
//       if (mounted) {
//         if (_isDelivered()) {
//           timer.cancel(); // Stop polling once delivered
//         } else {
//           _loadOrderStatus();
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   Future<void> _loadOrderStatus() async {
//     try {
//       final data = await OrderStatusService.getOrderStatus(widget.userId);
//       setState(() {
//         orderData = data;
//         isLoading = false;
//         if (data == null) {
//           error = 'Failed to load order status';
//         }
//       });

//       // ✅ Show snackbar when delivered
//       if (_isDelivered()) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text("Your order has been delivered! 🎉"),
//               backgroundColor: Colors.green,
//             ),
//           );
//         }
//       }
//     } catch (e) {
//       setState(() {
//         error: 'Error: $e';
//         isLoading: false;
//       });
//     }
//   }

//   bool _isDelivered() {
//     if (orderData == null) return false;
//     final statuses =
//         orderData!.statusTimeline.map((s) => s.status.toLowerCase());
//     return statuses
//         .any((s) => s.contains('delivered') || s.contains('completed'));
//   }

//   int get currentStep {
//     if (orderData?.statusTimeline.isEmpty ?? true) return 1;

//     // Get all unique statuses from timeline
//     final allStatuses = orderData!.statusTimeline
//         .map((s) => s.status.toLowerCase())
//         .toSet();

//     // Check for delivered/completed - Step 4 (final)
//     if (allStatuses.any((status) =>
//         status.contains('delivered') ||
//         status.contains('completed'))) {
//       return 4;
//     }

//     // Check for picked up - Step 3
//     if (allStatuses.any((status) =>
//         status.contains('pickedup') ||
//         status.contains('picked up'))) {
//       return 3;
//     }

//     // Check for accepted - Step 2
//     if (allStatuses.any((status) =>
//         status.contains('accepted'))) {
//       return 2;
//     }

//     // Check for pending/placed/rider assigned - Step 1
//     if (allStatuses.any((status) =>
//         status.contains('pending') ||
//         status.contains('placed') ||
//         status.contains('rider assigned') ||
//         status.contains('assigned'))) {
//       return 1;
//     }

//     return 1; // Default to first step
//   }

//   String get currentStatusLabel {
//     if (orderData?.statusTimeline.isEmpty ?? true) return 'Order Placed';

//     final latestStatus = orderData!.statusTimeline.last.status.toLowerCase();

//     if (latestStatus.contains('delivered') || latestStatus.contains('completed')) {
//       return 'Delivered';
//     } else if (latestStatus.contains('pickedup') || latestStatus.contains('picked up')) {
//       return 'Order Picked and Out for Delivery';
//     } else if (latestStatus.contains('accepted')) {
//       return 'Rider Accepted and going to PickUp';
//     } else if (latestStatus.contains('rider assigned') || latestStatus.contains('assigned') || latestStatus.contains('pending') || latestStatus.contains('placed')) {
//       return 'Order Placed';
//     }

//     return 'Order Placed';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 4,
//             offset: const Offset(0, 1),
//           ),
//         ],
//       ),
//       child: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : error != null
//               ? const Column(
//                   children: [
//                     SizedBox(height: 8),
//                     Text('No orders found'),
//                     SizedBox(height: 8),
//                   ],
//                 )
//               : Stack(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Container(
//                               width: 60,
//                               height: 60,
//                               decoration: BoxDecoration(
//                                 color: Colors.blue[50],
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: orderData!.medicines.isNotEmpty &&
//                                         orderData!
//                                             .medicines.first.images.isNotEmpty
//                                     ? Image.network(
//                                         orderData!.medicines.first.images.first,
//                                         fit: BoxFit.cover,
//                                         errorBuilder:
//                                             (context, error, stackTrace) =>
//                                                 Icon(Icons.local_pharmacy,
//                                                     color: Colors.blue[600],
//                                                     size: 30),
//                                       )
//                                     : Icon(Icons.local_pharmacy,
//                                         color: Colors.blue[600], size: 30),
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text(
//                                     'Order Status',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                   if (orderData?.statusTimeline.isNotEmpty ??
//                                       false)
//                                     Text(
//                                       orderData!.statusTimeline.last.message,
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.grey[600],
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                         CustomProgressBar(
//                             currentStep: currentStep, totalSteps: 4),
//                         const SizedBox(height: 16),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             _buildStepItem(
//                               icon: Icons.shopping_cart,
//                               label: 'Order Placed',
//                               isActive: currentStep >= 1,
//                             ),
//                             _buildStepItem(
//                               icon: Icons.check_circle_outline,
//                               label: 'Rider Accepted',
//                               isActive: currentStep >= 2,
//                             ),
//                             _buildStepItem(
//                               icon: Icons.local_shipping,
//                               label: 'Out for Delivery',
//                               isActive: currentStep >= 3,
//                             ),
//                             _buildStepItem(
//                               icon: Icons.check_circle,
//                               label: 'Delivered',
//                               isActive: currentStep >= 4,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 20),
//                       ],
//                     ),
//                     Positioned(
//                       top: 0,
//                       right: 0,
//                       child: Text(
//                         _formatLastUpdate(),
//                         style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                       ),
//                     ),
//                   ],
//                 ),
//     );
//   }

//   // ---------------- Helpers ----------------
//   Widget _buildStepItem({
//     required IconData icon,
//     required String label,
//     required bool isActive,
//   }) {
//     return Column(
//       children: [
//         Container(
//           width: 44,
//           height: 44,
//           decoration: BoxDecoration(
//             color: isActive ? Colors.blue[50] : Colors.grey[50],
//             borderRadius: BorderRadius.circular(22),
//             border: Border.all(
//               color: isActive ? Colors.blue : Colors.grey.shade300,
//               width: 2,
//             ),
//           ),
//           child: Icon(
//             icon,
//             color: isActive ? Colors.blue : Colors.grey[600],
//             size: 24,
//           ),
//         ),
//         const SizedBox(height: 6),
//         Text(
//           label,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 10,
//             fontWeight: FontWeight.normal,
//             color: isActive ? Colors.blue : Colors.grey[600],
//           ),
//         ),
//       ],
//     );
//   }

//   String _formatTimestamp(DateTime timestamp) {
//     final now = DateTime.now();
//     final difference = now.difference(timestamp);

//     if (difference.inMinutes < 60) {
//       return '${difference.inMinutes}m ago';
//     } else if (difference.inHours < 24) {
//       return '${difference.inHours}h ago';
//     } else {
//       return '${difference.inDays}d ago';
//     }
//   }

//   String _formatLastUpdate() {
//     if (orderData?.statusTimeline.isEmpty ?? true) {
//       return 'No updates';
//     }
//     final lastUpdate = orderData!.statusTimeline.last.timestamp;
//     return 'Updated ${_formatTimestamp(lastUpdate)}';
//   }
// }

// class OrderStatusWidget extends StatefulWidget {
//   final String userId;

//   const OrderStatusWidget({
//     Key? key,
//     required this.userId,
//   }) : super(key: key);

//   @override
//   State<OrderStatusWidget> createState() => _OrderStatusWidgetState();
// }

// class _OrderStatusWidgetState extends State<OrderStatusWidget> {
//   OrderStatusResponse? orderData;
//   bool isLoading = true;
//   String? error;
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     _loadOrderStatus();

//     // Poll API every 8 seconds
//     _timer = Timer.periodic(const Duration(seconds: 8), (timer) {
//       if (mounted) {
//         if (_isDelivered()) {
//           timer.cancel(); // Stop polling once delivered
//         } else {
//           _loadOrderStatus();
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   Future<void> _loadOrderStatus() async {
//     try {
//       final data = await OrderStatusService.getOrderStatus(widget.userId);
//       setState(() {
//         orderData = data;
//         isLoading = false;
//         if (data == null) {
//           error = 'Failed to load order status';
//         }
//       });

//       // Show snackbar when delivered
//       if (_isDelivered()) {
//         if (mounted) {
//           // ScaffoldMessenger.of(context).showSnackBar(
//           //   const SnackBar(
//           //     content: Text("Your order has been delivered! 🎉"),
//           //     backgroundColor: Colors.green,
//           //   ),
//           // );
//         }
//       }
//     } catch (e) {
//       setState(() {
//         error = 'Error: $e';
//         isLoading = false;
//       });
//     }
//   }

//   bool _isDelivered() {
//     if (orderData == null) return false;
//     final statuses =
//         orderData!.statusTimeline.map((s) => s.status.toLowerCase());
//     return statuses
//         .any((s) => s.contains('delivered') || s.contains('completed'));
//   }

//   int get currentStep {
//     if (orderData?.statusTimeline.isEmpty ?? true) return 1;

//     // Keep list for accurate length
//     final allStatuses =
//         orderData!.statusTimeline.map((s) => s.status.toLowerCase()).toList();

//     final allmsg =
//         orderData!.statusTimeline.map((s) => s.message.toLowerCase()).toList();

//     // Step 5: Delivered
//     if (allStatuses.any((status) =>
//         status.contains('delivered') || status.contains('completed'))) {
//       return 5;
//     }

//     // Step 4: Out for Delivery
//     if (allStatuses.any((status) =>
//         status.contains('out for delivery') ||
//         status.contains('pickedup') ||
//         status.contains('picked up'))) {
//       return 4;
//     }

//     // Step 3: Rider Accepted
//     if (allStatuses.any((status) => status.contains('accepted')) &&
//         allStatuses.length == 4) {
//       // also print the matched message
//       final acceptedMsg = allmsg.firstWhere(
//         (msg) => msg.contains('rider updated status to accepted'),
//         orElse: () => 'No rider accepted message found',
//       );
//       print("Matched Rider Accepted Message: $acceptedMsg");
//       return 3;
//     }

//     // Step 2: Vendor Accepted
//     if (allStatuses.any((status) =>
//         status.contains('vendor accepted') || status.contains('accepted'))) {
//       return 2;
//     }

//     // Step 1: Order Placed
//     if (allStatuses.any((status) =>
//         status.contains('pending') ||
//         status.contains('placed') ||
//         status.contains('rider assigned') ||
//         status.contains('assigned'))) {
//       return 1;
//     }

//     return 1; // Default to first step
//   }

//   String get currentStatusLabel {
//     if (orderData?.statusTimeline.isEmpty ?? true) return 'Order Placed';

//     final latestStatus = orderData!.statusTimeline.last.status.toLowerCase();

//     if (latestStatus.contains('delivered') ||
//         latestStatus.contains('completed')) {
//       return 'Delivered';
//     } else if (latestStatus.contains('out for delivery') ||
//         latestStatus.contains('pickedup') ||
//         latestStatus.contains('picked up')) {
//       return 'Out for Delivery';
//     } else if (latestStatus.contains('rider accepted')) {
//       return 'Rider Accepted';
//     } else if (latestStatus.contains('vendor accepted') ||
//         latestStatus.contains('accepted')) {
//       return 'Vendor Accepted';
//     } else if (latestStatus.contains('rider assigned') ||
//         latestStatus.contains('assigned') ||
//         latestStatus.contains('pending') ||
//         latestStatus.contains('placed')) {
//       return 'Order Placed';
//     }

//     return 'Order Placed';
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Hide widget completely when order is delivered
//     if (_isDelivered()) {
//       return const SizedBox.shrink();
//     }

//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 4,
//             offset: const Offset(0, 1),
//           ),
//         ],
//       ),
//       child: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : error != null
//               ? const Column(
//                   children: [
//                     SizedBox(height: 8),
//                     Text('No orders found'),
//                     SizedBox(height: 8),
//                   ],
//                 )
//               : Stack(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Container(
//                               width: 60,
//                               height: 60,
//                               decoration: BoxDecoration(
//                                 color: Colors.blue[50],
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: orderData!.medicines.isNotEmpty &&
//                                         orderData!
//                                             .medicines.first.images.isNotEmpty
//                                     ? Image.network(
//                                         orderData!.medicines.first.images.first,
//                                         fit: BoxFit.cover,
//                                         errorBuilder:
//                                             (context, error, stackTrace) =>
//                                                 Icon(Icons.local_pharmacy,
//                                                     color: Colors.blue[600],
//                                                     size: 30),
//                                       )
//                                     : Icon(Icons.local_pharmacy,
//                                         color: Colors.blue[600], size: 30),
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text(
//                                     'Order Status',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                   if (orderData?.statusTimeline.isNotEmpty ??
//                                       false)
//                                     Text(
//                                       orderData!.statusTimeline.last.message,
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.grey[600],
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                         CustomProgressBar(
//                             currentStep: currentStep, totalSteps: 5),
//                         const SizedBox(height: 16),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             _buildStepItem(
//                               icon: Icons.shopping_cart,
//                               label: 'Order\nPlaced',
//                               isActive: currentStep >= 1,
//                             ),
//                             _buildStepItem(
//                               icon: Icons.store,
//                               label: 'Vendor\nAccepted',
//                               isActive: currentStep >= 2,
//                             ),
//                             _buildStepItem(
//                               icon: Icons.two_wheeler,
//                               label: 'Rider\nAccepted',
//                               isActive: currentStep >= 3,
//                             ),
//                             _buildStepItem(
//                               icon: Icons.local_shipping,
//                               label: 'Out for\nDelivery',
//                               isActive: currentStep >= 4,
//                             ),
//                             _buildStepItem(
//                               icon: Icons.check_circle,
//                               label: 'Delivered',
//                               isActive: currentStep >= 5,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 20),
//                       ],
//                     ),
//                     Positioned(
//                       top: 0,
//                       right: 0,
//                       child: Text(
//                         _formatLastUpdate(),
//                         style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                       ),
//                     ),
//                   ],
//                 ),
//     );
//   }

//   // ---------------- Helpers ----------------
//   Widget _buildStepItem({
//     required IconData icon,
//     required String label,
//     required bool isActive,
//   }) {
//     return Column(
//       children: [
//         Container(
//           width: 40,
//           height: 40,
//           decoration: BoxDecoration(
//             color: isActive ? Colors.blue[50] : Colors.grey[50],
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(
//               color: isActive ? Colors.blue : Colors.grey.shade300,
//               width: 2,
//             ),
//           ),
//           child: Icon(
//             icon,
//             color: isActive ? Colors.blue : Colors.grey[600],
//             size: 20,
//           ),
//         ),
//         const SizedBox(height: 4),
//         SizedBox(
//           width: 50,
//           child: Text(
//             label,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 9,
//               fontWeight: FontWeight.normal,
//               color: isActive ? Colors.blue : Colors.grey[600],
//               height: 1.2,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   String _formatTimestamp(DateTime timestamp) {
//     final now = DateTime.now();
//     final difference = now.difference(timestamp);

//     if (difference.inMinutes < 60) {
//       return '${difference.inMinutes}m ago';
//     } else if (difference.inHours < 24) {
//       return '${difference.inHours}h ago';
//     } else {
//       return '${difference.inDays}d ago';
//     }
//   }

//   String _formatLastUpdate() {
//     if (orderData?.statusTimeline.isEmpty ?? true) {
//       return 'No updates';
//     }
//     final lastUpdate = orderData!.statusTimeline.last.timestamp;
//     return 'Updated ${_formatTimestamp(lastUpdate)}';
//   }
// }

class OrderStatusWidget extends StatefulWidget {
  final String userId;

  const OrderStatusWidget({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<OrderStatusWidget> createState() => _OrderStatusWidgetState();
}

class _OrderStatusWidgetState extends State<OrderStatusWidget> {
  OrderStatusResponse? orderData;
  bool isLoading = true;
  String? error;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadOrderStatus();

    // Poll API every 8 seconds
    _timer = Timer.periodic(const Duration(seconds: 8), (timer) {
      if (mounted) {
        if (_isDelivered() || _isCancelled()) {
          timer.cancel(); // Stop polling once delivered or cancelled
        } else {
          _loadOrderStatus();
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Future<void> _loadOrderStatus() async {
  //   try {
  //     final data = await OrderStatusService.getOrderStatus(widget.userId);
  //     setState(() {
  //       orderData = data;
  //       isLoading = false;
  //       if (data == null) {
  //         error = 'Failed to load order status';
  //       }
  //     });

  //     // Show snackbar when delivered
  //     if (_isDelivered()) {
  //       if (mounted) {
  //         // ScaffoldMessenger.of(context).showSnackBar(
  //         //   const SnackBar(
  //         //     content: Text("Your order has been delivered! 🎉"),
  //         //     backgroundColor: Colors.green,
  //         //   ),
  //         // );
  //       }
  //     }
  //   } catch (e) {
  //     setState(() {
  //       error = 'Error: $e';
  //       isLoading = false;
  //     });
  //   }
  // }



//   Future<void> _loadOrderStatus() async {
//   try {
//     final data = await OrderStatusService.getOrderStatus(widget.userId);
//     setState(() {
//       orderData = data;
//       isLoading = false;
//       if (data == null) {
//         error = 'Failed to load order status';
//       }
//     });

//     // Stop polling and hide widget if cancelled
//     if (_isCancelled()) {
//       _timer?.cancel();
//       if (mounted) {
//         // Optionally show a snackbar for cancelled orders
//         // ScaffoldMessenger.of(context).showSnackBar(
//         //   const SnackBar(
//         //     content: Text("Your order has been cancelled"),
//         //     backgroundColor: Colors.orange,
//         //     duration: Duration(seconds: 2),
//         //   ),
//         // );
//       }
//     }

//     // Show snackbar when delivered
//     if (_isDelivered()) {
//       _timer?.cancel();
//       if (mounted) {
//         // ScaffoldMessenger.of(context).showSnackBar(
//         //   const SnackBar(
//         //     content: Text("Your order has been delivered! 🎉"),
//         //     backgroundColor: Colors.green,
//         //     duration: Duration(seconds: 2),
//         //   ),
//         // );
//       }
//     }
//   } catch (e) {
//     setState(() {
//       error = 'Error: $e';
//       isLoading = false;
//     });
//   }
// }



Future<void> _loadOrderStatus() async {
  try {
    final data = await OrderStatusService.getOrderStatus(widget.userId);
    
    // Track if it was already delivered before this update
    final wasDelivered = _isDelivered();
    
    setState(() {
      orderData = data;
      isLoading = false;
      if (data == null) {
        error = 'Failed to load order status';
      }
    });

    // Stop polling and show popup if newly delivered
    if (!wasDelivered && _isDelivered()) {
      _timer?.cancel();
      if (mounted) {
        _showOrderCompletedDialog();
      }
    }

    // Stop polling if cancelled
    if (_isCancelled()) {
      _timer?.cancel();
    }

  } catch (e) {
    setState(() {
      error = 'Error: $e';
      isLoading = false;
    });
  }
}

void _showOrderCompletedDialog() {
  showDialog(
    context: context,
    barrierDismissible: false, // User must tap the button to close
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.green[50],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: Colors.green[600],
                size: 50,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Order Delivered! 🎉',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your order has been successfully delivered.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                'Great, Thanks!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

  bool _isDelivered() {
    if (orderData == null) return false;
    final statuses =
        orderData!.statusTimeline.map((s) => s.status.toLowerCase());
    return statuses
        .any((s) => s.contains('delivered') || s.contains('completed'));
  }

  // bool _isCancelled() {
  //   if (orderData == null) return false;
  //   final statuses =
  //       orderData!.statusTimeline.map((s) => s.status.toLowerCase());
  //   return statuses
  //       .any((s) => s.contains('cancelled') || s.contains('canceled'));
  // }


  bool _isCancelled() {
  if (orderData == null) return false;
  
  // Check both status and message fields for cancelled state
  final statuses = orderData!.statusTimeline.map((s) => s.status.toLowerCase());
  final messages = orderData!.statusTimeline.map((s) => s.message.toLowerCase());
  
  return statuses.any((s) => 
      s.contains('cancelled') || 
      s.contains('canceled') ||
      s == 'cancelled' ||
      s == 'canceled'
    ) || messages.any((m) => 
      m.contains('cancelled') || 
      m.contains('canceled')
    );
}

  int get currentStep {
    if (orderData?.statusTimeline.isEmpty ?? true) return 1;

    // Keep list for accurate length
    final allStatuses =
        orderData!.statusTimeline.map((s) => s.status.toLowerCase()).toList();

    final allmsg =
        orderData!.statusTimeline.map((s) => s.message.toLowerCase()).toList();

    // Step 5: Delivered
    if (allStatuses.any((status) =>
        status.contains('delivered') || status.contains('completed'))) {
      return 5;
    }

    // Step 4: Out for Delivery
    if (allStatuses.any((status) =>
        status.contains('out for delivery') ||
        status.contains('pickedup') ||
        status.contains('picked up'))) {
      return 4;
    }

    // Step 3: Rider Accepted
    if (allStatuses.any((status) => status.contains('accepted')) &&
        allStatuses.length == 4) {
      // also print the matched message
      final acceptedMsg = allmsg.firstWhere(
        (msg) => msg.contains('rider updated status to accepted'),
        orElse: () => 'No rider accepted message found',
      );
      print("Matched Rider Accepted Message: $acceptedMsg");
      return 3;
    }

    // Step 2: Vendor Accepted
    if (allStatuses.any((status) =>
        status.contains('vendor accepted') || status.contains('accepted'))) {
      return 2;
    }

    // Step 1: Order Placed
    if (allStatuses.any((status) =>
        status.contains('pending') ||
        status.contains('placed') ||
        status.contains('rider assigned') ||
        status.contains('assigned'))) {
      return 1;
    }

    return 1; // Default to first step
  }

  String get currentStatusLabel {
    if (orderData?.statusTimeline.isEmpty ?? true) return 'Order Placed';

    final latestStatus = orderData!.statusTimeline.last.status.toLowerCase();

    if (latestStatus.contains('delivered') ||
        latestStatus.contains('completed')) {
      return 'Delivered';
    } else if (latestStatus.contains('out for delivery') ||
        latestStatus.contains('pickedup') ||
        latestStatus.contains('picked up')) {
      return 'Out for Delivery';
    } else if (latestStatus.contains('rider accepted')) {
      return 'Rider Accepted';
    } else if (latestStatus.contains('vendor accepted') ||
        latestStatus.contains('accepted')) {
      return 'Vendor Accepted';
    } else if (latestStatus.contains('rider assigned') ||
        latestStatus.contains('assigned') ||
        latestStatus.contains('pending') ||
        latestStatus.contains('placed')) {
      return 'Order Placed';
    }

    return 'Order Placed';
  }

  @override
  Widget build(BuildContext context) {
    // Hide widget completely when order is delivered or cancelled
    if (_isDelivered() || _isCancelled()) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? const Column(
                  children: [
                    SizedBox(height: 8),
                    Text('No orders found'),
                    SizedBox(height: 8),
                  ],
                )
              : Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: orderData!.medicines.isNotEmpty &&
                                        orderData!
                                            .medicines.first.images.isNotEmpty
                                    ? Image.network(
                                        orderData!.medicines.first.images.first,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Icon(Icons.local_pharmacy,
                                                    color: Colors.blue[600],
                                                    size: 30),
                                      )
                                    : Icon(Icons.local_pharmacy,
                                        color: Colors.blue[600], size: 30),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Order Status',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  if (orderData?.statusTimeline.isNotEmpty ??
                                      false)
                                    Text(
                                      orderData!.statusTimeline.last.message,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        CustomProgressBar(
                            currentStep: currentStep, totalSteps: 5),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildStepItem(
                              icon: Icons.shopping_cart,
                              label: 'Order\nPlaced',
                              isActive: currentStep >= 1,
                            ),
                            _buildStepItem(
                              icon: Icons.store,
                              label: 'Vendor\nAccepted',
                              isActive: currentStep >= 2,
                            ),
                            _buildStepItem(
                              icon: Icons.two_wheeler,
                              label: 'Rider\nAccepted',
                              isActive: currentStep >= 3,
                            ),
                            _buildStepItem(
                              icon: Icons.local_shipping,
                              label: 'Out for\nDelivery',
                              isActive: currentStep >= 4,
                            ),
                            _buildStepItem(
                              icon: Icons.check_circle,
                              label: 'Delivered',
                              isActive: currentStep >= 5,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Text(
                        _formatLastUpdate(),
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
    );
  }

  // ---------------- Helpers ----------------
  Widget _buildStepItem({
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isActive ? Colors.blue[50] : Colors.grey[50],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isActive ? Colors.blue : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Icon(
            icon,
            color: isActive ? Colors.blue : Colors.grey[600],
            size: 20,
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 50,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.normal,
              color: isActive ? Colors.blue : Colors.grey[600],
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  String _formatLastUpdate() {
    if (orderData?.statusTimeline.isEmpty ?? true) {
      return 'No updates';
    }
    final lastUpdate = orderData!.statusTimeline.last.timestamp;
    return 'Updated ${_formatTimestamp(lastUpdate)}';
  }
}

// class OrderStatusWidget extends StatefulWidget {
//   final String userId;

//   const OrderStatusWidget({
//     Key? key,
//     required this.userId,
//   }) : super(key: key);

//   @override
//   State<OrderStatusWidget> createState() => _OrderStatusWidgetState();
// }

// class _OrderStatusWidgetState extends State<OrderStatusWidget> {
//   OrderStatusResponse? orderData;
//   bool isLoading = true;
//   String? error;
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     _loadOrderStatus();

//     // Poll API every 8 seconds
//     _timer = Timer.periodic(const Duration(seconds: 8), (timer) {
//       if (mounted) {
//         if (_isDelivered()) {
//           timer.cancel(); // Stop polling once delivered
//         } else {
//           _loadOrderStatus();
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   Future<void> _loadOrderStatus() async {
//     try {
//       final data = await OrderStatusService.getOrderStatus(widget.userId);
//       setState(() {
//         orderData = data;
//         isLoading = false;
//         if (data == null) {
//           error = 'Failed to load order status';
//         }
//       });

//       // Show snackbar when delivered
//       if (_isDelivered()) {
//         if (mounted) {
//           // ScaffoldMessenger.of(context).showSnackBar(
//           //   const SnackBar(
//           //     content: Text("Your order has been delivered! 🎉"),
//           //     backgroundColor: Colors.green,
//           //   ),
//           // );
//         }
//       }
//     } catch (e) {
//       setState(() {
//         error = 'Error: $e';
//         isLoading = false;
//       });
//     }
//   }

//   bool _isDelivered() {
//     if (orderData == null) return false;
//     final statuses =
//         orderData!.statusTimeline.map((s) => s.status.toLowerCase());
//     return statuses
//         .any((s) => s.contains('delivered') || s.contains('completed'));
//   }

//   int get currentStep {
//     if (orderData?.statusTimeline.isEmpty ?? true) return 1;

//     // Keep list for accurate length
//     final allStatuses =
//         orderData!.statusTimeline.map((s) => s.status.toLowerCase()).toList();

//     final allmsg =
//         orderData!.statusTimeline.map((s) => s.message.toLowerCase()).toList();

//     // Step 5: Delivered
//     if (allStatuses.any((status) =>
//         status.contains('delivered') || status.contains('completed'))) {
//       return 5;
//     }

//     // Step 4: Out for Delivery
//     if (allStatuses.any((status) =>
//         status.contains('out for delivery') ||
//         status.contains('pickedup') ||
//         status.contains('picked up'))) {
//       return 4;
//     }

//     // Step 3: Rider Accepted
//     if (allStatuses.any((status) => status.contains('accepted')) &&
//         allStatuses.length == 4) {
//       // also print the matched message
//       final acceptedMsg = allmsg.firstWhere(
//         (msg) => msg.contains('rider updated status to accepted'),
//         orElse: () => 'No rider accepted message found',
//       );
//       print("Matched Rider Accepted Message: $acceptedMsg");
//       return 3;
//     }

//     // Step 2: Vendor Accepted
//     if (allStatuses.any((status) =>
//         status.contains('vendor accepted') || status.contains('accepted'))) {
//       return 2;
//     }

//     // Step 1: Order Placed
//     if (allStatuses.any((status) =>
//         status.contains('pending') ||
//         status.contains('placed') ||
//         status.contains('rider assigned') ||
//         status.contains('assigned'))) {
//       return 1;
//     }

//     return 1; // Default to first step
//   }

//   String get currentStatusLabel {
//     if (orderData?.statusTimeline.isEmpty ?? true) return 'Order Placed';

//     final latestStatus = orderData!.statusTimeline.last.status.toLowerCase();

//     if (latestStatus.contains('delivered') ||
//         latestStatus.contains('completed')) {
//       return 'Delivered';
//     } else if (latestStatus.contains('out for delivery') ||
//         latestStatus.contains('pickedup') ||
//         latestStatus.contains('picked up')) {
//       return 'Out for Delivery';
//     } else if (latestStatus.contains('rider accepted')) {
//       return 'Rider Accepted';
//     } else if (latestStatus.contains('vendor accepted') ||
//         latestStatus.contains('accepted')) {
//       return 'Vendor Accepted';
//     } else if (latestStatus.contains('rider assigned') ||
//         latestStatus.contains('assigned') ||
//         latestStatus.contains('pending') ||
//         latestStatus.contains('placed')) {
//       return 'Order Placed';
//     }

//     return 'Order Placed';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 4,
//             offset: const Offset(0, 1),
//           ),
//         ],
//       ),
//       child: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : error != null
//               ? const Column(
//                   children: [
//                     SizedBox(height: 8),
//                     Text('No orders found'),
//                     SizedBox(height: 8),
//                   ],
//                 )
//               : Stack(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Container(
//                               width: 60,
//                               height: 60,
//                               decoration: BoxDecoration(
//                                 color: Colors.blue[50],
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: orderData!.medicines.isNotEmpty &&
//                                         orderData!
//                                             .medicines.first.images.isNotEmpty
//                                     ? Image.network(
//                                         orderData!.medicines.first.images.first,
//                                         fit: BoxFit.cover,
//                                         errorBuilder:
//                                             (context, error, stackTrace) =>
//                                                 Icon(Icons.local_pharmacy,
//                                                     color: Colors.blue[600],
//                                                     size: 30),
//                                       )
//                                     : Icon(Icons.local_pharmacy,
//                                         color: Colors.blue[600], size: 30),
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text(
//                                     'Order Status',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                   if (orderData?.statusTimeline.isNotEmpty ??
//                                       false)
//                                     Text(
//                                       orderData!.statusTimeline.last.message,
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.grey[600],
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                         CustomProgressBar(
//                             currentStep: currentStep, totalSteps: 5),
//                         const SizedBox(height: 16),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             _buildStepItem(
//                               icon: Icons.shopping_cart,
//                               label: 'Order\nPlaced',
//                               isActive: currentStep >= 1,
//                             ),
//                             _buildStepItem(
//                               icon: Icons.store,
//                               label: 'Vendor\nAccepted',
//                               isActive: currentStep >= 2,
//                             ),
//                             _buildStepItem(
//                               icon: Icons.two_wheeler,
//                               label: 'Rider\nAccepted',
//                               isActive: currentStep >= 3,
//                             ),
//                             _buildStepItem(
//                               icon: Icons.local_shipping,
//                               label: 'Out for\nDelivery',
//                               isActive: currentStep >= 4,
//                             ),
//                             _buildStepItem(
//                               icon: Icons.check_circle,
//                               label: 'Delivered',
//                               isActive: currentStep >= 5,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 20),
//                       ],
//                     ),
//                     Positioned(
//                       top: 0,
//                       right: 0,
//                       child: Text(
//                         _formatLastUpdate(),
//                         style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                       ),
//                     ),
//                   ],
//                 ),
//     );
//   }

//   // ---------------- Helpers ----------------
//   Widget _buildStepItem({
//     required IconData icon,
//     required String label,
//     required bool isActive,
//   }) {
//     return Column(
//       children: [
//         Container(
//           width: 40,
//           height: 40,
//           decoration: BoxDecoration(
//             color: isActive ? Colors.blue[50] : Colors.grey[50],
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(
//               color: isActive ? Colors.blue : Colors.grey.shade300,
//               width: 2,
//             ),
//           ),
//           child: Icon(
//             icon,
//             color: isActive ? Colors.blue : Colors.grey[600],
//             size: 20,
//           ),
//         ),
//         const SizedBox(height: 4),
//         SizedBox(
//           width: 50,
//           child: Text(
//             label,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 9,
//               fontWeight: FontWeight.normal,
//               color: isActive ? Colors.blue : Colors.grey[600],
//               height: 1.2,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   String _formatTimestamp(DateTime timestamp) {
//     final now = DateTime.now();
//     final difference = now.difference(timestamp);

//     if (difference.inMinutes < 60) {
//       return '${difference.inMinutes}m ago';
//     } else if (difference.inHours < 24) {
//       return '${difference.inHours}h ago';
//     } else {
//       return '${difference.inDays}d ago';
//     }
//   }

//   String _formatLastUpdate() {
//     if (orderData?.statusTimeline.isEmpty ?? true) {
//       return 'No updates';
//     }
//     final lastUpdate = orderData!.statusTimeline.last.timestamp;
//     return 'Updated ${_formatTimestamp(lastUpdate)}';
//   }
// }
