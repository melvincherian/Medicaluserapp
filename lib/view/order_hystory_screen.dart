import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medical_user_app/constant/api_constants.dart';
import 'package:medical_user_app/models/user_model.dart';
import 'package:medical_user_app/providers/language_provider.dart';
import 'package:medical_user_app/providers/order_provider.dart';
import 'package:medical_user_app/models/order_model.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';
import 'package:medical_user_app/view/chat/chat_screen.dart';
import 'package:medical_user_app/view/detail/reorder_detail_screen.dart';
import 'package:medical_user_app/view/invoices/invoice_screen.dart';
import 'package:medical_user_app/view/main_layout.dart';
import 'package:medical_user_app/view/navigate/navigate_screen.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

class OrdersHistoryScreen extends StatefulWidget {
  const OrdersHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrdersHistoryScreen> createState() => _OrdersHistoryScreenState();
}

class _OrdersHistoryScreenState extends State<OrdersHistoryScreen> {
  String? _cancellingOrderId;
  String? _deletingOrderId;
  String? _reorderingOrderId;
  late Razorpay razorpay;
  String? _currentReorderOrderId;
  String? userId;
  bool isLoading = true;

  String _selectedFilter = 'all'; // Default filter
  bool _showFilterDialog = false;

  // void _showFilterBottomSheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.transparent,
  //     builder: (BuildContext context) {
  //       return Container(
  //         decoration: const BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(20),
  //             topRight: Radius.circular(20),
  //           ),
  //         ),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             // Handle bar
  //             Container(
  //               margin: const EdgeInsets.symmetric(vertical: 12),
  //               width: 40,
  //               height: 4,
  //               decoration: BoxDecoration(
  //                 color: Colors.grey[300],
  //                 borderRadius: BorderRadius.circular(2),
  //               ),
  //             ),
  //             // Title
  //             const Padding(
  //               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //               child: Row(
  //                 children: [
  //                   Icon(Icons.filter_list, color: Colors.deepPurple),
  //                   SizedBox(width: 10),
  //                   Text(
  //                     'Filter Orders',
  //                     style: TextStyle(
  //                       fontSize: 18,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             const Divider(),
  //             // Filter options
  //             // _buildFilterOption('all', 'All Orders', Icons.list_alt),
  //             // _buildFilterOption('pending', 'Pending', Icons.check_circle),
  //             // // _buildFilterOption('ongoing', 'Ongoing', Icons.access_time),
  //             // _buildFilterOption('accepted', 'Accepted', Icons.check_circle_outline),
  //             // // _buildFilterOption('processing', 'Processing', Icons.local_shipping),
  //             // // _buildFilterOption('delivered', 'Delivered', Icons.check_circle),
  //             // _buildFilterOption('cancelled', 'Cancelled', Icons.cancel),

  //             _buildFilterOption('all', 'All Orders', Icons.list_alt),
  //             _buildFilterOption('pending', 'Pending', Icons.access_time),
  //             _buildFilterOption(
  //                 'accepted', 'Accepted', Icons.check_circle_outline),
  //             _buildFilterOption(
  //                 'rider accepted', 'Rider Accepted', Icons.delivery_dining),
  //             _buildFilterOption('pickedup', 'Picked Up', Icons.inventory),
  //             _buildFilterOption('completed', 'Completed', Icons.check_circle),
  //             _buildFilterOption('cancelled', 'Cancelled', Icons.cancel),
  //             const SizedBox(height: 10),
  //             // Clear filters button
  //             if (_selectedFilter != 'all')
  //               Padding(
  //                 padding:
  //                     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //                 child: SizedBox(
  //                   width: double.infinity,
  //                   child: OutlinedButton(
  //                     onPressed: () {
  //                       setState(() {
  //                         _selectedFilter = 'all';
  //                       });
  //                       Navigator.pop(context);
  //                     },
  //                     style: OutlinedButton.styleFrom(
  //                       foregroundColor: Colors.deepPurple,
  //                       side: const BorderSide(color: Colors.deepPurple),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                     ),
  //                     child: const Text('Clear Filters'),
  //                   ),
  //                 ),
  //               ),
  //             const SizedBox(height: 20),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true, // ← ADD THIS
      builder: (BuildContext context) {
        return Container(
          // ← ADD: constrain max height to 85% of screen
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Icon(Icons.filter_list, color: Colors.deepPurple),
                    SizedBox(width: 10),
                    Text(
                      'Filter Orders',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),

              // ← WRAP filter options + button in Flexible + SingleChildScrollView
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildFilterOption('all', 'All Orders', Icons.list_alt),
                      _buildFilterOption(
                          'pending', 'Pending', Icons.access_time),
                      _buildFilterOption(
                          'accepted', 'Accepted', Icons.check_circle_outline),
                      _buildFilterOption('rider accepted', 'Rider Accepted',
                          Icons.delivery_dining),
                      _buildFilterOption(
                          'pickedup', 'Picked Up', Icons.inventory),
                      // _buildFilterOption('completed', 'Completed', Icons.check_circle),
                      _buildFilterOption(
                          'delivered', 'Delivered', Icons.check_circle),

                      _buildFilterOption(
                          'cancelled', 'Cancelled', Icons.cancel),
                      const SizedBox(height: 10),
                      if (_selectedFilter != 'all')
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  _selectedFilter = 'all';
                                });
                                Navigator.pop(context);
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.deepPurple,
                                side:
                                    const BorderSide(color: Colors.deepPurple),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('Clear Filters'),
                            ),
                          ),
                        ),
                      // ← Safe area padding at the bottom
                      SizedBox(
                          height: MediaQuery.of(context).padding.bottom + 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Widget _buildFilterOption(String value, String label, IconData icon) {
  //   final isSelected = _selectedFilter == value;
  //   return ListTile(
  //     leading: Icon(
  //       icon,
  //       color: isSelected ? Colors.deepPurple : Colors.grey[600],
  //     ),
  //     title: Text(
  //       label,
  //       style: TextStyle(
  //         color: isSelected ? Colors.deepPurple : Colors.black,
  //         fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
  //       ),
  //     ),
  //     trailing:
  //         isSelected ? const Icon(Icons.check, color: Colors.deepPurple) : null,
  //     selected: isSelected,
  //     selectedTileColor: Colors.deepPurple.withOpacity(0.1),
  //     onTap: () {
  //       setState(() {
  //         _selectedFilter = value;
  //       });
  //       Navigator.pop(context);
  //     },
  //   );
  // }

  Widget _buildFilterOption(String value, String label, IconData icon) {
    final isSelected = _selectedFilter == value;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Colors.deepPurple : Colors.grey[600],
      ),
      title: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.deepPurple : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing:
          isSelected ? const Icon(Icons.check, color: Colors.deepPurple) : null,
      selected: isSelected,
      selectedTileColor: Colors.deepPurple.withOpacity(0.1),
      onTap: () {
        setState(() {
          _selectedFilter = value;
        });
        Navigator.pop(context);
      },
    );
  }

  // List<OrderModel> _getFilteredOrders(List<OrderModel> orders) {
  //   if (_selectedFilter == 'all') {
  //     return orders;
  //   }
  //   return orders
  //       .where((order) =>
  //           order.status.toLowerCase() == _selectedFilter.toLowerCase())
  //       .toList();
  // }

  // List<OrderModel> _getFilteredOrders(List<OrderModel> orders) {
  //   if (_selectedFilter == 'all') {
  //     return orders;
  //   }

  //   // Normalize the filter value to lowercase for comparison
  //   final filterLower = _selectedFilter.toLowerCase();

  //   return orders
  //       .where((order) => order.status.toLowerCase() == filterLower)
  //       .toList();
  // }

  List<OrderModel> _getFilteredOrders(List<OrderModel> orders) {
    if (_selectedFilter == 'all') return orders;

    final filterLower = _selectedFilter.toLowerCase();

    return orders.where((order) {
      final statusLower = order.status.toLowerCase();
      // Handle partial match for multi-word statuses like "Rider Accepted"
      return statusLower == filterLower || statusLower.contains(filterLower);
    }).toList();
  }

  @override
  void initState() {
    super.initState();

    _loadUserId();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderProvider>(context, listen: false).refreshOrders();
    });

    // Initialize Razorpay
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
  }

  Future<void> _loadUserId() async {
    try {
      final storedUser = await SharedPreferencesHelper.getUser();
      setState(() {
        userId = storedUser?.id;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error loading user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const AppText(
          'order_history',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          // Filter button
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              onPressed: _showFilterBottomSheet,
              icon: Stack(
                children: [
                  const Icon(Icons.filter_list, size: 20, color: Colors.black),
                  // Show active filter indicator
                  if (_selectedFilter != 'all')
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.deepPurple,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
              tooltip: 'Filter Orders',
            ),
          ),
        ],
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
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MainLayout()),
                  (route) => false,
                );
              },
              child: const Icon(Icons.arrow_back_ios_new, size: 18),
            ),
          ),
        ),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, orderProvider, child) {
          if (orderProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (orderProvider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    orderProvider.errorMessage!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => orderProvider.refreshOrders(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (!orderProvider.hasOrders) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No orders found',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start shopping to see your orders here',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => orderProvider.refreshOrders(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ongoing Orders section
                  // if (orderProvider.hasCurrentOrders) ...[
                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       const AppText(
                  //         'ongoing',
                  //         style: TextStyle(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  //   const SizedBox(height: 12),
                  //   ...orderProvider.currentOrders
                  //       .map((order) => Padding(
                  //             padding: const EdgeInsets.only(bottom: 12),
                  //             child:
                  //                 _buildOngoingOrderCard(order, orderProvider),
                  //           ))
                  //       .toList(),
                  //   const SizedBox(height: 24),
                  // ],

                  if (orderProvider.hasCurrentOrders) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AppText(
                          'ongoing',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Show filter indicator
                        if (_selectedFilter != 'all')
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Filtered: ${_selectedFilter.toUpperCase()}',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ..._getFilteredOrders(orderProvider.currentOrders)
                        .map((order) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child:
                                  _buildOngoingOrderCard(order, orderProvider),
                            ))
                        .toList(),
                    const SizedBox(height: 24),
                  ],

                  // Previous Orders section
                  // if (orderProvider.hasPreviousOrders) ...[
                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       const AppText(
                  //         'previous_orders',
                  //         style: TextStyle(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //       // Text(
                  //       //   '(${orderProvider.previousOrdersCount})',
                  //       //   style: TextStyle(
                  //       //     fontSize: 14,
                  //       //     color: Colors.grey[600],
                  //       //   ),
                  //       // ),
                  //     ],
                  //   ),
                  //   const SizedBox(height: 12),
                  //   ...orderProvider.previousOrders
                  //       .map((order) => Padding(
                  //             padding: const EdgeInsets.only(bottom: 12),
                  //             child:
                  //                 _buildPreviousOrderCard(order, orderProvider),
                  //           ))
                  //       .toList(),
                  // ],

                  if (orderProvider.hasPreviousOrders) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AppText(
                          'previous_orders',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Show filter indicator
                        if (_selectedFilter != 'all')
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Filtered: ${_selectedFilter.toUpperCase()}',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ..._getFilteredOrders(orderProvider.previousOrders)
                        .map((order) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child:
                                  _buildPreviousOrderCard(order, orderProvider),
                            ))
                        .toList(),
                  ],

                  // If only current orders exist
                  if (orderProvider.hasCurrentOrders &&
                      !orderProvider.hasPreviousOrders)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          'Previous orders will appear here once completed',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOngoingOrderCard(OrderModel order, OrderProvider orderProvider) {
    final firstItem =
        order.orderItems.isNotEmpty ? order.orderItems.first : null;
    final itemsCount = order.orderItems.length;
    final deliveryAddress = order.deliveryAddress;

    // Check if this specific order can be cancelled
    final bool canCancel = _canCancelOrder(order.status);
    final bool isCancellingThisOrder = _cancellingOrderId == order.id;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              // Order details row
              Row(
                children: [
                  // Medicine image (placeholder)
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200],
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (firstItem?.imageUrl != null)
                            ? NetworkImage(firstItem!.imageUrl.toString())
                            : const AssetImage('assets/tablet.png')
                                as ImageProvider,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),
                  // Order information
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          firstItem?.name ?? 'Order Items',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (itemsCount > 1)
                          // Text(
                          //   '+${itemsCount - 1} more items',
                          //   style: TextStyle(
                          //     fontSize: 12,
                          //     color: Colors.grey[600],
                          //   ),
                          // ),
                          const SizedBox(height: 4),
                        // Location row
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                size: 14, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                '${deliveryAddress.city}, ${deliveryAddress.state}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        // Status row
                        Row(
                          children: [
                            Icon(
                              _getStatusIcon(order.status),
                              size: 14,
                              color: _getStatusColor(order.status),
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

                        // Add this new prescription indicator row
                        if (order.isPrescriptionOrder)
                          Row(
                            children: [
                              Icon(
                                Icons.receipt_long,
                                size: 14,
                                color: Colors.blue.shade700,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Prescription Order',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue.shade700,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                        //                       if (order.)
                        // Row(
                        //   children: [
                        //     Icon(
                        //       Icons.receipt_long,
                        //       size: 14,
                        //       color: Colors.blue.shade700,
                        //     ),
                        //     const SizedBox(width: 4),
                        //     Text(
                        //       'Prescription Order',
                        //       style: TextStyle(
                        //         fontSize: 12,
                        //         color: Colors.blue.shade700,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (order.status != 'Cancelled' &&
                                order.status != 'canceled')
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => InvoiceScreen(
                                                  orderId: order.id,
                                                )));
                                  },
                                  icon: const Icon(Icons.description_outlined)),
                            // IconButton(
                            //     onPressed: () {
                            //       Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (context) => ChatScreen(
                            //                     userId: userId.toString(),
                            //                     riderId: order.assignedRider
                            //                         .toString(),
                            //                   )));
                            //     },
                            //     icon: const Icon(Icons.chat_bubble_outline)),

                            if (order.status != 'Cancelled' &&
                                order.status != 'canceled')
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                        userId: userId.toString(),
                                        riderId: order.assignedRider.toString(),
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.chat_bubble_outline),
                              ),
                          ],
                        )

                        // Replace the Row widget that contains the receipt and chat buttons in _buildOngoingOrderCard method

// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     // Invoice/Receipt button - always visible
//     IconButton(
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => InvoiceScreen(orderId: order.id)
//           )
//         );
//       },
//       icon: const Icon(Icons.receipt_long)
//     ),

//     // Chat button - only show if order is not pending, cancelled and has assigned rider
//     if (order.status.toLowerCase() != 'pending' &&
//         order.status.toLowerCase() != 'cancelled' &&
//         order.assignedRider != null &&
//         order.assignedRider!.isNotEmpty)
//       IconButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ChatScreen(
//                 userId: userId.toString(),
//                 riderId: order.assignedRider.toString(),
//               )
//             )
//           );
//         },
//         icon: const Icon(Icons.chat)
//       )
//     else if (order.status.toLowerCase() == 'pending')
//       // Show a disabled chat icon with tooltip for pending orders
//       Tooltip(
//         message: 'Chat will be available once rider is assigned',
//         child: IconButton(
//           onPressed: null, // Disabled
//           icon: Icon(
//             Icons.chat_outlined,
//             color: Colors.grey[400]
//           )
//         ),
//       )
//     else if (order.status.toLowerCase() == 'cancelled')
//       // Show a disabled chat icon with tooltip for cancelled orders
//       Tooltip(
//         message: 'Chat is not available for cancelled orders',
//         child: IconButton(
//           onPressed: null, // Disabled
//           icon: Icon(
//             Icons.chat_outlined,
//             color: Colors.grey[400]
//           )
//         ),
//       ),
//   ],
// )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Buttons row
              Row(
                children: [
                  // Cancel Order button - Enhanced with proper conditions
                  // Expanded(
                  //   child: OutlinedButton(
                  //     onPressed: (canCancel && !isCancellingThisOrder)
                  //         ? () => _handleCancelOrder(order, orderProvider)
                  //         : null,
                  //     style: OutlinedButton.styleFrom(
                  //       foregroundColor: canCancel ? Colors.red : Colors.grey,
                  //       side: BorderSide(
                  //         color: canCancel
                  //             ? Colors.red.shade300
                  //             : Colors.grey.shade300,
                  //       ),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(20),
                  //       ),
                  //       padding: const EdgeInsets.symmetric(vertical: 12),
                  //     ),
                  //     child: isCancellingThisOrder
                  //         ? const SizedBox(
                  //             width: 16,
                  //             height: 16,
                  //             child: CircularProgressIndicator(
                  //               strokeWidth: 2,
                  //               valueColor:
                  //                   AlwaysStoppedAnimation<Color>(Colors.red),
                  //             ),
                  //           )
                  //         : AppText(
                  //             canCancel ? 'cancel_order' : 'cannot_cancel',
                  //             style: const TextStyle(
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.w500,
                  //             ),
                  //           ),
                  //   ),
                  // ),
                  // const SizedBox(width: 12),
                  // // Track Order button
                  // Expanded(
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => NavigateScreen(
                  //                     userId: userId.toString(),
                  //                     orderId: order.id,
                  //                   )));
                  //       // _handleTrackOrder(order);
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: const Color(0xFF5E35B1),
                  //       foregroundColor: Colors.white,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(20),
                  //       ),
                  //       padding: const EdgeInsets.symmetric(vertical: 12),
                  //     ),
                  //     child: const AppText(
                  //       'Track Order',
                  //       style: TextStyle(
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  Expanded(
                    child: order.status == 'Cancelled' ||
                            order.status == 'canceled'
                        ? const SizedBox
                            .shrink() // Hide cancel button if order is cancelled
                        : OutlinedButton(
                            onPressed: (canCancel && !isCancellingThisOrder)
                                ? () => _handleCancelOrder(order, orderProvider)
                                : null,
                            style: OutlinedButton.styleFrom(
                              foregroundColor:
                                  canCancel ? Colors.red : Colors.grey,
                              side: BorderSide(
                                color: canCancel
                                    ? Colors.red.shade300
                                    : Colors.grey.shade300,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: isCancellingThisOrder
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.red),
                                    ),
                                  )
                                : AppText(
                                    canCancel
                                        ? 'cancel_order'
                                        : 'cannot_cancel',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          ),
                  ),
                  if (order.status != 'Cancelled' &&
                      order.status != 'cancelled')
                    const SizedBox(width: 12),
                  Expanded(
                    child: order.status == 'Cancelled' ||
                            order.status == 'canceled'
                        ? const SizedBox
                            .shrink() // Hide track button if order is cancelled
                        : ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NavigateScreen(
                                            userId: userId.toString(),
                                            orderId: order.id,
                                          )));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5E35B1),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const AppText(
                              'Track Order',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
          // Price at top right
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '₹${order.totalAmount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
            ),
          ),
          // Order ID at top left
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          //     decoration: BoxDecoration(
          //       color: Colors.blue.shade50,
          //       borderRadius: BorderRadius.circular(4),
          //     ),
          //     // child: Text(
          //     //   '#${order.id.substring(order.id.length - 6)}',
          //     //   style: TextStyle(
          //     //     fontSize: 10,
          //     //     fontWeight: FontWeight.bold,
          //     //     color: Colors.blue.shade700,
          //     //   ),
          //     // ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildPreviousOrderCard(
      OrderModel order, OrderProvider orderProvider) {
    final firstItem =
        order.orderItems.isNotEmpty ? order.orderItems.first : null;
    final itemsCount = order.orderItems.length;
    final deliveryAddress = order.deliveryAddress;
    final bool isDeletingThisOrder = _deletingOrderId == order.id;
    final bool isReorderingThisOrder = _reorderingOrderId == order.id;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Medicine image
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200],
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (firstItem?.imageUrl != null)
                            ? NetworkImage(firstItem!.imageUrl.toString())
                            : const AssetImage('assets/images/placeholder.png')
                                as ImageProvider,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),
                  // Order information
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          firstItem?.name ?? 'Order Items',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (itemsCount > 1)
                          Text(
                            '+${itemsCount - 1} more items',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        const SizedBox(height: 4),
                        // Location row
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 14, color: Colors.deepPurple),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                '${deliveryAddress.city}, ${deliveryAddress.state}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        // Status row
                        Row(
                          children: [
                            Icon(
                              _getStatusIcon(order.status),
                              size: 14,
                              color: _getStatusColor(order.status),
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

                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => InvoiceScreen(
                                                orderId: order.id,
                                              )));
                                },
                                icon: const Icon(Icons.receipt_long)),
                          ],
                        ),
                        // Date
                        Text(
                          _formatDate(order.createdAt),
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Price at top-right
              Positioned(
                top: 0,
                right: 0,
                child: Text(
                  '₹${order.totalAmount.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Order ID at top-left
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '#${order.id.substring(order.id.length - 6)}',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Re-Order button row
          Row(
            children: [
              // Re-Order button
              Expanded(
                child: OutlinedButton(
                  onPressed: (!isReorderingThisOrder && !isDeletingThisOrder)
                      ? () => _handleReorder(order, orderProvider)
                      : null,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.deepPurple,
                    side: const BorderSide(color: Colors.deepPurple),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: isReorderingThisOrder
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.deepPurple),
                          ),
                        )
                      : const AppText(
                          'reorder',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 50),
              // Delete button
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: const Color.fromARGB(255, 194, 194, 194)),
                ),
                child: IconButton(
                  onPressed: (!isDeletingThisOrder && !isReorderingThisOrder)
                      ? () => _handleDeleteOrder(order, orderProvider)
                      : null,
                  icon: isDeletingThisOrder
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                        )
                      : Icon(Icons.delete_outline,
                          color: Colors.red[400], size: 20),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Enhanced cancel order handler
  // Future<void> _handleCancelOrder(OrderModel order, OrderProvider orderProvider) async {
  //   // First check if order can be cancelled
  //   final canCancel = await orderProvider.canCancelOrder(order.id);
  //   if (!canCancel) {
  //     _showErrorSnackBar('This order cannot be cancelled at its current stage');
  //     return;
  //   }

  //   final cancelInfo = await _showCancelOrderDialog();
  //   if (cancelInfo == null) return;

  //   setState(() {
  //     _cancellingOrderId = order.id;
  //   });

  //   try {
  //     final success = await orderProvider.cancelOrder(
  //       order.id,
  //       cancelReason: cancelInfo['reason'],
  //     );

  //     if (success) {
  //       _showSuccessSnackBar(
  //         orderProvider.getCancelResponseMessage() ?? 'Order cancelled successfully'
  //       );
  //     } else {
  //       final errorDetails = orderProvider.getCancelErrorDetails();
  //       String errorMessage = 'Failed to cancel order';

  //       if (errorDetails != null) {
  //         errorMessage = errorDetails['message'] ?? errorMessage;
  //       } else if (orderProvider.errorMessage != null) {
  //         errorMessage = orderProvider.errorMessage!;
  //       }

  //       _showErrorSnackBar(errorMessage);
  //     }
  //   } catch (e) {
  //     _showErrorSnackBar('An unexpected error occurred while cancelling the order');
  //   } finally {
  //     setState(() {
  //       _cancellingOrderId = null;
  //     });
  //   }
  // }

  Future<void> _handleCancelOrder(
      OrderModel order, OrderProvider orderProvider) async {
    // First check if order can be cancelled
    final canCancel = await orderProvider.canCancelOrder(order.id);
    if (!canCancel) {
      _showErrorSnackBar('This order cannot be cancelled at its current stage');
      return;
    }

    final cancelInfo = await _showCancelOrderDialog();
    if (cancelInfo == null) return;

    setState(() {
      _cancellingOrderId = order.id;
    });

    try {
      final success = await orderProvider.cancelOrder(
        order.id,
        cancelReason: cancelInfo['reason'],
      );

      if (success) {
        //added this extra line

        await orderProvider.refreshOrders();

        _showSuccessSnackBar(orderProvider.getCancelResponseMessage() ??
            'Order cancelled successfully');
      } else {
        final errorDetails = orderProvider.getCancelErrorDetails();
        String errorMessage = 'Failed to cancel order';

        if (errorDetails != null) {
          errorMessage = errorDetails['message'] ?? errorMessage;
        } else if (orderProvider.errorMessage != null) {
          errorMessage = orderProvider.errorMessage!;
        }

        _showErrorSnackBar(errorMessage);
      }
    } catch (e) {
      _showErrorSnackBar(
          'An unexpected error occurred while cancelling the order');
    } finally {
      setState(() {
        _cancellingOrderId = null;
      });
    }
  }

  // Enhanced reorder handler
  Future<void> _handleReorder(
      OrderModel order, OrderProvider orderProvider) async {
    print("kkkkkkkkkkkdfhhhhhhhhhhhhhhhhhhhhhhhhisdhslsdils");
    // Store the order ID for reorder process
    setState(() {
      _currentReorderOrderId = order.id;
    });

    print(
        "kkkkkkkkkkkdfhhhhhhhhhhhhhhhhhhhhhhhhisdhslsdils$_currentReorderOrderId");

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ReorderDetailScreen(order: order)));

    // Initiate payment for reorder
    // _initiateRazorpayPaymentForReorder(order);
  }

  // Enhanced delete order handler
  Future<void> _handleDeleteOrder(
      OrderModel order, OrderProvider orderProvider) async {
    final confirmed = await _showDeleteConfirmation();
    if (!confirmed) return;

    setState(() {
      _deletingOrderId = order.id;
    });

    try {
      final success = await orderProvider.deletePreviousOrder(order.id);
      if (success) {
        _showSuccessSnackBar('Order deleted successfully');
      } else {
        _showErrorSnackBar(
            orderProvider.errorMessage ?? 'Failed to delete order');
      }
    } catch (e) {
      _showErrorSnackBar(
          'An unexpected error occurred while deleting the order');
    } finally {
      setState(() {
        _deletingOrderId = null;
      });
    }
  }

  // Track order handler
  void _handleTrackOrder(OrderModel order) {
    // TODO: Implement order tracking navigation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('Tracking order #${order.id.substring(order.id.length - 6)}'),
        action: SnackBarAction(
          label: 'View',
          onPressed: () {
            // Navigate to order tracking screen
          },
        ),
      ),
    );
  }

  // Helper method to check if order can be cancelled based on status
  bool _canCancelOrder(String status) {
    final cancellableStatuses = [
      'pending',
      'confirmed',
      'processing',
      'placed',
      'accepted',
    ];
    return cancellableStatuses.contains(status.toLowerCase());
  }

  // Helper methods for status styling
  // IconData _getStatusIcon(String status) {
  //   switch (status.toLowerCase()) {
  //     case 'pending':
  //       return Icons.access_time;
  //     case 'confirmed':
  //       return Icons.check_circle_outline;
  //     case 'processing':
  //       return Icons.local_shipping;
  //     case 'delivered':
  //       return Icons.check_circle;
  //     case 'cancelled':
  //       return Icons.cancel;
  //     default:
  //       return Icons.help_outline;
  //   }
  // }



  IconData _getStatusIcon(String status) {
  switch (status.toLowerCase()) {
    case 'pending':
      return Icons.access_time;
    case 'confirmed':
    case 'accepted':
      return Icons.check_circle_outline;
    case 'processing':
    case 'rider assigned':
    case 'rider accepted':
    case 'reassigned':
      return Icons.local_shipping;
    case 'pickedup':
    case 'picked up':
      return Icons.inventory;
    case 'delivered':
    case 'completed':    // ← ADD THIS
      return Icons.check_circle;
    case 'cancelled':
      return Icons.cancel;
    default:
      return Icons.help_outline;
  }
}

  // Color _getStatusColor(String status) {
  //   switch (status.toLowerCase()) {
  //     case 'pending':
  //       return Colors.orange;
  //     case 'confirmed':
  //       return Colors.blue;
  //     case 'processing':
  //       return Colors.purple;
  //     case 'delivered':
  //       return Colors.green;
  //     case 'cancelled':
  //       return Colors.red;
  //     default:
  //       return Colors.grey;
  //   }
  // }



  Color _getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'pending':
      return Colors.orange;
    case 'confirmed':
    case 'accepted':
      return Colors.blue;
    case 'processing':
    case 'rider assigned':
    case 'rider accepted':
    case 'reassigned':
      return Colors.purple;
    case 'pickedup':
    case 'picked up':
      return Colors.indigo;
    case 'delivered':
    case 'completed':    // ← ADD THIS
      return Colors.green;
    case 'cancelled':
      return Colors.red;
    default:
      return Colors.grey;
  }
}

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<Map<String, String>?> _showCancelOrderDialog() async {
    String? selectedReason;
    String customReason = '';

    final reasons = [
      'Changed my mind',
      // 'Found a better price',
      'Ordered by mistake',
      'Delivery taking too long',
      // 'Product not needed anymore',
      // 'Other',
    ];

    return await showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Cancel Order'),
              content: SizedBox(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  // Added ScrollView
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Please select a reason for cancelling:'),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue.shade200),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline,
                                color: Colors.blue.shade700, size: 16),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Cancelled orders will be moved to order history.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...reasons
                          .map((reason) => RadioListTile<String>(
                                title: Text(reason),
                                value: reason,
                                groupValue: selectedReason,
                                onChanged: (value) {
                                  setState(() {
                                    selectedReason = value;
                                    // if (value != 'Other') {
                                    //   customReason = '';
                                    // }
                                  });
                                },
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                              ))
                          .toList(),
                      if (selectedReason == 'Other') ...[
                        const SizedBox(height: 8),
                        TextField(
                          decoration: const InputDecoration(
                            hintText: 'Please specify...',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          onChanged: (value) => customReason = value,
                          maxLines: 2,
                          textInputAction: TextInputAction.done, // Added
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(null),
                  child: const Text('Keep Order'),
                ),
                TextButton(
                  onPressed: selectedReason != null &&
                          (selectedReason != 'Other' || customReason.isNotEmpty)
                      ? () {
                          final reason = selectedReason == 'Other'
                              ? customReason
                              : selectedReason!;
                          Navigator.of(context).pop({'reason': reason});
                        }
                      : null,
                  child: const Text('Cancel Order',
                      style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Method to initiate Razorpay payment for reorder
  void _initiateRazorpayPaymentForReorder(OrderModel order) {
    var options = {
      'key': 'rzp_test_BxtRNvflG06PTV', // Replace with your Razorpay key
      'amount': (order.totalAmount * 100).toInt(), // Amount in paise
      'name': 'CLYNIX',
      'description': 'Medicine Reorder Payment',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': "8309056333", // Get from user profile
        'email': "Simcurarx@gmail.com", // Get from user profile
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      print(
          "Opening Razorpay for reorder with payment methodddddddddddddddddd");
      razorpay.open(options);
      print("Razorpay opened successfully for reorder");
    } catch (e) {
      _showErrorSnackBar("Failed to open payment gateway: $e");
    }
  }

  // Process the reorder after successful payment
  Future<void> _processOrder(String? paymentId, {String? orderId}) async {
    try {
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

        _showErrorSnackBar("Order failed: $errorMessage");
      }
    } catch (e) {
      print("Error in _processOrder: $e");
      _showErrorSnackBar("Order processing failed: ${e.toString()}");
    }
  }

  // Razorpay event handlers
  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    _showErrorSnackBarr("Payment Failed: ${response.message}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    // Payment successful, now process the order
    try {
      await _processOrder(response.paymentId, orderId: _currentReorderOrderId);
    } catch (e) {
      _showErrorSnackBarr("Order processing failed after payment: $e");
    }
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    _showErrorSnackBarr("External wallet selected: ${response.walletName}");
  }

  // Helper method to show error messages
  void _showErrorSnackBarr(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  // Simple confirmation dialogs
  Future<bool> _showReorderConfirmation(OrderModel order) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Reorder'),
              content: const Text('Do you want to reorder the same items?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => {
                    // Store the order ID for reorder process
                    _currentReorderOrderId = order.id,

                    // Initiate payment for reorder
                    _initiateRazorpayPaymentForReorder(order),
                  },
                  child: const Text('Reorder'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<bool> _showDeleteConfirmation() async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Delete Order'),
              content: const Text(
                  'This will permanently delete this order from your history. Are you sure?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child:
                      const Text('Delete', style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  // Snackbar helpers
  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
