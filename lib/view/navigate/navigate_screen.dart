import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medical_user_app/widgets/progress_bar.dart';

class NavigateScreen extends StatefulWidget {
  final String userId;
  final String?orderId;

  const NavigateScreen({
    super.key,
    required this.userId,
    this.orderId
  });

  @override
  State<NavigateScreen> createState() => _NavigateScreenState();
}

class _NavigateScreenState extends State<NavigateScreen> {
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
        if (_isDelivered()) {
          timer.cancel(); // Stop polling once delivered
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

  Future<void> _loadOrderStatus() async {
    try {
      final data = await OrderStatusService.getOrderStatus(widget.userId);
      if (mounted) {
        setState(() {
          orderData = data;
          isLoading = false;
          if (data == null) {
            error = 'Failed to load order status';
          }
        });

        // Show snackbar when delivered
        if (_isDelivered()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Your order has been delivered! 🎉"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          error = 'Error: $e';
          isLoading = false;
        });
      }
    }
  }

  bool _isDelivered() {
    if (orderData == null) return false;
    final statuses = orderData!.statusTimeline.map((s) => s.status.toLowerCase());
    return statuses.any((s) => s.contains('delivered') || s.contains('completed'));
  }

  int get currentStep {
    if (orderData?.statusTimeline.isEmpty ?? true) return 1;

    final allStatuses = orderData!.statusTimeline
        .map((s) => s.status.toLowerCase())
        .toList();

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

    return 1;
  }

  String get currentStatusLabel {
    if (orderData?.statusTimeline.isEmpty ?? true) return 'Order Placed';

    final latestStatus = orderData!.statusTimeline.last.status.toLowerCase();

    if (latestStatus.contains('delivered') || latestStatus.contains('completed')) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Tracker',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon:const Icon(Icons.arrow_back_ios,color: Colors.black,)),
        // backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'No orders found',
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _loadOrderStatus,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadOrderStatus,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        // Order Status Card
                        Container(
                          margin: const EdgeInsets.all(16),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header with image and status
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
                                              orderData!.medicines.first.images.isNotEmpty
                                          ? Image.network(
                                              orderData!.medicines.first.images.first,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) =>
                                                  Icon(Icons.local_pharmacy,
                                                      color: Colors.blue[600], size: 30),
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
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          currentStatusLabel,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.blue[700],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        if (orderData?.statusTimeline.isNotEmpty ?? false)
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
                                  Text(
                                    _formatLastUpdate(),
                                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),

                              // Progress Bar
                              CustomProgressBar(currentStep: currentStep, totalSteps: 5),
                              const SizedBox(height: 24),

                              // Step Items
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
                            ],
                          ),
                        ),

                        // Status Timeline
                        // if (orderData?.statusTimeline.isNotEmpty ?? false)
                        //   Container(
                        //     margin: const EdgeInsets.symmetric(horizontal: 16),
                        //     padding: const EdgeInsets.all(16),
                        //     decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(12),
                        //       boxShadow: [
                        //         BoxShadow(
                        //           color: Colors.grey.withOpacity(0.1),
                        //           spreadRadius: 1,
                        //           blurRadius: 4,
                        //           offset: const Offset(0, 1),
                        //         ),
                        //       ],
                        //     ),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         const Text(
                        //           'Status Timeline',
                        //           style: TextStyle(
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: 16,
                        //           ),
                        //         ),
                        //         const SizedBox(height: 16),
                        //         ...orderData!.statusTimeline.reversed.map(
                        //           (status) => Padding(
                        //             padding: const EdgeInsets.only(bottom: 12),
                        //             child: Row(
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               children: [
                        //                 Icon(Icons.circle, size: 8, color: Colors.blue),
                        //                 const SizedBox(width: 8),
                        //                 Expanded(
                        //                   child: Column(
                        //                     crossAxisAlignment: CrossAxisAlignment.start,
                        //                     children: [
                        //                       Text(
                        //                         status.status,
                        //                         style: const TextStyle(
                        //                           fontWeight: FontWeight.w500,
                        //                           fontSize: 14,
                        //                         ),
                        //                       ),
                        //                       Text(
                        //                         status.message,
                        //                         style: TextStyle(
                        //                           fontSize: 12,
                        //                           color: Colors.grey[600],
                        //                         ),
                        //                       ),
                        //                       Text(
                        //                         _formatTimestamp(status.timestamp),
                        //                         style: TextStyle(
                        //                           fontSize: 11,
                        //                           color: Colors.grey[500],
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),

                        // Order Items
                        // if (orderData?.medicines.isNotEmpty ?? false)
                        //   Container(
                        //     margin: const EdgeInsets.all(16),
                        //     padding: const EdgeInsets.all(16),
                        //     decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(12),
                        //       boxShadow: [
                        //         BoxShadow(
                        //           color: Colors.grey.withOpacity(0.1),
                        //           spreadRadius: 1,
                        //           blurRadius: 4,
                        //           offset: const Offset(0, 1),
                        //         ),
                        //       ],
                        //     ),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         const Text(
                        //           'Order Items',
                        //           style: TextStyle(
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: 16,
                        //           ),
                        //         ),
                        //         const SizedBox(height: 12),
                        //         ...orderData!.medicines.map(
                        //           (medicine) => Padding(
                        //             padding: const EdgeInsets.only(bottom: 12),
                        //             child: Row(
                        //               children: [
                        //                 Container(
                        //                   width: 50,
                        //                   height: 50,
                        //                   decoration: BoxDecoration(
                        //                     color: Colors.blue[50],
                        //                     borderRadius: BorderRadius.circular(8),
                        //                   ),
                        //                   child: ClipRRect(
                        //                     borderRadius: BorderRadius.circular(8),
                        //                     child: medicine.images.isNotEmpty
                        //                         ? Image.network(
                        //                             medicine.images.first,
                        //                             fit: BoxFit.cover,
                        //                             errorBuilder: (context, error, stackTrace) =>
                        //                                 Icon(Icons.medical_services,
                        //                                     color: Colors.blue[600]),
                        //                           )
                        //                         : Icon(Icons.medical_services,
                        //                             color: Colors.blue[600]),
                        //                   ),
                        //                 ),
                        //                 const SizedBox(width: 12),
                        //                 Expanded(
                        //                   child: Column(
                        //                     crossAxisAlignment: CrossAxisAlignment.start,
                        //                     children: [
                        //                       Text(
                        //                         medicine.name,
                        //                         style: const TextStyle(
                        //                           fontWeight: FontWeight.w500,
                        //                           fontSize: 14,
                        //                         ),
                        //                       ),
                        //                       Text(
                        //                         'Qty: ${medicine.quantity}',
                        //                         style: TextStyle(
                        //                           fontSize: 12,
                        //                           color: Colors.grey[600],
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //                 Text(
                        //                   '₹${medicine.mrp.toStringAsFixed(2)}',
                        //                   style: const TextStyle(
                        //                     fontWeight: FontWeight.bold,
                        //                     fontSize: 14,
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                ),
    );
  }

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
}