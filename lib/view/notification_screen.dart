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

//   Future<void> _deleteNotification(String notificationId) async {
//     final user = await SharedPreferencesHelper.getUser();
//     if (user == null) return;

//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Delete Notification'),
//         content:
//             const Text('Are you sure you want to delete this notification?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context, true),
//             style: TextButton.styleFrom(foregroundColor: Colors.red),
//             child: const Text('Delete'),
//           ),
//         ],
//       ),
//     );

//     if (confirmed != true) return;

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => const Center(child: CircularProgressIndicator()),
//     );

//     try {
//       final provider =
//           Provider.of<NotificationProvider>(context, listen: false);
//       bool success = await provider.deleteNotification(user.id, notificationId);

//       Navigator.pop(context);

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(success
//               ? 'Notification deleted successfully'
//               : 'Failed to delete notification'),
//           backgroundColor: success ? Colors.green : Colors.red,
//         ),
//       );
//     } catch (e) {
//       Navigator.pop(context);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error: ${e.toString()}'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   Future<void> _deleteAllNotifications() async {
//     final user = await SharedPreferencesHelper.getUser();
//     if (user == null) return;

//     final provider =
//         Provider.of<NotificationProvider>(context, listen: false);

//     if (provider.notifications.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('No notifications to delete'),
//           backgroundColor: Colors.orange,
//         ),
//       );
//       return;
//     }

//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title: const Text(
//           'Delete All Notifications',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         content: const Text(
//           'Are you sure you want to delete all notifications? This action cannot be undone.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () => Navigator.pop(context, true),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red,
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8)),
//             ),
//             child: const Text('Delete All'),
//           ),
//         ],
//       ),
//     );

//     if (confirmed != true) return;

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => const Center(child: CircularProgressIndicator()),
//     );

//     try {
//       final success = await provider.deleteAllNotifications(user.id);

//       Navigator.pop(context);

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(success
//               ? 'All notifications deleted successfully'
//               : 'Failed to delete all notifications'),
//           backgroundColor: success ? Colors.green : Colors.red,
//         ),
//       );
//     } catch (e) {
//       Navigator.pop(context);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error: ${e.toString()}'),
//           backgroundColor: Colors.red,
//         ),
//       );
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
//                 child: Text("Please Provide Internet Connection"));
//           }

//           if (provider.notifications.isEmpty) {
//             return const Center(child: Text("No notifications found."));
//           }

//           return ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: provider.notifications.length,
//             itemBuilder: (context, index) {
//               final notification = provider.notifications[index];
//               return Dismissible(
//                 key: Key(notification.id),
//                 direction: DismissDirection.endToStart,
//                 confirmDismiss: (direction) async {
//                   return await showDialog<bool>(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       title: const Text('Delete Notification'),
//                       content: const Text(
//                           'Are you sure you want to delete this notification?'),
//                       actions: [
//                         TextButton(
//                           onPressed: () => Navigator.pop(context, false),
//                           child: const Text('Cancel'),
//                         ),
//                         TextButton(
//                           onPressed: () => Navigator.pop(context, true),
//                           style: TextButton.styleFrom(
//                               foregroundColor: Colors.red),
//                           child: const Text('Delete'),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 onDismissed: (direction) async {
//                   final user = await SharedPreferencesHelper.getUser();
//                   if (user != null) {
//                     await provider.deleteNotification(
//                         user.id, notification.id);
//                   }
//                 },
//                 background: Container(
//                   alignment: Alignment.centerRight,
//                   padding: const EdgeInsets.only(right: 20),
//                   decoration: BoxDecoration(
//                     color: Colors.red,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child:
//                       const Icon(Icons.delete, color: Colors.white, size: 30),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(bottom: 16),
//                   child: Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                         width: 1,
//                         color: const Color.fromARGB(255, 192, 192, 192),
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         Stack(
//                           children: [
//                             Row(
//                               children: [
//                                 const SizedBox(width: 8),
//                                 Expanded(
//                                   child: Text(
//                                     "Your order ID:\n${notification.orderId}",
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Positioned(
//                               top: 0,
//                               right: 0,
//                               child: Row(
//                                 children: [
//                                   Text(
//                                     _timeAgo(notification.timestamp),
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       color: Colors.grey[600],
//                                     ),
//                                   ),
//                                   const SizedBox(width: 8),
//                                   InkWell(
//                                     onTap: () =>
//                                         _deleteNotification(notification.id),
//                                     child: Container(
//                                       padding: const EdgeInsets.all(6),
//                                       decoration: BoxDecoration(
//                                         color: Colors.red.shade50,
//                                         borderRadius:
//                                             BorderRadius.circular(6),
//                                       ),
//                                       child: const Icon(
//                                         Icons.delete_outline,
//                                         color: Colors.red,
//                                         size: 20,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 notification.message,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                         CustomProgressBar(
//                           currentStep: _getStepFromStatus(notification.status),
//                           totalSteps: 5,
//                         ),
//                         const SizedBox(height: 16),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             _buildStepItem(
//                               icon: Icons.shopping_cart,
//                               label: 'Order\nPlaced',
//                               isActive:
//                                   _getStepFromStatus(notification.status) >= 1,
//                             ),
//                             _buildStepItem(
//                               icon: Icons.store,
//                               label: 'Vendor\nAccepted',
//                               isActive:
//                                   _getStepFromStatus(notification.status) >= 2,
//                             ),
//                             _buildStepItem(
//                               icon: Icons.two_wheeler,
//                               label: 'Rider\nAccepted',
//                               isActive:
//                                   _getStepFromStatus(notification.status) >= 3,
//                             ),
//                             _buildStepItem(
//                               icon: Icons.local_shipping,
//                               label: 'Out for\nDelivery',
//                               isActive:
//                                   _getStepFromStatus(notification.status) >= 4,
//                             ),
//                             _buildStepItem(
//                               icon: Icons.check_circle,
//                               label: 'Delivered',
//                               isActive:
//                                   _getStepFromStatus(notification.status) >= 5,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
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

//   /// Mirrors the exact step logic from OrderStatusWidget.currentStep
//   /// but operates on a single status string instead of a timeline list.
//   int _getStepFromStatus(String status) {
//     final s = status.toLowerCase();

//     // Step 5: Delivered / Completed
//     if (s.contains('delivered') || s.contains('completed')) {
//       return 5;
//     }

//     // Step 4: Out for Delivery / Picked Up
//     if (s.contains('out for delivery') ||
//         s.contains('pickedup') ||
//         s.contains('picked up')) {
//       return 4;
//     }

//     // Step 3: Rider Accepted
//     // The notification message contains "rider updated status to accepted"
//     // or the status field is explicitly "rider accepted".
//     if (s.contains('rider accepted') ||
//         s.contains('rider updated status to accepted')) {
//       return 3;
//     }

//     // Step 2: Vendor Accepted (any "accepted" that is NOT rider-related)
//     if (s.contains('vendor accepted') ||
//         (s.contains('accepted') && !s.contains('rider'))) {
//       return 2;
//     }

//     // Step 1: Order Placed / Pending / Assigned
//     if (s.contains('pending') ||
//         s.contains('placed') ||
//         s.contains('rider assigned') ||
//         s.contains('assigned')) {
//       return 1;
//     }

//     return 1; // default
//   }

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

  Future<void> _deleteNotification(String notificationId) async {
    final user = await SharedPreferencesHelper.getUser();
    if (user == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Notification'),
        content:
            const Text('Are you sure you want to delete this notification?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final provider =
          Provider.of<NotificationProvider>(context, listen: false);
      bool success = await provider.deleteNotification(user.id, notificationId);

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success
              ? 'Notification deleted successfully'
              : 'Failed to delete notification'),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _deleteAllNotifications() async {
    final user = await SharedPreferencesHelper.getUser();
    if (user == null) return;

    final provider =
        Provider.of<NotificationProvider>(context, listen: false);

    if (provider.notifications.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No notifications to delete'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Delete All Notifications',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Are you sure you want to delete all notifications? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Delete All'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final success = await provider.deleteAllNotifications(user.id);

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success
              ? 'All notifications deleted successfully'
              : 'Failed to delete all notifications'),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
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
        actions: [
          Consumer<NotificationProvider>(
            builder: (context, provider, _) {
              if (provider.notifications.isEmpty) return const SizedBox();
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: TextButton.icon(
                  onPressed: _deleteAllNotifications,
                  icon: const Icon(Icons.delete_sweep,
                      color: Colors.red, size: 20),
                  label: const Text(
                    'Clear All',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return const Center(
                child: Text("Please Provide Internet Connection"));
          }

          if (provider.notifications.isEmpty) {
            return const Center(child: Text("No notifications found."));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.notifications.length,
            itemBuilder: (context, index) {
              final notification = provider.notifications[index];

              // ✅ Pass BOTH status and message for accurate step detection
              final step = _getStepFromStatusAndMessage(
                notification.status,
                notification.message,
              );

              return Dismissible(
                key: Key(notification.id),
                direction: DismissDirection.endToStart,
                confirmDismiss: (direction) async {
                  return await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Notification'),
                      content: const Text(
                          'Are you sure you want to delete this notification?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.red),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
                onDismissed: (direction) async {
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
                        Stack(
                          children: [
                            Row(
                              children: [
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
                              child: Row(
                                children: [
                                  Text(
                                    _timeAgo(notification.timestamp),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  InkWell(
                                    onTap: () =>
                                        _deleteNotification(notification.id),
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.red.shade50,
                                        borderRadius:
                                            BorderRadius.circular(6),
                                      ),
                                      child: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
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
                        CustomProgressBar(
                          currentStep: step,
                          totalSteps: 5,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildStepItem(
                              icon: Icons.shopping_cart,
                              label: 'Order\nPlaced',
                              isActive: step >= 1,
                            ),
                            _buildStepItem(
                              icon: Icons.store,
                              label: 'Vendor\nAccepted',
                              isActive: step >= 2,
                            ),
                            _buildStepItem(
                              icon: Icons.two_wheeler,
                              label: 'Rider\nAccepted',
                              isActive: step >= 3,
                            ),
                            _buildStepItem(
                              icon: Icons.local_shipping,
                              label: 'Out for\nDelivery',
                              isActive: step >= 4,
                            ),
                            _buildStepItem(
                              icon: Icons.check_circle,
                              label: 'Delivered',
                              isActive: step >= 5,
                            ),
                          ],
                        ),
                      ],
                    ),
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


  int _getStepFromStatusAndMessage(String status, String message) {
    final s = status.toLowerCase().trim();
    final m = message.toLowerCase().trim();

    // ✅ Step 5: Delivered / Completed — check both fields
    if (s.contains('delivered') ||
        s.contains('completed') ||
        m.contains('delivered') ||
        m.contains('order has been delivered') ||
        m.contains('successfully delivered') ||
        m.contains('completed')) {
      return 5;
    }

    // Step 4: Out for Delivery / Picked Up — check both fields
    if (s.contains('out for delivery') ||
        s.contains('pickedup') ||
        s.contains('picked up') ||
        m.contains('out for delivery') ||
        m.contains('pickedup') ||
        m.contains('picked up')) {
      return 4;
    }

    // Step 3: Rider Accepted — check both fields
    if (s.contains('rider accepted') ||
        s.contains('rider updated status to accepted') ||
        m.contains('rider accepted') ||
        m.contains('rider updated status to accepted')) {
      return 3;
    }

    // Step 2: Vendor Accepted — check both fields
    if (s.contains('vendor accepted') ||
        (s.contains('accepted') && !s.contains('rider')) ||
        m.contains('vendor accepted') ||
        (m.contains('accepted') && !m.contains('rider'))) {
      return 2;
    }

    // Step 1: Order Placed / Pending / Assigned
    if (s.contains('pending') ||
        s.contains('placed') ||
        s.contains('rider assigned') ||
        s.contains('assigned') ||
        m.contains('pending') ||
        m.contains('placed') ||
        m.contains('assigned')) {
      return 1;
    }

    return 1; // default
  }

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