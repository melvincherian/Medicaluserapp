// import 'package:flutter/material.dart';
// import 'package:medical_user_app/models/user_model.dart';
// import 'package:medical_user_app/utils/shared_preferences_helper.dart';
// import 'package:medical_user_app/view/scanned_medicine_screen.dart';
// import 'package:medical_user_app/view/single_previous_order_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:medical_user_app/providers/language_provider.dart';
// import 'package:medical_user_app/providers/order_provider.dart';
// import 'package:medical_user_app/models/order_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MedicationOrdersList extends StatefulWidget {
//   const MedicationOrdersList({Key? key}) : super(key: key);

//   @override
//   State<MedicationOrdersList> createState() => _MedicationOrdersListState();
// }

// class _MedicationOrdersListState extends State<MedicationOrdersList> {
//   @override
//   void initState() {
//     super.initState();
//     // Trigger refresh when widget loads
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final orderProvider = Provider.of<OrderProvider>(context, listen: false);
//       if (orderProvider.needsRefresh) {
//         orderProvider.refreshOrders();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<OrderProvider>(
//       builder: (context, orderProvider, child) {
//         // Show loading indicator
//         if (orderProvider.isLoading) {
//           return Container(
//             width: double.infinity,
//             height: 190,
//             child:const Center(
//               child: CircularProgressIndicator(
//                 color: Color(0xFF5931DD),
//               ),
//             ),
//           );
//         }

//         // Show error message
//         if (orderProvider.errorMessage != null) {
//           return Container(
//             width: double.infinity,
//             height: 190,
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(
//                     Icons.error_outline,
//                     color: Colors.red,
//                     size: 32,
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     orderProvider.errorMessage!,
//                     style: const TextStyle(
//                       color: Colors.red,
//                       fontSize: 14,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 8),
//                   TextButton(
//                     onPressed: () {
//                       orderProvider.clearError();
//                       orderProvider.refreshOrders();
//                     },
//                     child: Text('Retry'),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }

//         // Show empty state
//         if (!orderProvider.hasPreviousOrders) {
//           return Container(
//             width: double.infinity,
//             height: 190,
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(
//                     Icons.shopping_bag_outlined,
//                     color: Colors.grey,
//                     size: 48,
//                   ),
//                   const SizedBox(height: 12),
//                   AppText(
//                     'No Previous Order Found',
//                     style: TextStyle(
//                       color: Colors.grey[600],
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }

//         // Show orders list
//         return Container(
//           width: double.infinity,
//           height: 190,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: orderProvider.previousOrders.length,
//             itemBuilder: (context, index) {
//               final order = orderProvider.previousOrders[index];
//               return _buildOrderCard(context, order, orderProvider);
//             },
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildOrderCard(
//       BuildContext context, OrderModel order, OrderProvider orderProvider) {
//     // Get the first medication from order items (assuming it exists)
//     final firstItem =
//         order.orderItems.isNotEmpty ? order.orderItems.first : null;

//     return Container(
//       width: 303,
//       height: 163,
//       margin: const EdgeInsets.all(5),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           color: Colors.grey.shade300,
//           width: 2,
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Top section with image, name, and price
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Medicine Image
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: firstItem?.imageUrl != null
//                       ? Image.network(
//                           firstItem!.imageUrl!,
//                           width: 75,
//                           height: 75,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Image.asset(
//                               'assets/tablet.png',
//                               width: 75,
//                               height: 75,
//                               fit: BoxFit.cover,
//                             );
//                           },
//                         )
//                       : Image.asset(
//                           'assets/tablet.png',
//                           width: 75,
//                           height: 75,
//                           fit: BoxFit.cover,
//                         ),
//                 ),
//                 const SizedBox(width: 12),
//                 // Name and details
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         firstItem?.name ?? 'Multiple Items',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       Text(
//                         '${order.orderItems.length} item${order.orderItems.length > 1 ? 's' : ''}',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       // Location with icon
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.location_on,
//                             color: Color(0xFF5931DD),
//                             size: 16,
//                           ),
//                           const SizedBox(width: 4),
//                           Expanded(
//                             child: Text(
//                               order.deliveryAddress.city ?? 'Unknown Location',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey[600],
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 5),
//                       // Status with icon
//                       Row(
//                         children: [
//                           Icon(
//                             _getStatusIcon(order.status),
//                             color: _getStatusColor(order.status),
//                             size: 16,
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             order.status,
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: _getStatusColor(order.status),
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Price
//                 Text(
//                   '₹${order.totalAmount.toStringAsFixed(0)}',
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             // Buttons
//             Row(
//               children: [
//                 // Re-Order Button
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: orderProvider.isCreatingOrder ? null : () {
//                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>ScannedMedicineScreen(medicineId: order.id,)));
//                     },
//                     // : () => _handleReorder(context, order, orderProvider),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF5931DD),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                     ),
//                     child: orderProvider.isCreatingOrder
//                         ? const SizedBox(
//                             width: 16,
//                             height: 16,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               color: Colors.white,
//                             ),
//                           )
//                         : const AppText(
//                             'reorder',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 // Details Button
//                 // Expanded(
//                 //   child: OutlinedButton(
//                 //     onPressed: () {

//                 //       Navigator.push(context, MaterialPageRoute(builder: (context)=>SinglePreviousOrderScreen(orderId: order.id,userId: ,)));
//                 //     },
//                 //     // onPressed: () => _showOrderDetails(context, order),
//                 //     style: OutlinedButton.styleFrom(
//                 //       foregroundColor:const Color(0xFF5931DD),
//                 //       side:const BorderSide(color: Color(0xFF5931DD)),
//                 //       shape: RoundedRectangleBorder(
//                 //         borderRadius: BorderRadius.circular(25),
//                 //       ),
//                 //       padding:const EdgeInsets.symmetric(vertical: 12),
//                 //     ),
//                 //     child:const AppText(
//                 //       'details',
//                 //       style: TextStyle(
//                 //         fontWeight: FontWeight.bold,
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),

//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: () async {
//                       User? user = await SharedPreferencesHelper.getUser();
//                       if (user != null && user.id.isNotEmpty) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => SinglePreviousOrderScreen(
//                               orderId: order.id,
//                               userId: user.id,
//                             ),
//                           ),
//                         );
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text("User not logged in"),
//                             backgroundColor: Colors.red,
//                           ),
//                         );
//                       }
//                     },
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: const Color(0xFF5931DD),
//                       side: const BorderSide(color: Color(0xFF5931DD)),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                     ),
//                     child: const Text(
//                       'Details',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // void _handleReorder(BuildContext context, OrderModel order, OrderProvider orderProvider) async {
//   //   // Show address selection dialog or use default address
//   //   // For now, we'll assume there's a default address
//   //   // You might want to show a dialog to select address

//   //   try {
//   //     final result = await orderProvider.reorder(
//   //       previousOrder: order,
//   //       addressId: order.deliveryAddress.id,
//   //       notes: order.notes,
//   //       paymentMethod: order.paymentMethod,
//   //     );

//   //     if (result != null) {
//   //       // Show success message
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(
//   //           content: AppText('order_placed_successfully'),
//   //           backgroundColor: Colors.green,
//   //         ),
//   //       );
//   //     } else {
//   //       // Show error message
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(
//   //           content: AppText('failed_to_place_order'),
//   //           backgroundColor: Colors.red,
//   //         ),
//   //       );
//   //     }
//   //   } catch (e) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         content: Text('Error: ${e.toString()}'),
//   //         backgroundColor: Colors.red,
//   //       ),
//   //     );
//   //   }
//   // }

//   void _showOrderDetails(BuildContext context, OrderModel order) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => DraggableScrollableSheet(
//         initialChildSize: 0.7,
//         maxChildSize: 0.9,
//         minChildSize: 0.5,
//         expand: false,
//         builder: (context, scrollController) {
//           return Container(
//             padding: EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Handle bar
//                 Center(
//                   child: Container(
//                     width: 40,
//                     height: 4,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 // Order Details Header
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Order Details',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Container(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                       decoration: BoxDecoration(
//                         color: _getStatusColor(order.status).withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Text(
//                         order.status,
//                         style: TextStyle(
//                           color: _getStatusColor(order.status),
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 // Order content
//                 Expanded(
//                   child: SingleChildScrollView(
//                     controller: scrollController,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Order ID and Date
//                         Text('Order ID: #${order.id}'),
//                         SizedBox(height: 4),
//                         Text('Date: ${_formatDate(order.createdAt)}'),
//                         SizedBox(height: 16),
//                         // Items
//                         Text(
//                           'Items (${order.orderItems.length})',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         SizedBox(height: 8),
//                         ...order.orderItems.map((item) => ListTile(
//                               contentPadding: EdgeInsets.zero,
//                               leading: item.imageUrl != null
//                                   ? Image.network(
//                                       item.imageUrl!,
//                                       width: 50,
//                                       height: 50,
//                                       fit: BoxFit.cover,
//                                     )
//                                   : Image.asset(
//                                       'assets/tablet.png',
//                                       width: 50,
//                                       height: 50,
//                                       fit: BoxFit.cover,
//                                     ),
//                               title: Text(item.name),
//                               subtitle: Text('Qty: ${item.quantity}'),
//                               trailing:
//                                   Text('₹${item.price.toStringAsFixed(0)}'),
//                             )),
//                         SizedBox(height: 16),
//                         // Delivery Address
//                         Text(
//                           'Delivery Address',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         SizedBox(height: 8),
//                         Text(order.deliveryAddress.city ??
//                             'No address provided'),
//                         SizedBox(height: 16),
//                         // Total Amount
//                         Container(
//                           padding: EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.grey[50],
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: Colors.grey[300]!),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Total Amount',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               Text(
//                                 '₹${order.totalAmount.toStringAsFixed(0)}',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   color: Color(0xFF5931DD),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   IconData _getStatusIcon(String status) {
//     switch (status.toLowerCase()) {
//       case 'delivered':
//         return Icons.check_circle;
//       case 'cancelled':
//         return Icons.cancel;
//       case 'pending':
//         return Icons.access_time;
//       case 'processing':
//         return Icons.settings;
//       case 'shipped':
//         return Icons.local_shipping;
//       default:
//         return Icons.info;
//     }
//   }

//   Color _getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'delivered':
//         return Colors.green;
//       case 'cancelled':
//         return Colors.red;
//       case 'pending':
//         return Colors.orange;
//       case 'processing':
//         return Colors.blue;
//       case 'shipped':
//         return Colors.purple;
//       default:
//         return Colors.grey;
//     }
//   }

//   String _formatDate(DateTime date) {
//     return '${date.day}/${date.month}/${date.year}';
//   }
// }

// class UserPreferences {
//   static Future<String?> getUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(
//         'userId'); // make sure you're saving it as 'userId' during login
//   }
// }

import 'package:flutter/material.dart';
import 'package:medical_user_app/constant/api_constants.dart';
import 'package:medical_user_app/models/user_model.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';
import 'package:medical_user_app/view/detail/reorder_detail_screen.dart';
import 'package:medical_user_app/view/scanned_medicine_screen.dart';
import 'package:medical_user_app/view/single_previous_order_screen.dart';
import 'package:provider/provider.dart';
import 'package:medical_user_app/providers/language_provider.dart';
import 'package:medical_user_app/providers/order_provider.dart';
import 'package:medical_user_app/providers/cart_provider.dart';
import 'package:medical_user_app/models/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MedicationOrdersList extends StatefulWidget {
  const MedicationOrdersList({Key? key}) : super(key: key);

  @override
  State<MedicationOrdersList> createState() => _MedicationOrdersListState();
}

class _MedicationOrdersListState extends State<MedicationOrdersList> {
  late Razorpay razorpay;
  bool _isProcessingOrder = false;
  String? _selectedPaymentMethod = "Razorpay";
  String? _currentReorderOrderId;

  @override
  void initState() {
    super.initState();

    // Initialize Razorpay
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);

    // Trigger refresh when widget loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final orderProvider = Provider.of<OrderProvider>(context, listen: false);
      if (orderProvider.needsRefresh) {
        orderProvider.refreshOrders();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        // Show loading indicator
        if (orderProvider.isLoading) {
          return Container(
            width: double.infinity,
            height: 190,
            child: const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF5931DD),
              ),
            ),
          );
        }

        // Show error message
        if (orderProvider.errorMessage != null) {
          return Container(
            width: double.infinity,
            height: 190,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const Icon(
                  //   Icons.error_outline,
                  //   color: Colors.red,
                  //   size: 32,
                  // ),
                  const SizedBox(height: 8),
                  Text(
                    'No previous orders',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  // TextButton(
                  //   onPressed: () {
                  //     orderProvider.clearError();
                  //     orderProvider.refreshOrders();
                  //   },
                  //   child: const Text('Retry'),
                  // ),
                ],
              ),
            ),
          );
        }

        // Show empty state
        if (!orderProvider.hasPreviousOrders) {
          return Container(
            width: double.infinity,
            height: 190,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.grey,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No Previous Order Found',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Show orders list
        return Container(
          width: double.infinity,
          height: 190,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: orderProvider.previousOrders.length,
            itemBuilder: (context, index) {
              final order = orderProvider.previousOrders[index];
              return _buildOrderCard(context, order, orderProvider);
            },
          ),
        );
      },
    );
  }

//   Widget _buildOrderCard(
//       BuildContext context, OrderModel order, OrderProvider orderProvider) {
//     // Get the first medication from order items (assuming it exists)
//     final firstItem =
//         order.orderItems.isNotEmpty ? order.orderItems.first : null;

//     return Container(
//       width: 303,
//       height: 163,
//       margin: const EdgeInsets.all(5),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           color: Colors.grey.shade300,
//           width: 2,
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Top section with image, name, and price
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Medicine Image
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: firstItem?.imageUrl != null
//                       ? Image.network(
//                           firstItem!.imageUrl!,
//                           width: 75,
//                           height: 75,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Image.asset(
//                               'assets/tablet.png',
//                               width: 75,
//                               height: 75,
//                               fit: BoxFit.cover,
//                             );
//                           },
//                         )
//                       : Image.asset(
//                           'assets/tablet.png',
//                           width: 75,
//                           height: 75,
//                           fit: BoxFit.cover,
//                         ),
//                 ),
//                 const SizedBox(width: 12),
//                 // Name and details
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         firstItem?.name ?? 'Multiple Items',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       Text(
//                         '${order.orderItems.length} item${order.orderItems.length > 1 ? 's' : ''}',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       // Location with icon
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.location_on,
//                             color: Color(0xFF5931DD),
//                             size: 16,
//                           ),
//                           const SizedBox(width: 4),
//                           Expanded(
//                             child: Text(
//                               order.deliveryAddress.city ?? 'Unknown Location',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey[600],
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 5),
//                       // Status with icon
//                       Row(
//                         children: [
//                           Icon(
//                             _getStatusIcon(order.status),
//                             color: _getStatusColor(order.status),
//                             size: 16,
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             order.status,
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: _getStatusColor(order.status),
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Price
//                 Text(
//                   '₹${order.totalAmount.toStringAsFixed(0)}',
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             // Buttons
//             Row(
//               children: [
//                 // Re-Order Button
//                 // Expanded(
//                 //   child: ElevatedButton(
//                 //     onPressed: (_isProcessingOrder || orderProvider.isCreatingOrder)
//                 //         ? null
//                 //         : () {
//                 //             // Store the order ID for reorder process
//                 //             _currentReorderOrderId = order.id;

//                 //             Navigator.push(context, MaterialPageRoute(builder: (context)=>ReorderDetailScreen()));
//                 //             // Initiate payment for reorder
//                 //             // _initiateRazorpayPaymentForReorder(order);
//                 //           },
//                 //     style: ElevatedButton.styleFrom(
//                 //       backgroundColor: const Color(0xFF5931DD),
//                 //       foregroundColor: Colors.white,
//                 //       shape: RoundedRectangleBorder(
//                 //         borderRadius: BorderRadius.circular(25),
//                 //       ),
//                 //       padding: const EdgeInsets.symmetric(vertical: 12),
//                 //     ),
//                 //     child: (_isProcessingOrder || orderProvider.isCreatingOrder)
//                 //         ? const SizedBox(
//                 //             width: 16,
//                 //             height: 16,
//                 //             child: CircularProgressIndicator(
//                 //               strokeWidth: 2,
//                 //               color: Colors.white,
//                 //             ),
//                 //           )
//                 //         : const Text(
//                 //             'Reorder',
//                 //             style: TextStyle(
//                 //               fontWeight: FontWeight.bold,
//                 //             ),
//                 //           ),
//                 //   ),
//                 // ),

//                 // Replace the Reorder button section in your _buildOrderCard method with this:

// // Re-Order Button
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed:
//                         (_isProcessingOrder || orderProvider.isCreatingOrder)
//                             ? null
//                             : () {
//                                 if (order.status != 'Cancelled') {
//                                   // Navigate to ReorderDetailScreen with order data
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           ReorderDetailScreen(order: order),
//                                     ),
//                                   );
//                                 } else {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text(
//                                           "Your order is cancelled, unable to reorder"),
//                                       backgroundColor: Colors.red,
//                                       behavior: SnackBarBehavior.floating,
//                                     ),
//                                   );
//                                 }

//                                 // if(order.status != 'Cancelled'){
//                                 //                          // Navigate to ReorderDetailScreen with order data
//                                 //   Navigator.push(
//                                 //       context,
//                                 //       MaterialPageRoute(
//                                 //           builder: (context) =>
//                                 //               ReorderDetailScreen(order: order)));
//                                 // }else{
//                                 //   ScaffoldMessenger.of(context);
//                                 // }
//                               },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF5931DD),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                     ),
//                     child: (_isProcessingOrder || orderProvider.isCreatingOrder)
//                         ? const SizedBox(
//                             width: 16,
//                             height: 16,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               color: Colors.white,
//                             ),
//                           )
//                         : const Text(
//                             'Reorder',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 // Details Button
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: () async {
//                       User? user = await SharedPreferencesHelper.getUser();
//                       if (user != null && user.id.isNotEmpty) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => SinglePreviousOrderScreen(
//                               orderId: order.id,
//                               userId: user.id,
//                             ),
//                           ),
//                         );
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text("User not logged in"),
//                             backgroundColor: Colors.red,
//                           ),
//                         );
//                       }
//                     },
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: const Color(0xFF5931DD),
//                       side: const BorderSide(color: Color(0xFF5931DD)),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                     ),
//                     child: const Text(
//                       'Details',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

  Widget _buildOrderCard(
      BuildContext context, OrderModel order, OrderProvider orderProvider) {
    // Get the first medication from order items (assuming it exists)
    final firstItem =
        order.orderItems.isNotEmpty ? order.orderItems.first : null;

    return Container(
      width: 303,
      height: 166,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top section with image, name, and price
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Medicine Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: firstItem?.imageUrl != null
                      ? Image.network(
                          firstItem!.imageUrl!,
                          width: 75,
                          height: 75,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/tablet.png',
                              width: 75,
                              height: 75,
                              fit: BoxFit.cover,
                            );
                          },
                        )
                      : Image.asset(
                          'assets/tablet.png',
                          width: 75,
                          height: 75,
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(width: 12),
                // Name and details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        firstItem?.name ?? 'Multiple Items',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${order.orderItems.length} item${order.orderItems.length > 1 ? 's' : ''}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Location with icon
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Color(0xFF5931DD),
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              order.deliveryAddress.city ?? 'Unknown Location',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      // Status with icon
                      Row(
                        children: [
                          Icon(
                            _getStatusIcon(order.status),
                            color: _getStatusColor(order.status),
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            order.status,
                            style: TextStyle(
                              fontSize: 12,
                              color: _getStatusColor(order.status),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Price
                Text(
                  '₹${order.totalAmount.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Buttons
            Row(
              children: [
                // Re-Order Button - Only show if order is NOT cancelled
                if (order.status.toLowerCase() != 'cancelled')
                  Expanded(
                    child: ElevatedButton(
                      onPressed:
                          (_isProcessingOrder || orderProvider.isCreatingOrder)
                              ? null
                              : () {
                                  // Navigate to ReorderDetailScreen with order data
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ReorderDetailScreen(order: order),
                                    ),
                                  );
                                },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5931DD),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child:
                          (_isProcessingOrder || orderProvider.isCreatingOrder)
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Reorder',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                    ),
                  ),
                // Add spacing only if reorder button is visible
                if (order.status.toLowerCase() != 'cancelled')
                  const SizedBox(width: 12),
                // Details Button
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      User? user = await SharedPreferencesHelper.getUser();
                      if (user != null && user.id.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SinglePreviousOrderScreen(
                              orderId: order.id,
                              userId: user.id,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("User not logged in"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF5931DD),
                      side: const BorderSide(color: Color(0xFF5931DD)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildOrderCard(
  //     BuildContext context, OrderModel order, OrderProvider orderProvider) {
  //   // Get the first medication from order items (assuming it exists)
  //   final firstItem =
  //       order.orderItems.isNotEmpty ? order.orderItems.first : null;

  //   return Container(
  //     width: 303,
  //     height: 166,
  //     margin: const EdgeInsets.all(5),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(8),
  //       border: Border.all(
  //         color: Colors.grey.shade300,
  //         width: 2,
  //       ),
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.all(12.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           // Top section with image, name, and price
  //           Row(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               // Medicine Image
  //               ClipRRect(
  //                 borderRadius: BorderRadius.circular(8),
  //                 child: firstItem?.imageUrl != null
  //                     ? Image.network(
  //                         firstItem!.imageUrl!,
  //                         width: 75,
  //                         height: 75,
  //                         fit: BoxFit.cover,
  //                         errorBuilder: (context, error, stackTrace) {
  //                           return Image.asset(
  //                             'assets/tablet.png',
  //                             width: 75,
  //                             height: 75,
  //                             fit: BoxFit.cover,
  //                           );
  //                         },
  //                       )
  //                     : Image.asset(
  //                         'assets/tablet.png',
  //                         width: 75,
  //                         height: 75,
  //                         fit: BoxFit.cover,
  //                       ),
  //               ),
  //               const SizedBox(width: 12),
  //               // Name and details
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       firstItem?.name ?? 'Multiple Items',
  //                       style: const TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 16,
  //                       ),
  //                       maxLines: 1,
  //                       overflow: TextOverflow.ellipsis,
  //                     ),
  //                     Text(
  //                       '${order.orderItems.length} item${order.orderItems.length > 1 ? 's' : ''}',
  //                       style: TextStyle(
  //                         fontSize: 14,
  //                         color: Colors.grey[600],
  //                       ),
  //                     ),
  //                     const SizedBox(height: 4),
  //                     // Location with icon
  //                     Row(
  //                       children: [
  //                         const Icon(
  //                           Icons.location_on,
  //                           color: Color(0xFF5931DD),
  //                           size: 16,
  //                         ),
  //                         const SizedBox(width: 4),
  //                         Expanded(
  //                           child: Text(
  //                             order.deliveryAddress.city ?? 'Unknown Location',
  //                             style: TextStyle(
  //                               fontSize: 12,
  //                               color: Colors.grey[600],
  //                             ),
  //                             maxLines: 1,
  //                             overflow: TextOverflow.ellipsis,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     const SizedBox(height: 5),
  //                     // Status with icon
  //                     Row(
  //                       children: [
  //                         Icon(
  //                           _getStatusIcon(order.status),
  //                           color: _getStatusColor(order.status),
  //                           size: 16,
  //                         ),
  //                         const SizedBox(width: 4),
  //                         Text(
  //                           order.status,
  //                           style: TextStyle(
  //                             fontSize: 12,
  //                             color: _getStatusColor(order.status),
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               // Price
  //               Text(
  //                 '₹${order.totalAmount.toStringAsFixed(0)}',
  //                 style: const TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 16,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 16),
  //           // Buttons
  //           Row(
  //             children: [
  //               // Re-Order Button - Only show if order is NOT cancelled
  //               if (order.status.toLowerCase() != 'cancelled')
  //                 Expanded(
  //                   child: ElevatedButton(
  //                     onPressed:
  //                         (_isProcessingOrder || orderProvider.isCreatingOrder)
  //                             ? null
  //                             : () {
  //                                 // Navigate to ReorderDetailScreen with order data
  //                                 Navigator.push(
  //                                   context,
  //                                   MaterialPageRoute(
  //                                     builder: (context) =>
  //                                         ReorderDetailScreen(order: order),
  //                                   ),
  //                                 );
  //                               },
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: const Color(0xFF5931DD),
  //                       foregroundColor: Colors.white,
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(25),
  //                       ),
  //                       padding: const EdgeInsets.symmetric(vertical: 12),
  //                     ),
  //                     child:
  //                         (_isProcessingOrder || orderProvider.isCreatingOrder)
  //                             ? const SizedBox(
  //                                 width: 16,
  //                                 height: 16,
  //                                 child: CircularProgressIndicator(
  //                                   strokeWidth: 2,
  //                                   color: Colors.white,
  //                                 ),
  //                               )
  //                             : const Text(
  //                                 'Reorder',
  //                                 style: TextStyle(
  //                                   fontWeight: FontWeight.bold,
  //                                 ),
  //                               ),
  //                   ),
  //                 ),
  //               // Add spacing only if reorder button is visible
  //               if (order.status.toLowerCase() != 'cancelled')
  //                 const SizedBox(width: 12),
  //               // Details Button
  //               Expanded(
  //                 child: OutlinedButton(
  //                   onPressed: () async {
  //                     User? user = await SharedPreferencesHelper.getUser();
  //                     if (user != null && user.id.isNotEmpty) {
  //                       Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                           builder: (context) => SinglePreviousOrderScreen(
  //                             orderId: order.id,
  //                             userId: user.id,
  //                           ),
  //                         ),
  //                       );
  //                     } else {
  //                       ScaffoldMessenger.of(context).showSnackBar(
  //                         const SnackBar(
  //                           content: Text("User not logged in"),
  //                           backgroundColor: Colors.red,
  //                         ),
  //                       );
  //                     }
  //                   },
  //                   style: OutlinedButton.styleFrom(
  //                     foregroundColor: const Color(0xFF5931DD),
  //                     side: const BorderSide(color: Color(0xFF5931DD)),
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(25),
  //                     ),
  //                     padding: const EdgeInsets.symmetric(vertical: 12),
  //                   ),
  //                   child: const Text(
  //                     'Details',
  //                     style: TextStyle(
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Method to initiate Razorpay payment for reorder
  void _initiateRazorpayPaymentForReorder(OrderModel order) {
    var options = {
      'key': 'rzp_test_BxtRNvflG06PTV', // Replace with your Razorpay key
      'amount': (order.totalAmount * 100).toInt(), // Amount in paise
      'name': 'Medical App',
      'description': 'Medicine Reorder Payment',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': "9961593179", // Get from user profile
        'email': "user@example.com", // Get from user profile
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      print(
          "Opening Razorpay for reorder with payment method: $_selectedPaymentMethod");
      setState(() {
        _isProcessingOrder = true;
      });
      razorpay.open(options);
      print("Razorpay opened successfully for reorder");
    } catch (e) {
      setState(() {
        _isProcessingOrder = false;
      });
      _showErrorSnackBar("Failed to open payment gateway: $e");
    }
  }

  // Process the reorder after successful payment
  Future<void> _processOrder(String? paymentId, {String? orderId}) async {
    try {
      setState(() {
        _isProcessingOrder = true;
      });

      // Get user ID from SharedPreferences
      User? user = await SharedPreferencesHelper.getUser();
      if (user == null || user.id.isEmpty) {
        throw Exception("User not logged in");
      }

      // Use the stored order ID or the passed one
      String? orderIdToUse = orderId ?? _currentReorderOrderId;
      if (orderIdToUse == null || orderIdToUse.isEmpty) {
        throw Exception("Order ID is required for reorder");
      }

      // Prepare the API endpoint
      final String apiUrl =
          '${ApiConstants.baseUrl}/users/reorder/${user.id}/$orderIdToUse';

      // Prepare the payload
      final Map<String, dynamic> payload = {
        "paymentMethod": "Phonepe" ?? "Phonepe",
        "transactionId": paymentId ?? ""
      };

      print("Making reorder API call to: $apiUrl");
      print("Payload: ${jsonEncode(payload)}");

      // Make the API call
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
          // 'Authorization': 'Bearer ${user.token}',
        },
        body: jsonEncode(payload),
      );

      print("API Response Status: ${response.statusCode}");
      print("API Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success
        final responseData = jsonDecode(response.body);

        setState(() {
          _isProcessingOrder = false;
          _currentReorderOrderId = null; // Clear the stored order ID
        });

        // Refresh orders in OrderProvider
        final orderProvider =
            Provider.of<OrderProvider>(context, listen: false);
        orderProvider.refreshOrders();

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Order placed successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );

        // You can navigate to order confirmation screen if needed
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrderSuccessScreen()));
      } else {
        // Handle error response
        String errorMessage = "Failed to place order";
        try {
          final errorData = jsonDecode(response.body);
          errorMessage = errorData['message'] ?? errorMessage;
        } catch (e) {
          // If response body is not valid JSON, use default message
        }

        setState(() {
          _isProcessingOrder = false;
        });

        _showErrorSnackBar("Order failed: $errorMessage");
      }
    } catch (e) {
      setState(() {
        _isProcessingOrder = false;
      });
      print("Error in _processOrder: $e");
      _showErrorSnackBar("Order processing failed: ${e.toString()}");
    }
  }

  // Razorpay event handlers
  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    setState(() {
      _isProcessingOrder = false;
    });
    _showErrorSnackBar("Payment Failed: ${response.message}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    // Payment successful, now process the order
    try {
      await _processOrder(response.paymentId, orderId: _currentReorderOrderId);
    } catch (e) {
      setState(() {
        _isProcessingOrder = false;
      });
      _showErrorSnackBar("Order processing failed after payment: $e");
    }
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    setState(() {
      _isProcessingOrder = false;
    });
    _showErrorSnackBar("External wallet selected: ${response.walletName}");
  }

  // Helper method to show error messages
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _showOrderDetails(BuildContext context, OrderModel order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Order Details Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Order Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getStatusColor(order.status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        order.status,
                        style: TextStyle(
                          color: _getStatusColor(order.status),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Order content
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Order ID and Date
                        Text('Order ID: #${order.id}'),
                        const SizedBox(height: 4),
                        Text('Date: ${_formatDate(order.createdAt)}'),
                        const SizedBox(height: 16),
                        // Items
                        Text(
                          'Items (${order.orderItems.length})',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...order.orderItems.map((item) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: item.imageUrl != null
                                  ? Image.network(
                                      item.imageUrl!,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/tablet.png',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                              title: Text(item.name),
                              subtitle: Text('Qty: ${item.quantity}'),
                              trailing:
                                  Text('₹${item.price.toStringAsFixed(0)}'),
                            )),
                        const SizedBox(height: 16),
                        // Delivery Address
                        const Text(
                          'Delivery Address',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(order.deliveryAddress.city ??
                            'No address provided'),
                        const SizedBox(height: 16),
                        // Total Amount
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total Amount',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '₹${order.totalAmount.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF5931DD),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return Icons.check_circle;
      case 'cancelled':
        return Icons.cancel;
      case 'pending':
        return Icons.access_time;
      case 'processing':
        return Icons.settings;
      case 'shipped':
        return Icons.local_shipping;
      default:
        return Icons.info;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.blue;
      case 'shipped':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class UserPreferences {
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(
        'userId'); // make sure you're saving it as 'userId' during login
  }
}
