// // import 'package:flutter/material.dart';
// // import 'package:medical_user_app/view/pharmacy_screen.dart';
// // import 'package:medical_user_app/widgets/bottom_navigation.dart';

// // class NearPharmacyScreen extends StatelessWidget {
// //   const NearPharmacyScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         backgroundColor: Colors.white,
// //         body: SafeArea(
// //           child: SingleChildScrollView(
// //             child: Padding(
// //               padding: const EdgeInsets.all(16.0),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Row(
// //                     children: [
// //                       CircleAvatar(
// //                         radius: 24,
// //                         backgroundImage: AssetImage('assets/profile.png'),
// //                         backgroundColor: Colors.grey[300],
// //                       ),
// //                       SizedBox(width: 12),
// //                       Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           Text("Hello",
// //                               style: TextStyle(
// //                                   fontSize: 16, color: Colors.grey[600])),
// //                           Text("Manoj Kumar",
// //                               style: TextStyle(
// //                                   fontSize: 18, fontWeight: FontWeight.bold)),
// //                         ],
// //                       ),
// //                       Spacer(),
// //                       Container(
// //                         padding: EdgeInsets.all(8),
// //                         child: Column(
// //                           children: [
// //                             Icon(Icons.location_on,
// //                                 size: 24, color: Colors.black54),
// //                             Text(
// //                               "Kakinada",
// //                               style: TextStyle(fontSize: 10),
// //                             )
// //                           ],
// //                         ),
// //                       ),
// //                       SizedBox(width: 12),
// //                       Container(
// //                         padding: EdgeInsets.all(8),
// //                         decoration: BoxDecoration(
// //                             color: Colors.grey[100],
// //                             borderRadius: BorderRadius.circular(5)),
// //                         child: Icon(Icons.translate_outlined,
// //                             size: 24, color: Colors.black54),
// //                       ),
// //                     ],
// //                   ),
// //                   SizedBox(height: 24),

// //                   // Search row
// //                   Row(
// //                     children: [
// //                       Expanded(
// //                         child: TextField(
// //                           decoration: InputDecoration(
// //                             hintText: 'Search your Medicine,Pharmacy...',
// //                             prefixIcon: Icon(Icons.search, color: Colors.grey),
// //                             contentPadding: EdgeInsets.symmetric(vertical: 12),
// //                             border: OutlineInputBorder(
// //                               borderRadius: BorderRadius.circular(30),
// //                               borderSide: BorderSide(color: Colors.grey[300]!),
// //                             ),
// //                             focusedBorder: OutlineInputBorder(
// //                               borderRadius: BorderRadius.circular(30),
// //                               borderSide: BorderSide(
// //                                   color: Color(0xFF5931DD), width: 2),
// //                             ),
// //                             enabledBorder: OutlineInputBorder(
// //                               borderRadius: BorderRadius.circular(30),
// //                               borderSide: BorderSide(color: Colors.grey[300]!),
// //                             ),
// //                             fillColor: Colors.white,
// //                             filled: true,
// //                           ),
// //                         ),
// //                       ),
// //                       SizedBox(width: 12),
// //                       Container(
// //                         padding: EdgeInsets.all(12),
// //                         decoration: BoxDecoration(
// //                           color: Color(0xFF5931DD),
// //                           shape: BoxShape.circle,
// //                         ),
// //                         child: Icon(Icons.mic, color: Colors.white),
// //                       ),
// //                     ],
// //                   ),
// //                   SizedBox(height: 24),

// //                   // Nearby Pharmacies Section
// //                   Text(
// //                     "Nearby Pharmacies",
// //                     style: TextStyle(
// //                       fontSize: 20,
// //                       fontWeight: FontWeight.bold,
// //                       color: Colors.black,
// //                     ),
// //                   ),
// //                   SizedBox(height: 16),

// //                   // Pharmacy List Items
// //                   _buildPharmacyItem(context),
// //                   SizedBox(height: 10),
// //                   _buildPharmacyItem(context),
// //                   SizedBox(height: 10),
// //                   _buildPharmacyItem(context),
// //                   SizedBox(height: 10),
// //                   _buildPharmacyItem(context),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// // );
// //   }

// //   Widget _buildPharmacyItem(BuildContext context) {
// //     return Container(
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16),
// //         border: Border.all(width: 1,color:Color.fromARGB(255, 205, 205, 205) ),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.grey.withOpacity(0.1),
// //             spreadRadius: 1,
// //             blurRadius: 2,
// //             offset: Offset(0, 1),
// //           ),
// //         ],
// //       ),
// //       child: Material(
// //         color: Colors.transparent,
// //         borderRadius: BorderRadius.circular(16),
// //         child: InkWell(
// //           borderRadius: BorderRadius.circular(16),
// //           onTap: () {},
// //           child: Padding(
// //             padding: const EdgeInsets.all(12.0),
// //             child: Row(
// //               children: [
// //                 // Pharmacy Image
// //                 ClipRRect(
// //                   borderRadius: BorderRadius.circular(8),
// //                   child: Image.asset(
// //                     'assets/pharmacy.png',
// //                     width: 90,
// //                     height: 90,
// //                     fit: BoxFit.cover,
// //                   ),
// //                 ),
// //                 SizedBox(width: 16),

// //                 // Pharmacy Details
// //                 Expanded(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         "Apollo Pharmacy",
// //                         style: TextStyle(
// //                           fontSize: 18,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                       SizedBox(height: 4),
// //                       Row(
// //                         children: [
// //                           Icon(
// //                             Icons.location_on,
// //                             size: 16,
// //                             color: Colors.indigo,
// //                           ),
// //                           SizedBox(width: 4),
// //                           Text(
// //                             "Gandhi Nagar",
// //                             style: TextStyle(
// //                               fontSize: 12,
// //                               color: Colors.grey,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),

// //                 // Arrow Icon
// //                 IconButton(onPressed: (){
// //                   Navigator.push(context, MaterialPageRoute(builder: (context)=>PharmacyScreen()));
// //                 }, icon: Icon(
// //                   Icons.chevron_right,
// //                   color: Colors.grey,
// //                   size: 24,
// //                 ),)
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:medical_user_app/view/pharmacy_screen.dart';
// import 'package:medical_user_app/widgets/bottom_navigation.dart';
// import 'package:medical_user_app/providers/pharmacy_provider.dart';
// import 'package:medical_user_app/models/pharmacy_model.dart';

// class NearPharmacyScreen extends StatefulWidget {
//   const NearPharmacyScreen({super.key});

//   @override
//   State<NearPharmacyScreen> createState() => _NearPharmacyScreenState();
// }

// class _NearPharmacyScreenState extends State<NearPharmacyScreen> {
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     // Fetch pharmacies when screen initializes
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<PharmacyProvider>().fetchPharmacies();
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: RefreshIndicator(
//           onRefresh: () => context.read<PharmacyProvider>().refreshPharmacies(),
//           child: SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Header Row
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 24,
//                         backgroundImage: AssetImage('assets/profile.png'),
//                         backgroundColor: Colors.grey[300],
//                       ),
//                       SizedBox(width: 12),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text("Hello",
//                               style: TextStyle(
//                                   fontSize: 16, color: Colors.grey[600])),
//                           Text("Manoj Kumar",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold)),
//                         ],
//                       ),
//                       Spacer(),
//                       Container(
//                         padding: EdgeInsets.all(8),
//                         child: Column(
//                           children: [
//                             Icon(Icons.location_on,
//                                 size: 24, color: Colors.black54),
//                             Text(
//                               "Kakinada",
//                               style: TextStyle(fontSize: 10),
//                             )
//                           ],
//                         ),
//                       ),
//                       SizedBox(width: 12),
//                       Container(
//                         padding: EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                             color: Colors.grey[100],
//                             borderRadius: BorderRadius.circular(5)),
//                         child: Icon(Icons.translate_outlined,
//                             size: 24, color: Colors.black54),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 24),

//                   // Search Row
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: _searchController,
//                           onChanged: (value) {
//                             context.read<PharmacyProvider>().searchPharmacies(value);
//                           },
//                           decoration: InputDecoration(
//                             hintText: 'Search your Medicine,Pharmacy...',
//                             prefixIcon: Icon(Icons.search, color: Colors.grey),
//                             suffixIcon: _searchController.text.isNotEmpty
//                                 ? IconButton(
//                                     icon: Icon(Icons.clear, color: Colors.grey),
//                                     onPressed: () {
//                                       _searchController.clear();
//                                       context.read<PharmacyProvider>().clearSearch();
//                                     },
//                                   )
//                                 : null,
//                             contentPadding: EdgeInsets.symmetric(vertical: 12),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide: BorderSide(color: Colors.grey[300]!),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide: BorderSide(
//                                   color: Color(0xFF5931DD), width: 2),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide: BorderSide(color: Colors.grey[300]!),
//                             ),
//                             fillColor: Colors.white,
//                             filled: true,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 12),
//                       Container(
//                         padding: EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Color(0xFF5931DD),
//                           shape: BoxShape.circle,
//                         ),
//                         child: Icon(Icons.mic, color: Colors.white),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 24),

//                   // Nearby Pharmacies Section
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Nearby Pharmacies",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       Consumer<PharmacyProvider>(
//                         builder: (context, provider, child) {
//                           if (provider.filteredPharmacies.isNotEmpty) {
//                             return Text(
//                               "",
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey[600],
//                               ),
//                             );
//                           }
//                           return SizedBox.shrink();
//                         },
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),

//                   // Pharmacy List
//                   Consumer<PharmacyProvider>(
//                     builder: (context, provider, child) {
//                       if (provider.isLoading) {
//                         return _buildLoadingState();
//                       }

//                       if (provider.errorMessage.isNotEmpty) {
//                         return _buildErrorState(provider.errorMessage);
//                       }

//                       if (provider.filteredPharmacies.isEmpty) {
//                         return _buildEmptyState();
//                       }

//                       return ListView.separated(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: provider.filteredPharmacies.length,
//                         separatorBuilder: (context, index) => SizedBox(height: 12),
//                         itemBuilder: (context, index) {
//                           final pharmacy = provider.filteredPharmacies[index];
//                           return _buildPharmacyItem(context, pharmacy);
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPharmacyItem(BuildContext context, Pharmacy pharmacy) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(width: 1, color: Color.fromARGB(255, 205, 205, 205)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 2,
//             offset: Offset(0, 1),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(16),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(16),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => PharmacyScreen(pharmacyId: pharmacy.id,),
//                 settings: RouteSettings(arguments: pharmacy),
//               ),
//             );
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Row(
//               children: [
//                 // Pharmacy Image
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: pharmacy.image.isNotEmpty
//                       ? Image.network(
//                           pharmacy.image,
//                           width: 90,
//                           height: 90,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Container(
//                               width: 90,
//                               height: 90,
//                               decoration: BoxDecoration(
//                                 color: Colors.grey[200],
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Icon(
//                                 Icons.local_pharmacy,
//                                 size: 40,
//                                 color: Colors.grey[400],
//                               ),
//                             );
//                           },
//                           loadingBuilder: (context, child, loadingProgress) {
//                             if (loadingProgress == null) return child;
//                             return Container(
//                               width: 90,
//                               height: 90,
//                               decoration: BoxDecoration(
//                                 color: Colors.grey[200],
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child:const Center(
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                   color: Color(0xFF5931DD),
//                                 ),
//                               ),
//                             );
//                           },
//                         )
//                       : Container(
//                           width: 90,
//                           height: 90,
//                           decoration: BoxDecoration(
//                             color: Colors.grey[200],
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Icon(
//                             Icons.local_pharmacy,
//                             size: 40,
//                             color: Colors.grey[400],
//                           ),
//                         ),
//                 ),
//                 SizedBox(width: 16),

//                 // Pharmacy Details
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         pharmacy.name,
//                         style:const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     const  SizedBox(height: 4),
//                       Row(
//                         children: [
//                         const  Icon(
//                             Icons.location_on,
//                             size: 16,
//                             color: Colors.indigo,
//                           ),
//                         const  SizedBox(width: 4),
//                           Expanded(
//                             child: Text(
//                               "Lat: ${pharmacy.latitude.toStringAsFixed(3)}, Lng: ${pharmacy.longitude.toStringAsFixed(3)}",
//                               style:const TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                       if (pharmacy.categories.isNotEmpty) ...[
//                         SizedBox(height: 4),
//                         Row(
//                           children: [
//                             // Icon(
//                             //   Icons.category,
//                             //   size: 14,
//                             //   color: Colors.green,
//                             // ),
//                             SizedBox(width: 4),
//                             // Expanded(
//                             //   child: Text(
//                             //     "${pharmacy.categories.length} categories available",
//                             //     style: TextStyle(
//                             //       fontSize: 11,
//                             //       color: Colors.green[700],
//                             //     ),
//                             //     maxLines: 1,
//                             //     overflow: TextOverflow.ellipsis,
//                             //   ),
//                             // ),
//                           ],
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),

//                 // Arrow Icon
//                 IconButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => PharmacyScreen(pharmacyId: pharmacy.id,),
//                         settings: RouteSettings(arguments: pharmacy),
//                       ),
//                     );
//                   },
//                   icon: Icon(
//                     Icons.chevron_right,
//                     color: Colors.grey,
//                     size: 24,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLoadingState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircularProgressIndicator(
//             color: Color(0xFF5931DD),
//           ),
//           SizedBox(height: 16),
//           Text(
//             "Loading pharmacies...",
//             style: TextStyle(
//               color: Colors.grey[600],
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildErrorState(String error) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.error_outline,
//             size: 60,
//             color: Colors.red[300],
//           ),
//           SizedBox(height: 16),
//           Text(
//             "Error loading pharmacies",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.red[700],
//             ),
//           ),
//           SizedBox(height: 8),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 32),
//             child: Text(
//               error,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.grey[600],
//                 fontSize: 14,
//               ),
//             ),
//           ),
//           SizedBox(height: 16),
//           ElevatedButton.icon(
//             onPressed: () {
//               context.read<PharmacyProvider>().fetchPharmacies();
//             },
//             icon: Icon(Icons.refresh),
//             label: Text("Retry"),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Color(0xFF5931DD),
//               foregroundColor: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.local_pharmacy_outlined,
//             size: 60,
//             color: Colors.grey[400],
//           ),
//           SizedBox(height: 16),
//           Text(
//             "No pharmacies found",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey[700],
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             "Try adjusting your search or check back later",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.grey[600],
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:medical_user_app/models/user_model.dart';
// import 'package:medical_user_app/providers/profile_provider.dart';
// import 'package:medical_user_app/utils/shared_preferences_helper.dart';
// import 'package:medical_user_app/view/profile_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:medical_user_app/view/pharmacy_screen.dart';
// import 'package:medical_user_app/providers/pharmacy_provider.dart';
// import 'package:medical_user_app/models/pharmacy_model.dart';

// class NearPharmacyScreen extends StatefulWidget {
//   const NearPharmacyScreen({super.key});

//   @override
//   State<NearPharmacyScreen> createState() => _NearPharmacyScreenState();
// }

// class _NearPharmacyScreenState extends State<NearPharmacyScreen> {
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<PharmacyProvider>().fetchPharmacies();
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: RefreshIndicator(
//           onRefresh: () => context.read<PharmacyProvider>().refreshPharmacies(),
//           child: ListView(
//             padding: const EdgeInsets.all(16.0),
//             children: [
//               // Header Row
//               Row(
//                 children: [
//                   Consumer<ProfileProvider>(
//                     builder: (context, profileProvider, child) {
//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const ProfileScreen(),
//                             ),
//                           );
//                         },
//                         child: CircleAvatar(
//                           radius: 24,
//                           backgroundColor: Colors.grey[300],
//                           backgroundImage: profileProvider.hasProfileImage()
//                               ? NetworkImage(
//                                   profileProvider.getProfileImageUrl()!)
//                               : const AssetImage('assets/profile.png')
//                                   as ImageProvider,
//                           child: profileProvider.hasProfileImage()
//                               ? null
//                               : Image.asset('assets/profile.png',
//                                   fit: BoxFit.cover),
//                         ),
//                       );
//                     },
//                   ),
//                   const SizedBox(width: 12),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Hello",
//                           style:
//                               TextStyle(fontSize: 16, color: Colors.grey[600])),
//                       FutureBuilder<User?>(
//                         future: SharedPreferencesHelper.getUser(),
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return const Text(
//                               "Loading...",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             );
//                           } else if (snapshot.hasError) {
//                             return const Text(
//                               "User",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             );
//                           } else if (snapshot.hasData &&
//                               snapshot.data != null) {
//                             return Text(
//                               snapshot.data!.name,
//                               style: const TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             );
//                           } else {
//                             return const Text(
//                               "Guest",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             );
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                   const Spacer(),
//                   const Column(
//                     children: [
//                       Icon(Icons.location_on, size: 24, color: Colors.black54),
//                       Text("Kakinada", style: TextStyle(fontSize: 10)),
//                     ],
//                   ),
//                   const SizedBox(width: 12),
//                   Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                         color: Colors.grey[100],
//                         borderRadius: BorderRadius.circular(5)),
//                     child: const Icon(Icons.translate_outlined,
//                         size: 24, color: Colors.black54),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),

//               // Search Row
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _searchController,
//                       onChanged: (value) {
//                         context
//                             .read<PharmacyProvider>()
//                             .searchPharmacies(value);
//                       },
//                       decoration: InputDecoration(
//                         hintText: 'Search your Medicine, Pharmacy...',
//                         prefixIcon:
//                             const Icon(Icons.search, color: Colors.grey),
//                         suffixIcon: _searchController.text.isNotEmpty
//                             ? IconButton(
//                                 icon:
//                                     const Icon(Icons.clear, color: Colors.grey),
//                                 onPressed: () {
//                                   _searchController.clear();
//                                   context
//                                       .read<PharmacyProvider>()
//                                       .clearSearch();
//                                 },
//                               )
//                             : null,
//                         contentPadding:
//                             const EdgeInsets.symmetric(vertical: 12),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: BorderSide(color: Colors.grey[300]!),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: const BorderSide(
//                               color: Color(0xFF5931DD), width: 2),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: BorderSide(color: Colors.grey[300]!),
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: const BoxDecoration(
//                       color: Color(0xFF5931DD),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(Icons.mic, color: Colors.white),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),

//               // Nearby Pharmacies Section
//               const Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Nearby Pharmacies",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               // Pharmacy List
//               Consumer<PharmacyProvider>(
//                 builder: (context, provider, child) {
//                   if (provider.isLoading) {
//                     return _buildLoadingState();
//                   }
//                   if (provider.errorMessage.isNotEmpty) {
//                     return _buildErrorState(provider.errorMessage);
//                   }
//                   if (provider.filteredPharmacies.isEmpty) {
//                     return _buildEmptyState();
//                   }
//                   return ListView.separated(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: provider.filteredPharmacies.length,
//                     separatorBuilder: (context, index) =>
//                         const SizedBox(height: 12),
//                     itemBuilder: (context, index) {
//                       final pharmacy = provider.filteredPharmacies[index];
//                       return _buildPharmacyItem(context, pharmacy);
//                     },
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPharmacyItem(BuildContext context, Pharmacy pharmacy) {
//     return Container(
//       height: 99,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(width: 1, color: Colors.grey[300]!),
//       ),
//       child: ListTile(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => PharmacyScreen(pharmacyId: pharmacy.id),
//               settings: RouteSettings(arguments: pharmacy),
//             ),
//           );
//         },
//         leading: ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: (pharmacy.image.isNotEmpty)
//               ? Image.network(
//                   pharmacy.image,
//                   width: 60,
//                   height: 60,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) {
//                     return const Icon(Icons.local_pharmacy, size: 40);
//                   },
//                 )
//               : const Icon(Icons.local_pharmacy, size: 40),
//         ),
//         title: Text(pharmacy.name,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         subtitle: Text(
//           "Lat: ${pharmacy.latitude.toStringAsFixed(3)}, Lng: ${pharmacy.longitude.toStringAsFixed(3)}",
//           style: const TextStyle(fontSize: 12, color: Colors.grey),
//         ),
//         trailing: const Icon(Icons.chevron_right),
//       ),
//     );
//   }

//   Widget _buildLoadingState() => const Center(
//         child: Padding(
//           padding: EdgeInsets.all(24.0),
//           child: CircularProgressIndicator(color: Color(0xFF5931DD)),
//         ),
//       );

//   Widget _buildErrorState(String error) => Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child:
//               Text("Error: $error", style: TextStyle(color: Colors.red[700])),
//         ),
//       );

//   Widget _buildEmptyState() => const Center(
//         child: Padding(
//           padding: EdgeInsets.all(24.0),
//           child: Text("No pharmacies found"),
//         ),
//       );
// }



import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medical_user_app/models/user_model.dart';
import 'package:medical_user_app/providers/profile_provider.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';
import 'package:medical_user_app/view/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:medical_user_app/view/pharmacy_screen.dart';
import 'package:medical_user_app/providers/pharmacy_provider.dart';
import 'package:medical_user_app/models/pharmacy_model.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';

class NearPharmacyScreen extends StatefulWidget {
  const NearPharmacyScreen({super.key});

  @override
  State<NearPharmacyScreen> createState() => _NearPharmacyScreenState();
}

class _NearPharmacyScreenState extends State<NearPharmacyScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late SpeechToText _speechToText;
  bool _speechEnabled = false;
  bool _isListening = false;
  String _lastWords = '';
  Pharmacy? selectedPharmacy;
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _initSpeech();
    _setupAnimations();
    _getCurrentLocation();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PharmacyProvider>().fetchPharmacies();
    });
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  /// Initialize the speech-to-text plugin
  void _initSpeech() async {
    _speechToText = SpeechToText();
    _speechEnabled = await _speechToText.initialize(
      onError: (errorNotification) {
        final errorMsg = errorNotification.errorMsg;
        if (errorMsg != 'error_no_match' &&
            errorMsg != 'error_network_timeout' &&
            errorMsg != 'error_network') {
          print('Speech recognition error: $errorMsg');
        }
        // _showErrorSnackBar(
        //     'Speech recognition error: ${errorNotification.errorMsg}');
        _stopListening();
      },
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          _stopListening();
        }
      },
    );
    setState(() {});
  }

  /// Start listening for speech input
  void _startListening() async {
    // Check microphone permission
    final permission = await Permission.microphone.status;
    if (permission.isDenied) {
      final result = await Permission.microphone.request();
      if (!result.isGranted) {
        // _showErrorSnackBar(
        //     'Microphone permission is required for voice search');
        return;
      }
    }

    if (_speechEnabled && !_isListening) {
      setState(() {
        _isListening = true;
        _lastWords = '';
      });

      _animationController.repeat(reverse: true);

      await _speechToText.listen(
        onResult: (result) {
          setState(() {
            _lastWords = result.recognizedWords;
            _searchController.text = _lastWords;
          });
          // Update search results as user speaks
          context.read<PharmacyProvider>().searchPharmacies(_lastWords);
        },
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 3),
        partialResults: true,
        cancelOnError: true,
        listenMode: ListenMode.confirmation,
      );
    }
  }

  /// Stop listening for speech input
  void _stopListening() async {
    if (_isListening) {
      await _speechToText.stop();
      setState(() {
        _isListening = false;
      });
      _animationController.stop();
      _animationController.reset();
    }
  }

  String _currentLocation = "Getting location...";

// Add this method to get user's current location
  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _currentLocation = "Location permission denied";
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _currentLocation = "Location permission permanently denied";
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition();

      // You can use reverse geocoding to get address from coordinates
      // For now, showing coordinates
      setState(() {
        _currentLocation =
            "Lat: ${position.latitude.toStringAsFixed(3)}, Lng: ${position.longitude.toStringAsFixed(3)}";
      });
    } catch (e) {
      setState(() {
        _currentLocation = "Error getting location";
      });
    }
  }

  /// Toggle between start and stop listening
  void _toggleListening() {
    if (_isListening) {
      _stopListening();
    } else {
      _startListening();
    }
  }

  // void _showErrorSnackBar(String message) {
  //  const Text('Result not found');
  //   // ScaffoldMessenger.of(context).showSnackBar(
  //   //   SnackBar(
  //   //     content: Text(message),
  //   //     backgroundColor: Colors.red,
  //   //     behavior: SnackBarBehavior.floating,
  //   //   ),
  //   // );
  // }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => context.read<PharmacyProvider>().refreshPharmacies(),
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // Header Row
              Row(
                children: [
                  Consumer<ProfileProvider>(
                    builder: (context, profileProvider, child) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: profileProvider.hasProfileImage()
                              ? NetworkImage(
                                  profileProvider.getProfileImageUrl()!)
                              : null, // No background image if there's no profile
                          child: profileProvider.hasProfileImage()
                              ? null
                              : const Icon(
                                  Icons.person,
                                  size: 30,
                                  color: Colors.grey,
                                ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello",
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[600])),
                      FutureBuilder<User?>(
                        future: SharedPreferencesHelper.getUser(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text(
                              "Loading...",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            );
                          } else if (snapshot.hasError) {
                            return const Text(
                              "User",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            );
                          } else if (snapshot.hasData &&
                              snapshot.data != null) {
                            return Text(
                              snapshot.data!.name,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            );
                          } else {
                            return const Text(
                              "Guest",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  Spacer(),
//                   Column(
//                     children: [
//                       Icon(Icons.location_on, size: 24, color: Colors.black54),
//                       // Text("Hyderabad", style: TextStyle(fontSize: 10)),
// Text(selectedPharmacy?.address ?? "No address available")
//                       // Text(ph)
//                       // Text(selectedPharmacy?.address ?? "No address available")
//                     ],
//                   ),

// Replace the location column with Consumer:
                  Consumer<PharmacyProvider>(
                    builder: (context, provider, child) {
                      String locationText = "No location";

                      if (provider.isLoading) {
                        locationText = "Loading...";
                      } else if (provider.filteredPharmacies.isNotEmpty) {
                        // Show first pharmacy's city or a shortened address
                        String address =
                            provider.filteredPharmacies.first.address;
                        // Extract city name or limit address length
                        locationText = address.length > 15
                            ? "${address.substring(0, 15)}..."
                            : address;
                      } else {
                        locationText = ""; // Default location
                      }

                      return Column(
                        children: [
                          const Icon(Icons.location_on,
                              size: 24, color: Colors.black54),
                          Text(locationText,
                              style: const TextStyle(fontSize: 10)),
                        ],
                      );
                    },
                  ),
                  // const SizedBox(width: 12),
                  // Container(
                  //   padding: const EdgeInsets.all(8),
                  //   decoration: BoxDecoration(
                  //       color: Colors.grey[100],
                  //       borderRadius: BorderRadius.circular(5)),
                  //   child: const Icon(Icons.translate_outlined,
                  //       size: 24, color: Colors.black54),
                  // ),
                ],
              ),
              const SizedBox(height: 24),

              // Search Row with Voice Recognition
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        context
                            .read<PharmacyProvider>()
                            .searchPharmacies(value);
                      },
                      decoration: InputDecoration(
                        hintText: _isListening
                            ? 'Listening...'
                            : 'Search your Pharmacy...',
                        hintStyle: TextStyle(
                          color: _isListening
                              ? const Color(0xFF5931DD)
                              : Colors.grey,
                          fontStyle: _isListening
                              ? FontStyle.italic
                              : FontStyle.normal,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: _isListening
                              ? const Color(0xFF5931DD)
                              : Colors.grey,
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon:
                                    const Icon(Icons.clear, color: Colors.grey),
                                onPressed: () {
                                  _searchController.clear();
                                  context
                                      .read<PharmacyProvider>()
                                      .clearSearch();
                                },
                              )
                            : null,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: _isListening
                                ? const Color(0xFF5931DD)
                                : Colors.grey[300]!,
                            width: _isListening ? 2 : 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: Color(0xFF5931DD), width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: _isListening
                                ? const Color(0xFF5931DD)
                                : Colors.grey[300]!,
                            width: _isListening ? 2 : 1,
                          ),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFEFF3F7),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Voice Search Button with Animation
                  // GestureDetector(
                  //   onTap: _speechEnabled ? _toggleListening : null,
                  //   child: AnimatedBuilder(
                  //     animation: _pulseAnimation,
                  //     builder: (context, child) {
                  //       return Transform.scale(
                  //         scale: _isListening ? _pulseAnimation.value : 1.0,
                  //         child: Container(
                  //           padding: const EdgeInsets.all(12),
                  //           decoration: BoxDecoration(
                  //             color: _isListening
                  //                 ? Colors.red
                  //                 : (_speechEnabled
                  //                     ? const Color(0xFF5931DD)
                  //                     : Colors.grey),
                  //             shape: BoxShape.circle,
                  //             boxShadow: _isListening
                  //                 ? [
                  //                     BoxShadow(
                  //                       color: Colors.red.withOpacity(0.3),
                  //                       spreadRadius: 2,
                  //                       blurRadius: 8,
                  //                     ),
                  //                   ]
                  //                 : null,
                  //           ),
                  //           child: Icon(
                  //             _isListening ? Icons.mic : Icons.mic_none,
                  //             color: Colors.white,
                  //             size: 24,
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),

              // Voice Status Indicator
              if (_isListening)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5931DD).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _lastWords.isEmpty ? 'Say something...' : _lastWords,
                        style: const TextStyle(
                          color: Color(0xFF5931DD),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 24),

              // Nearby Pharmacies Section
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nearby Pharmacies",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Pharmacy List
              Consumer<PharmacyProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return _buildLoadingState();
                  }
                  if (provider.errorMessage.isNotEmpty) {
                    return _buildErrorState(provider.errorMessage);
                  }
                  if (provider.filteredPharmacies.isEmpty) {
                    return _buildEmptyState();
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.filteredPharmacies.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final pharmacy = provider.filteredPharmacies[index];
                      return _buildPharmacyItem(context, pharmacy);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildPharmacyItem(BuildContext context, Pharmacy pharmacy) {
  //   return Container(
  //     height: 99,
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(16),
  //       border: Border.all(width: 1, color: Colors.grey[300]!),
  //     ),
  //     child: ListTile(
  //       onTap: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => PharmacyScreen(pharmacyId: pharmacy.id),
  //             settings: RouteSettings(arguments: pharmacy),
  //           ),
  //         );
  //       },
  //       leading: ClipRRect(
  //         borderRadius: BorderRadius.circular(8),
  //         child: (pharmacy.image.isNotEmpty)
  //             ? Image.network(
  //                 pharmacy.image,
  //                 width: 60,
  //                 height: 60,
  //                 fit: BoxFit.cover,
  //                 errorBuilder: (context, error, stackTrace) {
  //                   return const Icon(Icons.local_pharmacy, size: 40);
  //                 },
  //               )
  //             : const Icon(Icons.local_pharmacy, size: 40),
  //       ),
  //       title: Text(pharmacy.name,
  //           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //       subtitle: Text(
  //         '${pharmacy.address}',
  //         // "Lat: ${pharmacy.latitude.toStringAsFixed(3)}, Lng: ${pharmacy.longitude.toStringAsFixed(3)}",
  //         style: const TextStyle(fontSize: 12, color: Colors.grey),
  //       ),
  //       trailing: const Icon(Icons.chevron_right),
  //     ),
  //   );
  // }

  Widget _buildPharmacyItem(BuildContext context, Pharmacy pharmacy) {
    return Container(
      height: 99,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PharmacyScreen(pharmacyId: pharmacy.id),
              settings: RouteSettings(arguments: pharmacy),
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Pharmacy Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: (pharmacy.image.isNotEmpty)
                  ? Image.network(
                      pharmacy.image,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.local_pharmacy, size: 40);
                      },
                    )
                  : const Icon(Icons.local_pharmacy, size: 40),
            ),
            const SizedBox(width: 12),

            // Pharmacy Name + Address
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pharmacy.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pharmacy.address,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Right Arrow
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() => const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: CircularProgressIndicator(color: Color(0xFF5931DD)),
        ),
      );

  Widget _buildErrorState(String error) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text('No pharmacies found'),
          // child:
          //     Text("Error: $error", style: TextStyle(color: Colors.red[700])),
        ),
      );

  Widget _buildEmptyState() => const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text("No pharmacies found"),
        ),
      );
}
