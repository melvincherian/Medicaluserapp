// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class SinglePreviousOrderScreen extends StatefulWidget {
//   final String userId;
//   final String orderId;

//   const SinglePreviousOrderScreen({
//     super.key,
//     required this.userId,
//     required this.orderId,
//   });

//   @override
//   State<SinglePreviousOrderScreen> createState() =>
//       _SinglePreviousOrderScreenState();
// }

// class _SinglePreviousOrderScreenState extends State<SinglePreviousOrderScreen> {
//   Map<String, dynamic>? order;
//   bool isLoading = true;
//   String? errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     fetchOrder();
//   }

//   Future<void> fetchOrder() async {
//     setState(() {
//       isLoading = true;
//       errorMessage = null;
//     });

//     try {
//       final url =
//           "https://api.simcurarx.com/api/users/singlepreviousorder/${widget.userId}/${widget.orderId}";

//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);

//         if (data['order'] != null) {
//           setState(() {
//             order = data['order'];
//             isLoading = false;
//           });
//         } else {
//           setState(() {
//             errorMessage = "No order details found.";
//             isLoading = false;
//           });
//         }
//       } else {
//         setState(() {
//           errorMessage = "Failed to fetch order. Status ${response.statusCode}";
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = "Error fetching order: $e";
//         isLoading = false;
//       });
//     }
//   }

//   Color getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'delivered':
//         return Colors.green;
//       case 'pending':
//         return Colors.orange;
//       case 'cancelled':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Order Details",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.blue,
//         elevation: 2,
//         centerTitle: true,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             icon: const Icon(Icons.arrow_back_ios)),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : errorMessage != null
//               ? Center(
//                   child: Text(
//                   errorMessage!,
//                   style: const TextStyle(color: Colors.red),
//                 ))
//               : order == null
//                   ? const Center(child: Text("No order found"))
//                   : SingleChildScrollView(
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Order Status & Total
//                           Card(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12)),
//                             elevation: 3,
//                             margin: const EdgeInsets.only(bottom: 16),
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       const Icon(Icons.local_shipping,
//                                           color: Colors.teal),
//                                       const SizedBox(width: 8),
//                                       Text(
//                                         "${order!['status']}",
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold,
//                                             color: getStatusColor(
//                                                 order!['status'])),
//                                       ),
//                                     ],
//                                   ),
//                                   Text(
//                                     "₹${order!['totalAmount']}",
//                                     style: const TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.green),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),

//                           // Delivery Address
//                           const Text("Delivery Address",
//                               style: TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.w600)),
//                           const SizedBox(height: 6),
//                           Card(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12)),
//                             elevation: 2,
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Text(
//                                 "${order!['deliveryAddress']['house']}, "
//                                 "${order!['deliveryAddress']['street']}, "
//                                 "${order!['deliveryAddress']['city']}, "
//                                 "${order!['deliveryAddress']['state']} - "
//                                 "${order!['deliveryAddress']['pincode']}, "
//                                 "${order!['deliveryAddress']['country']}",
//                                 style: const TextStyle(fontSize: 14),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 16),

//                           // Items
//                           const Text("Order Items",
//                               style: TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.w600)),
//                           const SizedBox(height: 8),
//                           ...List.generate(order!['orderItems'].length,
//                               (index) {
//                             final item = order!['orderItems'][index];
//                             final medicine = item['medicineId'];
//                             return Card(
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12)),
//                               elevation: 2,
//                               margin: const EdgeInsets.only(bottom: 12),
//                               child: ListTile(
//                                 leading: ClipRRect(
//                                   borderRadius: BorderRadius.circular(8),
//                                   child: medicine['images'] != null &&
//                                           medicine['images'].isNotEmpty
//                                       ? Image.network(
//                                           medicine['images'][0],
//                                           width: 60,
//                                           height: 60,
//                                           fit: BoxFit.cover,
//                                           errorBuilder: (context, error,
//                                                   stackTrace) =>
//                                               const Icon(Icons.medical_services,
//                                                   size: 40),
//                                         )
//                                       : const Icon(Icons.medical_services,
//                                           size: 40),
//                                 ),
//                                 title: Text(
//                                   medicine['name'],
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 subtitle: Text(
//                                   medicine['description'],
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 trailing: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Text(
//                                       "₹${medicine['price']}",
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     Text("x${item['quantity']}"),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           }),
//                           const SizedBox(height: 16),

//                           // Payment & Notes
//                           Card(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12)),
//                             elevation: 2,
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                       "Payment Method: ${order!['paymentMethod']}",
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.w500)),
//                                   const SizedBox(height: 8),
//                                   if (order!['notes'] != null &&
//                                       order!['notes'].toString().isNotEmpty)
//                                     Text("Notes: ${order!['notes']}"),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 30),
//                         ],
//                       ),
//                     ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SinglePreviousOrderScreen extends StatefulWidget {
  final String userId;
  final String orderId;

  const SinglePreviousOrderScreen({
    super.key,
    required this.userId,
    required this.orderId,
  });

  @override
  State<SinglePreviousOrderScreen> createState() =>
      _SinglePreviousOrderScreenState();
}

class _SinglePreviousOrderScreenState extends State<SinglePreviousOrderScreen>
    with TickerProviderStateMixin {
  Map<String, dynamic>? order;
  bool isLoading = true;
  String? errorMessage;

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    fetchOrder();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  Future<void> fetchOrder() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final url =
          "https://api.simcurarx.com/api/users/singlepreviousorder/${widget.userId}/${widget.orderId}";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['order'] != null) {
          setState(() {
            order = data['order'];
            isLoading = false;
          });
          // Start animations after data is loaded
          _fadeController.forward();
          await Future.delayed(const Duration(milliseconds: 200));
          _slideController.forward();
        } else {
          setState(() {
            errorMessage = "No order details found.";
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = "Failed to fetch order. Status ${response.statusCode}";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error fetching order: $e";
        isLoading = false;
      });
    }
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return const Color(0xFF1565C0);
      case 'pending':
        return const Color(0xFFFF9800);
      case 'cancelled':
        return const Color(0xFFF44336);
      case 'processing':
        return const Color(0xFF2196F3);
      default:
        return const Color(0xFF757575);
    }
  }

  IconData getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return Icons.check_circle;
      case 'pending':
        return Icons.access_time;
      case 'cancelled':
        return Icons.cancel;
      case 'processing':
        return Icons.refresh;
      default:
        return Icons.info;
    }
  }

  Widget _buildAnimatedCard({
    required Widget child,
    required int index,
    EdgeInsetsGeometry? margin,
  }) {
    // Ensure intervals don't exceed 1.0
    final double startInterval = (0.1 * index).clamp(0.0, 0.8);
    final double endInterval = (0.3 + (0.1 * index)).clamp(0.2, 1.0);
    final double fadeStartInterval = (0.05 * index).clamp(0.0, 0.7);
    final double fadeEndInterval = (0.25 + (0.05 * index)).clamp(0.1, 1.0);

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _slideController,
        curve: Interval(
          startInterval,
          endInterval,
          curve: Curves.easeOutCubic,
        ),
      )),
      child: FadeTransition(
        opacity: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: _fadeController,
          curve: Interval(
            fadeStartInterval,
            fadeEndInterval,
            curve: Curves.easeIn,
          ),
        )),
        child: Container(
          margin: margin ?? const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          "Order Details",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1565C0),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF1565C0)),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Loading order details...",
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          : errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red[300],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: fetchOrder,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1565C0),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                )
              : order == null
                  ? const Center(
                      child: Text(
                        "No order found",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF757575)),
                      ),
                    )
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Order Status & Total
                          _buildAnimatedCard(
                            index: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    getStatusColor(order!['status'])
                                        .withOpacity(0.1),
                                    getStatusColor(order!['status'])
                                        .withOpacity(0.05),
                                  ],
                                ),
                                border: Border.all(
                                  color: getStatusColor(order!['status'])
                                      .withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: getStatusColor(order!['status']),
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                getStatusColor(order!['status'])
                                                    .withOpacity(0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        getStatusIcon(order!['status']),
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            order!['status']
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: getStatusColor(
                                                  order!['status']),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            "Order #${widget.orderId}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF1565C0),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF1565C0),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        "₹${order!['totalAmount']}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          _buildAnimatedCard(
                            index: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF1565C0),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(
                                        Icons.medical_services,
                                        color:
                                            Color.fromARGB(255, 252, 252, 252),
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      "Order Items (${order!['orderItems'].length})",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF212121),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          ...List.generate(order!['orderItems'].length,
                              (index) {
                            final item = order!['orderItems'][index];
                            final medicine = item['medicineId'];
                            return _buildAnimatedCard(
                              index: index + 3,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      // Medicine Image
                                      Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.grey[100],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: medicine['images'] != null &&
                                                  medicine['images'].isNotEmpty
                                              ? Image.network(
                                                  medicine['images'][0],
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      const Icon(
                                                    Icons.medical_services,
                                                    size: 30,
                                                    color: Color(0xFF4CAF50),
                                                  ),
                                                )
                                              : const Icon(
                                                  Icons.medical_services,
                                                  size: 30,
                                                  color: Color(0xFF4CAF50),
                                                ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),

                                      // Medicine Details
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              medicine['name'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Color(0xFF212121),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              medicine['description'],
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                                height: 1.3,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFF4CAF50)
                                                            .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  child: Text(
                                                    "Qty: ${item['quantity']}",
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xFF1565C0),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Price
                                      // Container(
                                      //   padding: const EdgeInsets.symmetric(
                                      //     horizontal: 12,
                                      //     vertical: 6,
                                      //   ),
                                      //   decoration: BoxDecoration(
                                      //     color: const Color(0xFF1565C0).withOpacity(0.1),
                                      //     borderRadius: BorderRadius.circular(8),
                                      //   ),
                                      //   child: Text(
                                      //     "₹${medicine['price']}",
                                      //     style: const TextStyle(
                                      //       fontWeight: FontWeight.bold,
                                      //       fontSize: 16,
                                      //       color: Color(0xFF1565C0),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),

                          // Delivery Address
                          _buildAnimatedCard(
                            index: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF1565C0)
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Icon(
                                            Icons.location_on,
                                            color: Color(0xFF1565C0),
                                            size: 20,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        const Text(
                                          "Delivery Address",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF212121),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF5F5F5),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        "${order!['deliveryAddress']['house']}, "
                                        "${order!['deliveryAddress']['street']}, "
                                        "${order!['deliveryAddress']['city']}, "
                                        "${order!['deliveryAddress']['state']} - "
                                        "${order!['deliveryAddress']['pincode']}, "
                                        "${order!['deliveryAddress']['country']}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          height: 1.5,
                                          color: Color(0xFF424242),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Items Header

                          // Order Items

                          // Payment & Notes
                          _buildAnimatedCard(
                            index: order!['orderItems'].length + 3,
                            margin: const EdgeInsets.only(bottom: 30),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFF9800)
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Icon(
                                            Icons.payment,
                                            color: Color(0xFFFF9800),
                                            size: 20,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        const Text(
                                          "Payment Information",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF212121),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF5F5F5),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.credit_card,
                                                size: 16,
                                                color: Color(0xFF757575),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                "Method: ${order!['paymentMethod']}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  color: Color(0xFF424242),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // if (order!['notes'] != null &&
                                          //     order!['notes'].toString().isNotEmpty) ...[
                                          //   const SizedBox(height: 12),
                                          //   const Divider(height: 1),
                                          //   const SizedBox(height: 12),
                                          //   Row(
                                          //     crossAxisAlignment: CrossAxisAlignment.start,
                                          //     children: [
                                          //       const Icon(
                                          //         Icons.note_alt,
                                          //         size: 16,
                                          //         color: Color(0xFF757575),
                                          //       ),
                                          //       const SizedBox(width: 8),
                                          //       Expanded(
                                          //         child: Column(
                                          //           crossAxisAlignment: CrossAxisAlignment.start,
                                          //           children: [
                                          //             const Text(
                                          //               "Notes:",
                                          //               style: TextStyle(
                                          //                 fontWeight: FontWeight.w500,
                                          //                 fontSize: 15,
                                          //                 color: Color(0xFF424242),
                                          //               ),
                                          //             ),
                                          //             const SizedBox(height: 4),
                                          //             Text(
                                          //               order!['notes'],
                                          //               style: TextStyle(
                                          //                 fontSize: 14,
                                          //                 color: Colors.grey[600],
                                          //                 height: 1.4,
                                          //               ),
                                          //             ),
                                          //           ],
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ],
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
    );
  }
}
