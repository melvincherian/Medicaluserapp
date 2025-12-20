// // import 'package:flutter/material.dart';
// // import 'package:medical_user_app/view/main_layout.dart';
// // import 'package:medical_user_app/widgets/progress_bar.dart';

// // class NotificationScreen extends StatefulWidget {
// //   const NotificationScreen({super.key});

// //   @override
// //   State<NotificationScreen> createState() => _NotificationScreenState();
// // }

// // class _NotificationScreenState extends State<NotificationScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         centerTitle: true,
// //         title: const Text(
// //           'Notifications',
// //           style: TextStyle(
// //               color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
// //         ),
// //         leading: InkWell(
// //           onTap: () => Navigator.pop(context),
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
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             Container(
// //               width: double.infinity,
// //               padding: const EdgeInsets.all(16),
// //               decoration: BoxDecoration(
// //                   color: Colors.white,
// //                   borderRadius: BorderRadius.circular(12),
// //                   border: Border.all(
// //                       width: 1,
// //                       color: const Color.fromARGB(255, 192, 192, 192))),
// //               child: Stack(
// //                 children: [
// //                   // Main Content Column
// //                   Column(
// //                     children: [
// //                       // Header Row
// //                       Row(
// //                         children: [
// //                           // App Icon and Order Status
// //                           Container(
// //                             width: 60,
// //                             height: 60,
// //                             decoration: BoxDecoration(
// //                               color: Colors.blue[50],
// //                               borderRadius: BorderRadius.circular(12),
// //                             ),
// //                             child: ClipRRect(
// //                               borderRadius: BorderRadius.circular(12),
// //                               child: Image.asset(
// //                                 "assets/tablet.png",
// //                                 width: 60,
// //                                 height: 60,
// //                                 fit: BoxFit.cover,
// //                               ),
// //                             ),
// //                           ),
// //                           const SizedBox(width: 8),
// //                           Text(
// //                             "Your Order will be\ndelivery in 10 min.",
// //                             style: TextStyle(
// //                               fontWeight: FontWeight.bold,
// //                               fontSize: 14,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       const SizedBox(height: 16),
// //                       // Progress Bar
// //                       CustomProgressBar(currentStep: 2, totalSteps: 3),
// //                       const SizedBox(height: 16),
// //                       // Order Status Icons
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                         children: [
// //                           // Order Placed
// //                           _buildStepItem(
// //                             imagePath: 'assets/icons/cart.png',
// //                             label: 'Order\nPlaced',
// //                           ),

// //                           // Order Pickup
// //                           _buildStepItem(
// //                             imagePath: 'assets/icons/pickup.png',
// //                             label: 'Order\nPickup',
// //                           ),

// //                           // Order Delivery (active)
// //                           _buildStepItem(
// //                             imagePath: 'assets/icons/order.png',
// //                             label: 'Order\nDelivery',
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                   // Updated Time Text - positioned at top right
// //                   Positioned(
// //                     top: 0,
// //                     right: 0,
// //                     child: Text(
// //                       "Updated 6 sec ago",
// //                       style: TextStyle(
// //                         fontSize: 12,
// //                         color: Colors.grey[600],
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             SizedBox(
// //               height: 30,
// //             ),
// //             _orderId(),
// //             const Spacer(),

// //             // Proceed button
// //             Padding(
// //               padding: const EdgeInsets.all(16),
// //               child: SizedBox(
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   onPressed: () {
// //                     Navigator.push(context,
// //                         MaterialPageRoute(builder: (context) => MainLayout()));
// //                   },
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Color(0XFF5931DD),
// //                     foregroundColor: Colors.white,
// //                     padding: const EdgeInsets.symmetric(vertical: 16),
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(12),
// //                     ),
// //                   ),
// //                   child: const Text(
// //                     'Go To Home',
// //                     style: TextStyle(
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildStepItem({
// //     required String imagePath,
// //     required String label,
// //   }) {
// //     return Column(
// //       children: [
// //         Container(
// //           width: 44,
// //           height: 44,
// //           padding: EdgeInsets.all(10),
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.circular(50),
// //             border: Border.all(
// //               color: Colors.grey.shade300,
// //               width: 2,
// //             ),
// //           ),
// //           child: Image.asset(
// //             imagePath,
// //             width: 24,
// //             height: 24,
// //           ),
// //         ),
// //         const SizedBox(height: 6),
// //         Text(
// //           label,
// //           textAlign: TextAlign.center,
// //           style: TextStyle(
// //             fontSize: 12,
// //             fontWeight: FontWeight.normal,
// //             color: Colors.grey[600],
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _orderId() {
// //     return Column(
// //       children: [
// //         Container(
// //           width: double.infinity,
// //           padding: const EdgeInsets.all(16),
// //           decoration: BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.circular(12),
// //               border: Border.all(
// //                   width: 1, color: const Color.fromARGB(255, 192, 192, 192))),
// //           child: Stack(
// //             children: [
// //               // Main Content Column
// //               Column(
// //                 children: [
// //                   // Header Row
// //                   Row(
// //                     children: [
// //                       // App Icon and Order Status
// //                       Container(
// //                         width: 60,
// //                         height: 60,
// //                         decoration: BoxDecoration(
// //                           color: Colors.blue[50],
// //                           borderRadius: BorderRadius.circular(12),
// //                         ),
// //                         child: ClipRRect(
// //                           borderRadius: BorderRadius.circular(12),
// //                           child: Image.asset(
// //                             "assets/tablet.png",
// //                             width: 60,
// //                             height: 60,
// //                             fit: BoxFit.cover,
// //                           ),
// //                         ),
// //                       ),
// //                       const SizedBox(width: 8),
// //                       Text(
// //                         "Your order ID:\n12345678943",
// //                         style: TextStyle(
// //                           fontWeight: FontWeight.bold,
// //                           fontSize: 16,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //               Positioned(
// //                 top: 0,
// //                 right: 0,
// //                 child: Column(
// //                   children: [
// //                     Text(
// //                       "6 sec ago",
// //                       style: TextStyle(
// //                         fontSize: 12,
// //                         color: Colors.grey[600],
// //                       ),
// //                     ),
// //                     Icon(Icons.keyboard_arrow_down)
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }


















// // import 'package:flutter/material.dart';
// // import 'package:medical_user_app/utils/shared_preferences_helper.dart';
// // import 'package:provider/provider.dart';
// // import 'package:medical_user_app/providers/notification_provider.dart';
// // import 'package:medical_user_app/widgets/progress_bar.dart';

// // class NotificationScreen extends StatefulWidget {
// //   const NotificationScreen({super.key});

// //   @override
// //   State<NotificationScreen> createState() => _NotificationScreenState();
// // }

// // class _NotificationScreenState extends State<NotificationScreen> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadNotifications();
// //   }

// //   Future<void> _loadNotifications() async {
// //     final user = await SharedPreferencesHelper.getUser();
// //     if (user != null) {
// //       Provider.of<NotificationProvider>(context, listen: false)
// //           .loadNotifications(user.id);
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         centerTitle: true,
// //         title: const Text(
// //           'Notifications',
// //           style: TextStyle(
// //               color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
// //         ),
// //         leading: InkWell(
// //           onTap: () => Navigator.pop(context),
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
// //       body: Consumer<NotificationProvider>(
// //         builder: (context, provider, child) {
// //           if (provider.isLoading) {
// //             return const Center(child: CircularProgressIndicator());
// //           }

// //           if (provider.error != null) {
// //             return Center(child: Text("Error: ${provider.error}"));
// //           }

// //           if (provider.notifications.isEmpty) {
// //             return const Center(child: Text("No notifications found."));
// //           }

// //           return ListView.builder(
// //             padding: const EdgeInsets.all(16),
// //             itemCount: provider.notifications.length,
// //             itemBuilder: (context, index) {
// //               final notification = provider.notifications[index];
// //               return Padding(
// //                 padding: const EdgeInsets.only(bottom: 16),
// //                 child: Container(
// //                   width: double.infinity,
// //                   padding: const EdgeInsets.all(16),
// //                   decoration: BoxDecoration(
// //                     color: Colors.white,
// //                     borderRadius: BorderRadius.circular(12),
// //                     border: Border.all(
// //                       width: 1,
// //                       color: const Color.fromARGB(255, 192, 192, 192),
// //                     ),
// //                   ),
// //                   child: Stack(
// //                     children: [
// //                       Column(
// //                         children: [
// //                           Row(
// //                             children: [
// //                               Container(
// //                                 width: 60,
// //                                 height: 60,
// //                                 decoration: BoxDecoration(
// //                                   color: Colors.blue[50],
// //                                   borderRadius: BorderRadius.circular(12),
// //                                 ),
// //                                 child: ClipRRect(
// //                                   borderRadius: BorderRadius.circular(12),
// //                                   child: Image.asset(
// //                                     "assets/tablet.png",
// //                                     width: 60,
// //                                     height: 60,
// //                                     fit: BoxFit.cover,
// //                                   ),
// //                                 ),
// //                               ),
// //                               const SizedBox(width: 8),
// //                               Expanded(
// //                                 child: Text(
// //                                   notification.message,
// //                                   style: const TextStyle(
// //                                     fontWeight: FontWeight.bold,
// //                                     fontSize: 14,
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                           const SizedBox(height: 16),
// //                           CustomProgressBar(
// //                             currentStep: _getStep(notification.status),
// //                             totalSteps: 3,
// //                           ),
// //                           const SizedBox(height: 16),
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                             children: [
// //                               _buildStepItem(
// //                                 imagePath: 'assets/icons/cart.png',
// //                                 label: 'Order\nPlaced',
// //                               ),
// //                               _buildStepItem(
// //                                 imagePath: 'assets/icons/pickup.png',
// //                                 label: 'Order\nPickup',
// //                               ),
// //                               _buildStepItem(
// //                                 imagePath: 'assets/icons/order.png',
// //                                 label: 'Order\nDelivery',
// //                               ),
// //                             ],
// //                           ),
// //                         ],
// //                       ),
// //                       Positioned(
// //                         top: 0,
// //                         right: 0,
// //                         child: Text(
// //                           _timeAgo(notification.timestamp),
// //                           style: TextStyle(
// //                             fontSize: 12,
// //                             color: Colors.grey[600],
// //                           ),
// //                         ),
                        
// //                       ),
                     
// //                     ],
// //                   ),
// //                 ),
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   Widget _buildStepItem({
// //     required String imagePath,
// //     required String label,
// //   }) {
// //     return Column(
// //       children: [
// //         Container(
// //           width: 44,
// //           height: 44,
// //           padding: const EdgeInsets.all(10),
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.circular(50),
// //             border: Border.all(
// //               color: Colors.grey.shade300,
// //               width: 2,
// //             ),
// //           ),
// //           child: Image.asset(
// //             imagePath,
// //             width: 24,
// //             height: 24,
// //           ),
// //         ),
// //         const SizedBox(height: 6),
// //         Text(
// //           label,
// //           textAlign: TextAlign.center,
// //           style: TextStyle(
// //             fontSize: 12,
// //             color: Colors.grey[600],
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   /// Map status string to step number
// //   int _getStep(String status) {
// //     switch (status.toLowerCase()) {
// //       case 'pending':
// //         return 1;
// //       case 'confirmed':
// //         return 2;
// //       case 'shipped':
// //         return 3;
// //       default:
// //         return 1;
// //     }
// //   }

// //   /// Helper to show "time ago" string
// //   String _timeAgo(DateTime dateTime) {
// //     final diff = DateTime.now().difference(dateTime);
// //     if (diff.inSeconds < 60) {
// //       return "${diff.inSeconds}s ago";
// //     } else if (diff.inMinutes < 60) {
// //       return "${diff.inMinutes}m ago";
// //     } else if (diff.inHours < 24) {
// //       return "${diff.inHours}h ago";
// //     } else {
// //       return "${diff.inDays}d ago";
// //     }
// //   }
// // }

















// import 'package:flutter/material.dart';
// import 'package:medical_user_app/utils/shared_preferences_helper.dart';
// import 'package:provider/provider.dart';
// import 'package:medical_user_app/providers/notification_provider.dart';
// import 'package:medical_user_app/widgets/progress_bar.dart';

// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});

//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _loadNotifications();
//   }

//   Future<void> _loadNotifications() async {
//     final user = await SharedPreferencesHelper.getUser();
//     if (user != null) {
//       Provider.of<NotificationProvider>(context, listen: false)
//           .loadNotifications(user.id);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text(
//           'Notifications',
//           style: TextStyle(
//               color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
//         ),
//         leading: InkWell(
//           onTap: () => Navigator.pop(context),
//           child: Container(
//             margin: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(color: Colors.grey.shade300),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: const Icon(Icons.arrow_back_ios_new, size: 18),
//           ),
//         ),
//       ),
//       body: Consumer<NotificationProvider>(
//         builder: (context, provider, child) {
//           if (provider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (provider.error != null) {
//             return Center(child: Text("Error: ${provider.error}"));
//           }

//           if (provider.notifications.isEmpty) {
//             return const Center(child: Text("No notifications found."));
//           }

//           return ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: provider.notifications.length,
//             itemBuilder: (context, index) {
//               final notification = provider.notifications[index];
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 16),
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(
//                       width: 1,
//                       color: const Color.fromARGB(255, 192, 192, 192),
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       // Order ID + Time Row
//                       Stack(
//                         children: [
//                           Row(
//                             children: [
//                               Container(
//                                 width: 60,
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   color: Colors.blue[50],
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(12),
//                                   child: Image.asset(
//                                     "assets/tablet.png",
//                                     width: 60,
//                                     height: 60,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               Expanded(
//                                 child: Text(
//                                   "Your order ID:\n${notification.orderId}",
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Positioned(
//                             top: 0,
//                             right: 0,
//                             child: Column(
//                               children: [
//                                 Text(
//                                   _timeAgo(notification.timestamp),
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.grey[600],
//                                   ),
//                                 ),
//                                 const Icon(Icons.keyboard_arrow_down),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),

//                       // Notification Message
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               notification.message,
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),

//                       // Progress Bar
//                       CustomProgressBar(
//                         currentStep: _getStep(notification.status),
//                         totalSteps: 3,
//                       ),
//                       const SizedBox(height: 16),

//                       // Steps Row
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           _buildStepItem(
//                             imagePath: 'assets/icons/cart.png',
//                             label: 'Order\nPlaced',
//                           ),
//                           _buildStepItem(
//                             imagePath: 'assets/icons/pickup.png',
//                             label: 'Order\nPickup',
//                           ),
//                           _buildStepItem(
//                             imagePath: 'assets/icons/order.png',
//                             label: 'Order\nDelivery',
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildStepItem({
//     required String imagePath,
//     required String label,
//   }) {
//     return Column(
//       children: [
//         Container(
//           width: 44,
//           height: 44,
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(50),
//             border: Border.all(
//               color: Colors.grey.shade300,
//               width: 2,
//             ),
//           ),
//           child: Image.asset(
//             imagePath,
//             width: 24,
//             height: 24,
//           ),
//         ),
//         const SizedBox(height: 6),
//         Text(
//           label,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.grey[600],
//           ),
//         ),
//       ],
//     );
//   }

//   /// Map status string to step number
//   int _getStep(String status) {
//     switch (status.toLowerCase()) {
//       case 'pending':
//         return 1;
//       case 'confirmed':
//         return 2;
//       case 'shipped':
//         return 3;
//       default:
//         return 1;
//     }
//   }

//   /// Helper to show "time ago" string
//   String _timeAgo(DateTime dateTime) {
//     final diff = DateTime.now().difference(dateTime);
//     if (diff.inSeconds < 60) {
//       return "${diff.inSeconds}s ago";
//     } else if (diff.inMinutes < 60) {
//       return "${diff.inMinutes}m ago";
//     } else if (diff.inHours < 24) {
//       return "${diff.inHours}h ago";
//     } else {
//       return "${diff.inDays}d ago";
//     }
//   }
// }

















// import 'package:flutter/material.dart';
// import 'package:medical_user_app/utils/shared_preferences_helper.dart';
// import 'package:provider/provider.dart';
// import 'package:medical_user_app/providers/notification_provider.dart';
// import 'package:medical_user_app/widgets/progress_bar.dart';

// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});

//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _loadNotifications();
//   }

//   Future<void> _loadNotifications() async {
//     final user = await SharedPreferencesHelper.getUser();
//     if (user != null) {
//       Provider.of<NotificationProvider>(context, listen: false)
//           .loadNotifications(user.id);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text(
//           'Notifications',
//           style: TextStyle(
//               color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
//         ),
//         leading: InkWell(
//           onTap: () => Navigator.pop(context),
//           child: Container(
//             margin: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(color: Colors.grey.shade300),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: const Icon(Icons.arrow_back_ios_new, size: 18),
//           ),
//         ),
//       ),
//       body: Consumer<NotificationProvider>(
//         builder: (context, provider, child) {
//           if (provider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (provider.error != null) {
//             return Center(child: Text("Error: ${provider.error}"));
//           }

//           if (provider.notifications.isEmpty) {
//             return const Center(child: Text("No notifications found."));
//           }

//           return ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: provider.notifications.length,
//             itemBuilder: (context, index) {
//               final notification = provider.notifications[index];
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 16),
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(
//                       width: 1,
//                       color: const Color.fromARGB(255, 192, 192, 192),
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       // Order ID + Time Row
//                       Stack(
//                         children: [
//                           Row(
//                             children: [
//                               Container(
//                                 width: 60,
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   color: Colors.blue[50],
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(12),
//                                   child: Image.asset(
//                                     "assets/tablet.png",
//                                     width: 60,
//                                     height: 60,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               Expanded(
//                                 child: Text(
//                                   "Your order ID:\n${notification.orderId}",
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Positioned(
//                             top: 0,
//                             right: 0,
//                             child: Column(
//                               children: [
//                                 Text(
//                                   _timeAgo(notification.timestamp),
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.grey[600],
//                                   ),
//                                 ),
//                                 const Icon(Icons.keyboard_arrow_down),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),

//                       // Notification Message
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               notification.message,
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),

//                       // Dynamic Progress Bar (same as OrderWidget)
//                       CustomProgressBar(
//                         currentStep: _getStepFromStatus(notification.status),
//                         totalSteps: 4,
//                       ),
//                       const SizedBox(height: 16),

//                       // Steps Row (matching OrderWidget with 4 steps)
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           _buildStepItem(
//                             icon: Icons.shopping_cart,
//                             label: 'Order Placed',
//                             isActive: _getStepFromStatus(notification.status) >= 1,
//                           ),
//                           _buildStepItem(
//                             icon: Icons.check_circle_outline,
//                             label: 'Rider Accepted',
//                             isActive: _getStepFromStatus(notification.status) >= 2,
//                           ),
//                           _buildStepItem(
//                             icon: Icons.local_shipping,
//                             label: 'Out for Delivery',
//                             isActive: _getStepFromStatus(notification.status) >= 3,
//                           ),
//                           _buildStepItem(
//                             icon: Icons.check_circle,
//                             label: 'Delivered',
//                             isActive: _getStepFromStatus(notification.status) >= 4,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

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

//   /// Map status string to step number (matching OrderWidget logic)
//   int _getStepFromStatus(String status) {
//     final statusLower = status.toLowerCase();
    
//     // Check for delivered/completed - Step 4 (final)
//     if (statusLower.contains('delivered') || 
//         statusLower.contains('completed')) {
//       return 4;
//     }
    
//     // Check for picked up - Step 3
//     if (statusLower.contains('pickedup') || 
//         statusLower.contains('picked up') ||
//         statusLower.contains('pickup')) {
//       return 3;
//     }
    
//     // Check for accepted - Step 2
//     if (statusLower.contains('accepted') ||
//         statusLower.contains('confirmed')) {
//       return 2;
//     }
    
//     // Check for pending/placed/rider assigned - Step 1
//     if (statusLower.contains('pending') || 
//         statusLower.contains('placed') ||
//         statusLower.contains('rider assigned') ||
//         statusLower.contains('assigned')) {
//       return 1;
//     }
    
//     return 1; // Default to first step
//   }

//   /// Helper to show "time ago" string
//   String _timeAgo(DateTime dateTime) {
//     final diff = DateTime.now().difference(dateTime);
//     if (diff.inSeconds < 60) {
//       return "${diff.inSeconds}s ago";
//     } else if (diff.inMinutes < 60) {
//       return "${diff.inMinutes}m ago";
//     } else if (diff.inHours < 24) {
//       return "${diff.inHours}h ago";
//     } else {
//       return "${diff.inDays}d ago";
//     }
//   }
// }













import 'package:flutter/material.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';
import 'package:provider/provider.dart';
import 'package:medical_user_app/providers/notification_provider.dart';
import 'package:medical_user_app/widgets/progress_bar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final user = await SharedPreferencesHelper.getUser();
    if (user != null) {
      Provider.of<NotificationProvider>(context, listen: false)
          .loadNotifications(user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.arrow_back_ios_new, size: 18),
          ),
        ),
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text("Please Provide Internet Connection"));
          }

          if (provider.notifications.isEmpty) {
            return const Center(child: Text("No notifications found."));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.notifications.length,
            itemBuilder: (context, index) {
              final notification = provider.notifications[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: const Color.fromARGB(255, 192, 192, 192),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Order ID + Time Row
                      Stack(
                        children: [
                          Row(
                            children: [
                              // Container(
                              //   width: 60,
                              //   height: 60,
                              //   decoration: BoxDecoration(
                              //     color: Colors.blue[50],
                              //     borderRadius: BorderRadius.circular(12),
                              //   ),
                              //   child: ClipRRect(
                              //     borderRadius: BorderRadius.circular(12),
                              //     child: Image.asset(
                              //       "assets/tablet.png",
                              //       width: 60,
                              //       height: 60,
                              //       fit: BoxFit.cover,
                              //     ),
                              //   ),
                              // ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "Your order ID:\n${notification.orderId}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Column(
                              children: [
                                Text(
                                  _timeAgo(notification.timestamp),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                // const Icon(Icons.keyboard_arrow_down),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Notification Message
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              notification.message,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Dynamic Progress Bar (updated to 5 steps)
                      CustomProgressBar(
                        currentStep: _getStepFromStatus(notification.status),
                        totalSteps: 5,
                      ),
                      const SizedBox(height: 16),

                      // Steps Row (updated to 5 steps matching OrderStatusWidget)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildStepItem(
                            icon: Icons.shopping_cart,
                            label: 'Order\nPlaced',
                            isActive: _getStepFromStatus(notification.status) >= 1,
                          ),
                          _buildStepItem(
                            icon: Icons.store,
                            label: 'Vendor\nAccepted',
                            isActive: _getStepFromStatus(notification.status) >= 2,
                          ),
                          _buildStepItem(
                            icon: Icons.two_wheeler,
                            label: 'Rider\nAccepted',
                            isActive: _getStepFromStatus(notification.status) >= 3,
                          ),
                          _buildStepItem(
                            icon: Icons.local_shipping,
                            label: 'Out for\nDelivery',
                            isActive: _getStepFromStatus(notification.status) >= 4,
                          ),
                          _buildStepItem(
                            icon: Icons.check_circle,
                            label: 'Delivered',
                            isActive: _getStepFromStatus(notification.status) >= 5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
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

  /// Map status string to step number (matching OrderStatusWidget logic with 5 steps)
  int _getStepFromStatus(String status) {
    final statusLower = status.toLowerCase();
    
    // Step 5: Delivered
    if (statusLower.contains('delivered') || 
        statusLower.contains('completed')) {
      return 5;
    }
    
    // Step 4: Out for Delivery
    if (statusLower.contains('out for delivery') ||
        statusLower.contains('pickedup') || 
        statusLower.contains('picked up')) {
      return 4;
    }
    
    // Step 3: Rider Accepted
    if (statusLower.contains('rider accepted')) {
      return 3;
    }
    
    // Step 2: Vendor Accepted
    if (statusLower.contains('vendor accepted') ||
        (statusLower.contains('accepted') && !statusLower.contains('rider'))) {
      return 2;
    }
    
    // Step 1: Order Placed
    if (statusLower.contains('pending') || 
        statusLower.contains('placed') ||
        statusLower.contains('rider assigned') ||
        statusLower.contains('assigned')) {
      return 1;
    }
    
    return 1; // Default to first step
  }

  /// Helper to show "time ago" string
  String _timeAgo(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    if (diff.inSeconds < 60) {
      return "${diff.inSeconds}s ago";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes}m ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours}h ago";
    } else {
      return "${diff.inDays}d ago";
    }
  }
}