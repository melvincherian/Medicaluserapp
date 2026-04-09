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

// //   Future<void> _deleteNotification(String notificationId) async {
// //     final user = await SharedPreferencesHelper.getUser();
// //     if (user == null) return;

// //     final confirmed = await showDialog<bool>(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         title: const Text('Delete Notification'),
// //         content:
// //             const Text('Are you sure you want to delete this notification?'),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(context, false),
// //             child: const Text('Cancel'),
// //           ),
// //           TextButton(
// //             onPressed: () => Navigator.pop(context, true),
// //             style: TextButton.styleFrom(foregroundColor: Colors.red),
// //             child: const Text('Delete'),
// //           ),
// //         ],
// //       ),
// //     );

// //     if (confirmed != true) return;

// //     showDialog(
// //       context: context,
// //       barrierDismissible: false,
// //       builder: (context) => const Center(child: CircularProgressIndicator()),
// //     );

// //     try {
// //       final provider =
// //           Provider.of<NotificationProvider>(context, listen: false);
// //       bool success = await provider.deleteNotification(user.id, notificationId);

// //       Navigator.pop(context);

// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text(success
// //               ? 'Notification deleted successfully'
// //               : 'Failed to delete notification'),
// //           backgroundColor: success ? Colors.green : Colors.red,
// //         ),
// //       );
// //     } catch (e) {
// //       Navigator.pop(context);
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('Error: ${e.toString()}'),
// //           backgroundColor: Colors.red,
// //         ),
// //       );
// //     }
// //   }

// //   Future<void> _deleteAllNotifications() async {
// //     final user = await SharedPreferencesHelper.getUser();
// //     if (user == null) return;

// //     final provider =
// //         Provider.of<NotificationProvider>(context, listen: false);

// //     if (provider.notifications.isEmpty) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(
// //           content: Text('No notifications to delete'),
// //           backgroundColor: Colors.orange,
// //         ),
// //       );
// //       return;
// //     }

// //     final confirmed = await showDialog<bool>(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// //         title: const Text(
// //           'Delete All Notifications',
// //           style: TextStyle(fontWeight: FontWeight.bold),
// //         ),
// //         content: const Text(
// //           'Are you sure you want to delete all notifications? This action cannot be undone.',
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(context, false),
// //             child: const Text('Cancel'),
// //           ),
// //           ElevatedButton(
// //             onPressed: () => Navigator.pop(context, true),
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Colors.red,
// //               foregroundColor: Colors.white,
// //               shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(8)),
// //             ),
// //             child: const Text('Delete All'),
// //           ),
// //         ],
// //       ),
// //     );

// //     if (confirmed != true) return;

// //     showDialog(
// //       context: context,
// //       barrierDismissible: false,
// //       builder: (context) => const Center(child: CircularProgressIndicator()),
// //     );

// //     try {
// //       final success = await provider.deleteAllNotifications(user.id);

// //       Navigator.pop(context);

// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text(success
// //               ? 'All notifications deleted successfully'
// //               : 'Failed to delete all notifications'),
// //           backgroundColor: success ? Colors.green : Colors.red,
// //         ),
// //       );
// //     } catch (e) {
// //       Navigator.pop(context);
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('Error: ${e.toString()}'),
// //           backgroundColor: Colors.red,
// //         ),
// //       );
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
// //         actions: [
// //           Consumer<NotificationProvider>(
// //             builder: (context, provider, _) {
// //               if (provider.notifications.isEmpty) return const SizedBox();
// //               return Padding(
// //                 padding: const EdgeInsets.only(right: 12),
// //                 child: TextButton.icon(
// //                   onPressed: _deleteAllNotifications,
// //                   icon: const Icon(Icons.delete_sweep,
// //                       color: Colors.red, size: 20),
// //                   label: const Text(
// //                     'Clear All',
// //                     style: TextStyle(
// //                       color: Colors.red,
// //                       fontWeight: FontWeight.w600,
// //                       fontSize: 13,
// //                     ),
// //                   ),
// //                 ),
// //               );
// //             },
// //           ),
// //         ],
// //       ),
// //       body: Consumer<NotificationProvider>(
// //         builder: (context, provider, child) {
// //           if (provider.isLoading) {
// //             return const Center(child: CircularProgressIndicator());
// //           }

// //           if (provider.error != null) {
// //             return const Center(
// //                 child: Text("Please Provide Internet Connection"));
// //           }

// //           if (provider.notifications.isEmpty) {
// //             return const Center(child: Text("No notifications found."));
// //           }

// //           return ListView.builder(
// //             padding: const EdgeInsets.all(16),
// //             itemCount: provider.notifications.length,
// //             itemBuilder: (context, index) {
// //               final notification = provider.notifications[index];

// //               // ✅ Pass BOTH status and message for accurate step detection
// //               final step = _getStepFromStatusAndMessage(
// //                 notification.status,
// //                 notification.message,
// //               );

// //               return Dismissible(
// //                 key: Key(notification.id),
// //                 direction: DismissDirection.endToStart,
// //                 confirmDismiss: (direction) async {
// //                   return await showDialog<bool>(
// //                     context: context,
// //                     builder: (context) => AlertDialog(
// //                       title: const Text('Delete Notification'),
// //                       content: const Text(
// //                           'Are you sure you want to delete this notification?'),
// //                       actions: [
// //                         TextButton(
// //                           onPressed: () => Navigator.pop(context, false),
// //                           child: const Text('Cancel'),
// //                         ),
// //                         TextButton(
// //                           onPressed: () => Navigator.pop(context, true),
// //                           style: TextButton.styleFrom(
// //                               foregroundColor: Colors.red),
// //                           child: const Text('Delete'),
// //                         ),
// //                       ],
// //                     ),
// //                   );
// //                 },
// //                 onDismissed: (direction) async {
// //                   final user = await SharedPreferencesHelper.getUser();
// //                   if (user != null) {
// //                     await provider.deleteNotification(
// //                         user.id, notification.id);
// //                   }
// //                 },
// //                 background: Container(
// //                   alignment: Alignment.centerRight,
// //                   padding: const EdgeInsets.only(right: 20),
// //                   decoration: BoxDecoration(
// //                     color: Colors.red,
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                   child:
// //                       const Icon(Icons.delete, color: Colors.white, size: 30),
// //                 ),
// //                 child: Padding(
// //                   padding: const EdgeInsets.only(bottom: 16),
// //                   child: Container(
// //                     width: double.infinity,
// //                     padding: const EdgeInsets.all(16),
// //                     decoration: BoxDecoration(
// //                       color: Colors.white,
// //                       borderRadius: BorderRadius.circular(12),
// //                       border: Border.all(
// //                         width: 1,
// //                         color: const Color.fromARGB(255, 192, 192, 192),
// //                       ),
// //                     ),
// //                     child: Column(
// //                       children: [
// //                         Stack(
// //                           children: [
// //                             Row(
// //                               children: [
// //                                 const SizedBox(width: 8),
// //                                 Expanded(
// //                                   child: Text(
// //                                     "Your order ID:\n${notification.orderId}",
// //                                     style: const TextStyle(
// //                                       fontWeight: FontWeight.bold,
// //                                       fontSize: 16,
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                             Positioned(
// //                               top: 0,
// //                               right: 0,
// //                               child: Row(
// //                                 children: [
// //                                   Text(
// //                                     _timeAgo(notification.timestamp),
// //                                     style: TextStyle(
// //                                       fontSize: 12,
// //                                       color: Colors.grey[600],
// //                                     ),
// //                                   ),
// //                                   const SizedBox(width: 8),
// //                                   InkWell(
// //                                     onTap: () =>
// //                                         _deleteNotification(notification.id),
// //                                     child: Container(
// //                                       padding: const EdgeInsets.all(6),
// //                                       decoration: BoxDecoration(
// //                                         color: Colors.red.shade50,
// //                                         borderRadius:
// //                                             BorderRadius.circular(6),
// //                                       ),
// //                                       child: const Icon(
// //                                         Icons.delete_outline,
// //                                         color: Colors.red,
// //                                         size: 20,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                         const SizedBox(height: 16),
// //                         Row(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Expanded(
// //                               child: Text(
// //                                 notification.message,
// //                                 style: const TextStyle(
// //                                   fontWeight: FontWeight.w500,
// //                                   fontSize: 14,
// //                                 ),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                         const SizedBox(height: 16),
// //                         CustomProgressBar(
// //                           currentStep: step,
// //                           totalSteps: 5,
// //                         ),
// //                         const SizedBox(height: 16),
// //                         Row(
// //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                           children: [
// //                             _buildStepItem(
// //                               icon: Icons.shopping_cart,
// //                               label: 'Order\nPlaced',
// //                               isActive: step >= 1,
// //                             ),
// //                             _buildStepItem(
// //                               icon: Icons.store,
// //                               label: 'Vendor\nAccepted',
// //                               isActive: step >= 2,
// //                             ),
// //                             _buildStepItem(
// //                               icon: Icons.two_wheeler,
// //                               label: 'Rider\nAccepted',
// //                               isActive: step >= 3,
// //                             ),
// //                             _buildStepItem(
// //                               icon: Icons.local_shipping,
// //                               label: 'Out for\nDelivery',
// //                               isActive: step >= 4,
// //                             ),
// //                             _buildStepItem(
// //                               icon: Icons.check_circle,
// //                               label: 'Delivered',
// //                               isActive: step >= 5,
// //                             ),
// //                           ],
// //                         ),
// //                       ],
// //                     ),
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
// //     required IconData icon,
// //     required String label,
// //     required bool isActive,
// //   }) {
// //     return Column(
// //       children: [
// //         Container(
// //           width: 40,
// //           height: 40,
// //           decoration: BoxDecoration(
// //             color: isActive ? Colors.blue[50] : Colors.grey[50],
// //             borderRadius: BorderRadius.circular(20),
// //             border: Border.all(
// //               color: isActive ? Colors.blue : Colors.grey.shade300,
// //               width: 2,
// //             ),
// //           ),
// //           child: Icon(
// //             icon,
// //             color: isActive ? Colors.blue : Colors.grey[600],
// //             size: 20,
// //           ),
// //         ),
// //         const SizedBox(height: 4),
// //         SizedBox(
// //           width: 50,
// //           child: Text(
// //             label,
// //             textAlign: TextAlign.center,
// //             style: TextStyle(
// //               fontSize: 9,
// //               fontWeight: FontWeight.normal,
// //               color: isActive ? Colors.blue : Colors.grey[600],
// //               height: 1.2,
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   int _getStepFromStatusAndMessage(String status, String message) {
// //     final s = status.toLowerCase().trim();
// //     final m = message.toLowerCase().trim();

// //     // ✅ Step 5: Delivered / Completed — check both fields
// //     if (s.contains('delivered') ||
// //         s.contains('completed') ||
// //         m.contains('delivered') ||
// //         m.contains('order has been delivered') ||
// //         m.contains('successfully delivered') ||
// //         m.contains('completed')) {
// //       return 5;
// //     }

// //     // Step 4: Out for Delivery / Picked Up — check both fields
// //     if (s.contains('out for delivery') ||
// //         s.contains('pickedup') ||
// //         s.contains('picked up') ||
// //         m.contains('out for delivery') ||
// //         m.contains('pickedup') ||
// //         m.contains('picked up')) {
// //       return 4;
// //     }

// //     // Step 3: Rider Accepted — check both fields
// //     if (s.contains('rider accepted') ||
// //         s.contains('rider updated status to accepted') ||
// //         m.contains('rider accepted') ||
// //         m.contains('rider updated status to accepted')) {
// //       return 3;
// //     }

// //     // Step 2: Vendor Accepted — check both fields
// //     if (s.contains('vendor accepted') ||
// //         (s.contains('accepted') && !s.contains('rider')) ||
// //         m.contains('vendor accepted') ||
// //         (m.contains('accepted') && !m.contains('rider'))) {
// //       return 2;
// //     }

// //     // Step 1: Order Placed / Pending / Assigned
// //     if (s.contains('pending') ||
// //         s.contains('placed') ||
// //         s.contains('rider assigned') ||
// //         s.contains('assigned') ||
// //         m.contains('pending') ||
// //         m.contains('placed') ||
// //         m.contains('assigned')) {
// //       return 1;
// //     }

// //     return 1; // default
// //   }

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
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class _OrderStatusApi {
//   static const String _base = 'http://31.97.206.144:7021/api/users';

//   static Future<String?> latestStatus(String orderId) async {
//     try {
//       final uri = Uri.parse('$_base/order-status/$orderId');
//       final res = await http
//           .get(uri, headers: {'Content-Type': 'application/json'})
//           .timeout(const Duration(seconds: 10));

//       if (res.statusCode != 200) return null;

//       final json = jsonDecode(res.body) as Map<String, dynamic>;
//       final timeline = json['statusTimeline'] as List<dynamic>?;
//       if (timeline == null || timeline.isEmpty) return null;

//       // ✅ Last item = most recent status
//       final last = timeline.last as Map<String, dynamic>;
//       return (last['status'] ?? '').toString().trim();
//     } catch (_) {
//       return null;
//     }
//   }
// }

// int _resolveStep(String apiStatus) {
//   switch (apiStatus.toLowerCase().trim()) {
//     case 'delivered':
//     case 'completed':
//       return 5;
//     case 'picked up':
//     case 'pickedup':
//     case 'out for delivery':
//       return 4;
//     case 'rider assigned':
//     case 'rider accepted':
//       return 3;
//     case 'accepted':
//     case 'vendor accepted':
//       return 2;
//     case 'pending':
//     case 'placed':
//     default:
//       return 1;
//   }
// }

// // ─────────────────────────────────────────────
// // Notification Screen
// // ─────────────────────────────────────────────
// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});

//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   /// Cache: orderId → resolved step from live API
//   final Map<String, int> _liveStepCache = {};
//   bool _isFetchingLive = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadNotifications();
//   }

//   Future<void> _loadNotifications() async {
//     final user = await SharedPreferencesHelper.getUser();
//     if (user != null && mounted) {
//       await Provider.of<NotificationProvider>(context, listen: false)
//           .loadNotifications(user.id);
//       await _fetchLiveSteps();
//     }
//   }

//   /// For every unique orderId, fetch the latest status from API.
//   Future<void> _fetchLiveSteps() async {
//     if (!mounted) return;
//     setState(() => _isFetchingLive = true);

//     final provider =
//         Provider.of<NotificationProvider>(context, listen: false);
//     final orderIds =
//         provider.notifications.map((n) => n.orderId).toSet();

//     for (final orderId in orderIds) {
//       final status = await _OrderStatusApi.latestStatus(orderId);
//       if (status != null && mounted) {
//         setState(() {
//           _liveStepCache[orderId] = _resolveStep(status);
//         });
//       }
//     }

//     if (mounted) setState(() => _isFetchingLive = false);
//   }

//   // ── Delete helpers ───────────────────────────────────────────────────────

//   Future<void> _deleteNotification(String notificationId) async {
//     final user = await SharedPreferencesHelper.getUser();
//     if (user == null) return;

//     final confirmed = await _confirmDialog(
//       title: 'Delete Notification',
//       content: 'Are you sure you want to delete this notification?',
//     );
//     if (confirmed != true) return;

//     _showLoader();
//     try {
//       final provider =
//           Provider.of<NotificationProvider>(context, listen: false);
//       final success =
//           await provider.deleteNotification(user.id, notificationId);
//       if (mounted) Navigator.pop(context);
//       _showSnack(
//         success ? 'Notification deleted successfully' : 'Failed to delete',
//         success ? Colors.green : Colors.red,
//       );
//     } catch (e) {
//       if (mounted) Navigator.pop(context);
//       _showSnack('Error: ${e.toString()}', Colors.red);
//     }
//   }

//   Future<void> _deleteAllNotifications() async {
//     final user = await SharedPreferencesHelper.getUser();
//     if (user == null) return;

//     final provider =
//         Provider.of<NotificationProvider>(context, listen: false);

//     if (provider.notifications.isEmpty) {
//       _showSnack('No notifications to delete', Colors.orange);
//       return;
//     }

//     final confirmed = await _confirmDialog(
//       title: 'Delete All Notifications',
//       content:
//           'Are you sure you want to delete all notifications? This action cannot be undone.',
//       confirmLabel: 'Delete All',
//     );
//     if (confirmed != true) return;

//     _showLoader();
//     try {
//       final success = await provider.deleteAllNotifications(user.id);
//       if (mounted) Navigator.pop(context);
//       _showSnack(
//         success
//             ? 'All notifications deleted successfully'
//             : 'Failed to delete all notifications',
//         success ? Colors.green : Colors.red,
//       );
//     } catch (e) {
//       if (mounted) Navigator.pop(context);
//       _showSnack('Error: ${e.toString()}', Colors.red);
//     }
//   }

//   // ── Utility ──────────────────────────────────────────────────────────────

//   Future<bool?> _confirmDialog({
//     required String title,
//     required String content,
//     String confirmLabel = 'Delete',
//   }) {
//     return showDialog<bool>(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title:
//             Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//         content: Text(content),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx, false),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () => Navigator.pop(ctx, true),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red,
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8)),
//             ),
//             child: Text(confirmLabel),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showLoader() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => const Center(child: CircularProgressIndicator()),
//     );
//   }

//   void _showSnack(String msg, Color bg) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(msg), backgroundColor: bg),
//     );
//   }

//   String _timeAgo(DateTime dateTime) {
//     final diff = DateTime.now().difference(dateTime);
//     if (diff.inSeconds < 60) return '${diff.inSeconds}s ago';
//     if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
//     if (diff.inHours < 24) return '${diff.inHours}h ago';
//     return '${diff.inDays}d ago';
//   }

//   // ── Build ────────────────────────────────────────────────────────────────

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         title: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               'Notifications',
//               style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20),
//             ),
//             // Small spinner while fetching live statuses
//             if (_isFetchingLive) ...[
//               const SizedBox(width: 8),
//               const SizedBox(
//                 width: 14,
//                 height: 14,
//                 child: CircularProgressIndicator(strokeWidth: 2),
//               ),
//             ],
//           ],
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
//         actions: [
//           Consumer<NotificationProvider>(
//             builder: (context, provider, _) {
//               if (provider.notifications.isEmpty) return const SizedBox();
//               return Padding(
//                 padding: const EdgeInsets.only(right: 12),
//                 child: TextButton.icon(
//                   onPressed: _deleteAllNotifications,
//                   icon: const Icon(Icons.delete_sweep,
//                       color: Colors.red, size: 20),
//                   label: const Text(
//                     'Clear All',
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 13,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Consumer<NotificationProvider>(
//         builder: (context, provider, child) {
//           if (provider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (provider.error != null) {
//             return const Center(
//                 child: Text('Please Provide Internet Connection'));
//           }

//           if (provider.notifications.isEmpty) {
//             return const Center(child: Text('No notifications found.'));
//           }

//           return RefreshIndicator(
//             onRefresh: _loadNotifications,
//             child: ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: provider.notifications.length,
//               itemBuilder: (context, index) {
//                 final notification = provider.notifications[index];

//                 // ✅ Live API step takes priority over local status field
//                 final step = _liveStepCache[notification.orderId] ??
//                     _resolveStep(notification.status);

//                 return Dismissible(
//                   key: Key(notification.id),
//                   direction: DismissDirection.endToStart,
//                   confirmDismiss: (_) => _confirmDialog(
//                     title: 'Delete Notification',
//                     content:
//                         'Are you sure you want to delete this notification?',
//                   ),
//                   onDismissed: (_) async {
//                     final user = await SharedPreferencesHelper.getUser();
//                     if (user != null) {
//                       await provider.deleteNotification(
//                           user.id, notification.id);
//                     }
//                   },
//                   background: Container(
//                     alignment: Alignment.centerRight,
//                     padding: const EdgeInsets.only(right: 20),
//                     decoration: BoxDecoration(
//                       color: Colors.red,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Icon(Icons.delete,
//                         color: Colors.white, size: 30),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(bottom: 16),
//                     child: _NotificationCard(
//                       notification: notification,
//                       step: step,
//                       onDelete: () =>
//                           _deleteNotification(notification.id),
//                       timeAgo: _timeAgo(notification.timestamp),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────
// // Notification Card
// // ─────────────────────────────────────────────
// class _NotificationCard extends StatelessWidget {
//   final dynamic notification;
//   final int step;
//   final VoidCallback onDelete;
//   final String timeAgo;

//   const _NotificationCard({
//     required this.notification,
//     required this.step,
//     required this.onDelete,
//     required this.timeAgo,
//   });

//   String get _statusLabel {
//     switch (step) {
//       case 5:
//         return 'Delivered ✓';
//       case 4:
//         return 'Out for Delivery';
//       case 3:
//         return 'Rider Assigned';
//       case 2:
//         return 'Vendor Accepted';
//       default:
//         return 'Order Placed';
//     }
//   }

//   Color get _statusColor {
//     switch (step) {
//       case 5:
//         return Colors.green;
//       case 4:
//         return Colors.orange;
//       case 3:
//         return Colors.blue;
//       case 2:
//         return Colors.indigo;
//       default:
//         return Colors.grey;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           width: 1,
//           color: const Color.fromARGB(255, 192, 192, 192),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ── Header ──
//           Stack(
//             children: [
//               Row(
//                 children: [
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       'Order ID:\n${notification.orderId}',
//                       style: const TextStyle(
//                           fontWeight: FontWeight.bold, fontSize: 16),
//                     ),
//                   ),
//                 ],
//               ),
//               Positioned(
//                 top: 0,
//                 right: 0,
//                 child: Row(
//                   children: [
//                     Text(timeAgo,
//                         style: TextStyle(
//                             fontSize: 12, color: Colors.grey[600])),
//                     const SizedBox(width: 8),
//                     InkWell(
//                       onTap: onDelete,
//                       child: Container(
//                         padding: const EdgeInsets.all(6),
//                         decoration: BoxDecoration(
//                           color: Colors.red.shade50,
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                         child: const Icon(Icons.delete_outline,
//                             color: Colors.red, size: 20),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 12),

//           // ── Message ──
//           Text(
//             notification.message,
//             style:
//                 const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
//           ),

//           const SizedBox(height: 8),

//           // ── Live status badge ──
//           Container(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//             decoration: BoxDecoration(
//               color: _statusColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(color: _statusColor.withOpacity(0.4)),
//             ),
//             child: Text(
//               _statusLabel,
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//                 color: _statusColor,
//               ),
//             ),
//           ),

//           const SizedBox(height: 16),

//           // ── Progress bar ──
//           CustomProgressBar(currentStep: step, totalSteps: 5),

//           const SizedBox(height: 16),

//           // ── Step icons ──
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _StepItem(
//                   icon: Icons.shopping_cart,
//                   label: 'Order\nPlaced',
//                   isActive: step >= 1),
//               _StepItem(
//                   icon: Icons.store,
//                   label: 'Vendor\nAccepted',
//                   isActive: step >= 2),
//               _StepItem(
//                   icon: Icons.two_wheeler,
//                   label: 'Rider\nAssigned',
//                   isActive: step >= 3),
//               _StepItem(
//                   icon: Icons.local_shipping,
//                   label: 'Out for\nDelivery',
//                   isActive: step >= 4),
//               _StepItem(
//                   icon: Icons.check_circle,
//                   label: 'Delivered',
//                   isActive: step >= 5),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────
// // Step icon widget
// // ─────────────────────────────────────────────
// class _StepItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final bool isActive;

//   const _StepItem({
//     required this.icon,
//     required this.label,
//     required this.isActive,
//   });

//   @override
//   Widget build(BuildContext context) {
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
//           child: Icon(icon,
//               color: isActive ? Colors.blue : Colors.grey[600], size: 20),
//         ),
//         const SizedBox(height: 4),
//         SizedBox(
//           width: 50,
//           child: Text(
//             label,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 9,
//               color: isActive ? Colors.blue : Colors.grey[600],
//               height: 1.2,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:medical_user_app/utils/shared_preferences_helper.dart';
// import 'package:provider/provider.dart';
// import 'package:medical_user_app/providers/notification_provider.dart';
// import 'package:medical_user_app/widgets/progress_bar.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class _OrderStatusApi {
//   static const String _base = 'http://31.97.206.144:7021/api/users';

//   static Future<String?> latestStatus(String orderId) async {
//     try {
//       final uri = Uri.parse('$_base/order-status/$orderId');
//       final res = await http
//           .get(uri, headers: {'Content-Type': 'application/json'})
//           .timeout(const Duration(seconds: 10));

//       if (res.statusCode != 200) return null;

//       final json = jsonDecode(res.body) as Map<String, dynamic>;
//       final timeline = json['statusTimeline'] as List<dynamic>?;
//       if (timeline == null || timeline.isEmpty) return null;

//       final last = timeline.last as Map<String, dynamic>;
//       return (last['status'] ?? '').toString().trim();
//     } catch (_) {
//       return null;
//     }
//   }
// }

// // ✅ FIXED: Added all possible API status variants
// int _resolveStep(String apiStatus) {
//   switch (apiStatus.toLowerCase().trim()) {
//     case 'delivered':
//     case 'completed':
//     case 'complete':
//       return 5;
//     case 'picked up':
//     case 'pickedup':
//     case 'out for delivery':
//     case 'outfordelivery':
//       return 4;
//     case 'rider assigned':
//     case 'riderassigned':
//     case 'rider accepted':
//     case 'rideraccepted':
//       return 3;
//     case 'accepted':
//     case 'vendor accepted':
//     case 'vendoraccepted':
//       return 2;
//     case 'pending':
//     case 'placed':
//     default:
//       return 1;
//   }
// }

// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});

//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   final Map<String, int> _liveStepCache = {};
//   bool _isFetchingLive = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadNotifications();
//   }

//   Future<void> _loadNotifications() async {
//     final user = await SharedPreferencesHelper.getUser();
//     if (user != null && mounted) {
//       await Provider.of<NotificationProvider>(context, listen: false)
//           .loadNotifications(user.id);
//       await _fetchLiveSteps();
//     }
//   }

//   // ✅ FIXED: Fetch all order statuses CONCURRENTLY, then update UI in ONE setState
//   Future<void> _fetchLiveSteps() async {
//     if (!mounted) return;
//     setState(() => _isFetchingLive = true);

//     final provider =
//         Provider.of<NotificationProvider>(context, listen: false);
//     final orderIds =
//         provider.notifications.map((n) => n.orderId).toSet();

//     // Fetch all at the same time instead of one-by-one
//     final results = await Future.wait(
//       orderIds.map((orderId) async {
//         final status = await _OrderStatusApi.latestStatus(orderId);
//         return MapEntry(orderId, status);
//       }),
//     );

//     if (!mounted) return;

//     // ✅ Single setState — no partial/stale renders
//     setState(() {
//       for (final entry in results) {
//         if (entry.value != null) {
//           _liveStepCache[entry.key] = _resolveStep(entry.value!);
//         }
//       }
//       _isFetchingLive = false;
//     });
//   }

//   Future<void> _deleteNotification(String notificationId) async {
//     final user = await SharedPreferencesHelper.getUser();
//     if (user == null) return;

//     final confirmed = await _confirmDialog(
//       title: 'Delete Notification',
//       content: 'Are you sure you want to delete this notification?',
//     );
//     if (confirmed != true) return;

//     _showLoader();
//     try {
//       final provider =
//           Provider.of<NotificationProvider>(context, listen: false);
//       final success =
//           await provider.deleteNotification(user.id, notificationId);
//       if (mounted) Navigator.pop(context);
//       _showSnack(
//         success ? 'Notification deleted successfully' : 'Failed to delete',
//         success ? Colors.green : Colors.red,
//       );
//     } catch (e) {
//       if (mounted) Navigator.pop(context);
//       _showSnack('Error: ${e.toString()}', Colors.red);
//     }
//   }

//   Future<void> _deleteAllNotifications() async {
//     final user = await SharedPreferencesHelper.getUser();
//     if (user == null) return;

//     final provider =
//         Provider.of<NotificationProvider>(context, listen: false);

//     if (provider.notifications.isEmpty) {
//       _showSnack('No notifications to delete', Colors.orange);
//       return;
//     }

//     final confirmed = await _confirmDialog(
//       title: 'Delete All Notifications',
//       content:
//           'Are you sure you want to delete all notifications? This action cannot be undone.',
//       confirmLabel: 'Delete All',
//     );
//     if (confirmed != true) return;

//     _showLoader();
//     try {
//       final success = await provider.deleteAllNotifications(user.id);
//       if (mounted) Navigator.pop(context);
//       _showSnack(
//         success
//             ? 'All notifications deleted successfully'
//             : 'Failed to delete all notifications',
//         success ? Colors.green : Colors.red,
//       );
//     } catch (e) {
//       if (mounted) Navigator.pop(context);
//       _showSnack('Error: ${e.toString()}', Colors.red);
//     }
//   }

//   Future<bool?> _confirmDialog({
//     required String title,
//     required String content,
//     String confirmLabel = 'Delete',
//   }) {
//     return showDialog<bool>(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title:
//             Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//         content: Text(content),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx, false),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () => Navigator.pop(ctx, true),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red,
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8)),
//             ),
//             child: Text(confirmLabel),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showLoader() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => const Center(child: CircularProgressIndicator()),
//     );
//   }

//   void _showSnack(String msg, Color bg) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(msg), backgroundColor: bg),
//     );
//   }

//   String _timeAgo(DateTime dateTime) {
//     final diff = DateTime.now().difference(dateTime);
//     if (diff.inSeconds < 60) return '${diff.inSeconds}s ago';
//     if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
//     if (diff.inHours < 24) return '${diff.inHours}h ago';
//     return '${diff.inDays}d ago';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         title: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               'Notifications',
//               style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20),
//             ),
//             if (_isFetchingLive) ...[
//               const SizedBox(width: 8),
//               const SizedBox(
//                 width: 14,
//                 height: 14,
//                 child: CircularProgressIndicator(strokeWidth: 2),
//               ),
//             ],
//           ],
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
//         // actions: [
//         //   Consumer<NotificationProvider>(
//         //     builder: (context, provider, _) {
//         //       if (provider.notifications.isEmpty) return const SizedBox();
//         //       return Padding(
//         //         padding: const EdgeInsets.only(right: 12),
//         //         child: TextButton.icon(
//         //           onPressed: _deleteAllNotifications,
//         //           icon: const Icon(Icons.delete_sweep,
//         //               color: Colors.red, size: 20),
//         //           label: const Text(
//         //             'Clear All',
//         //             style: TextStyle(
//         //               color: Colors.red,
//         //               fontWeight: FontWeight.w600,
//         //               fontSize: 13,
//         //             ),
//         //           ),
//         //         ),
//         //       );
//         //     },
//         //   ),
//         // ],
//       ),
//       body: Consumer<NotificationProvider>(
//         builder: (context, provider, child) {
//           if (provider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (provider.error != null) {
//             return const Center(
//                 child: Text('Please Provide Internet Connection'));
//           }

//           if (provider.notifications.isEmpty) {
//             return const Center(child: Text('No notifications found.'));
//           }

//           return RefreshIndicator(
//             onRefresh: _loadNotifications,
//             child: ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: provider.notifications.length,
//               itemBuilder: (context, index) {
//                 final notification = provider.notifications[index];

//                 // ✅ Live cache always wins — falls back to local only if fetch not done yet
//                 final step = _liveStepCache[notification.orderId] ??
//                     _resolveStep(notification.status);

//                 return Dismissible(
//                   key: Key(notification.id),
//                   direction: DismissDirection.endToStart,
//                   confirmDismiss: (_) => _confirmDialog(
//                     title: 'Delete Notification',
//                     content:
//                         'Are you sure you want to delete this notification?',
//                   ),
//                   onDismissed: (_) async {
//                     final user = await SharedPreferencesHelper.getUser();
//                     if (user != null) {
//                       await provider.deleteNotification(
//                           user.id, notification.id);
//                     }
//                   },
//                   background: Container(
//                     alignment: Alignment.centerRight,
//                     padding: const EdgeInsets.only(right: 20),
//                     decoration: BoxDecoration(
//                       color: Colors.red,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Icon(Icons.delete,
//                         color: Colors.white, size: 30),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(bottom: 16),
//                     child: _NotificationCard(
//                       notification: notification,
//                       step: step,
//                       onDelete: () =>
//                           _deleteNotification(notification.id),
//                       timeAgo: _timeAgo(notification.timestamp),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────
// // Notification Card
// // ─────────────────────────────────────────────
// class _NotificationCard extends StatelessWidget {
//   final dynamic notification;
//   final int step;
//   final VoidCallback onDelete;
//   final String timeAgo;

//   const _NotificationCard({
//     required this.notification,
//     required this.step,
//     required this.onDelete,
//     required this.timeAgo,
//   });

//   String get _statusLabel {
//     switch (step) {
//       case 5:
//         return 'Delivered ✓';
//       case 4:
//         return 'Out for Delivery';
//       case 3:
//         return 'Rider Assigned';
//       case 2:
//         return 'Vendor Accepted';
//       default:
//         return 'Order Placed';
//     }
//   }

//   Color get _statusColor {
//     switch (step) {
//       case 5:
//         return Colors.green;
//       case 4:
//         return Colors.orange;
//       case 3:
//         return Colors.blue;
//       case 2:
//         return Colors.indigo;
//       default:
//         return Colors.grey;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           width: 1,
//           color: const Color.fromARGB(255, 192, 192, 192),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ── Header ──
//           Stack(
//             children: [
//               Row(
//                 children: [
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       'Order ID:\n${notification.orderId}',
//                       style: const TextStyle(
//                           fontWeight: FontWeight.bold, fontSize: 16),
//                     ),
//                   ),
//                 ],
//               ),
//               Positioned(
//                 top: 0,
//                 right: 0,
//                 child: Row(
//                   children: [
//                     Text(timeAgo,
//                         style: TextStyle(
//                             fontSize: 12, color: Colors.grey[600])),
//                     const SizedBox(width: 8),
//                     InkWell(
//                       onTap: onDelete,
//                       child: Container(
//                         padding: const EdgeInsets.all(6),
//                         decoration: BoxDecoration(
//                           color: Colors.red.shade50,
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                         child: const Icon(Icons.delete_outline,
//                             color: Colors.red, size: 20),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 12),

//           // ── Message ──
//           Text(
//             notification.message,
//             style:
//                 const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
//           ),

//           const SizedBox(height: 8),

//           // ── Live status badge ──
//           Container(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//             decoration: BoxDecoration(
//               color: _statusColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(color: _statusColor.withOpacity(0.4)),
//             ),
//             child: Text(
//               _statusLabel,
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//                 color: _statusColor,
//               ),
//             ),
//           ),

//           const SizedBox(height: 16),

//           // ── Progress bar ──
//           CustomProgressBar(currentStep: step, totalSteps: 5),

//           const SizedBox(height: 16),

//           // ── Step icons ──
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _StepItem(
//                   icon: Icons.shopping_cart,
//                   label: 'Order\nPlaced',
//                   isActive: step >= 1),
//               _StepItem(
//                   icon: Icons.store,
//                   label: 'Vendor\nAccepted',
//                   isActive: step >= 2),
//               _StepItem(
//                   icon: Icons.two_wheeler,
//                   label: 'Rider\nAssigned',
//                   isActive: step >= 3),
//               _StepItem(
//                   icon: Icons.local_shipping,
//                   label: 'Out for\nDelivery',
//                   isActive: step >= 4),
//               _StepItem(
//                   icon: Icons.check_circle,
//                   label: 'Delivered',
//                   isActive: step >= 5),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────
// // Step icon widget
// // ─────────────────────────────────────────────
// class _StepItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final bool isActive;

//   const _StepItem({
//     required this.icon,
//     required this.label,
//     required this.isActive,
//   });

//   @override
//   Widget build(BuildContext context) {
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
//           child: Icon(icon,
//               color: isActive ? Colors.blue : Colors.grey[600], size: 20),
//         ),
//         const SizedBox(height: 4),
//         SizedBox(
//           width: 50,
//           child: Text(
//             label,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 9,
//               color: isActive ? Colors.blue : Colors.grey[600],
//               height: 1.2,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';
import 'package:provider/provider.dart';
import 'package:medical_user_app/providers/notification_provider.dart';
import 'package:medical_user_app/widgets/progress_bar.dart';

int _resolveStep(String apiStatus) {
  switch (apiStatus.toLowerCase().trim()) {
    case 'delivered':
    case 'completed':
    case 'complete':
      return 5;
    case 'picked up':
    case 'pickedup':
    case 'out for delivery':
    case 'outfordelivery':
      return 4;
    case 'rider assigned':
    case 'riderassigned':
    case 'rider accepted':
    case 'rideraccepted':
      return 3;
    case 'accepted':
    case 'vendor accepted':
    case 'vendoraccepted':
      return 2;
    case 'pending':
    case 'placed':
    default:
      return 1;
  }
}

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
    if (user != null && mounted) {
      await Provider.of<NotificationProvider>(context, listen: false)
          .loadNotifications(user.id);
    }
  }

  Future<void> _deleteNotification(String notificationId) async {
    final user = await SharedPreferencesHelper.getUser();
    if (user == null) return;

    final confirmed = await _confirmDialog(
      title: 'Delete Notification',
      content: 'Are you sure you want to delete this notification?',
    );
    if (confirmed != true) return;

    _showLoader();
    try {
      final provider =
          Provider.of<NotificationProvider>(context, listen: false);
      final success =
          await provider.deleteNotification(user.id, notificationId);
      if (mounted) Navigator.pop(context);
      _showSnack(
        success ? 'Notification deleted successfully' : 'Failed to delete',
        success ? Colors.green : Colors.red,
      );
    } catch (e) {
      if (mounted) Navigator.pop(context);
      _showSnack('Error: ${e.toString()}', Colors.red);
    }
  }

  Future<void> _deleteAllNotifications() async {
    final user = await SharedPreferencesHelper.getUser();
    if (user == null) return;

    final provider = Provider.of<NotificationProvider>(context, listen: false);

    if (provider.notifications.isEmpty) {
      _showSnack('No notifications to delete', Colors.orange);
      return;
    }

    final confirmed = await _confirmDialog(
      title: 'Delete All Notifications',
      content:
          'Are you sure you want to delete all notifications? This action cannot be undone.',
      confirmLabel: 'Delete All',
    );
    if (confirmed != true) return;

    _showLoader();
    try {
      final success = await provider.deleteAllNotifications(user.id);
      if (mounted) Navigator.pop(context);
      _showSnack(
        success
            ? 'All notifications deleted successfully'
            : 'Failed to delete all notifications',
        success ? Colors.green : Colors.red,
      );
    } catch (e) {
      if (mounted) Navigator.pop(context);
      _showSnack('Error: ${e.toString()}', Colors.red);
    }
  }

  Future<bool?> _confirmDialog({
    required String title,
    required String content,
    String confirmLabel = 'Delete',
  }) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
  }

  void _showLoader() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  void _showSnack(String msg, Color bg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: bg),
    );
  }

  String _timeAgo(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    if (diff.inSeconds < 60) return '${diff.inSeconds}s ago';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
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
            return const Center(
                child: Text('Please Provide Internet Connection'));
          }

          if (provider.notifications.isEmpty) {
            return const Center(child: Text('No notifications found.'));
          }

          return RefreshIndicator(
            onRefresh: _loadNotifications,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.notifications.length,
              itemBuilder: (context, index) {
                final notification = provider.notifications[index];

                // Each notification uses its OWN status field directly
                final step = _resolveStep(notification.status ?? '');

                return Dismissible(
                  key: Key(notification.id),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (_) => _confirmDialog(
                    title: 'Delete Notification',
                    content:
                        'Are you sure you want to delete this notification?',
                  ),
                  onDismissed: (_) async {
                    final user = await SharedPreferencesHelper.getUser();
                    if (user != null) {
                      await provider.deleteNotification(
                          user.id, notification.id);
                    }
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:
                        const Icon(Icons.delete, color: Colors.white, size: 30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _NotificationCard(
                      notification: notification,
                      step: step,
                      onDelete: () => _deleteNotification(notification.id),
                      timeAgo: _timeAgo(notification.timestamp),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Notification Card
// ─────────────────────────────────────────────
class _NotificationCard extends StatelessWidget {
  final dynamic notification;
  final int step;
  final VoidCallback onDelete;
  final String timeAgo;

  const _NotificationCard({
    required this.notification,
    required this.step,
    required this.onDelete,
    required this.timeAgo,
  });

  String get _statusLabel {
    switch (step) {
      case 5:
        return 'Delivered ✓';
      case 4:
        return 'Out for Delivery';
      case 3:
        return 'Rider Assigned';
      case 2:
        return 'Vendor Accepted';
      default:
        return 'Order Placed';
    }
  }

  Color get _statusColor {
    switch (step) {
      case 5:
        return Colors.green;
      case 4:
        return Colors.orange;
      case 3:
        return Colors.blue;
      case 2:
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Stack(
            children: [
              Row(
                children: [
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Order ID:\n${notification.orderId}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Row(
                  children: [
                    Text(timeAgo,
                        style:
                            TextStyle(fontSize: 12, color: Colors.grey[600])),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: onDelete,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(Icons.delete_outline,
                            color: Colors.red, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ── Message ──
          Text(
            notification.message,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),

          const SizedBox(height: 8),

          // ── Status badge ──
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _statusColor.withOpacity(0.4)),
            ),
            child: Text(
              _statusLabel,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _statusColor,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ── Progress bar ──
          CustomProgressBar(currentStep: step, totalSteps: 5),

          const SizedBox(height: 16),

          // ── Step icons ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StepItem(
                  icon: Icons.shopping_cart,
                  label: 'Order\nPlaced',
                  isActive: step >= 1),
              _StepItem(
                  icon: Icons.store,
                  label: 'Vendor\nAccepted',
                  isActive: step >= 2),
              _StepItem(
                  icon: Icons.two_wheeler,
                  label: 'Rider\nAssigned',
                  isActive: step >= 3),
              _StepItem(
                  icon: Icons.local_shipping,
                  label: 'Out for\nDelivery',
                  isActive: step >= 4),
              // _StepItem(
              //     icon: Icons.check_circle,
              //     label: 'Delivered',
              //     isActive: step >= 5),

              _StepItem(
                  icon: Icons.check_circle,
                  label: 'Delivered',
                  isActive: step >= 5,
                  isDelivered: step >= 5),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Step icon widget
// ─────────────────────────────────────────────
class _StepItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final bool isDelivered;

  const _StepItem({
    required this.icon,
    required this.label,
    required this.isActive,
    this.isDelivered = false,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = isDelivered ? Colors.green : Colors.blue;
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            // color: isActive ? Colors.blue[50] : Colors.grey[50],

            color: isActive ? activeColor.withOpacity(0.1) : Colors.grey[50],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isActive ? Colors.blue : Colors.grey.shade300,
              width: 2,
            ),
          ),
          // child: Icon(icon,
          //     color: isActive ? Colors.blue : Colors.grey[600], size: 20),

          child: Icon(icon,
              color: isActive ? activeColor : Colors.grey[600], size: 20),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 50,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9,
              // color: isActive ? Colors.blue : Colors.grey[600],

              color: isActive ? activeColor : Colors.grey[600],
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}
