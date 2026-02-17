// // // import 'dart:async';
// // // import 'package:flutter/material.dart';
// // // import 'dart:math';
// // // import 'dart:ui' as ui;
// // // import 'package:flutter/services.dart';
// // // import 'package:medical_user_app/view/main_layout.dart';

// // // class RadarAnimationScreen extends StatefulWidget {
// // //   final String? orderId;
// // //   final double? orderAmount;
// // //   final String? paymentMethod;
// // //   final String? addressId;

// // //   const RadarAnimationScreen({
// // //     super.key,
// // //     this.orderId,
// // //     this.paymentMethod,
// // //     this.orderAmount,
// // //     this.addressId,
// // //   });

// // //   @override
// // //   _RadarAnimationScreenState createState() => _RadarAnimationScreenState();
// // // }

// // // class _RadarAnimationScreenState extends State<RadarAnimationScreen>
// // //     with SingleTickerProviderStateMixin {
// // //   late AnimationController _controller;
// // //   ui.Image? _mapImage;

// // //   @override
// // //   void initState() {
// // //     super.initState();

// // //     _loadMapImage();

// // //     _controller = AnimationController(
// // //       vsync: this,
// // //       duration: const Duration(seconds: 4),
// // //     )..repeat();
// // //   }

// // //   Future<void> _loadMapImage() async {
// // //     try {
// // //       final ByteData data = await rootBundle.load('assets/map.jpg');
// // //       final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
// // //       final frame = await codec.getNextFrame();
// // //       if (mounted) {
// // //         setState(() {
// // //           _mapImage = frame.image;
// // //         });
// // //       }
// // //     } catch (e) {
// // //       // If image fails to load, the radar will show the fallback gradient
// // //       debugPrint('Map image failed to load: $e');
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.black,
// // //       appBar: AppBar(
// // //         backgroundColor: Colors.black,
// // //         elevation: 0,
// // //         leading: IconButton(
// // //           icon: const Icon(Icons.close, color: Colors.white),
// // //           onPressed: () {
// // //             Navigator.pushAndRemoveUntil(
// // //               context,
// // //               MaterialPageRoute(builder: (context) => const MainLayout()),
// // //               (Route<dynamic> route) => false,
// // //             );
// // //           },
// // //         ),
// // //       ),
// // //       body: SafeArea(
// // //         child: Padding(
// // //           padding: const EdgeInsets.symmetric(horizontal: 24.0),
// // //           child: Column(
// // //             children: [
// // //               const SizedBox(height: 40),
// // //               // Thank you message
// // //               const Text(
// // //                 'Thank You for Your Order!',
// // //                 style: TextStyle(
// // //                   color: Colors.white,
// // //                   fontSize: 24,
// // //                   fontWeight: FontWeight.bold,
// // //                 ),
// // //                 textAlign: TextAlign.center,
// // //               ),
// // //               const SizedBox(height: 12),
// // //               const Text(
// // //                 'Your order will be delivered soon',
// // //                 style: TextStyle(
// // //                   color: Colors.greenAccent,
// // //                   fontSize: 16,
// // //                   fontWeight: FontWeight.w500,
// // //                 ),
// // //                 textAlign: TextAlign.center,
// // //               ),
// // //               const SizedBox(height: 40),

// // //               // Radar Animation
// // //               AnimatedBuilder(
// // //                 animation: _controller,
// // //                 builder: (_, __) {
// // //                   return CustomPaint(
// // //                     size: const Size(300, 300),
// // //                     painter: RadarPainter(_controller.value, _mapImage),
// // //                   );
// // //                 },
// // //               ),
// // //               const Spacer(),

// // //               // Loading bar widget
// // //               AnimatedBuilder(
// // //                 animation: _controller,
// // //                 builder: (_, __) {
// // //                   return CustomPaint(
// // //                     size: const Size(400, 60),
// // //                     painter: LoadingBarPainter(_controller.value),
// // //                   );
// // //                 },
// // //               ),
// // //               const SizedBox(height: 40),

// // //               // Done button
// // //               SizedBox(
// // //                 width: double.infinity,
// // //                 child: ElevatedButton(
// // //                   onPressed: () {
// // //                     Navigator.pushAndRemoveUntil(
// // //                       context,
// // //                       MaterialPageRoute(
// // //                           builder: (context) => const MainLayout()),
// // //                       (Route<dynamic> route) => false,
// // //                     );
// // //                   },
// // //                   style: ElevatedButton.styleFrom(
// // //                     backgroundColor: const Color(0XFF5931DD),
// // //                     padding: const EdgeInsets.symmetric(vertical: 16),
// // //                     shape: RoundedRectangleBorder(
// // //                       borderRadius: BorderRadius.circular(12),
// // //                     ),
// // //                   ),
// // //                   child: const Text(
// // //                     'DONE',
// // //                     style: TextStyle(
// // //                       fontSize: 16,
// // //                       fontWeight: FontWeight.bold,
// // //                       color: Colors.white,
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 20),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _controller.dispose();
// // //     super.dispose();
// // //   }
// // // }

// // // class LoadingBarPainter extends CustomPainter {
// // //   final double progress;

// // //   LoadingBarPainter(this.progress);

// // //   @override
// // //   void paint(Canvas canvas, Size size) {
// // //     final barWidth = size.width * 0.8;
// // //     final barHeight = 20.0;
// // //     final barLeft = (size.width - barWidth) / 2;
// // //     final barTop = 0.0;

// // //     final barRect = RRect.fromRectAndRadius(
// // //       Rect.fromLTWH(barLeft, barTop, barWidth, barHeight),
// // //       const Radius.circular(20),
// // //     );

// // //     // Outer glow
// // //     final glowPaint = Paint()
// // //       ..color = Colors.white.withOpacity(0.3)
// // //       ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

// // //     canvas.drawRRect(
// // //       RRect.fromRectAndRadius(
// // //         Rect.fromLTWH(barLeft - 4, barTop - 4, barWidth + 8, barHeight + 8),
// // //         const Radius.circular(24),
// // //       ),
// // //       glowPaint,
// // //     );

// // //     // Outer border (light gray)
// // //     final borderPaint = Paint()
// // //       ..color = const Color(0xFF555555)
// // //       ..style = PaintingStyle.stroke
// // //       ..strokeWidth = 3;

// // //     canvas.drawRRect(barRect, borderPaint);

// // //     // Inner background (dark gray)
// // //     final backgroundPaint = Paint()
// // //       ..color = const Color(0xFF2a2a2a);

// // //     canvas.drawRRect(
// // //       RRect.fromRectAndRadius(
// // //         Rect.fromLTWH(barLeft + 3, barTop + 3, barWidth - 6, barHeight - 6),
// // //         const Radius.circular(17),
// // //       ),
// // //       backgroundPaint,
// // //     );

// // //     // Loading progress fill - goes from 0% to 100% then resets
// // //     final loopProgress = progress % 1.0;
// // //     final fillWidth = (barWidth - 6) * loopProgress;

// // //     if (fillWidth > 0) {
// // //       // Green gradient fill
// // //       final fillGradient = LinearGradient(
// // //         begin: Alignment.centerLeft,
// // //         end: Alignment.centerRight,
// // //         colors: [
// // //           const Color(0xFF4CAF50),
// // //           const Color(0xFF8BC34A),
// // //           const Color(0xFFCDDC39),
// // //         ],
// // //       );

// // //       final fillPaint = Paint()
// // //         ..shader = fillGradient.createShader(
// // //           Rect.fromLTWH(barLeft + 3, barTop + 3, fillWidth, barHeight - 6),
// // //         );

// // //       canvas.drawRRect(
// // //         RRect.fromRectAndRadius(
// // //           Rect.fromLTWH(barLeft + 3, barTop + 3, fillWidth, barHeight - 6),
// // //           const Radius.circular(17),
// // //         ),
// // //         fillPaint,
// // //       );

// // //       // Bright glow at the end of the loading bar
// // //       final glowPosition = barLeft + 3 + fillWidth - 30;
// // //       final glowWidth = 60.0;

// // //       final glowGradient = LinearGradient(
// // //         begin: Alignment.centerLeft,
// // //         end: Alignment.centerRight,
// // //         colors: [
// // //           Colors.greenAccent.withOpacity(0.0),
// // //           Colors.greenAccent.withOpacity(0.6),
// // //           Colors.yellowAccent.withOpacity(0.9),
// // //           Colors.greenAccent.withOpacity(0.6),
// // //           Colors.greenAccent.withOpacity(0.0),
// // //         ],
// // //       );

// // //       final glowFillPaint = Paint()
// // //         ..shader = glowGradient.createShader(
// // //           Rect.fromLTWH(glowPosition, barTop + 3, glowWidth, barHeight - 6),
// // //         )
// // //         ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

// // //       canvas.drawRRect(
// // //         RRect.fromRectAndRadius(
// // //           Rect.fromLTWH(glowPosition, barTop + 3, glowWidth, barHeight - 6),
// // //           const Radius.circular(17),
// // //         ),
// // //         glowFillPaint,
// // //       );
// // //     }

// // //     // "LOADING..." text
// // //     final textPainter = TextPainter(
// // //       text: const TextSpan(
// // //         text: 'LOADING...',
// // //         style: TextStyle(
// // //           color: Color(0xFF4a7a6a),
// // //           fontSize: 16,
// // //           fontWeight: FontWeight.w500,
// // //           letterSpacing: 3,
// // //         ),
// // //       ),
// // //       textDirection: TextDirection.ltr,
// // //     );

// // //     textPainter.layout();
// // //     textPainter.paint(
// // //       canvas,
// // //       Offset(
// // //         (size.width - textPainter.width) / 2,
// // //         barTop + barHeight + 10,
// // //       ),
// // //     );
// // //   }

// // //   @override
// // //   bool shouldRepaint(covariant LoadingBarPainter oldDelegate) => true;
// // // }

// // // class RadarPainter extends CustomPainter {
// // //   final double progress;
// // //   final ui.Image? mapImage;

// // //   RadarPainter(this.progress, this.mapImage);

// // //   @override
// // //   void paint(Canvas canvas, Size size) {
// // //     final center = size.center(Offset.zero);
// // //     final radius = size.width / 4;

// // //     // Clip to circle for map background
// // //     canvas.save();
// // //     canvas.clipPath(Path()..addOval(Rect.fromCircle(center: center, radius: radius)));

// // //     if (mapImage != null) {
// // //       // Draw actual map image
// // //       final srcRect = Rect.fromLTWH(
// // //         0,
// // //         0,
// // //         mapImage!.width.toDouble(),
// // //         mapImage!.height.toDouble(),
// // //       );
// // //       final dstRect = Rect.fromCircle(center: center, radius: radius);

// // //       canvas.drawImageRect(
// // //         mapImage!,
// // //         srcRect,
// // //         dstRect,
// // //         Paint()..filterQuality = FilterQuality.high,
// // //       );
// // //     } else {
// // //       // Fallback gradient while image is loading
// // //       final mapGradient = RadialGradient(
// // //         center: Alignment.center,
// // //         colors: [
// // //           Color(0xFF1a3a1a),
// // //           Color(0xFF0d1f0d),
// // //         ],
// // //       );

// // //       final mapPaint = Paint()
// // //         ..shader = mapGradient.createShader(
// // //           Rect.fromCircle(center: center, radius: radius),
// // //         );

// // //       canvas.drawCircle(center, radius, mapPaint);
// // //     }

// // //     canvas.restore();

// // //     // Outer circle
// // //     final ringPaint = Paint()
// // //       ..color = Colors.yellow.withOpacity(0.7)
// // //       ..style = PaintingStyle.stroke
// // //       ..strokeWidth = 2;

// // //     canvas.drawCircle(center, radius, ringPaint);

// // //     // Center filled circle
// // //     final centerPaint = Paint()
// // //       ..color = Colors.green.withOpacity(0.8)
// // //       ..style = PaintingStyle.fill;

// // //     canvas.drawCircle(center, 8, centerPaint);

// // //     // Rotating sweep gradient
// // //     final sweepGradient = SweepGradient(
// // //       startAngle: 0,
// // //       endAngle: pi / 3,
// // //       colors: [
// // //         Colors.blue.withOpacity(0.0),
// // //         Colors.blue.withOpacity(0.8),
// // //       ],
// // //     );

// // //     final sweepPaint = Paint()
// // //       ..shader = sweepGradient.createShader(
// // //         Rect.fromCircle(center: center, radius: radius),
// // //       );

// // //     final sweepAngle = progress * 2 * pi;

// // //     canvas.save();
// // //     canvas.translate(center.dx, center.dy);
// // //     canvas.rotate(sweepAngle);
// // //     canvas.translate(-center.dx, -center.dy);

// // //     canvas.drawArc(
// // //       Rect.fromCircle(center: center, radius: radius),
// // //       0,
// // //       pi / 3,
// // //       true,
// // //       sweepPaint,
// // //     );

// // //     canvas.restore();

// // //     // Glowing dot
// // //     final dotAngle = progress * 2 * pi;
// // //     final dotOffset = Offset(
// // //       center.dx + cos(dotAngle) * radius * 0.6,
// // //       center.dy + sin(dotAngle) * radius * 0.6,
// // //     );

// // //     final dotPaint = Paint()
// // //       ..color = Colors.greenAccent
// // //       ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

// // //     canvas.drawCircle(dotOffset, 6, dotPaint);
// // //   }

// // //   @override
// // //   bool shouldRepaint(covariant RadarPainter oldDelegate) => true;
// // // }














// // import 'dart:async';
// // import 'package:flutter/material.dart';
// // import 'dart:math';
// // import 'dart:ui' as ui;
// // import 'package:flutter/services.dart';
// // import 'package:medical_user_app/view/main_layout.dart';
// // import 'package:medical_user_app/services/order_service.dart';
// // import 'package:medical_user_app/models/order_model.dart';
// // import 'package:medical_user_app/utils/shared_preferences_helper.dart';

// // class RadarAnimationScreen extends StatefulWidget {
// //   final String? orderId;
// //   final double? orderAmount;
// //   final String? paymentMethod;
// //   final String? addressId;

// //   const RadarAnimationScreen({
// //     super.key,
// //     this.orderId,
// //     this.paymentMethod,
// //     this.orderAmount,
// //     this.addressId,
// //   });

// //   @override
// //   _RadarAnimationScreenState createState() => _RadarAnimationScreenState();
// // }

// // class _RadarAnimationScreenState extends State<RadarAnimationScreen>
// //     with SingleTickerProviderStateMixin {
// //   late AnimationController _controller;
// //   ui.Image? _mapImage;
  
// //   // Order status tracking
// //   Timer? _orderStatusTimer;
// //   OrderModel? _currentOrder;
// //   String _orderStatus = 'pending';
// //   bool _isLoadingOrder = false;
// //   String? _userId;

// //   @override
// //   void initState() {
// //     super.initState();

// //     _loadMapImage();
// //     _loadUserId();

// //     _controller = AnimationController(
// //       vsync: this,
// //       duration: const Duration(seconds: 4),
// //     )..repeat();

// //     // Start polling order status every 5 seconds
// //     _startOrderStatusPolling();
// //   }

// //   Future<void> _loadUserId() async {
// //     try {
// //       final user = await SharedPreferencesHelper.getUser();
// //       if (user != null && mounted) {
// //         setState(() {
// //           _userId = user.id;
// //         });

// //         print("llllllllllllllllllllllllllllllllllllllllllllll$_userId");
// //         // Fetch initial order status
// //         _fetchOrderStatus();
// //       }
// //     } catch (e) {
// //       debugPrint('Error loading user ID: $e');
// //     }
// //   }

// //   void _startOrderStatusPolling() {
// //     _orderStatusTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
// //       if (mounted) {
// //         _fetchOrderStatus();
// //       } else {
// //         timer.cancel();
// //       }
// //     });
// //   }

// //   Future<void> _fetchOrderStatus() async {
// //     print("llllllllllllllllllllllllllllllllldfjsjf$_userId");
// //         print("llllllllllllllllllllllllllllllllldfjsjf${widget.orderId}");

// //     if (_userId == null) {
// //       debugPrint('Cannot fetch order status - missing userId or orderId');
// //       return;
// //     }

// //     if (_isLoadingOrder) return; // Prevent multiple simultaneous requests

// //     setState(() {
// //       _isLoadingOrder = true;
// //     });

// //     try {
// //       debugPrint('Fetching order status for order: ${widget.orderId}');
      
// //       final orders = await OrderService.getCurrentOrders(_userId!);
      
// //       if (mounted) {
// //         // Find the specific order by ID
// //         final order = orders.where((o) => o.id == widget.orderId).firstOrNull;
        
// //         if (order != null) {
// //           setState(() {
// //             _currentOrder = order;
// //             _orderStatus = order.status.toLowerCase();
// //           });
          
// //           debugPrint('Order status updated: $_orderStatus');
          
// //           // Check if order is completed or delivered
// //           if (_orderStatus == 'delivered' || _orderStatus == 'completed') {
// //             _orderStatusTimer?.cancel();
// //             debugPrint('Order completed - stopped polling');
// //           }
// //         } else {
// //           debugPrint('Order not found in current orders');
// //           // Try to check if order moved to previous orders (completed/cancelled)
// //           final previousOrders = await OrderService.getPreviousOrders(_userId!);
// //           final previousOrder = previousOrders.where((o) => o.id == widget.orderId).firstOrNull;
          
// //           if (previousOrder != null && mounted) {
// //             setState(() {
// //               _currentOrder = previousOrder;
// //               _orderStatus = previousOrder.status.toLowerCase();
// //             });
// //             _orderStatusTimer?.cancel();
// //             debugPrint('Order found in previous orders: $_orderStatus');
// //           }
// //         }
// //       }
// //     } catch (e) {
// //       debugPrint('Error fetching order status: $e');
// //     } finally {
// //       if (mounted) {
// //         setState(() {
// //           _isLoadingOrder = false;
// //         });
// //       }
// //     }
// //   }

// //   Future<void> _loadMapImage() async {
// //     try {
// //       final ByteData data = await rootBundle.load('assets/map.jpg');
// //       final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
// //       final frame = await codec.getNextFrame();
// //       if (mounted) {
// //         setState(() {
// //           _mapImage = frame.image;
// //         });
// //       }
// //     } catch (e) {
// //       // If image fails to load, the radar will show the fallback gradient
// //       debugPrint('Map image failed to load: $e');
// //     }
// //   }

// //   String _getStatusDisplayText() {
// //     switch (_orderStatus.toLowerCase()) {
// //       case 'pending':
// //         return 'Order Placed';
// //       case 'confirmed':
// //       case 'accepted':
// //         return 'Order Confirmed';
// //       case 'processing':
// //         return 'Processing Order';
// //       case 'rider assigned':
// //       case 'assigned':
// //         return 'Rider Assigned';
// //       case 'pickedup':
// //       case 'picked up':
// //         return 'Order Picked Up';
// //       case 'out_for_delivery':
// //       case 'out for delivery':
// //         return 'Out for Delivery';
// //       case 'delivered':
// //         return 'Order Delivered';
// //       case 'completed':
// //         return 'Order Completed';
// //       case 'cancelled':
// //         return 'Order Cancelled';
// //       default:
// //         return 'Processing Order';
// //     }
// //   }

// //   Color _getStatusColor() {
// //     switch (_orderStatus.toLowerCase()) {
// //       case 'pending':
// //       case 'confirmed':
// //       case 'accepted':
// //         return Colors.orange;
// //       case 'processing':
// //       case 'rider assigned':
// //       case 'assigned':
// //         return Colors.blue;
// //       case 'pickedup':
// //       case 'picked up':
// //       case 'out_for_delivery':
// //       case 'out for delivery':
// //         return Colors.purple;
// //       case 'delivered':
// //       case 'completed':
// //         return Colors.green;
// //       case 'cancelled':
// //         return Colors.red;
// //       default:
// //         return Colors.greenAccent;
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       appBar: AppBar(
// //         backgroundColor: Colors.black,
// //         elevation: 0,
// //         // leading: IconButton(
// //         //   icon: const Icon(Icons.close, color: Colors.white),
// //         //   onPressed: () {
// //         //     _orderStatusTimer?.cancel();
// //         //     Navigator.pushAndRemoveUntil(
// //         //       context,
// //         //       MaterialPageRoute(builder: (context) => const MainLayout()),
// //         //       (Route<dynamic> route) => false,
// //         //     );
// //         //   },
// //         // ),
// //       ),
// //       body: SafeArea(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 24.0),
// //           child: Column(
// //             children: [
// //               const SizedBox(height: 40),
// //               // Thank you message
// //               const Text(
// //                 'Thank You for Your Order!',
// //                 style: TextStyle(
// //                   color: Colors.white,
// //                   fontSize: 24,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //                 textAlign: TextAlign.center,
// //               ),
// //               const SizedBox(height: 12),
// //               const Text(
// //                 'Your order will be delivered soon',
// //                 style: TextStyle(
// //                   color: Colors.greenAccent,
// //                   fontSize: 16,
// //                   fontWeight: FontWeight.w500,
// //                 ),
// //                 textAlign: TextAlign.center,
// //               ),
// //               const SizedBox(height: 30),

// //               // Order Status Display
// //               Container(
// //                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
// //                 decoration: BoxDecoration(
// //                   color: _getStatusColor().withOpacity(0.2),
// //                   borderRadius: BorderRadius.circular(25),
// //                   border: Border.all(
// //                     color: _getStatusColor().withOpacity(0.5),
// //                     width: 1.5,
// //                   ),
// //                 ),
// //                 child: Row(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     if (_isLoadingOrder)
// //                       SizedBox(
// //                         width: 16,
// //                         height: 16,
// //                         child: CircularProgressIndicator(
// //                           strokeWidth: 2,
// //                           valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor()),
// //                         ),
// //                       )
// //                     else
// //                       Icon(
// //                         _orderStatus == 'delivered' || _orderStatus == 'completed'
// //                             ? Icons.check_circle
// //                             : _orderStatus == 'cancelled'
// //                                 ? Icons.cancel
// //                                 : Icons.local_shipping,
// //                         color: _getStatusColor(),
// //                         size: 20,
// //                       ),
// //                     const SizedBox(width: 10),
// //                     Text(
// //                       _getStatusDisplayText(),
// //                       style: TextStyle(
// //                         color: _getStatusColor(),
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.bold,
// //                         letterSpacing: 0.5,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               const SizedBox(height: 10),

// //               // Order ID (if available)
// //               if (widget.orderId != null)
// //                 Text(
// //                   'Order ID: ${widget.orderId!.substring(0, min(8, widget.orderId!.length))}...',
// //                   style: TextStyle(
// //                     color: Colors.grey[500],
// //                     fontSize: 12,
// //                   ),
// //                 ),
// //               const SizedBox(height: 30),

// //               // Radar Animation
// //               AnimatedBuilder(
// //                 animation: _controller,
// //                 builder: (_, __) {
// //                   return CustomPaint(
// //                     size: const Size(300, 300),
// //                     painter: RadarPainter(_controller.value, _mapImage),
// //                   );
// //                 },
// //               ),
// //               const Spacer(),

// //               // Loading bar widget
// //               AnimatedBuilder(
// //                 animation: _controller,
// //                 builder: (_, __) {
// //                   return CustomPaint(
// //                     size: const Size(400, 60),
// //                     painter: LoadingBarPainter(_controller.value),
// //                   );
// //                 },
// //               ),
// //               const SizedBox(height: 40),

// //               // Done button
// //               // SizedBox(
// //               //   width: double.infinity,
// //               //   child: ElevatedButton(
// //               //     onPressed: () {
// //               //       _orderStatusTimer?.cancel();
// //               //       Navigator.pushAndRemoveUntil(
// //               //         context,
// //               //         MaterialPageRoute(
// //               //             builder: (context) => const MainLayout()),
// //               //         (Route<dynamic> route) => false,
// //               //       );
// //               //     },
// //               //     style: ElevatedButton.styleFrom(
// //               //       backgroundColor: const Color(0XFF5931DD),
// //               //       padding: const EdgeInsets.symmetric(vertical: 16),
// //               //       shape: RoundedRectangleBorder(
// //               //         borderRadius: BorderRadius.circular(12),
// //               //       ),
// //               //     ),
// //               //     child: const Text(
// //               //       'DONE',
// //               //       style: TextStyle(
// //               //         fontSize: 16,
// //               //         fontWeight: FontWeight.bold,
// //               //         color: Colors.white,
// //               //       ),
// //               //     ),
// //               //   ),
// //               // ),
// //               const SizedBox(height: 20),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _orderStatusTimer?.cancel();
// //     _controller.dispose();
// //     super.dispose();
// //   }
// // }

// // class LoadingBarPainter extends CustomPainter {
// //   final double progress;

// //   LoadingBarPainter(this.progress);

// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     final barWidth = size.width * 0.8;
// //     final barHeight = 20.0;
// //     final barLeft = (size.width - barWidth) / 2;
// //     final barTop = 0.0;

// //     final barRect = RRect.fromRectAndRadius(
// //       Rect.fromLTWH(barLeft, barTop, barWidth, barHeight),
// //       const Radius.circular(20),
// //     );

// //     // Outer glow
// //     final glowPaint = Paint()
// //       ..color = Colors.white.withOpacity(0.3)
// //       ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

// //     canvas.drawRRect(
// //       RRect.fromRectAndRadius(
// //         Rect.fromLTWH(barLeft - 4, barTop - 4, barWidth + 8, barHeight + 8),
// //         const Radius.circular(24),
// //       ),
// //       glowPaint,
// //     );

// //     // Outer border (light gray)
// //     final borderPaint = Paint()
// //       ..color = const Color(0xFF555555)
// //       ..style = PaintingStyle.stroke
// //       ..strokeWidth = 3;

// //     canvas.drawRRect(barRect, borderPaint);

// //     // Inner background (dark gray)
// //     final backgroundPaint = Paint()
// //       ..color = const Color(0xFF2a2a2a);

// //     canvas.drawRRect(
// //       RRect.fromRectAndRadius(
// //         Rect.fromLTWH(barLeft + 3, barTop + 3, barWidth - 6, barHeight - 6),
// //         const Radius.circular(17),
// //       ),
// //       backgroundPaint,
// //     );

// //     // Loading progress fill - goes from 0% to 100% then resets
// //     final loopProgress = progress % 1.0;
// //     final fillWidth = (barWidth - 6) * loopProgress;

// //     if (fillWidth > 0) {
// //       // Green gradient fill
// //       final fillGradient = LinearGradient(
// //         begin: Alignment.centerLeft,
// //         end: Alignment.centerRight,
// //         colors: [
// //           const Color(0xFF4CAF50),
// //           const Color(0xFF8BC34A),
// //           const Color(0xFFCDDC39),
// //         ],
// //       );

// //       final fillPaint = Paint()
// //         ..shader = fillGradient.createShader(
// //           Rect.fromLTWH(barLeft + 3, barTop + 3, fillWidth, barHeight - 6),
// //         );

// //       canvas.drawRRect(
// //         RRect.fromRectAndRadius(
// //           Rect.fromLTWH(barLeft + 3, barTop + 3, fillWidth, barHeight - 6),
// //           const Radius.circular(17),
// //         ),
// //         fillPaint,
// //       );

// //       // Bright glow at the end of the loading bar
// //       final glowPosition = barLeft + 3 + fillWidth - 30;
// //       final glowWidth = 60.0;

// //       final glowGradient = LinearGradient(
// //         begin: Alignment.centerLeft,
// //         end: Alignment.centerRight,
// //         colors: [
// //           Colors.greenAccent.withOpacity(0.0),
// //           Colors.greenAccent.withOpacity(0.6),
// //           Colors.yellowAccent.withOpacity(0.9),
// //           Colors.greenAccent.withOpacity(0.6),
// //           Colors.greenAccent.withOpacity(0.0),
// //         ],
// //       );

// //       final glowFillPaint = Paint()
// //         ..shader = glowGradient.createShader(
// //           Rect.fromLTWH(glowPosition, barTop + 3, glowWidth, barHeight - 6),
// //         )
// //         ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

// //       canvas.drawRRect(
// //         RRect.fromRectAndRadius(
// //           Rect.fromLTWH(glowPosition, barTop + 3, glowWidth, barHeight - 6),
// //           const Radius.circular(17),
// //         ),
// //         glowFillPaint,
// //       );
// //     }

// //     // "LOADING..." text
// //     final textPainter = TextPainter(
// //       text: const TextSpan(
// //         text: 'LOADING...',
// //         style: TextStyle(
// //           color: Color(0xFF4a7a6a),
// //           fontSize: 16,
// //           fontWeight: FontWeight.w500,
// //           letterSpacing: 3,
// //         ),
// //       ),
// //       textDirection: TextDirection.ltr,
// //     );

// //     textPainter.layout();
// //     textPainter.paint(
// //       canvas,
// //       Offset(
// //         (size.width - textPainter.width) / 2,
// //         barTop + barHeight + 10,
// //       ),
// //     );
// //   }

// //   @override
// //   bool shouldRepaint(covariant LoadingBarPainter oldDelegate) => true;
// // }

// // class RadarPainter extends CustomPainter {
// //   final double progress;
// //   final ui.Image? mapImage;

// //   RadarPainter(this.progress, this.mapImage);

// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     final center = size.center(Offset.zero);
// //     final radius = size.width / 4;

// //     // Clip to circle for map background
// //     canvas.save();
// //     canvas.clipPath(Path()..addOval(Rect.fromCircle(center: center, radius: radius)));

// //     if (mapImage != null) {
// //       // Draw actual map image
// //       final srcRect = Rect.fromLTWH(
// //         0,
// //         0,
// //         mapImage!.width.toDouble(),
// //         mapImage!.height.toDouble(),
// //       );
// //       final dstRect = Rect.fromCircle(center: center, radius: radius);

// //       canvas.drawImageRect(
// //         mapImage!,
// //         srcRect,
// //         dstRect,
// //         Paint()..filterQuality = FilterQuality.high,
// //       );
// //     } else {
// //       // Fallback gradient while image is loading
// //       final mapGradient = RadialGradient(
// //         center: Alignment.center,
// //         colors: [
// //           Color(0xFF1a3a1a),
// //           Color(0xFF0d1f0d),
// //         ],
// //       );

// //       final mapPaint = Paint()
// //         ..shader = mapGradient.createShader(
// //           Rect.fromCircle(center: center, radius: radius),
// //         );

// //       canvas.drawCircle(center, radius, mapPaint);
// //     }

// //     canvas.restore();

// //     // Outer circle
// //     final ringPaint = Paint()
// //       ..color = Colors.yellow.withOpacity(0.7)
// //       ..style = PaintingStyle.stroke
// //       ..strokeWidth = 2;

// //     canvas.drawCircle(center, radius, ringPaint);

// //     // Center filled circle
// //     final centerPaint = Paint()
// //       ..color = Colors.green.withOpacity(0.8)
// //       ..style = PaintingStyle.fill;

// //     canvas.drawCircle(center, 8, centerPaint);

// //     // Rotating sweep gradient
// //     final sweepGradient = SweepGradient(
// //       startAngle: 0,
// //       endAngle: pi / 3,
// //       colors: [
// //         Colors.blue.withOpacity(0.0),
// //         Colors.blue.withOpacity(0.8),
// //       ],
// //     );

// //     final sweepPaint = Paint()
// //       ..shader = sweepGradient.createShader(
// //         Rect.fromCircle(center: center, radius: radius),
// //       );

// //     final sweepAngle = progress * 2 * pi;

// //     canvas.save();
// //     canvas.translate(center.dx, center.dy);
// //     canvas.rotate(sweepAngle);
// //     canvas.translate(-center.dx, -center.dy);

// //     canvas.drawArc(
// //       Rect.fromCircle(center: center, radius: radius),
// //       0,
// //       pi / 3,
// //       true,
// //       sweepPaint,
// //     );

// //     canvas.restore();

// //     // Glowing dot
// //     final dotAngle = progress * 2 * pi;
// //     final dotOffset = Offset(
// //       center.dx + cos(dotAngle) * radius * 0.6,
// //       center.dy + sin(dotAngle) * radius * 0.6,
// //     );

// //     final dotPaint = Paint()
// //       ..color = Colors.greenAccent
// //       ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

// //     canvas.drawCircle(dotOffset, 6, dotPaint);
// //   }

// //   @override
// //   bool shouldRepaint(covariant RadarPainter oldDelegate) => true;
// // }



























import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui' as ui;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/view/main_layout.dart';
import 'package:medical_user_app/services/order_service.dart';
import 'package:medical_user_app/models/order_model.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';

class RadarAnimationScreen extends StatefulWidget {
  final String? orderId;
  final double? orderAmount;
  final String? paymentMethod;
  final String? addressId;

  const RadarAnimationScreen({
    super.key,
    this.orderId,
    this.paymentMethod,
    this.orderAmount,
    this.addressId,
  });

  @override
  _RadarAnimationScreenState createState() => _RadarAnimationScreenState();
}

class _RadarAnimationScreenState extends State<RadarAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ui.Image? _mapImage;
  
  // Order status tracking
  Timer? _orderStatusTimer;
  OrderStatusResponse? orderData;
  bool isLoading = true;
  String? error;
  String? _userId;

  @override
  void initState() {
    super.initState();

    _loadMapImage();
    _loadUserId();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    // Start polling order status every 8 seconds (same as OrderStatusWidget)
    _startOrderStatusPolling();
  }

  Future<void> _loadUserId() async {
    try {
      final user = await SharedPreferencesHelper.getUser();
      if (user != null && mounted) {
        setState(() {
          _userId = user.id;
        });
        // Fetch initial order status
        _loadOrderStatus();
      }
    } catch (e) {
      debugPrint('Error loading user ID: $e');
    }
  }

  void _startOrderStatusPolling() {
    _orderStatusTimer = Timer.periodic(const Duration(seconds: 8), (timer) {
      if (mounted) {
        if (_isDelivered() || _isCancelled()) {
          timer.cancel(); // Stop polling once delivered or cancelled
        } else {
          _loadOrderStatus();
        }
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _loadOrderStatus() async {
    if (_userId == null) return;

    try {
      final data = await OrderStatusService.getOrderStatus(_userId!);
      if (mounted) {
        setState(() {
          orderData = data;
          isLoading = false;
          if (data == null) {
            error = 'Failed to load order status';
          }
        });

        // Stop polling if cancelled or delivered
        if (_isCancelled() || _isDelivered()) {
          _orderStatusTimer?.cancel();
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

  bool _isCancelled() {
    if (orderData == null) return false;
    
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

    final allStatuses = orderData!.statusTimeline.map((s) => s.status.toLowerCase()).toList();
    final allmsg = orderData!.statusTimeline.map((s) => s.message.toLowerCase()).toList();

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

  Future<void> _loadMapImage() async {
    try {
      final ByteData data = await rootBundle.load('assets/map.jpg');
      final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
      final frame = await codec.getNextFrame();
      if (mounted) {
        setState(() {
          _mapImage = frame.image;
        });
      }
    } catch (e) {
      debugPrint('Map image failed to load: $e');
    }
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

  Widget _buildStepItem({
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: isActive
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.9),
                      Colors.white.withOpacity(0.7),
                    ],
                  )
                : null,
            color: isActive ? null : Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isActive 
                  ? Colors.white 
                  : Colors.white.withOpacity(0.3),
              width: 2.5,
            ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      blurRadius: 12,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Icon(
            icon,
            color: isActive ? Color(0xFF667eea) : Colors.white60,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 60,
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              color: isActive ? Colors.white : Colors.white60,
              height: 1.3,
              shadows: isActive
                  ? [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset(0, 1),
                        blurRadius: 2,
                      ),
                    ]
                  : [],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            _orderStatusTimer?.cancel();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainLayout()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Thank you message
                const Text(
                  'Thank You for Your Order!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Your order will be delivered soon',
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Order Status Widget - Enhanced UI
                if (!_isDelivered() && !_isCancelled())
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF667eea),
                          Color(0xFF764ba2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF667eea).withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: isLoading
                        ? Container(
                            padding: const EdgeInsets.all(40),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : error != null
                            ? Container(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Icon(Icons.info_outline, color: Colors.white70, size: 40),
                                    const SizedBox(height: 12),
                                    Text(
                                      'No active orders',
                                      style: TextStyle(color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BackdropFilter(
                                  filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.white.withOpacity(0.2),
                                          Colors.white.withOpacity(0.1),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.2),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Header Section
                                        Row(
                                          children: [
                                            // Medicine Image with enhanced styling
                                            Container(
                                              width: 70,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.white.withOpacity(0.3),
                                                    Colors.white.withOpacity(0.1),
                                                  ],
                                                ),
                                                borderRadius: BorderRadius.circular(16),
                                                border: Border.all(
                                                  color: Colors.white.withOpacity(0.3),
                                                  width: 2,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(0.1),
                                                    blurRadius: 10,
                                                    offset: Offset(0, 4),
                                                  ),
                                                ],
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(14),
                                                child: orderData!.medicines.isNotEmpty &&
                                                        orderData!.medicines.first.images.isNotEmpty
                                                    ? Image.network(
                                                        orderData!.medicines.first.images.first,
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context, error, stackTrace) =>
                                                            Icon(
                                                              Icons.local_pharmacy,
                                                              color: Colors.white,
                                                              size: 35,
                                                            ),
                                                      )
                                                    : Icon(
                                                        Icons.local_pharmacy,
                                                        color: Colors.white,
                                                        size: 35,
                                                      ),
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      // Container(
                                                      //   padding: EdgeInsets.symmetric(
                                                      //     horizontal: 10,
                                                      //     vertical: 4,
                                                      //   ),
                                                      //   decoration: BoxDecoration(
                                                      //     color: Colors.greenAccent.withOpacity(0.9),
                                                      //     borderRadius: BorderRadius.circular(20),
                                                      //   ),
                                                      //   child: Row(
                                                      //     mainAxisSize: MainAxisSize.min,
                                                      //     children: [
                                                      //       Icon(
                                                      //         Icons.fiber_manual_record,
                                                      //         size: 8,
                                                      //         color: Colors.green[900],
                                                      //       ),
                                                      //       SizedBox(width: 4),
                                                      //       Text(
                                                      //         'LIVE',
                                                      //         style: TextStyle(
                                                      //           fontSize: 10,
                                                      //           fontWeight: FontWeight.bold,
                                                      //           color: Colors.green[900],
                                                      //           letterSpacing: 1,
                                                      //         ),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                      Spacer(),
                                                      Text(
                                                        _formatLastUpdate(),
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.white70,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  const Text(
                                                    'Order Tracking',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      letterSpacing: 0.5,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  if (orderData?.statusTimeline.isNotEmpty ?? false)
                                                    Container(
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white.withOpacity(0.2),
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                      child: Text(
                                                        orderData!.statusTimeline.last.message,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 24),
                                        
                                        // Enhanced Progress Bar
                                        CustomProgressBar(
                                          currentStep: currentStep,
                                          totalSteps: 5,
                                        ),
                                        const SizedBox(height: 20),
                                        
                                        // Status Steps with enhanced styling
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            _buildStepItem(
                                              icon: Icons.shopping_cart_rounded,
                                              label: 'Order\nPlaced',
                                              isActive: currentStep >= 1,
                                            ),
                                            _buildStepItem(
                                              icon: Icons.store_rounded,
                                              label: 'Vendor\nAccepted',
                                              isActive: currentStep >= 2,
                                            ),
                                            _buildStepItem(
                                              icon: Icons.two_wheeler_rounded,
                                              label: 'Rider\nAssigned',
                                              isActive: currentStep >= 3,
                                            ),
                                            _buildStepItem(
                                              icon: Icons.local_shipping_rounded,
                                              label: 'Out for\nDelivery',
                                              isActive: currentStep >= 4,
                                            ),
                                            _buildStepItem(
                                              icon: Icons.check_circle_rounded,
                                              label: 'Delivered',
                                              isActive: currentStep >= 5,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                  ),

                const SizedBox(height: 30),

                // Radar Animation
                AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) {
                    return CustomPaint(
                      size: const Size(300, 300),
                      painter: RadarPainter(_controller.value, _mapImage),
                    );
                  },
                ),
                const SizedBox(height: 40),

                // Loading bar widget
                AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) {
                    return CustomPaint(
                      size: const Size(400, 60),
                      painter: LoadingBarPainter(_controller.value),
                    );
                  },
                ),
                const SizedBox(height: 40),

                // Done button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _orderStatusTimer?.cancel();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainLayout()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFF5931DD),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'DONE',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _orderStatusTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }
}

// ---------------- Progress Bar Widget ----------------
class CustomProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  
  const CustomProgressBar({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progressPercentage = currentStep / totalSteps;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background track with glow
          Container(
            height: 6,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
          
          // Progress line - Dynamic width with gradient and glow
          Positioned(
            left: 0,
            child: Container(
              height: 12,
              width: (MediaQuery.of(context).size.width - 80) * progressPercentage,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.greenAccent,
                    Colors.cyanAccent,
                    Colors.white,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.greenAccent.withOpacity(0.6),
                    blurRadius: 15,
                    spreadRadius: 2,
                    offset: Offset(0, 0),
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.8),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
            ),
          ),
          
          // Step indicators with enhanced styling
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(totalSteps, (index) {
              bool isCompleted = index < currentStep;
              bool isCurrent = index == currentStep - 1;
              
              return Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  gradient: isCompleted
                      ? LinearGradient(
                          colors: [
                            Colors.greenAccent,
                            Colors.cyanAccent,
                          ],
                        )
                      : null,
                  color: isCompleted ? null : Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isCompleted 
                        ? Colors.white 
                        : Colors.white.withOpacity(0.4),
                    width: 2.5,
                  ),
                  boxShadow: [
                    if (isCompleted)
                      BoxShadow(
                        color: isCurrent 
                            ? Colors.greenAccent.withOpacity(0.8)
                            : Colors.greenAccent.withOpacity(0.4),
                        blurRadius: isCurrent ? 15 : 8,
                        spreadRadius: isCurrent ? 3 : 1,
                        offset: Offset(0, 0),
                      ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.check_rounded,
                    size: 18,
                    color: isCompleted ? Colors.white : Colors.white.withOpacity(0.5),
                    shadows: isCompleted
                        ? [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: Offset(0, 1),
                              blurRadius: 2,
                            ),
                          ]
                        : [],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ---------------- Models (copied from your second file) ----------------
class OrderStatus {
  final String status;
  final String message;
  final DateTime timestamp;
  final String id;

  OrderStatus({
    required this.status,
    required this.message,
    required this.timestamp,
    required this.id,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) {
    return OrderStatus(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      timestamp: DateTime.parse(json['timestamp']),
      id: json['_id'] ?? '',
    );
  }
}

class Medicine {
  final String name;
  final double mrp;
  final String description;
  final List<String> images;
  final int quantity;

  Medicine({
    required this.name,
    required this.mrp,
    required this.description,
    required this.images,
    required this.quantity,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      name: json['name'] ?? '',
      mrp: (json['mrp'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      quantity: json['quantity'] ?? 0,
    );
  }
}

class OrderStatusResponse {
  final String message;
  final List<OrderStatus> statusTimeline;
  final String? deliveryNote;
  final List<Medicine> medicines;

  OrderStatusResponse({
    required this.message,
    required this.statusTimeline,
    this.deliveryNote,
    required this.medicines,
  });

  factory OrderStatusResponse.fromJson(Map<String, dynamic> json) {
    return OrderStatusResponse(
      message: json['message'] ?? '',
      statusTimeline: (json['statusTimeline'] as List<dynamic>?)
              ?.map((item) => OrderStatus.fromJson(item))
              .toList() ??
          [],
      deliveryNote: json['deliveryNote'],
      medicines: (json['medicines'] as List<dynamic>?)
              ?.map((item) => Medicine.fromJson(item))
              .toList() ??
          [],
    );
  }
}

// ---------------- API Service ----------------
class OrderStatusService {
  static const String baseUrl = 'http://31.97.206.144:7021/api/users';

  static Future<OrderStatusResponse?> getOrderStatus(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/order-status/$userId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

  


      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return OrderStatusResponse.fromJson(jsonData);
      } else {
        print('Failed to load order status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching order status: $e');
      return null;
    }
  }
}

class LoadingBarPainter extends CustomPainter {
  final double progress;

  LoadingBarPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final barWidth = size.width * 0.8;
    final barHeight = 20.0;
    final barLeft = (size.width - barWidth) / 2;
    final barTop = 0.0;

    final barRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(barLeft, barTop, barWidth, barHeight),
      const Radius.circular(20),
    );

    // Outer glow
    final glowPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(barLeft - 4, barTop - 4, barWidth + 8, barHeight + 8),
        const Radius.circular(24),
      ),
      glowPaint,
    );

    // Outer border (light gray)
    final borderPaint = Paint()
      ..color = const Color(0xFF555555)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawRRect(barRect, borderPaint);

    // Inner background (dark gray)
    final backgroundPaint = Paint()
      ..color = const Color(0xFF2a2a2a);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(barLeft + 3, barTop + 3, barWidth - 6, barHeight - 6),
        const Radius.circular(17),
      ),
      backgroundPaint,
    );

    // Loading progress fill - goes from 0% to 100% then resets
    final loopProgress = progress % 1.0;
    final fillWidth = (barWidth - 6) * loopProgress;

    if (fillWidth > 0) {
      // Green gradient fill
      final fillGradient = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          const Color(0xFF4CAF50),
          const Color(0xFF8BC34A),
          const Color(0xFFCDDC39),
        ],
      );

      final fillPaint = Paint()
        ..shader = fillGradient.createShader(
          Rect.fromLTWH(barLeft + 3, barTop + 3, fillWidth, barHeight - 6),
        );

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(barLeft + 3, barTop + 3, fillWidth, barHeight - 6),
          const Radius.circular(17),
        ),
        fillPaint,
      );

      // Bright glow at the end of the loading bar
      final glowPosition = barLeft + 3 + fillWidth - 30;
      final glowWidth = 60.0;

      final glowGradient = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.greenAccent.withOpacity(0.0),
          Colors.greenAccent.withOpacity(0.6),
          Colors.yellowAccent.withOpacity(0.9),
          Colors.greenAccent.withOpacity(0.6),
          Colors.greenAccent.withOpacity(0.0),
        ],
      );

      final glowFillPaint = Paint()
        ..shader = glowGradient.createShader(
          Rect.fromLTWH(glowPosition, barTop + 3, glowWidth, barHeight - 6),
        )
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(glowPosition, barTop + 3, glowWidth, barHeight - 6),
          const Radius.circular(17),
        ),
        glowFillPaint,
      );
    }

    // "LOADING..." text
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'LOADING...',
        style: TextStyle(
          color: Color(0xFF4a7a6a),
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 3,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.width - textPainter.width) / 2,
        barTop + barHeight + 10,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant LoadingBarPainter oldDelegate) => true;
}

class RadarPainter extends CustomPainter {
  final double progress;
  final ui.Image? mapImage;

  RadarPainter(this.progress, this.mapImage);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 4;

    // Clip to circle for map background
    canvas.save();
    canvas.clipPath(Path()..addOval(Rect.fromCircle(center: center, radius: radius)));

    if (mapImage != null) {
      // Draw actual map image
      final srcRect = Rect.fromLTWH(
        0,
        0,
        mapImage!.width.toDouble(),
        mapImage!.height.toDouble(),
      );
      final dstRect = Rect.fromCircle(center: center, radius: radius);

      canvas.drawImageRect(
        mapImage!,
        srcRect,
        dstRect,
        Paint()..filterQuality = FilterQuality.high,
      );
    } else {
      // Fallback gradient while image is loading
      final mapGradient = RadialGradient(
        center: Alignment.center,
        colors: [
          Color(0xFF1a3a1a),
          Color(0xFF0d1f0d),
        ],
      );

      final mapPaint = Paint()
        ..shader = mapGradient.createShader(
          Rect.fromCircle(center: center, radius: radius),
        );

      canvas.drawCircle(center, radius, mapPaint);
    }

    canvas.restore();

    // Outer circle
    final ringPaint = Paint()
      ..color = Colors.yellow.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, radius, ringPaint);

    // Center filled circle
    final centerPaint = Paint()
      ..color = Colors.green.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 8, centerPaint);

    // Rotating sweep gradient
    final sweepGradient = SweepGradient(
      startAngle: 0,
      endAngle: pi / 3,
      colors: [
        Colors.blue.withOpacity(0.0),
        Colors.blue.withOpacity(0.8),
      ],
    );

    final sweepPaint = Paint()
      ..shader = sweepGradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      );

    final sweepAngle = progress * 2 * pi;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(sweepAngle);
    canvas.translate(-center.dx, -center.dy);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      pi / 3,
      true,
      sweepPaint,
    );

    canvas.restore();

    // Glowing dot
    final dotAngle = progress * 2 * pi;
    final dotOffset = Offset(
      center.dx + cos(dotAngle) * radius * 0.6,
      center.dy + sin(dotAngle) * radius * 0.6,
    );

    final dotPaint = Paint()
      ..color = Colors.greenAccent
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    canvas.drawCircle(dotOffset, 6, dotPaint);
  }

  @override
  bool shouldRepaint(covariant RadarPainter oldDelegate) => true;
}