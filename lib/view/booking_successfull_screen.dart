// // import 'package:flutter/material.dart';
// // import 'package:medical_user_app/view/main_layout.dart';


// // class BookingSuccessfullScreen extends StatelessWidget {
// //   final String? orderId;
// //   final double? orderAmount;
// //   final String? paymentMethod;
// //   final String? addressId;
// //   const BookingSuccessfullScreen(
// //       {super.key,
// //       this.orderId,
// //       this.paymentMethod,
// //       this.orderAmount,
// //       this.addressId});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         centerTitle: true,
// //         leading: InkWell(
// //           onTap: () {
// //             Navigator.pushAndRemoveUntil(
// //               context,
// //               MaterialPageRoute(builder: (context) => const MainLayout()),
// //               (Route<dynamic> route) => false,
// //             );
// //           },
// //           child: Container(
// //             margin: const EdgeInsets.all(8),
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               border: Border.all(color: Colors.grey.shade300),
// //               borderRadius: BorderRadius.circular(8),
// //             ),
// //             child: const Icon(Icons.arrow_back_ios_new, size: 18),
// //           ),
// //         ),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(24),
// //         child: Center(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               const Icon(Icons.check_circle, color: Colors.green, size: 120),
// //               const SizedBox(height: 24),
// //               const Text(
// //                 'Order Placed Successfully',
// //                 style: TextStyle(
// //                   fontSize: 22,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.black,
// //                 ),
// //               ),
// //               const SizedBox(height: 8),
// //               const Text(
// //                 'Your booking confirmed',
// //                 style: TextStyle(
// //                   fontSize: 16,
// //                   color: Colors.grey,
// //                 ),
// //               ),
// //               const SizedBox(height: 24),
// //               const Text(
// //                 'Your order has been booked successfully!\n'
// //                 'Check My Bookings to track your order.',
// //                 textAlign: TextAlign.center,
// //                 style: TextStyle(
// //                   fontSize: 14,
// //                   color: Colors.grey,
// //                   height: 1.5,
// //                 ),
// //               ),
// //               const Spacer(),
// //               SizedBox(
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   onPressed: () {
// //                     Navigator.pushAndRemoveUntil(
// //                       context,
// //                       MaterialPageRoute(
// //                           builder: (context) => const MainLayout()),
// //                       (Route<dynamic> route) => false,
// //                     );
// //                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
// //                   },
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: const Color(0XFF5931DD),
// //                     padding: const EdgeInsets.symmetric(vertical: 16),
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(12),
// //                     ),
// //                   ),
// //                   child: const Text(
// //                     'DONE',
// //                     style: TextStyle(
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.bold,
// //                         color: Colors.white),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }













// import 'package:flutter/material.dart';
// import 'package:medical_user_app/view/main_layout.dart';

// class BookingSuccessfullScreen extends StatefulWidget {
//   final String? orderId;
//   final double? orderAmount;
//   final String? paymentMethod;
//   final String? addressId;
  
//   const BookingSuccessfullScreen({
//     super.key,
//     this.orderId,
//     this.paymentMethod,
//     this.orderAmount,
//     this.addressId
//   });

//   @override
//   State<BookingSuccessfullScreen> createState() => _BookingSuccessfullScreenState();
// }

// class _BookingSuccessfullScreenState extends State<BookingSuccessfullScreen> 
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
    
//     _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.elasticOut,
//       ),
//     );
    
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeIn,
//       ),
//     );
    
//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FA),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: Container(
//           margin: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 10,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: IconButton(
//             icon: const Icon(Icons.close, color: Colors.black87, size: 20),
//             onPressed: () {
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (context) => const MainLayout()),
//                 (Route<dynamic> route) => false,
//               );
//             },
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//           child: Column(
//             children: [
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Animated Success Icon
//                     ScaleTransition(
//                       scale: _scaleAnimation,
//                       child: Container(
//                         width: 140,
//                         height: 140,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: const Color(0XFF5931DD).withOpacity(0.2),
//                               blurRadius: 30,
//                               spreadRadius: 5,
//                               offset: const Offset(0, 10),
//                             ),
//                           ],
//                         ),
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             // Outer gradient ring
//                             Container(
//                               width: 120,
//                               height: 120,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     const Color(0XFF5931DD).withOpacity(0.1),
//                                     const Color(0XFF5931DD).withOpacity(0.05),
//                                   ],
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                 ),
//                               ),
//                             ),
//                             // Checkmark icon
//                             const Icon(
//                               Icons.check_circle_rounded,
//                               color: Color(0XFF5931DD),
//                               size: 80,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
                    
//                     const SizedBox(height: 40),
                    
//                     // Success Title
//                     FadeTransition(
//                       opacity: _fadeAnimation,
//                       child: const Text(
//                         'Order Placed!',
//                         style: TextStyle(
//                           fontSize: 32,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                           letterSpacing: -0.5,
//                         ),
//                       ),
//                     ),
                    
//                     const SizedBox(height: 12),
                    
//                     // Subtitle
//                     FadeTransition(
//                       opacity: _fadeAnimation,
//                       child: const Text(
//                         'Your order has been confirmed',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.black54,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
                    
//                     const SizedBox(height: 40),
                    
//                     // Order Details Card
//                     // FadeTransition(
//                     //   opacity: _fadeAnimation,
//                     //   child: Container(
//                     //     width: double.infinity,
//                     //     padding: const EdgeInsets.all(24),
//                     //     decoration: BoxDecoration(
//                     //       color: Colors.white,
//                     //       borderRadius: BorderRadius.circular(20),
//                     //       boxShadow: [
//                     //         BoxShadow(
//                     //           color: Colors.black.withOpacity(0.05),
//                     //           blurRadius: 20,
//                     //           offset: const Offset(0, 5),
//                     //         ),
//                     //       ],
//                     //     ),
//                     //     child: Column(
//                     //       children: [
//                     //         // Order ID
//                     //         if (widget.orderId != null) ...[
//                     //           _buildDetailRow(
//                     //             icon: Icons.receipt_long_rounded,
//                     //             label: 'Order ID',
//                     //             value: '#${widget.orderId}',
//                     //             isHighlight: true,
//                     //           ),
//                     //           const SizedBox(height: 20),
//                     //         ],
                            
//                     //         // Payment Method
//                     //         if (widget.paymentMethod != null) ...[
//                     //           _buildDetailRow(
//                     //             icon: Icons.payments_rounded,
//                     //             label: 'Payment Method',
//                     //             value: widget.paymentMethod!,
//                     //           ),
//                     //           const SizedBox(height: 20),
//                     //         ],
                            
//                     //         // Order Amount
//                     //         if (widget.orderAmount != null)
//                     //           _buildDetailRow(
//                     //             icon: Icons.account_balance_wallet_rounded,
//                     //             label: 'Total Amount',
//                     //             value: '₹${widget.orderAmount!.toStringAsFixed(2)}',
//                     //             valueColor: const Color(0XFF5931DD),
//                     //           ),
//                     //       ],
//                     //     ),
//                     //   ),
//                     // ),
                    
//                     const SizedBox(height: 32),
                    
//                     // Info Text
//                     // FadeTransition(
//                     //   opacity: _fadeAnimation,
//                     //   child: Container(
//                     //     padding: const EdgeInsets.all(16),
//                     //     decoration: BoxDecoration(
//                     //       color: const Color(0XFF5931DD).withOpacity(0.05),
//                     //       borderRadius: BorderRadius.circular(16),
//                     //       border: Border.all(
//                     //         color: const Color(0XFF5931DD).withOpacity(0.1),
//                     //       ),
//                     //     ),
//                     //     child: Row(
//                     //       children: [
//                     //         Container(
//                     //           padding: const EdgeInsets.all(8),
//                     //           decoration: BoxDecoration(
//                     //             color: const Color(0XFF5931DD).withOpacity(0.1),
//                     //             borderRadius: BorderRadius.circular(10),
//                     //           ),
//                     //           child: const Icon(
//                     //             Icons.info_outline_rounded,
//                     //             color: Color(0XFF5931DD),
//                     //             size: 20,
//                     //           ),
//                     //         ),
//                     //         const SizedBox(width: 12),
//                     //         const Expanded(
//                     //           child: Text(
//                     //             'Track your order status in\n"My Orders" section',
//                     //             style: TextStyle(
//                     //               fontSize: 13,
//                     //               color: Colors.black87,
//                     //               height: 1.4,
//                     //               fontWeight: FontWeight.w500,
//                     //             ),
//                     //           ),
//                     //         ),
//                     //       ],
//                     //     ),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
              
//               // Action Buttons
//               Column(
//                 children: [
//                   // Primary Button
//                   SizedBox(
//                     width: double.infinity,
//                     height: 56,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.pushAndRemoveUntil(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const MainLayout(),
//                           ),
//                           (Route<dynamic> route) => false,
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0XFF5931DD),
//                         foregroundColor: Colors.white,
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         shadowColor: const Color(0XFF5931DD).withOpacity(0.3),
//                       ),
//                       child: const Text(
//                         'Done',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: 0.5,
//                         ),
//                       ),
//                     ),
//                   ),
                  
//                   const SizedBox(height: 12),
                  
//                   // Secondary Button
//                   // SizedBox(
//                   //   width: double.infinity,
//                   //   height: 56,
//                   //   child: OutlinedButton(
//                   //     onPressed: () {
//                   //       // Navigate to orders screen
//                   //       Navigator.pushAndRemoveUntil(
//                   //         context,
//                   //         MaterialPageRoute(
//                   //           builder: (context) => const MainLayout(),
//                   //         ),
//                   //         (Route<dynamic> route) => false,
//                   //       );
//                   //       // TODO: Navigate to orders tab
//                   //     },
//                   //     style: OutlinedButton.styleFrom(
//                   //       foregroundColor: const Color(0XFF5931DD),
//                   //       side: const BorderSide(
//                   //         color: Color(0XFF5931DD),
//                   //         width: 2,
//                   //       ),
//                   //       shape: RoundedRectangleBorder(
//                   //         borderRadius: BorderRadius.circular(16),
//                   //       ),
//                   //     ),
//                   //     child: const Text(
//                   //       'View My Orders',
//                   //       style: TextStyle(
//                   //         fontSize: 16,
//                   //         fontWeight: FontWeight.bold,
//                   //         letterSpacing: 0.5,
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailRow({
//     required IconData icon,
//     required String label,
//     required String value,
//     bool isHighlight = false,
//     Color? valueColor,
//   }) {
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: const Color(0XFF5931DD).withOpacity(0.08),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Icon(
//             icon,
//             color: const Color(0XFF5931DD),
//             size: 22,
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.black.withOpacity(0.5),
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 value,
//                 style: TextStyle(
//                   fontSize: isHighlight ? 16 : 15,
//                   color: valueColor ?? Colors.black87,
//                   fontWeight: FontWeight.w700,
//                   letterSpacing: isHighlight ? 0.5 : 0,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }















import 'package:flutter/material.dart';
import 'package:medical_user_app/view/main_layout.dart';
import 'package:medical_user_app/view/order_hystory_screen.dart';

class BookingSuccessfullScreen extends StatefulWidget {
  final String? orderId;
  final double? orderAmount;
  final String? paymentMethod;
  final String? addressId;

  const BookingSuccessfullScreen({
    super.key,
    this.orderId,
    this.paymentMethod,
    this.orderAmount,
    this.addressId,
  });

  @override
  State<BookingSuccessfullScreen> createState() =>
      _BookingSuccessfullScreenState();
}

class _BookingSuccessfullScreenState extends State<BookingSuccessfullScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.black87, size: 20),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const OrdersHistoryScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            /// Scrollable content (fixes overflow)
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),

                    // Animated Success Icon
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0XFF5931DD).withOpacity(0.2),
                              blurRadius: 30,
                              spreadRadius: 5,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0XFF5931DD).withOpacity(0.1),
                                    const Color(0XFF5931DD).withOpacity(0.05),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.check_circle_rounded,
                              color: Color(0XFF5931DD),
                              size: 80,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: const Text(
                        'Order Placed!',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: const Text(
                        'Your order has been confirmed',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            /// Bottom Buttons (non-scrollable)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainLayout()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFF5931DD),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    bool isHighlight = false,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0XFF5931DD).withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0XFF5931DD),
            size: 22,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: isHighlight ? 16 : 15,
                  color: valueColor ?? Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
