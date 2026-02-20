// import 'package:flutter/material.dart';
// import 'package:medical_user_app/models/user_model.dart';
// import 'package:medical_user_app/providers/location_provider.dart';
// import 'package:medical_user_app/providers/notification_provider.dart';
// import 'package:medical_user_app/providers/profile_provider.dart';
// import 'package:medical_user_app/utils/shared_preferences_helper.dart';
// import 'package:medical_user_app/view/notification_screen.dart';
// import 'package:medical_user_app/view/profile_screen.dart';
// import 'package:medical_user_app/view/search/user_location_screen.dart';
// import 'package:provider/provider.dart';

// class PremiumAppBar extends StatelessWidget {
//   final String userId;

//   const PremiumAppBar({
//     Key? key,
//     required this.userId,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             const Color(0xFF6366F1),
//             const Color(0xFF8B5CF6),
//             const Color(0xFFA855F7),
//           ],
//         ),
//       ),
//       child: SafeArea(
//         top: false,
//         // bottom: false,
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
//           child: Column(
//             children: [
//               // Top Row - Profile, Greeting, Notification
//               Row(
//                 children: [
//                   // Profile Avatar with Online Indicator
//                   Consumer<ProfileProvider>(
//                     builder: (context, profileProvider, child) {
//                       final hasImage = profileProvider.hasProfileImage();
//                       final imageUrl = profileProvider.getProfileImageUrl();

//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const ProfileScreen(),
//                             ),
//                           );
//                         },
//                         child: Hero(
//                           tag: 'profile_avatar',
//                           child: Stack(
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   border: Border.all(
//                                     color: Colors.white.withOpacity(0.3),
//                                     width: 3,
//                                   ),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.15),
//                                       blurRadius: 12,
//                                       offset: const Offset(0, 4),
//                                     ),
//                                   ],
//                                 ),
//                                 child: CircleAvatar(
//                                   radius: 26,
//                                   backgroundColor: Colors.white,
//                                   backgroundImage:
//                                       hasImage ? NetworkImage(imageUrl!) : null,
//                                   onBackgroundImageError: hasImage
//                                       ? (exception, stackTrace) {}
//                                       : null,
//                                   child: !hasImage
//                                       ? Icon(
//                                           Icons.person_rounded,
//                                           size: 28,
//                                           color: const Color(0xFF6366F1),
//                                         )
//                                       : null,
//                                 ),
//                               ),
//                               // Online indicator
//                               Positioned(
//                                 bottom: 2,
//                                 right: 2,
//                                 child: Container(
//                                   width: 14,
//                                   height: 14,
//                                   decoration: BoxDecoration(
//                                     color: const Color(0xFF10B981),
//                                     shape: BoxShape.circle,
//                                     border: Border.all(
//                                       color: Colors.white,
//                                       width: 2.5,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),

//                   const SizedBox(width: 16),

//                   // Greeting and Name
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             const SizedBox(width: 6),
//                           ],
//                         ),
//                         const SizedBox(height: 2),
//                         Consumer<ProfileProvider>(
//                           builder: (context, profileProvider, child) {
//                             final userName =
//                                 profileProvider.user?.name ?? "Guest User";

//                             return Text(
//                               userName,
//                               key: ValueKey(
//                                   userName), // Add key to prevent rebuilds
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                                 letterSpacing: 0.5,
//                                 shadows: [
//                                   Shadow(
//                                     color: Colors.black12,
//                                     offset: Offset(0, 1),
//                                     blurRadius: 2,
//                                   ),
//                                 ],
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Notification Bell
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const NotificationScreen(),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       width: 48,
//                       height: 48,
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.15),
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: Colors.white.withOpacity(0.2),
//                           width: 1.5,
//                         ),
//                       ),
//                       child: Consumer<NotificationProvider>(
//                         builder: (context, notificationProvider, child) {
//                           final hasNotifications =
//                               notificationProvider.notifications.isNotEmpty;

//                           return Stack(
//                             clipBehavior: Clip.none,
//                             children: [
//                               Center(
//                                 child: Icon(
//                                   hasNotifications
//                                       ? Icons.notifications_rounded
//                                       : Icons.notifications_outlined,
//                                   size: 24,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               if (hasNotifications)
//                                 Positioned(
//                                   right: 10,
//                                   top: 10,
//                                   child: Container(
//                                     padding: const EdgeInsets.all(4),
//                                     constraints: const BoxConstraints(
//                                       minWidth: 18,
//                                       minHeight: 18,
//                                     ),
//                                     decoration: BoxDecoration(
//                                       color: const Color(0xFFEF4444),
//                                       shape: BoxShape.circle,
//                                       border: Border.all(
//                                         color: Colors.white,
//                                         width: 2,
//                                       ),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.black.withOpacity(0.2),
//                                           blurRadius: 4,
//                                           offset: const Offset(0, 2),
//                                         ),
//                                       ],
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         notificationProvider
//                                                     .notifications.length >
//                                                 9
//                                             ? '9+'
//                                             : '${notificationProvider.notifications.length}',
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.bold,
//                                           height: 1,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 20),

//               // Location Selector
//               Consumer<LocationProvider>(
//                 builder: (context, locationProvider, child) {
//                   final addressParts = (locationProvider?.address ?? '')
//                       .split(',')
//                       .map((e) => e.trim())
//                       .toList();
//                   final primaryAddress = addressParts.isNotEmpty
//                       ? addressParts[0]
//                       : 'Set your location';
//                   final secondaryAddress = addressParts.length > 1
//                       ? addressParts.sublist(1).take(2).join(', ')
//                       : 'Tap to select delivery address';

//                   return GestureDetector(
//                     onTap: () async {
//                       final result = await Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               LocationSearchScreen(userId: userId),
//                         ),
//                       );

//                       if (result == true && context.mounted) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Row(
//                               children: [
//                                 Icon(
//                                   Icons.check_circle,
//                                   color: Colors.white,
//                                   size: 20,
//                                 ),
//                                 SizedBox(width: 12),
//                                 Text('Location updated successfully'),
//                               ],
//                             ),
//                             backgroundColor: const Color(0xFF10B981),
//                             behavior: SnackBarBehavior.floating,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             margin: const EdgeInsets.all(16),
//                             duration: const Duration(seconds: 2),
//                           ),
//                         );
//                       }
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.12),
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(
//                           color: Colors.white.withOpacity(0.25),
//                           width: 1.5,
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.08),
//                             blurRadius: 12,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         children: [
//                           // Location Icon
//                           Container(
//                             padding: const EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(12),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.1),
//                                   blurRadius: 8,
//                                   offset: const Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: Icon(
//                               Icons.location_on_rounded,
//                               color: const Color(0xFF6366F1),
//                               size: 22,
//                             ),
//                           ),

//                           const SizedBox(width: 14),

//                           // Location Details
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 if (locationProvider?.isLoading == true)
//                                   Row(
//                                     children: [
//                                       SizedBox(
//                                         width: 14,
//                                         height: 14,
//                                         child: CircularProgressIndicator(
//                                           strokeWidth: 2,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       const SizedBox(width: 10),
//                                       Text(
//                                         'Fetching location...',
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 else ...[
//                                   Text(
//                                     primaryAddress,
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w700,
//                                       letterSpacing: 0.3,
//                                     ),
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Text(
//                                     secondaryAddress,
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       color: Colors.white.withOpacity(0.85),
//                                       fontWeight: FontWeight.w400,
//                                       letterSpacing: 0.2,
//                                     ),
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ],
//                               ],
//                             ),
//                           ),

//                           // Dropdown Arrow
//                           Container(
//                             padding: const EdgeInsets.all(6),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.15),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Icon(
//                               Icons.keyboard_arrow_down_rounded,
//                               color: Colors.white,
//                               size: 22,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Shimmer Loading Widget (for name loading state)
// class ShimmerLoading extends StatefulWidget {
//   final double width;
//   final double height;
//   final double borderRadius;

//   const ShimmerLoading({
//     Key? key,
//     required this.width,
//     required this.height,
//     this.borderRadius = 4,
//   }) : super(key: key);

//   @override
//   State<ShimmerLoading> createState() => _ShimmerLoadingState();
// }

// class _ShimmerLoadingState extends State<ShimmerLoading>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     )..repeat();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) {
//         return Container(
//           width: widget.width,
//           height: widget.height,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(widget.borderRadius),
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Colors.white.withOpacity(0.1),
//                 Colors.white.withOpacity(0.3),
//                 Colors.white.withOpacity(0.1),
//               ],
//               stops: [
//                 0.0,
//                 _controller.value,
//                 1.0,
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


















// import 'package:flutter/material.dart';
// import 'package:medical_user_app/providers/location_provider.dart';
// import 'package:medical_user_app/providers/notification_provider.dart';
// import 'package:medical_user_app/providers/profile_provider.dart';
// import 'package:medical_user_app/view/notification_screen.dart';
// import 'package:medical_user_app/view/profile_screen.dart';
// import 'package:medical_user_app/view/search/user_location_screen.dart';
// import 'package:provider/provider.dart';
// import 'dart:ui';

// class PremiumAppBar extends StatelessWidget {
//   final String userId;

//   const PremiumAppBar({
//     Key? key,
//     required this.userId,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             const Color(0xFF0F172A), // Dark slate
//             const Color(0xFF1E293B),
//             const Color(0xFF334155),
//           ],
//         ),
//       ),
//       child: SafeArea(
//         // top: false,
//         bottom: false,
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
//           child: Column(
//             children: [
//               // Top Section - Profile & Actions
//               Row(
//                 children: [
//                   // Profile Section
//                   Expanded(
//                     child: Consumer<ProfileProvider>(
//                       builder: (context, profileProvider, child) {
//                         final hasImage = profileProvider.hasProfileImage();
//                         final imageUrl = profileProvider.getProfileImageUrl();
//                         final userName = profileProvider.user?.name ?? "Guest User";

//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const ProfileScreen(),
//                               ),
//                             );
//                           },
//                           child: Row(
//                             children: [
//                               // Avatar with gradient border
//                               Hero(
//                                 tag: 'profile_avatar',
//                                 child: Container(
//                                   padding: const EdgeInsets.all(3),
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         const Color(0xFF3B82F6),
//                                         const Color(0xFF8B5CF6),
//                                         const Color(0xFFEC4899),
//                                       ],
//                                     ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: const Color(0xFF3B82F6).withOpacity(0.3),
//                                         blurRadius: 16,
//                                         offset: const Offset(0, 4),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Container(
//                                     padding: const EdgeInsets.all(2),
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       color: const Color(0xFF1E293B),
//                                     ),
//                                     child: CircleAvatar(
//                                       radius: 24,
//                                       backgroundColor: const Color(0xFF334155),
//                                       backgroundImage: hasImage ? NetworkImage(imageUrl!) : null,
//                                       onBackgroundImageError: hasImage ? (exception, stackTrace) {} : null,
//                                       child: !hasImage
//                                           ? Icon(
//                                               Icons.person_rounded,
//                                               size: 26,
//                                               color: Colors.white70,
//                                             )
//                                           : null,
//                                     ),
//                                   ),
//                                 ),
//                               ),

//                               const SizedBox(width: 14),

//                               // User Info
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Welcome back 👋',
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.white.withOpacity(0.6),
//                                         fontWeight: FontWeight.w500,
//                                         letterSpacing: 0.5,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Text(
//                                       userName,
//                                       key: ValueKey(userName),
//                                       style: const TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.w700,
//                                         color: Colors.white,
//                                         letterSpacing: 0.3,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                       maxLines: 1,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),

//                   const SizedBox(width: 12),

//                   // Notification Button
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const NotificationScreen(),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.08),
//                         borderRadius: BorderRadius.circular(14),
//                         border: Border.all(
//                           color: Colors.white.withOpacity(0.12),
//                           width: 1,
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 8,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Consumer<NotificationProvider>(
//                         builder: (context, notificationProvider, child) {
//                           final hasNotifications = notificationProvider.notifications.isNotEmpty;

//                           return Stack(
//                             clipBehavior: Clip.none,
//                             children: [
//                               Center(
//                                 child: Icon(
//                                   hasNotifications
//                                       ? Icons.notifications_rounded
//                                       : Icons.notifications_none_rounded,
//                                   size: 24,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               if (hasNotifications)
//                                 Positioned(
//                                   right: 8,
//                                   top: 8,
//                                   child: Container(
//                                     padding: const EdgeInsets.all(2),
//                                     constraints: const BoxConstraints(
//                                       minWidth: 16,
//                                       minHeight: 16,
//                                     ),
//                                     decoration: BoxDecoration(
//                                       gradient: LinearGradient(
//                                         colors: [
//                                           const Color(0xFFEF4444),
//                                           const Color(0xFFDC2626),
//                                         ],
//                                       ),
//                                       shape: BoxShape.circle,
//                                       border: Border.all(
//                                         color: const Color(0xFF1E293B),
//                                         width: 2,
//                                       ),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: const Color(0xFFEF4444).withOpacity(0.4),
//                                           blurRadius: 6,
//                                           offset: const Offset(0, 2),
//                                         ),
//                                       ],
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         notificationProvider.notifications.length > 9
//                                             ? '9+'
//                                             : '${notificationProvider.notifications.length}',
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 9,
//                                           fontWeight: FontWeight.bold,
//                                           height: 1.2,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 20),

//               // Location Card with Glassmorphism
//               Consumer<LocationProvider>(
//                 builder: (context, locationProvider, child) {
//                   final addressParts = (locationProvider?.address ?? '')
//                       .split(',')
//                       .map((e) => e.trim())
//                       .toList();
//                   final primaryAddress = addressParts.isNotEmpty
//                       ? addressParts[0]
//                       : 'Set your location';
//                   final secondaryAddress = addressParts.length > 1
//                       ? addressParts.sublist(1).take(2).join(', ')
//                       : 'Tap to select your address';

//                   return GestureDetector(
//                     onTap: () async {
//                       final result = await Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => LocationSearchScreen(userId: userId),
//                         ),
//                       );

//                       if (result == true && context.mounted) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Row(
//                               children: [
//                                 Container(
//                                   padding: const EdgeInsets.all(6),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white.withOpacity(0.2),
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Icon(
//                                     Icons.check_circle_rounded,
//                                     color: Colors.white,
//                                     size: 18,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 const Text(
//                                   'Location updated successfully',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             backgroundColor: const Color(0xFF10B981),
//                             behavior: SnackBarBehavior.floating,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(14),
//                             ),
//                             margin: const EdgeInsets.all(16),
//                             duration: const Duration(seconds: 2),
//                             elevation: 6,
//                           ),
//                         );
//                       }
//                     },
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(18),
//                       child: BackdropFilter(
//                         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                         child: Container(
//                           padding: const EdgeInsets.all(18),
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                               colors: [
//                                 Colors.white.withOpacity(0.15),
//                                 Colors.white.withOpacity(0.08),
//                               ],
//                             ),
//                             borderRadius: BorderRadius.circular(18),
//                             border: Border.all(
//                               color: Colors.white.withOpacity(0.2),
//                               width: 1.5,
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.1),
//                                 blurRadius: 20,
//                                 offset: const Offset(0, 8),
//                               ),
//                             ],
//                           ),
//                           child: Row(
//                             children: [
//                               // Location Icon with gradient
//                               Container(
//                                 width: 48,
//                                 height: 48,
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     begin: Alignment.topLeft,
//                                     end: Alignment.bottomRight,
//                                     colors: [
//                                       const Color(0xFF3B82F6),
//                                       const Color(0xFF2563EB),
//                                     ],
//                                   ),
//                                   borderRadius: BorderRadius.circular(14),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: const Color(0xFF3B82F6).withOpacity(0.4),
//                                       blurRadius: 12,
//                                       offset: const Offset(0, 4),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Icon(
//                                   Icons.location_on_rounded,
//                                   color: Colors.white,
//                                   size: 26,
//                                 ),
//                               ),

//                               const SizedBox(width: 16),

//                               // Location Text
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     if (locationProvider?.isLoading == true)
//                                       Row(
//                                         children: [
//                                           SizedBox(
//                                             width: 16,
//                                             height: 16,
//                                             child: CircularProgressIndicator(
//                                               strokeWidth: 2,
//                                               valueColor: AlwaysStoppedAnimation<Color>(
//                                                 Colors.white,
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(width: 12),
//                                           Text(
//                                             'Fetching location...',
//                                             style: TextStyle(
//                                               fontSize: 15,
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                         ],
//                                       )
//                                     else ...[
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Text(
//                                               primaryAddress,
//                                               style: TextStyle(
//                                                 fontSize: 15,
//                                                 color: Colors.white,
//                                                 fontWeight: FontWeight.w700,
//                                                 letterSpacing: 0.2,
//                                               ),
//                                               maxLines: 1,
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                           ),
//                                           const SizedBox(width: 8),
//                                           // Container(
//                                           //   padding: const EdgeInsets.symmetric(
//                                           //     horizontal: 8,
//                                           //     vertical: 4,
//                                           //   ),
//                                           //   decoration: BoxDecoration(
//                                           //     color: const Color(0xFF10B981).withOpacity(0.2),
//                                           //     borderRadius: BorderRadius.circular(6),
//                                           //     border: Border.all(
//                                           //       color: const Color(0xFF10B981).withOpacity(0.3),
//                                           //     ),
//                                           //   ),
//                                           //   child: Row(
//                                           //     mainAxisSize: MainAxisSize.min,
//                                           //     children: [
//                                           //       Icon(
//                                           //         Icons.check_circle_rounded,
//                                           //         size: 12,
//                                           //         color: const Color(0xFF10B981),
//                                           //       ),
//                                           //       const SizedBox(width: 4),
//                                           //       Text(
//                                           //         'Active',
//                                           //         style: TextStyle(
//                                           //           fontSize: 10,
//                                           //           color: const Color(0xFF10B981),
//                                           //           fontWeight: FontWeight.w600,
//                                           //         ),
//                                           //       ),
//                                           //     ],
//                                           //   ),
//                                           // ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 6),
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.place_outlined,
//                                             size: 14,
//                                             color: Colors.white.withOpacity(0.7),
//                                           ),
//                                           const SizedBox(width: 6),
//                                           Expanded(
//                                             child: Text(
//                                               secondaryAddress,
//                                               style: TextStyle(
//                                                 fontSize: 13,
//                                                 color: Colors.white.withOpacity(0.8),
//                                                 fontWeight: FontWeight.w400,
//                                                 letterSpacing: 0.1,
//                                               ),
//                                               maxLines: 1,
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ],
//                                 ),
//                               ),

//                               const SizedBox(width: 12),

//                               // Change Button
//                               Container(
//                                 padding: const EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white.withOpacity(0.15),
//                                   borderRadius: BorderRadius.circular(10),
//                                   border: Border.all(
//                                     color: Colors.white.withOpacity(0.2),
//                                   ),
//                                 ),
//                                 child: Icon(
//                                   Icons.edit_location_alt_rounded,
//                                   color: Colors.white,
//                                   size: 20,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Shimmer Loading Widget (for name loading state)
// class ShimmerLoading extends StatefulWidget {
//   final double width;
//   final double height;
//   final double borderRadius;

//   const ShimmerLoading({
//     Key? key,
//     required this.width,
//     required this.height,
//     this.borderRadius = 4,
//   }) : super(key: key);

//   @override
//   State<ShimmerLoading> createState() => _ShimmerLoadingState();
// }

// class _ShimmerLoadingState extends State<ShimmerLoading>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     )..repeat();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) {
//         return Container(
//           width: widget.width,
//           height: widget.height,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(widget.borderRadius),
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Colors.white.withOpacity(0.1),
//                 Colors.white.withOpacity(0.3),
//                 Colors.white.withOpacity(0.1),
//               ],
//               stops: [
//                 0.0,
//                 _controller.value,
//                 1.0,
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


















import 'package:flutter/material.dart';
import 'package:medical_user_app/providers/location_provider.dart';
import 'package:medical_user_app/providers/notification_provider.dart';
import 'package:medical_user_app/providers/profile_provider.dart';
import 'package:medical_user_app/view/notification_screen.dart';
import 'package:medical_user_app/view/profile_screen.dart';
import 'package:medical_user_app/view/search/user_location_screen.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class PremiumAppBar extends StatelessWidget {
  final String userId;

  const PremiumAppBar({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0F172A), // Dark slate
            const Color(0xFF1E293B),
            const Color(0xFF334155),
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          child: Column(
            children: [
              // Top Section - Profile & Actions
              Row(
                children: [
                  // Profile Section
                  Expanded(
                    child: Consumer<ProfileProvider>(
                      builder: (context, profileProvider, child) {
                        final hasImage = profileProvider.hasProfileImage();
                        final imageUrl = profileProvider.getProfileImageUrl();
                        final userName = profileProvider.user?.name ?? "Guest User";

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfileScreen(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              // Avatar with gradient border
                              Hero(
                                tag: 'profile_avatar',
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(0xFF3B82F6),
                                        const Color(0xFF8B5CF6),
                                        const Color(0xFFEC4899),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF3B82F6).withOpacity(0.3),
                                        blurRadius: 16,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xFF1E293B),
                                    ),
                                    child: CircleAvatar(
                                      radius: 24,
                                      backgroundColor: const Color(0xFF334155),
                                      backgroundImage: hasImage ? NetworkImage(imageUrl!) : null,
                                      onBackgroundImageError: hasImage ? (exception, stackTrace) {} : null,
                                      child: !hasImage
                                          ? Icon(
                                              Icons.person_rounded,
                                              size: 26,
                                              color: Colors.white70,
                                            )
                                          : null,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 14),

                              // User Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Welcome back 👋',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white.withOpacity(0.6),
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      userName,
                                      key: ValueKey(userName),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        letterSpacing: 0.3,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Notification Button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.12),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Consumer<NotificationProvider>(
                        builder: (context, notificationProvider, child) {
                          final hasNotifications = notificationProvider.notifications.isNotEmpty;

                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Center(
                                child: Icon(
                                  hasNotifications
                                      ? Icons.notifications_rounded
                                      : Icons.notifications_none_rounded,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ),
                              if (hasNotifications)
                                Positioned(
                                  right: 8,
                                  top: 8,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    constraints: const BoxConstraints(
                                      minWidth: 16,
                                      minHeight: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          const Color(0xFFEF4444),
                                          const Color(0xFFDC2626),
                                        ],
                                      ),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFF1E293B),
                                        width: 2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFFEF4444).withOpacity(0.4),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        notificationProvider.notifications.length > 9
                                            ? '9+'
                                            : '${notificationProvider.notifications.length}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold,
                                          height: 1.2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Enhanced Location Card
              Consumer<LocationProvider>(
                builder: (context, locationProvider, child) {
                  final addressParts = (locationProvider?.address ?? '')
                      .split(',')
                      .map((e) => e.trim())
                      .toList();
                  final primaryAddress = addressParts.isNotEmpty
                      ? addressParts[0]
                      : 'No location set';
                  final secondaryAddress = addressParts.length > 1
                      ? addressParts.sublist(1).take(2).join(', ')
                      : 'Tap to set your delivery address';

                  return GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LocationSearchScreen(userId: userId),
                        ),
                      );

                      if (result == true && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.check_circle_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Location updated successfully',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: const Color(0xFF10B981),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            margin: const EdgeInsets.all(16),
                            duration: const Duration(seconds: 2),
                            elevation: 6,
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF3B82F6).withOpacity(0.15),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withOpacity(0.18),
                                  Colors.white.withOpacity(0.10),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.25),
                                width: 1.5,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  // Enhanced Location Icon
                                  Container(
                                    width: 56,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          const Color(0xFF3B82F6),
                                          const Color(0xFF2563EB),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF3B82F6).withOpacity(0.5),
                                          blurRadius: 16,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.location_on_rounded,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),

                                  const SizedBox(width: 18),

                                  // Location Text Content
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (locationProvider?.isLoading == true)
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 18,
                                                height: 18,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2.5,
                                                  valueColor: AlwaysStoppedAnimation<Color>(
                                                    Colors.white,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 14),
                                              Text(
                                                'Finding your location...',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.2,
                                                ),
                                              ),
                                            ],
                                          )
                                        else ...[
                                          // Label
                                          Row(
                                            children: [
                                              Text(
                                                'Delivery Location',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.white.withOpacity(0.7),
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.8,
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                              Container(
                                                width: 4,
                                                height: 4,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFF10B981),
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: const Color(0xFF10B981).withOpacity(0.6),
                                                      blurRadius: 4,
                                                      spreadRadius: 1,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          // Primary Address
                                          Text(
                                            primaryAddress,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 0.3,
                                              height: 1.2,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 6),
                                          // Secondary Address
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.my_location_rounded,
                                                size: 13,
                                                color: Colors.white.withOpacity(0.65),
                                              ),
                                              const SizedBox(width: 6),
                                              Expanded(
                                                child: Text(
                                                  secondaryAddress,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white.withOpacity(0.75),
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 0.1,
                                                    height: 1.3,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  // Edit Button
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.white.withOpacity(0.2),
                                          Colors.white.withOpacity(0.1),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Shimmer Loading Widget (for name loading state)
class ShimmerLoading extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerLoading({
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius = 4,
  }) : super(key: key);

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.3),
                Colors.white.withOpacity(0.1),
              ],
              stops: [
                0.0,
                _controller.value,
                1.0,
              ],
            ),
          ),
        );
      },
    );
  }
}