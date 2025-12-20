// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:medical_user_app/providers/language_provider.dart';
// // // // // import 'package:medical_user_app/view/home_screen.dart';

// // // // // class PeriodicMedsPlanCardSimple extends StatelessWidget {
// // // // //   const PeriodicMedsPlanCardSimple({Key? key}) : super(key: key);

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Container(
// // // // //       width: double.infinity,
// // // // //       height: 160,
// // // // //       decoration: BoxDecoration(
// // // // //         color: Colors.white,
// // // // //         borderRadius: BorderRadius.circular(16),
// // // // //         boxShadow: [
// // // // //           BoxShadow(
// // // // //             color: Colors.grey.withOpacity(0.1),
// // // // //             spreadRadius: 1,
// // // // //             blurRadius: 4,
// // // // //             offset: const Offset(0, 1),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //       child: Stack(
// // // // //         clipBehavior: Clip.none, // Allow overflow for buttons
// // // // //         children: [
// // // // //           // Purple curved background
// // // // //           Positioned(
// // // // //             right: 0,
// // // // //             top: 0,
// // // // //             bottom: 0,
// // // // //             child: ClipPath(
// // // // //               clipper: CurvedClipper(),
// // // // //               child: Container(
// // // // //                 width: 150,
// // // // //                 decoration: const BoxDecoration(
// // // // //                   color: Color(0xFF5931DD),
// // // // //                 ),
// // // // //                 child: Center(
// // // // //                   child: Padding(
// // // // //                     padding: const EdgeInsets.only(left: 20),
// // // // //                     child: Image.asset(
// // // // //                       'assets/doctor.png',
// // // // //                       width: 80,
// // // // //                       height: 80,
// // // // //                       fit: BoxFit.contain,
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),
// // // // //               ),
// // // // //             ),
// // // // //           ),

// // // // //           // Content (text + buttons)
// // // // //           Padding(
// // // // //             padding: const EdgeInsets.all(16),
// // // // //             child: Column(
// // // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // // //               children: [
// // // // //                 const AppText(
// // // // //                   "periodic_meds",
// // // // //                   style: TextStyle(
// // // // //                     fontSize: 20,
// // // // //                     fontWeight: FontWeight.bold,
// // // // //                   ),
// // // // //                 ),
// // // // //                 const SizedBox(height: 2),
// // // // //                 const AppText(
// // // // //                   "plan",
// // // // //                   style: TextStyle(
// // // // //                     fontSize: 20,
// // // // //                     fontWeight: FontWeight.bold,
// // // // //                   ),
// // // // //                 ),
// // // // //                 const Spacer(),

// // // // //                 // Buttons row (without limiting width too much)
// // // // //                 Row(
// // // // //                   children: [
// // // // //                     // Activate button
// // // // //                     Expanded(
// // // // //                       flex: 5,
// // // // //                       child: ElevatedButton(
// // // // //                         onPressed: () {
// // // // //                          MedicineDetailsModal(name: 'name', description: 'description', price: '100', location: 'kakinada', imagePath: 'imagepath',);
// // // // //                         },
// // // // //                         style: ElevatedButton.styleFrom(
// // // // //                           backgroundColor: const Color(0xFF5931DD),
// // // // //                           foregroundColor: Colors.white,
// // // // //                           padding: const EdgeInsets.symmetric(vertical: 12),
// // // // //                           shape: RoundedRectangleBorder(
// // // // //                             borderRadius: BorderRadius.circular(24),
// // // // //                           ),
// // // // //                         ),
// // // // //                         child: const AppText(
// // // // //                           "activate",
// // // // //                           style: TextStyle(
// // // // //                             fontSize: 16,
// // // // //                             fontWeight: FontWeight.w500,
// // // // //                           ),
// // // // //                         ),
// // // // //                       ),
// // // // //                     ),
// // // // //                     const SizedBox(width: 8),

// // // // //                     // Details button (allow overlap)
// // // // //                     Expanded(
// // // // //                       flex: 4,
// // // // //                       child: OutlinedButton(
// // // // //                         onPressed: () {},
// // // // //                         style: OutlinedButton.styleFrom(
// // // // //                           side: const BorderSide(color: Color(0xFF5931DD)),
// // // // //                           foregroundColor: const Color(0xFF5931DD),
// // // // //                           padding: const EdgeInsets.symmetric(vertical: 12),
// // // // //                           shape: RoundedRectangleBorder(
// // // // //                             borderRadius: BorderRadius.circular(24),
// // // // //                           ),
// // // // //                           backgroundColor: Colors.white,
// // // // //                           elevation: 0,
// // // // //                         ),
// // // // //                         child: const AppText(
// // // // //                           "details",
// // // // //                           style: TextStyle(
// // // // //                             fontSize: 16,
// // // // //                             fontWeight: FontWeight.w500,
// // // // //                           ),
// // // // //                         ),
// // // // //                       ),
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // // class CurvedClipper extends CustomClipper<Path> {
// // // // //   @override
// // // // //   Path getClip(Size size) {
// // // // //     final path = Path();

// // // // //     path.moveTo(size.width, 0);
// // // // //     path.lineTo(size.width, size.height);
// // // // //     path.quadraticBezierTo(
// // // // //       size.width * 0.3, size.height * 0.85,
// // // // //       size.width * 0.2, size.height * 0.5,
// // // // //     );
// // // // //     path.quadraticBezierTo(
// // // // //       size.width * 0.3, size.height * 0.15,
// // // // //       size.width, 0,
// // // // //     );
// // // // //     path.close();
// // // // //     return path;
// // // // //   }

// // // // //   @override
// // // // //   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// // // // // }

// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:medical_user_app/providers/language_provider.dart';
// // // // // import 'package:medical_user_app/view/home_screen.dart';

// // // // // class PeriodicMedsPlanCardSimple extends StatelessWidget {
// // // // //   const PeriodicMedsPlanCardSimple({Key? key}) : super(key: key);

// // // // //   // Method to show bottom modal with medicine details
// // // // //   void _showMedicineDetailsModal(
// // // // //     BuildContext context, {
// // // // //     required String name,
// // // // //     required String description,
// // // // //     required String price,
// // // // //     required String location,
// // // // //     required String imagePath,
// // // // //   }) {
// // // // //     showModalBottomSheet(
// // // // //       context: context,
// // // // //       isScrollControlled: true,
// // // // //       backgroundColor: Colors.transparent,
// // // // //       builder: (context) => MedicineDetailsModal(
// // // // //         name: name,
// // // // //         description: description,
// // // // //         price: price,
// // // // //         location: location,
// // // // //         imagePath: imagePath,
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Container(
// // // // //       width: double.infinity,
// // // // //       height: 160,
// // // // //       decoration: BoxDecoration(
// // // // //         color: Colors.white,
// // // // //         borderRadius: BorderRadius.circular(16),
// // // // //         boxShadow: [
// // // // //           BoxShadow(
// // // // //             color: Colors.grey.withOpacity(0.1),
// // // // //             spreadRadius: 1,
// // // // //             blurRadius: 4,
// // // // //             offset: const Offset(0, 1),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //       child: Stack(
// // // // //         clipBehavior: Clip.none, // Allow overflow for buttons
// // // // //         children: [
// // // // //           // Purple curved background
// // // // //           Positioned(
// // // // //             right: 0,
// // // // //             top: 0,
// // // // //             bottom: 0,
// // // // //             child: ClipPath(
// // // // //               clipper: CurvedClipper(),
// // // // //               child: Container(
// // // // //                 width: 150,
// // // // //                 decoration: const BoxDecoration(
// // // // //                   color: Color(0xFF5931DD),
// // // // //                 ),
// // // // //                 child: Center(
// // // // //                   child: Padding(
// // // // //                     padding: const EdgeInsets.only(left: 20),
// // // // //                     child: Image.asset(
// // // // //                       'assets/doctor.png',
// // // // //                       width: 80,
// // // // //                       height: 80,
// // // // //                       fit: BoxFit.contain,
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),
// // // // //               ),
// // // // //             ),
// // // // //           ),

// // // // //           // Content (text + buttons)
// // // // //           Padding(
// // // // //             padding: const EdgeInsets.all(16),
// // // // //             child: Column(
// // // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // // //               children: [
// // // // //                 const AppText(
// // // // //                   "periodic_meds",
// // // // //                   style: TextStyle(
// // // // //                     fontSize: 20,
// // // // //                     fontWeight: FontWeight.bold,
// // // // //                   ),
// // // // //                 ),
// // // // //                 const SizedBox(height: 2),
// // // // //                 const AppText(
// // // // //                   "plan",
// // // // //                   style: TextStyle(
// // // // //                     fontSize: 20,
// // // // //                     fontWeight: FontWeight.bold,
// // // // //                   ),
// // // // //                 ),
// // // // //                 const Spacer(),

// // // // //                 // Buttons row (without limiting width too much)
// // // // //                 Row(
// // // // //                   children: [
// // // // //                     // Activate button - FIXED
// // // // //                     Expanded(
// // // // //                       flex: 5,
// // // // //                       child: ElevatedButton(
// // // // //                         onPressed: () {
// // // // //                           // Now properly calling the modal method
// // // // //                           _showMedicineDetailsModal(
// // // // //                             context,
// // // // //                             name: 'Sample Medicine Store',
// // // // //                             description: 'High quality medicines available',
// // // // //                             price: '100',
// // // // //                             location: 'Kakinada, Andhra Pradesh',
// // // // //                             imagePath: 'https://png.pngtree.com/png-clipart/20240619/original/pngtree-drug-capsule-pill-from-prescription-in-drugstore-pharmacy-for-treatment-health-png-image_15366552.png',
// // // // //                           );
// // // // //                         },
// // // // //                         style: ElevatedButton.styleFrom(
// // // // //                           backgroundColor: const Color(0xFF5931DD),
// // // // //                           foregroundColor: Colors.white,
// // // // //                           padding: const EdgeInsets.symmetric(vertical: 12),
// // // // //                           shape: RoundedRectangleBorder(
// // // // //                             borderRadius: BorderRadius.circular(24),
// // // // //                           ),
// // // // //                         ),
// // // // //                         child: const AppText(
// // // // //                           "activate",
// // // // //                           style: TextStyle(
// // // // //                             fontSize: 16,
// // // // //                             fontWeight: FontWeight.w500,
// // // // //                           ),
// // // // //                         ),
// // // // //                       ),
// // // // //                     ),
// // // // //                     const SizedBox(width: 8),

// // // // //                     // Details button (allow overlap)
// // // // //                     Expanded(
// // // // //                       flex: 4,
// // // // //                       child: OutlinedButton(
// // // // //                         onPressed: () {},
// // // // //                         style: OutlinedButton.styleFrom(
// // // // //                           side: const BorderSide(color: Color(0xFF5931DD)),
// // // // //                           foregroundColor: const Color(0xFF5931DD),
// // // // //                           padding: const EdgeInsets.symmetric(vertical: 12),
// // // // //                           shape: RoundedRectangleBorder(
// // // // //                             borderRadius: BorderRadius.circular(24),
// // // // //                           ),
// // // // //                           backgroundColor: Colors.white,
// // // // //                           elevation: 0,
// // // // //                         ),
// // // // //                         child: const AppText(
// // // // //                           "details",
// // // // //                           style: TextStyle(
// // // // //                             fontSize: 16,
// // // // //                             fontWeight: FontWeight.w500,
// // // // //                           ),
// // // // //                         ),
// // // // //                       ),
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // // class CurvedClipper extends CustomClipper<Path> {
// // // // //   @override
// // // // //   Path getClip(Size size) {
// // // // //     final path = Path();

// // // // //     path.moveTo(size.width, 0);
// // // // //     path.lineTo(size.width, size.height);
// // // // //     path.quadraticBezierTo(
// // // // //       size.width * 0.3, size.height * 0.85,
// // // // //       size.width * 0.2, size.height * 0.5,
// // // // //     );
// // // // //     path.quadraticBezierTo(
// // // // //       size.width * 0.3, size.height * 0.15,
// // // // //       size.width, 0,
// // // // //     );
// // // // //     path.close();
// // // // //     return path;
// // // // //   }

// // // // //   @override
// // // // //   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// // // // // }

// // // // import 'package:flutter/material.dart';
// // // // import 'package:provider/provider.dart';
// // // // import 'package:medical_user_app/providers/language_provider.dart';
// // // // import 'package:medical_user_app/providers/pharmacy_provider.dart';
// // // // import 'package:medical_user_app/models/pharmacy_model.dart';
// // // // import 'package:medical_user_app/view/home_screen.dart';

// // // // class PeriodicMedsPlanCardSimple extends StatelessWidget {
// // // //   const PeriodicMedsPlanCardSimple({Key? key}) : super(key: key);

// // // //   // Method to show bottom modal with medicine details using actual pharmacy data
// // // //   void _showMedicineDetailsModal(
// // // //     BuildContext context, {
// // // //     Pharmacy? pharmacy,
// // // //     String? medicineName,
// // // //     String? description,
// // // //     String? price,
// // // //   }) {
// // // //     // Use the first available pharmacy if none provided
// // // //     final pharmacyProvider = context.read<PharmacyProvider>();
// // // //     final selectedPharmacy = pharmacy ??
// // // //         (pharmacyProvider.filteredPharmacies.isNotEmpty
// // // //             ? pharmacyProvider.filteredPharmacies.first
// // // //             : null);

// // // //     if (selectedPharmacy == null) {
// // // //       // Show error or fetch pharmacies first
// // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // //         const SnackBar(
// // // //           content: Text('No pharmacies available. Please try again.'),
// // // //           backgroundColor: Colors.red,
// // // //         ),
// // // //       );
// // // //       return;
// // // //     }

// // // //     showModalBottomSheet(
// // // //       context: context,
// // // //       isScrollControlled: true,
// // // //       backgroundColor: Colors.transparent,
// // // //       builder: (context) => MedicineDetailsModal(
// // // //         pharmacyName: selectedPharmacy.name,
// // // //         medicineName: medicineName ?? 'Paracetamol 500mg',
// // // //         description: description ??
// // // //             'Pain relief and fever reducer - Take as prescribed by doctor',
// // // //         price: price ?? '45.00',
// // // //         location: _formatLocation(selectedPharmacy),
// // // //         pharmacyImage: selectedPharmacy.image,
// // // //       ),
// // // //     );
// // // //   }

// // // //   // Helper method to format location from coordinates
// // // //   String _formatLocation(Pharmacy pharmacy) {
// // // //     return "Lat: ${pharmacy.latitude.toStringAsFixed(3)}, Lng: ${pharmacy.longitude.toStringAsFixed(3)}";
// // // //   }

// // // //   // Method to get a random pharmacy for demonstration
// // // //   Pharmacy? _getRandomPharmacy(List<Pharmacy> pharmacies) {
// // // //     if (pharmacies.isEmpty) return null;
// // // //     return pharmacies[
// // // //         (DateTime.now().millisecondsSinceEpoch % pharmacies.length)];
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Consumer<PharmacyProvider>(
// // // //       builder: (context, pharmacyProvider, child) {
// // // //         // Auto-fetch pharmacies if not loaded
// // // //         if (pharmacyProvider.pharmacies.isEmpty &&
// // // //             !pharmacyProvider.isLoading) {
// // // //           WidgetsBinding.instance.addPostFrameCallback((_) {
// // // //             pharmacyProvider.fetchPharmacies();
// // // //           });
// // // //         }

// // // //         return Container(
// // // //           width: double.infinity,
// // // //           height: 160,
// // // //           decoration: BoxDecoration(
// // // //             color: Colors.white,
// // // //             borderRadius: BorderRadius.circular(16),
// // // //             boxShadow: [
// // // //               BoxShadow(
// // // //                 color: Colors.grey.withOpacity(0.1),
// // // //                 spreadRadius: 1,
// // // //                 blurRadius: 4,
// // // //                 offset: const Offset(0, 1),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //           child: Stack(
// // // //             clipBehavior: Clip.none,
// // // //             children: [
// // // //               // Purple curved background
// // // //               Positioned(
// // // //                 right: 0,
// // // //                 top: 0,
// // // //                 bottom: 0,
// // // //                 child: ClipPath(
// // // //                   clipper: CurvedClipper(),
// // // //                   child: Container(
// // // //                     width: 150,
// // // //                     decoration: const BoxDecoration(
// // // //                       color: Color(0xFF5931DD),
// // // //                     ),
// // // //                     child: Center(
// // // //                       child: Padding(
// // // //                         padding: const EdgeInsets.only(left: 20),
// // // //                         child: Image.asset(
// // // //                           'assets/doctor.png',
// // // //                           width: 80,
// // // //                           height: 80,
// // // //                           fit: BoxFit.contain,
// // // //                         ),
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                 ),
// // // //               ),

// // // //               // Content (text + buttons)
// // // //               Padding(
// // // //                 padding: const EdgeInsets.all(16),
// // // //                 child: Column(
// // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // //                   children: [
// // // //                     const AppText(
// // // //                       "periodic_meds",
// // // //                       style: TextStyle(
// // // //                         fontSize: 20,
// // // //                         fontWeight: FontWeight.bold,
// // // //                       ),
// // // //                     ),
// // // //                     const SizedBox(height: 2),
// // // //                     const AppText(
// // // //                       "plan",
// // // //                       style: TextStyle(
// // // //                         fontSize: 20,
// // // //                         fontWeight: FontWeight.bold,
// // // //                       ),
// // // //                     ),
// // // //                     const Spacer(),

// // // //                     // Buttons row
// // // //                     Row(
// // // //                       children: [
// // // //                         // Activate button - Uses first available pharmacy
// // // //                         Expanded(
// // // //                           flex: 5,
// // // //                           child: ElevatedButton(
// // // //                             onPressed: pharmacyProvider.isLoading
// // // //                                 ? null
// // // //                                 : () {
// // // //                                     final firstPharmacy = pharmacyProvider
// // // //                                             .filteredPharmacies.isNotEmpty
// // // //                                         ? pharmacyProvider
// // // //                                             .filteredPharmacies.first
// // // //                                         : null;

// // // //                                     _showMedicineDetailsModal(
// // // //                                       context,
// // // //                                       pharmacy: firstPharmacy,
// // // //                                       medicineName: 'Paracetamol 500mg',
// // // //                                       description:
// // // //                                           'Pain relief and fever reducer - Take as prescribed by doctor',
// // // //                                       price: '45.00',
// // // //                                     );
// // // //                                   },
// // // //                             style: ElevatedButton.styleFrom(
// // // //                               backgroundColor: const Color(0xFF5931DD),
// // // //                               foregroundColor: Colors.white,
// // // //                               padding: const EdgeInsets.symmetric(vertical: 12),
// // // //                               shape: RoundedRectangleBorder(
// // // //                                 borderRadius: BorderRadius.circular(24),
// // // //                               ),
// // // //                             ),
// // // //                             child: pharmacyProvider.isLoading
// // // //                                 ? const SizedBox(
// // // //                                     width: 16,
// // // //                                     height: 16,
// // // //                                     child: CircularProgressIndicator(
// // // //                                       strokeWidth: 2,
// // // //                                       color: Colors.white,
// // // //                                     ),
// // // //                                   )
// // // //                                 : const AppText(
// // // //                                     "activate",
// // // //                                     style: TextStyle(
// // // //                                       fontSize: 16,
// // // //                                       fontWeight: FontWeight.w500,
// // // //                                     ),
// // // //                                   ),
// // // //                           ),
// // // //                         ),
// // // //                         const SizedBox(width: 8),

// // // //                         // Details button - Uses random pharmacy for variety
// // // //                         Expanded(
// // // //                           flex: 4,
// // // //                           child: OutlinedButton(
// // // //                             onPressed: pharmacyProvider.isLoading
// // // //                                 ? null
// // // //                                 : () {
// // // //                                     final randomPharmacy = _getRandomPharmacy(
// // // //                                         pharmacyProvider.filteredPharmacies);

// // // //                                     _showMedicineDetailsModal(
// // // //                                       context,
// // // //                                       pharmacy: randomPharmacy,
// // // //                                       medicineName: 'Vitamin D3 1000 IU',
// // // //                                       description:
// // // //                                           'Daily vitamin supplement for bone health and immunity',
// // // //                                       price: '120.00',
// // // //                                     );
// // // //                                   },
// // // //                             style: OutlinedButton.styleFrom(
// // // //                               side: const BorderSide(color: Color(0xFF5931DD)),
// // // //                               foregroundColor: const Color(0xFF5931DD),
// // // //                               padding: const EdgeInsets.symmetric(vertical: 12),
// // // //                               shape: RoundedRectangleBorder(
// // // //                                 borderRadius: BorderRadius.circular(24),
// // // //                               ),
// // // //                               backgroundColor: Colors.white,
// // // //                               elevation: 0,
// // // //                             ),
// // // //                             child: const AppText(
// // // //                               "details",
// // // //                               style: TextStyle(
// // // //                                 fontSize: 16,
// // // //                                 fontWeight: FontWeight.w500,
// // // //                               ),
// // // //                             ),
// // // //                           ),
// // // //                         ),
// // // //                       ],
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         );
// // // //       },
// // // //     );
// // // //   }
// // // // }

// // // // class CurvedClipper extends CustomClipper<Path> {
// // // //   @override
// // // //   Path getClip(Size size) {
// // // //     final path = Path();

// // // //     path.moveTo(size.width, 0);
// // // //     path.lineTo(size.width, size.height);
// // // //     path.quadraticBezierTo(
// // // //       size.width * 0.3,
// // // //       size.height * 0.85,
// // // //       size.width * 0.2,
// // // //       size.height * 0.5,
// // // //     );
// // // //     path.quadraticBezierTo(
// // // //       size.width * 0.3,
// // // //       size.height * 0.15,
// // // //       size.width,
// // // //       0,
// // // //     );
// // // //     path.close();
// // // //     return path;
// // // //   }

// // // //   @override
// // // //   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// // // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:provider/provider.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'dart:convert';
// // // import 'package:medical_user_app/providers/language_provider.dart';
// // // import 'package:medical_user_app/providers/pharmacy_provider.dart';
// // // import 'package:medical_user_app/models/pharmacy_model.dart';
// // // import 'package:medical_user_app/view/home_screen.dart';
// // // import 'package:medical_user_app/utils/shared_preferences_helper.dart';

// // // class PeriodicMedsPlanCardSimple extends StatelessWidget {
// // //   const PeriodicMedsPlanCardSimple({Key? key}) : super(key: key);

// // //   // Method to activate periodic meds plan
// // //   Future<bool> _activatePeriodicMedsPlan() async {
// // //     try {
// // //       // Get user ID from SharedPreferences
// // //       final user = await SharedPreferencesHelper.getUser();
// // //       final token = await SharedPreferencesHelper.getToken();

// // //       if (user == null || token == null) {
// // //         print('Error: User or token not found');
// // //         return false;
// // //       }

// // //       final url = 'http://31.97.206.144:7021/api/users/periodicmedsplan/${user.id}';

// // //       final response = await http.put(
// // //         Uri.parse(url),
// // //         headers: {
// // //           'Content-Type': 'application/json',
// // //           'Authorization': 'Bearer $token',
// // //         },
// // //         body: json.encode({
// // //           'isActive': true,
// // //         }),
// // //       );

// // //       if (response.statusCode == 200) {
// // //         print('Periodic meds plan activated successfully');
// // //         return true;
// // //       } else {
// // //         print('Failed to activate periodic meds plan: ${response.statusCode}');
// // //         print('Response body: ${response.body}');
// // //         return false;
// // //       }
// // //     } catch (e) {
// // //       print('Error activating periodic meds plan: $e');
// // //       return false;
// // //     }
// // //   }

// // //   // Method to show bottom modal with medicine details and search functionality
// // //   void _showMedicineDetailsModal(
// // //     BuildContext context, {
// // //     Pharmacy? pharmacy,
// // //     String? medicineName,
// // //     String? description,
// // //     String? price,
// // //     bool showAfterActivation = false,
// // //   }) {
// // //     // Use the first available pharmacy if none provided
// // //     final pharmacyProvider = context.read<PharmacyProvider>();
// // //     final selectedPharmacy = pharmacy ??
// // //         (pharmacyProvider.filteredPharmacies.isNotEmpty
// // //             ? pharmacyProvider.filteredPharmacies.first
// // //             : null);

// // //     if (selectedPharmacy == null && !showAfterActivation) {
// // //       // Show error or fetch pharmacies first
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(
// // //           content: Text('No pharmacies available. Please try again.'),
// // //           backgroundColor: Colors.red,
// // //         ),
// // //       );
// // //       return;
// // //     }

// // //     showModalBottomSheet(
// // //       context: context,
// // //       isScrollControlled: true,
// // //       backgroundColor: Colors.transparent,
// // //       builder: (context) => MedicineDetailsModalWithSearch(
// // //         pharmacyName: selectedPharmacy?.name ?? 'Default Pharmacy',
// // //         medicineName: medicineName ?? 'Paracetamol 500mg',
// // //         description: description ??
// // //             'Pain relief and fever reducer - Take as prescribed by doctor',
// // //         price: price ?? '45.00',
// // //         location: selectedPharmacy != null ? _formatLocation(selectedPharmacy) : 'Location not available',
// // //         pharmacyImage: selectedPharmacy?.image,
// // //         showAfterActivation: showAfterActivation,
// // //       ),
// // //     );
// // //   }

// // //   // Helper method to format location from coordinates
// // //   String _formatLocation(Pharmacy pharmacy) {
// // //     return "Lat: ${pharmacy.latitude.toStringAsFixed(3)}, Lng: ${pharmacy.longitude.toStringAsFixed(3)}";
// // //   }

// // //   // Method to get a random pharmacy for demonstration
// // //   Pharmacy? _getRandomPharmacy(List<Pharmacy> pharmacies) {
// // //     if (pharmacies.isEmpty) return null;
// // //     return pharmacies[
// // //         (DateTime.now().millisecondsSinceEpoch % pharmacies.length)];
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Consumer<PharmacyProvider>(
// // //       builder: (context, pharmacyProvider, child) {
// // //         // Auto-fetch pharmacies if not loaded
// // //         if (pharmacyProvider.pharmacies.isEmpty &&
// // //             !pharmacyProvider.isLoading) {
// // //           WidgetsBinding.instance.addPostFrameCallback((_) {
// // //             pharmacyProvider.fetchPharmacies();
// // //           });
// // //         }

// // //         return Container(
// // //           width: double.infinity,
// // //           height: 160,
// // //           decoration: BoxDecoration(
// // //             color: Colors.white,
// // //             borderRadius: BorderRadius.circular(16),
// // //             boxShadow: [
// // //               BoxShadow(
// // //                 color: Colors.grey.withOpacity(0.1),
// // //                 spreadRadius: 1,
// // //                 blurRadius: 4,
// // //                 offset: const Offset(0, 1),
// // //               ),
// // //             ],
// // //           ),
// // //           child: Stack(
// // //             clipBehavior: Clip.none,
// // //             children: [
// // //               // Purple curved background
// // //               Positioned(
// // //                 right: 0,
// // //                 top: 0,
// // //                 bottom: 0,
// // //                 child: ClipPath(
// // //                   clipper: CurvedClipper(),
// // //                   child: Container(
// // //                     width: 150,
// // //                     decoration: const BoxDecoration(
// // //                       color: Color(0xFF5931DD),
// // //                     ),
// // //                     child: Center(
// // //                       child: Padding(
// // //                         padding: const EdgeInsets.only(left: 20),
// // //                         child: Image.asset(
// // //                           'assets/doctor.png',
// // //                           width: 80,
// // //                           height: 80,
// // //                           fit: BoxFit.contain,
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ),

// // //               // Content (text + buttons)
// // //               Padding(
// // //                 padding: const EdgeInsets.all(16),
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     const AppText(
// // //                       "periodic_meds",
// // //                       style: TextStyle(
// // //                         fontSize: 20,
// // //                         fontWeight: FontWeight.bold,
// // //                       ),
// // //                     ),
// // //                     const SizedBox(height: 2),
// // //                     const AppText(
// // //                       "plan",
// // //                       style: TextStyle(
// // //                         fontSize: 20,
// // //                         fontWeight: FontWeight.bold,
// // //                       ),
// // //                     ),
// // //                     const Spacer(),

// // //                     // Buttons row
// // //                     Row(
// // //                       children: [
// // //                         // Activate button - Calls API and shows modal
// // //                         Expanded(
// // //                           flex: 5,
// // //                           child: ElevatedButton(
// // //                             onPressed: pharmacyProvider.isLoading
// // //                                 ? null
// // //                                 : () async {
// // //                                     // Show loading
// // //                                     showDialog(
// // //                                       context: context,
// // //                                       barrierDismissible: false,
// // //                                       builder: (context) => const Center(
// // //                                         child: CircularProgressIndicator(
// // //                                           color: Color(0xFF5931DD),
// // //                                         ),
// // //                                       ),
// // //                                     );

// // //                                     // Call API to activate periodic meds plan
// // //                                     final success = await _activatePeriodicMedsPlan();

// // //                                     // Hide loading
// // //                                     Navigator.of(context).pop();

// // //                                     if (success) {
// // //                                       // Show success message
// // //                                       ScaffoldMessenger.of(context).showSnackBar(
// // //                                         const SnackBar(
// // //                                           content: Text('Periodic Meds Plan activated successfully!'),
// // //                                           backgroundColor: Colors.green,
// // //                                         ),
// // //                                       );

// // //                                       // Show modal after successful activation
// // //                                       _showMedicineDetailsModal(
// // //                                         context,
// // //                                         showAfterActivation: true,
// // //                                         medicineName: 'Paracetamol 500mg',
// // //                                         description:
// // //                                             'Pain relief and fever reducer - Take as prescribed by doctor',
// // //                                         price: '45.00',
// // //                                       );
// // //                                     } else {
// // //                                       // Show error message
// // //                                       ScaffoldMessenger.of(context).showSnackBar(
// // //                                         const SnackBar(
// // //                                           content: Text('Failed to activate Periodic Meds Plan. Please try again.'),
// // //                                           backgroundColor: Colors.red,
// // //                                         ),
// // //                                       );
// // //                                     }
// // //                                   },
// // //                             style: ElevatedButton.styleFrom(
// // //                               backgroundColor: const Color(0xFF5931DD),
// // //                               foregroundColor: Colors.white,
// // //                               padding: const EdgeInsets.symmetric(vertical: 12),
// // //                               shape: RoundedRectangleBorder(
// // //                                 borderRadius: BorderRadius.circular(24),
// // //                               ),
// // //                             ),
// // //                             child: pharmacyProvider.isLoading
// // //                                 ? const SizedBox(
// // //                                     width: 16,
// // //                                     height: 16,
// // //                                     child: CircularProgressIndicator(
// // //                                       strokeWidth: 2,
// // //                                       color: Colors.white,
// // //                                     ),
// // //                                   )
// // //                                 : const AppText(
// // //                                     "activate",
// // //                                     style: TextStyle(
// // //                                       fontSize: 16,
// // //                                       fontWeight: FontWeight.w500,
// // //                                     ),
// // //                                   ),
// // //                           ),
// // //                         ),
// // //                         const SizedBox(width: 8),

// // //                         // Details button - Uses random pharmacy for variety
// // //                         Expanded(
// // //                           flex: 4,
// // //                           child: OutlinedButton(
// // //                             onPressed: pharmacyProvider.isLoading
// // //                                 ? null
// // //                                 : () {
// // //                                     final randomPharmacy = _getRandomPharmacy(
// // //                                         pharmacyProvider.filteredPharmacies);

// // //                                     _showMedicineDetailsModal(
// // //                                       context,
// // //                                       pharmacy: randomPharmacy,
// // //                                       medicineName: 'Vitamin D3 1000 IU',
// // //                                       description:
// // //                                           'Daily vitamin supplement for bone health and immunity',
// // //                                       price: '120.00',
// // //                                     );
// // //                                   },
// // //                             style: OutlinedButton.styleFrom(
// // //                               side: const BorderSide(color: Color(0xFF5931DD)),
// // //                               foregroundColor: const Color(0xFF5931DD),
// // //                               padding: const EdgeInsets.symmetric(vertical: 12),
// // //                               shape: RoundedRectangleBorder(
// // //                                 borderRadius: BorderRadius.circular(24),
// // //                               ),
// // //                               backgroundColor: Colors.white,
// // //                               elevation: 0,
// // //                             ),
// // //                             child: const AppText(
// // //                               "details",
// // //                               style: TextStyle(
// // //                                 fontSize: 16,
// // //                                 fontWeight: FontWeight.w500,
// // //                               ),
// // //                             ),
// // //                           ),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         );
// // //       },
// // //     );
// // //   }
// // // }

// // // // New Modal Widget with Search Functionality
// // // class MedicineDetailsModalWithSearch extends StatefulWidget {
// // //   final String pharmacyName;
// // //   final String medicineName;
// // //   final String description;
// // //   final String price;
// // //   final String location;
// // //   final String? pharmacyImage;
// // //   final bool showAfterActivation;

// // //   const MedicineDetailsModalWithSearch({
// // //     Key? key,
// // //     required this.pharmacyName,
// // //     required this.medicineName,
// // //     required this.description,
// // //     required this.price,
// // //     required this.location,
// // //     this.pharmacyImage,
// // //     this.showAfterActivation = false,
// // //   }) : super(key: key);

// // //   @override
// // //   State<MedicineDetailsModalWithSearch> createState() => _MedicineDetailsModalWithSearchState();
// // // }

// // // class _MedicineDetailsModalWithSearchState extends State<MedicineDetailsModalWithSearch> {
// // //   final TextEditingController _searchController = TextEditingController();
// // //   List<dynamic> _searchResults = [];
// // //   bool _isSearching = false;
// // //   bool _isActive = true; // Toggle state
// // //   dynamic _selectedMedicine;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _selectedMedicine = {
// // //       'name': widget.medicineName,
// // //       'description': widget.description,
// // //       'price': widget.price,
// // //     };
// // //   }

// // //   // Method to search medicines
// // //   Future<void> _searchMedicines(String query) async {
// // //     if (query.trim().isEmpty) {
// // //       setState(() {
// // //         _searchResults = [];
// // //       });
// // //       return;
// // //     }

// // //     setState(() {
// // //       _isSearching = true;
// // //     });

// // //     try {
// // //       final token = await SharedPreferencesHelper.getToken();
// // //       final url = 'http://31.97.206.144:7021/api/pharmacy/allmedicine?name=${Uri.encodeComponent(query)}';

// // //       final response = await http.get(
// // //         Uri.parse(url),
// // //         headers: {
// // //           'Content-Type': 'application/json',
// // //           if (token != null) 'Authorization': 'Bearer $token',
// // //         },
// // //       );

// // //       if (response.statusCode == 200) {
// // //         final data = json.decode(response.body);
// // //         setState(() {
// // //           _searchResults = data['medicines'] ?? data ?? [];
// // //         });
// // //       } else {
// // //         print('Failed to search medicines: ${response.statusCode}');
// // //         setState(() {
// // //           _searchResults = [];
// // //         });
// // //       }
// // //     } catch (e) {
// // //       print('Error searching medicines: $e');
// // //       setState(() {
// // //         _searchResults = [];
// // //       });
// // //     } finally {
// // //       setState(() {
// // //         _isSearching = false;
// // //       });
// // //     }
// // //   }

// // //   // Method to update periodic meds plan status
// // //   Future<void> _updatePeriodicMedsPlan(bool isActive) async {
// // //     try {
// // //       final user = await SharedPreferencesHelper.getUser();
// // //       final token = await SharedPreferencesHelper.getToken();

// // //       if (user == null || token == null) {
// // //         print('Error: User or token not found');
// // //         return;
// // //       }

// // //       final url = 'http://31.97.206.144:7021/api/users/periodicmedsplan/${user.id}';

// // //       final response = await http.put(
// // //         Uri.parse(url),
// // //         headers: {
// // //           'Content-Type': 'application/json',
// // //           'Authorization': 'Bearer $token',
// // //         },
// // //         body: json.encode({
// // //           'isActive': isActive,
// // //         }),
// // //       );

// // //       if (response.statusCode == 200) {
// // //         print('Periodic meds plan updated successfully: $isActive');
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(
// // //             content: Text(isActive
// // //                 ? 'Periodic Meds Plan activated!'
// // //                 : 'Periodic Meds Plan deactivated!'),
// // //             backgroundColor: isActive ? Colors.green : Colors.orange,
// // //           ),
// // //         );
// // //       } else {
// // //         print('Failed to update periodic meds plan: ${response.statusCode}');
// // //         // Revert toggle state on failure
// // //         setState(() {
// // //           _isActive = !isActive;
// // //         });

// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(
// // //             content: Text('Failed to update plan status. Please try again.'),
// // //             backgroundColor: Colors.red,
// // //           ),
// // //         );
// // //       }
// // //     } catch (e) {
// // //       print('Error updating periodic meds plan: $e');
// // //       // Revert toggle state on error
// // //       setState(() {
// // //         _isActive = !isActive;
// // //       });

// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(
// // //           content: Text('Error updating plan status. Please try again.'),
// // //           backgroundColor: Colors.red,
// // //         ),
// // //       );
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Container(
// // //       height: MediaQuery.of(context).size.height * 0.85,
// // //       decoration: const BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.only(
// // //           topLeft: Radius.circular(20),
// // //           topRight: Radius.circular(20),
// // //         ),
// // //       ),
// // //       child: Column(
// // //         children: [
// // //           // Handle bar
// // //           Container(
// // //             width: 40,
// // //             height: 4,
// // //             margin: const EdgeInsets.symmetric(vertical: 8),
// // //             decoration: BoxDecoration(
// // //               color: Colors.grey[300],
// // //               borderRadius: BorderRadius.circular(2),
// // //             ),
// // //           ),

// // //           // Header with toggle
// // //           Padding(
// // //             padding: const EdgeInsets.all(16),
// // //             child: Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //               children: [
// // //                 const Text(
// // //                   'Periodic Meds Plan',
// // //                   style: TextStyle(
// // //                     fontSize: 20,
// // //                     fontWeight: FontWeight.bold,
// // //                   ),
// // //                 ),
// // //                 Row(
// // //                   children: [
// // //                     Text(
// // //                       _isActive ? 'Active' : 'Inactive',
// // //                       style: TextStyle(
// // //                         color: _isActive ? Colors.green : Colors.grey,
// // //                         fontWeight: FontWeight.w500,
// // //                       ),
// // //                     ),
// // //                     const SizedBox(width: 8),
// // //                     Switch(
// // //                       value: _isActive,
// // //                       onChanged: (value) {
// // //                         setState(() {
// // //                           _isActive = value;
// // //                         });
// // //                         _updatePeriodicMedsPlan(value);
// // //                       },
// // //                       activeColor: const Color(0xFF5931DD),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ],
// // //             ),
// // //           ),

// // //           // Search field
// // //           Padding(
// // //             padding: const EdgeInsets.symmetric(horizontal: 16),
// // //             child: TextField(
// // //               controller: _searchController,
// // //               onChanged: (value) {
// // //                 _searchMedicines(value);
// // //               },
// // //               decoration: InputDecoration(
// // //                 hintText: 'Search your medicine...',
// // //                 prefixIcon: const Icon(Icons.search, color: Color(0xFF5931DD)),
// // //                 suffixIcon: _isSearching
// // //                     ? const SizedBox(
// // //                         width: 20,
// // //                         height: 20,
// // //                         child: Padding(
// // //                           padding: EdgeInsets.all(12),
// // //                           child: CircularProgressIndicator(
// // //                             strokeWidth: 2,
// // //                             color: Color(0xFF5931DD),
// // //                           ),
// // //                         ),
// // //                       )
// // //                     : _searchController.text.isNotEmpty
// // //                         ? IconButton(
// // //                             icon: const Icon(Icons.clear),
// // //                             onPressed: () {
// // //                               _searchController.clear();
// // //                               setState(() {
// // //                                 _searchResults = [];
// // //                               });
// // //                             },
// // //                           )
// // //                         : null,
// // //                 border: OutlineInputBorder(
// // //                   borderRadius: BorderRadius.circular(12),
// // //                   borderSide: const BorderSide(color: Color(0xFF5931DD)),
// // //                 ),
// // //                 focusedBorder: OutlineInputBorder(
// // //                   borderRadius: BorderRadius.circular(12),
// // //                   borderSide: const BorderSide(color: Color(0xFF5931DD), width: 2),
// // //                 ),
// // //               ),
// // //             ),
// // //           ),

// // //           const SizedBox(height: 16),

// // //           // Search results or selected medicine details
// // //           Expanded(
// // //             child: _searchResults.isNotEmpty
// // //                 ? ListView.builder(
// // //                     padding: const EdgeInsets.symmetric(horizontal: 16),
// // //                     itemCount: _searchResults.length,
// // //                     itemBuilder: (context, index) {
// // //                       final medicine = _searchResults[index];
// // //                       return Card(
// // //                         margin: const EdgeInsets.only(bottom: 8),
// // //                         child: ListTile(
// // //                           leading: Container(
// // //                             width: 50,
// // //                             height: 50,
// // //                             decoration: BoxDecoration(
// // //                               color: const Color(0xFF5931DD).withOpacity(0.1),
// // //                               borderRadius: BorderRadius.circular(8),
// // //                             ),
// // //                             child: const Icon(
// // //                               Icons.medication,
// // //                               color: Color(0xFF5931DD),
// // //                             ),
// // //                           ),
// // //                           title: Text(
// // //                             medicine['name'] ?? 'Unknown Medicine',
// // //                             style: const TextStyle(fontWeight: FontWeight.w600),
// // //                           ),
// // //                           subtitle: Column(
// // //                             crossAxisAlignment: CrossAxisAlignment.start,
// // //                             children: [
// // //                               Text(medicine['description'] ?? 'No description'),
// // //                               const SizedBox(height: 4),
// // //                               Text(
// // //                                 '₹${medicine['price'] ?? '0.00'}',
// // //                                 style: const TextStyle(
// // //                                   color: Color(0xFF5931DD),
// // //                                   fontWeight: FontWeight.bold,
// // //                                 ),
// // //                               ),
// // //                             ],
// // //                           ),
// // //                           onTap: () {
// // //                             setState(() {
// // //                               _selectedMedicine = medicine;
// // //                               _searchResults = [];
// // //                               _searchController.clear();
// // //                             });
// // //                           },
// // //                         ),
// // //                       );
// // //                     },
// // //                   )
// // //                 : _buildSelectedMedicineDetails(),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildSelectedMedicineDetails() {
// // //     return Padding(
// // //       padding: const EdgeInsets.all(16),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           // Pharmacy info
// // //           Container(
// // //             padding: const EdgeInsets.all(16),
// // //             decoration: BoxDecoration(
// // //               color: const Color(0xFF5931DD).withOpacity(0.1),
// // //               borderRadius: BorderRadius.circular(12),
// // //             ),
// // //             child: Row(
// // //               children: [
// // //                 Container(
// // //                   width: 60,
// // //                   height: 60,
// // //                   decoration: BoxDecoration(
// // //                     color: Colors.white,
// // //                     borderRadius: BorderRadius.circular(8),
// // //                   ),
// // //                   child: widget.pharmacyImage != null
// // //                       ? ClipRRect(
// // //                           borderRadius: BorderRadius.circular(8),
// // //                           child: Image.network(
// // //                             widget.pharmacyImage!,
// // //                             fit: BoxFit.cover,
// // //                             errorBuilder: (context, error, stackTrace) {
// // //                               return const Icon(
// // //                                 Icons.local_pharmacy,
// // //                                 color: Color(0xFF5931DD),
// // //                                 size: 30,
// // //                               );
// // //                             },
// // //                           ),
// // //                         )
// // //                       : const Icon(
// // //                           Icons.local_pharmacy,
// // //                           color: Color(0xFF5931DD),
// // //                           size: 30,
// // //                         ),
// // //                 ),
// // //                 const SizedBox(width: 12),
// // //                 Expanded(
// // //                   child: Column(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       Text(
// // //                         widget.pharmacyName,
// // //                         style: const TextStyle(
// // //                           fontSize: 16,
// // //                           fontWeight: FontWeight.bold,
// // //                         ),
// // //                       ),
// // //                       Text(
// // //                         widget.location,
// // //                         style: TextStyle(
// // //                           color: Colors.grey[600],
// // //                           fontSize: 12,
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),

// // //           const SizedBox(height: 20),

// // //           // Selected medicine details
// // //           const Text(
// // //             'Selected Medicine',
// // //             style: TextStyle(
// // //               fontSize: 18,
// // //               fontWeight: FontWeight.bold,
// // //             ),
// // //           ),

// // //           const SizedBox(height: 12),

// // //           Container(
// // //             width: double.infinity,
// // //             padding: const EdgeInsets.all(16),
// // //             decoration: BoxDecoration(
// // //               border: Border.all(color: Colors.grey[300]!),
// // //               borderRadius: BorderRadius.circular(12),
// // //             ),
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 Text(
// // //                   _selectedMedicine['name'] ?? 'No medicine selected',
// // //                   style: const TextStyle(
// // //                     fontSize: 18,
// // //                     fontWeight: FontWeight.bold,
// // //                     color: Color(0xFF5931DD),
// // //                   ),
// // //                 ),
// // //                 const SizedBox(height: 8),
// // //                 Text(
// // //                   _selectedMedicine['description'] ?? 'No description available',
// // //                   style: TextStyle(
// // //                     color: Colors.grey[600],
// // //                     fontSize: 14,
// // //                   ),
// // //                 ),
// // //                 const SizedBox(height: 12),
// // //                 Row(
// // //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                   children: [
// // //                     const Text(
// // //                       'Price:',
// // //                       style: TextStyle(
// // //                         fontWeight: FontWeight.w600,
// // //                       ),
// // //                     ),
// // //                     Text(
// // //                       '₹${_selectedMedicine['price'] ?? '0.00'}',
// // //                       style: const TextStyle(
// // //                         fontSize: 18,
// // //                         fontWeight: FontWeight.bold,
// // //                         color: Color(0xFF5931DD),
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ],
// // //             ),
// // //           ),

// // //           const Spacer(),

// // //           // Continue button
// // //           SizedBox(
// // //             width: double.infinity,
// // //             child: ElevatedButton(
// // //               onPressed: () {
// // //                 Navigator.of(context).pop();
// // //                 ScaffoldMessenger.of(context).showSnackBar(
// // //                   SnackBar(
// // //                     content: Text('Added ${_selectedMedicine['name']} to your periodic plan'),
// // //                     backgroundColor: Colors.green,
// // //                   ),
// // //                 );
// // //               },
// // //               style: ElevatedButton.styleFrom(
// // //                 backgroundColor: const Color(0xFF5931DD),
// // //                 foregroundColor: Colors.white,
// // //                 padding: const EdgeInsets.symmetric(vertical: 16),
// // //                 shape: RoundedRectangleBorder(
// // //                   borderRadius: BorderRadius.circular(12),
// // //                 ),
// // //               ),
// // //               child: const Text(
// // //                 'Continue',
// // //                 style: TextStyle(
// // //                   fontSize: 16,
// // //                   fontWeight: FontWeight.w600,
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _searchController.dispose();
// // //     super.dispose();
// // //   }
// // // }

// // // class CurvedClipper extends CustomClipper<Path> {
// // //   @override
// // //   Path getClip(Size size) {
// // //     final path = Path();

// // //     path.moveTo(size.width, 0);
// // //     path.lineTo(size.width, size.height);
// // //     path.quadraticBezierTo(
// // //       size.width * 0.3,
// // //       size.height * 0.85,
// // //       size.width * 0.2,
// // //       size.height * 0.5,
// // //     );
// // //     path.quadraticBezierTo(
// // //       size.width * 0.3,
// // //       size.height * 0.15,
// // //       size.width,
// // //       0,
// // //     );
// // //     path.close();
// // //     return path;
// // //   }

// // //   @override
// // //   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'dart:convert';
// // // import 'package:medical_user_app/utils/shared_preferences_helper.dart';
// // // import 'package:medical_user_app/view/checkout_screen.dart';

// // // // Medicine Models
// // // class Medicine {
// // //   final String medicineId;
// // //   final String name;
// // //   final List<String> images;
// // //   final int price;
// // //   final int mrp;
// // //   final String description;
// // //   final String categoryName;
// // //   final Pharmacy pharmacy;

// // //   Medicine({
// // //     required this.medicineId,
// // //     required this.name,
// // //     required this.images,
// // //     required this.price,
// // //     required this.mrp,
// // //     required this.description,
// // //     required this.categoryName,
// // //     required this.pharmacy,
// // //   });

// // //   factory Medicine.fromJson(Map<String, dynamic> json) {
// // //     return Medicine(
// // //       medicineId: json['medicineId'] ?? '',
// // //       name: json['name'] ?? '',
// // //       images: List<String>.from(json['images'] ?? []),
// // //       price: json['price'] ?? 0,
// // //       mrp: json['mrp'] ?? 0,
// // //       description: json['description'] ?? '',
// // //       categoryName: json['categoryName'] ?? '',
// // //       pharmacy: Pharmacy.fromJson(json['pharmacy'] ?? {}),
// // //     );
// // //   }
// // // }

// // // class Pharmacy {
// // //   final String id;
// // //   final String name;
// // //   final Location location;

// // //   Pharmacy({
// // //     required this.id,
// // //     required this.name,
// // //     required this.location,
// // //   });

// // //   factory Pharmacy.fromJson(Map<String, dynamic> json) {
// // //     return Pharmacy(
// // //       id: json['_id'] ?? '',
// // //       name: json['name'] ?? '',
// // //       location: Location.fromJson(json['location'] ?? {}),
// // //     );
// // //   }
// // // }

// // // class Location {
// // //   final String type;
// // //   final List<double> coordinates;

// // //   Location({
// // //     required this.type,
// // //     required this.coordinates,
// // //   });

// // //   factory Location.fromJson(Map<String, dynamic> json) {
// // //     return Location(
// // //       type: json['type'] ?? '',
// // //       coordinates: List<double>.from(json['coordinates'] ?? []),
// // //     );
// // //   }
// // // }

// // // class ApiResponse {
// // //   final String message;
// // //   final int total;
// // //   final List<Medicine> medicines;

// // //   ApiResponse({
// // //     required this.message,
// // //     required this.total,
// // //     required this.medicines,
// // //   });

// // //   factory ApiResponse.fromJson(Map<String, dynamic> json) {
// // //     return ApiResponse(
// // //       message: json['message'] ?? '',
// // //       total: json['total'] ?? 0,
// // //       medicines: (json['medicines'] as List? ?? [])
// // //           .map((medicine) => Medicine.fromJson(medicine))
// // //           .toList(),
// // //     );
// // //   }
// // // }

// // // class PeriodicMedsPlanCardSimple extends StatelessWidget {
// // //   const PeriodicMedsPlanCardSimple({Key? key}) : super(key: key);

// // //   // Method to activate periodic meds plan
// // //   Future<bool> _activatePeriodicMedsPlan() async {
// // //     try {
// // //       // Get user ID from SharedPreferences
// // //       final user = await SharedPreferencesHelper.getUser();
// // //       final token = await SharedPreferencesHelper.getToken();

// // //       if (user == null || token == null) {
// // //         print('Error: User or token not found');
// // //         return false;
// // //       }

// // //       final url = 'http://31.97.206.144:7021/api/users/periodicmedsplan/${user.id}';

// // //       final response = await http.put(
// // //         Uri.parse(url),
// // //         headers: {
// // //           'Content-Type': 'application/json',
// // //           'Authorization': 'Bearer $token',
// // //         },
// // //         body: json.encode({
// // //           'isActive': true,
// // //         }),
// // //       );

// // //       if (response.statusCode == 200) {
// // //         print('Periodic meds plan activated successfully');
// // //         return true;
// // //       } else {
// // //         print('Failed to activate periodic meds plan: ${response.statusCode}');
// // //         print('Response body: ${response.body}');
// // //         return false;
// // //       }
// // //     } catch (e) {
// // //       print('Error activating periodic meds plan: $e');
// // //       return false;
// // //     }
// // //   }

// // //   // Method to show bottom modal with medicine details and search functionality
// // //   void _showMedicineDetailsModal(
// // //     BuildContext context, {
// // //     bool showAfterActivation = false,
// // //   }) {
// // //     showModalBottomSheet(
// // //       context: context,
// // //       isScrollControlled: true,
// // //       backgroundColor: Colors.transparent,
// // //       builder: (context) => MedicineDetailsModalWithSearch(
// // //         showAfterActivation: showAfterActivation,
// // //       ),
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Container(
// // //       width: double.infinity,
// // //       height: 160,
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(16),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.grey.withOpacity(0.1),
// // //             spreadRadius: 1,
// // //             blurRadius: 4,
// // //             offset: const Offset(0, 1),
// // //           ),
// // //         ],
// // //       ),
// // //       child: Stack(
// // //         clipBehavior: Clip.none,
// // //         children: [
// // //           // Purple curved background
// // //           Positioned(
// // //             right: 0,
// // //             top: 0,
// // //             bottom: 0,
// // //             child: ClipPath(
// // //               clipper: CurvedClipper(),
// // //               child: Container(
// // //                 width: 150,
// // //                 decoration: const BoxDecoration(
// // //                   color: Color(0xFF5931DD),
// // //                 ),
// // //                 child: Center(
// // //                   child: Padding(
// // //                     padding: const EdgeInsets.only(left: 20),
// // //                     child: Image.asset(
// // //                       'assets/doctor.png',
// // //                       width: 80,
// // //                       height: 80,
// // //                       fit: BoxFit.contain,
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ),
// // //             ),
// // //           ),

// // //           // Content (text + buttons)
// // //           Padding(
// // //             padding: const EdgeInsets.all(16),
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 const Text(
// // //                   "Periodic Meds",
// // //                   style: TextStyle(
// // //                     fontSize: 20,
// // //                     fontWeight: FontWeight.bold,
// // //                   ),
// // //                 ),
// // //                 const SizedBox(height: 2),
// // //                 const Text(
// // //                   "Plan",
// // //                   style: TextStyle(
// // //                     fontSize: 20,
// // //                     fontWeight: FontWeight.bold,
// // //                   ),
// // //                 ),
// // //                 const Spacer(),

// // //                 // Buttons row
// // //                 Row(
// // //                   children: [
// // //                     // Activate button - Calls API and shows modal
// // //                     Expanded(
// // //                       flex: 5,
// // //                       child: ElevatedButton(
// // //                         onPressed: () async {
// // //                           // Show loading
// // //                           showDialog(
// // //                             context: context,
// // //                             barrierDismissible: false,
// // //                             builder: (context) => const Center(
// // //                               child: CircularProgressIndicator(
// // //                                 color: Color(0xFF5931DD),
// // //                               ),
// // //                             ),
// // //                           );

// // //                           // Call API to activate periodic meds plan
// // //                           final success = await _activatePeriodicMedsPlan();

// // //                           // Hide loading
// // //                           Navigator.of(context).pop();

// // //                           if (success) {
// // //                             // Show success message
// // //                             ScaffoldMessenger.of(context).showSnackBar(
// // //                               const SnackBar(
// // //                                 content: Text('Periodic Meds Plan activated successfully!'),
// // //                                 backgroundColor: Colors.green,
// // //                               ),
// // //                             );

// // //                             // Show modal after successful activation
// // //                             _showMedicineDetailsModal(
// // //                               context,
// // //                               showAfterActivation: true,
// // //                             );
// // //                           } else {
// // //                             // Show error message
// // //                             ScaffoldMessenger.of(context).showSnackBar(
// // //                               const SnackBar(
// // //                                 content: Text('Failed to activate Periodic Meds Plan. Please try again.'),
// // //                                 backgroundColor: Colors.red,
// // //                               ),
// // //                             );
// // //                           }
// // //                         },
// // //                         style: ElevatedButton.styleFrom(
// // //                           backgroundColor: const Color(0xFF5931DD),
// // //                           foregroundColor: Colors.white,
// // //                           padding: const EdgeInsets.symmetric(vertical: 12),
// // //                           shape: RoundedRectangleBorder(
// // //                             borderRadius: BorderRadius.circular(24),
// // //                           ),
// // //                         ),
// // //                         child: const Text(
// // //                           "Activate",
// // //                           style: TextStyle(
// // //                             fontSize: 16,
// // //                             fontWeight: FontWeight.w500,
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     ),
// // //                     const SizedBox(width: 8),

// // //                     // Details button
// // //                     Expanded(
// // //                       flex: 4,
// // //                       child: OutlinedButton(
// // //                         onPressed: () {
// // //                           _showMedicineDetailsModal(context);
// // //                         },
// // //                         style: OutlinedButton.styleFrom(
// // //                           side: const BorderSide(color: Color(0xFF5931DD)),
// // //                           foregroundColor: const Color(0xFF5931DD),
// // //                           padding: const EdgeInsets.symmetric(vertical: 12),
// // //                           shape: RoundedRectangleBorder(
// // //                             borderRadius: BorderRadius.circular(24),
// // //                           ),
// // //                           backgroundColor: Colors.white,
// // //                           elevation: 0,
// // //                         ),
// // //                         child: const Text(
// // //                           "Details",
// // //                           style: TextStyle(
// // //                             fontSize: 16,
// // //                             fontWeight: FontWeight.w500,
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // // New Modal Widget with Search Functionality
// // // class MedicineDetailsModalWithSearch extends StatefulWidget {
// // //   final bool showAfterActivation;

// // //   const MedicineDetailsModalWithSearch({
// // //     Key? key,
// // //     this.showAfterActivation = false,
// // //   }) : super(key: key);

// // //   @override
// // //   State<MedicineDetailsModalWithSearch> createState() => _MedicineDetailsModalWithSearchState();
// // // }

// // // class _MedicineDetailsModalWithSearchState extends State<MedicineDetailsModalWithSearch> {
// // //   final TextEditingController _searchController = TextEditingController();
// // //   List<Medicine> _searchResults = [];
// // //   bool _isSearching = false;
// // //   bool _isActive = true; // Toggle state
// // //   Medicine? _selectedMedicine;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     if (widget.showAfterActivation) {
// // //       // Set initial state as active if coming from activation
// // //       _isActive = true;
// // //     }
// // //   }

// // //   // Method to search medicines
// // //   Future<void> _searchMedicines(String query) async {
// // //     if (query.trim().isEmpty) {
// // //       setState(() {
// // //         _searchResults = [];
// // //       });
// // //       return;
// // //     }

// // //     setState(() {
// // //       _isSearching = true;
// // //     });

// // //     try {
// // //       final token = await SharedPreferencesHelper.getToken();
// // //       final url = 'http://31.97.206.144:7021/api/pharmacy/allmedicine?name=${Uri.encodeComponent(query)}';

// // //       final response = await http.get(
// // //         Uri.parse(url),
// // //         headers: {
// // //           'Content-Type': 'application/json',
// // //           if (token != null) 'Authorization': 'Bearer $token',
// // //         },
// // //       );

// // //       if (response.statusCode == 200) {
// // //         final data = json.decode(response.body);
// // //         final apiResponse = ApiResponse.fromJson(data);
// // //         setState(() {
// // //           _searchResults = apiResponse.medicines;
// // //         });
// // //       } else {
// // //         print('Failed to search medicines: ${response.statusCode}');
// // //         setState(() {
// // //           _searchResults = [];
// // //         });
// // //       }
// // //     } catch (e) {
// // //       print('Error searching medicines: $e');
// // //       setState(() {
// // //         _searchResults = [];
// // //       });
// // //     } finally {
// // //       setState(() {
// // //         _isSearching = false;
// // //       });
// // //     }
// // //   }

// // //   // Method to update periodic meds plan status
// // //   Future<void> _updatePeriodicMedsPlan(bool isActive) async {
// // //     try {
// // //       final user = await SharedPreferencesHelper.getUser();
// // //       final token = await SharedPreferencesHelper.getToken();

// // //       if (user == null || token == null) {
// // //         print('Error: User or token not found');
// // //         return;
// // //       }

// // //       final url = 'http://31.97.206.144:7021/api/users/periodicmedsplan/${user.id}';

// // //       final response = await http.put(
// // //         Uri.parse(url),
// // //         headers: {
// // //           'Content-Type': 'application/json',
// // //           'Authorization': 'Bearer $token',
// // //         },
// // //         body: json.encode({
// // //           'isActive': isActive,
// // //         }),
// // //       );

// // //       if (response.statusCode == 200) {
// // //         print('Periodic meds plan updated successfully: $isActive');
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(
// // //             content: Text(isActive
// // //                 ? 'Periodic Meds Plan activated!'
// // //                 : 'Periodic Meds Plan deactivated!'),
// // //             backgroundColor: isActive ? Colors.green : Colors.orange,
// // //           ),
// // //         );
// // //       } else {
// // //         print('Failed to update periodic meds plan: ${response.statusCode}');
// // //         // Revert toggle state on failure
// // //         setState(() {
// // //           _isActive = !isActive;
// // //         });

// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(
// // //             content: Text('Failed to update plan status. Please try again.'),
// // //             backgroundColor: Colors.red,
// // //           ),
// // //         );
// // //       }
// // //     } catch (e) {
// // //       print('Error updating periodic meds plan: $e');
// // //       // Revert toggle state on error
// // //       setState(() {
// // //         _isActive = !isActive;
// // //       });

// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(
// // //           content: Text('Error updating plan status. Please try again.'),
// // //           backgroundColor: Colors.red,
// // //         ),
// // //       );
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Container(
// // //       height: MediaQuery.of(context).size.height * 0.85,
// // //       decoration: const BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.only(
// // //           topLeft: Radius.circular(20),
// // //           topRight: Radius.circular(20),
// // //         ),
// // //       ),
// // //       child: Column(
// // //         children: [
// // //           // Handle bar
// // //           Container(
// // //             width: 40,
// // //             height: 4,
// // //             margin: const EdgeInsets.symmetric(vertical: 8),
// // //             decoration: BoxDecoration(
// // //               color: Colors.grey[300],
// // //               borderRadius: BorderRadius.circular(2),
// // //             ),
// // //           ),

// // //           // Header with toggle
// // //           Padding(
// // //             padding: const EdgeInsets.all(16),
// // //             child: Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //               children: [
// // //                 const Text(
// // //                   'Periodic Meds Plan',
// // //                   style: TextStyle(
// // //                     fontSize: 20,
// // //                     fontWeight: FontWeight.bold,
// // //                   ),
// // //                 ),
// // //                 Row(
// // //                   children: [
// // //                     Text(
// // //                       _isActive ? 'Active' : 'Inactive',
// // //                       style: TextStyle(
// // //                         color: _isActive ? Colors.green : Colors.grey,
// // //                         fontWeight: FontWeight.w500,
// // //                       ),
// // //                     ),
// // //                     const SizedBox(width: 8),
// // //                     Switch(
// // //                       value: _isActive,
// // //                       onChanged: (value) {
// // //                         setState(() {
// // //                           _isActive = value;
// // //                         });
// // //                         _updatePeriodicMedsPlan(value);
// // //                       },
// // //                       activeColor: const Color(0xFF5931DD),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ],
// // //             ),
// // //           ),

// // //           // Search field
// // //           Padding(
// // //             padding: const EdgeInsets.symmetric(horizontal: 16),
// // //             child: TextField(
// // //               controller: _searchController,
// // //               onChanged: (value) {
// // //                 _searchMedicines(value);
// // //               },
// // //               decoration: InputDecoration(
// // //                 hintText: 'Search your medicine...',
// // //                 prefixIcon: const Icon(Icons.search, color: Color(0xFF5931DD)),
// // //                 suffixIcon: _isSearching
// // //                     ? const SizedBox(
// // //                         width: 20,
// // //                         height: 20,
// // //                         child: Padding(
// // //                           padding: EdgeInsets.all(12),
// // //                           child: CircularProgressIndicator(
// // //                             strokeWidth: 2,
// // //                             color: Color(0xFF5931DD),
// // //                           ),
// // //                         ),
// // //                       )
// // //                     : _searchController.text.isNotEmpty
// // //                         ? IconButton(
// // //                             icon: const Icon(Icons.clear),
// // //                             onPressed: () {
// // //                               _searchController.clear();
// // //                               setState(() {
// // //                                 _searchResults = [];
// // //                               });
// // //                             },
// // //                           )
// // //                         : null,
// // //                 border: OutlineInputBorder(
// // //                   borderRadius: BorderRadius.circular(12),
// // //                   borderSide: const BorderSide(color: Color(0xFF5931DD)),
// // //                 ),
// // //                 focusedBorder: OutlineInputBorder(
// // //                   borderRadius: BorderRadius.circular(12),
// // //                   borderSide: const BorderSide(color: Color(0xFF5931DD), width: 2),
// // //                 ),
// // //               ),
// // //             ),
// // //           ),

// // //           const SizedBox(height: 16),

// // //           // Search results or selected medicine details
// // //           Expanded(
// // //             child: _searchResults.isNotEmpty
// // //                 ? ListView.builder(
// // //                     padding: const EdgeInsets.symmetric(horizontal: 16),
// // //                     itemCount: _searchResults.length,
// // //                     itemBuilder: (context, index) {
// // //                       final medicine = _searchResults[index];
// // //                       return Card(
// // //                         margin: const EdgeInsets.only(bottom: 12),
// // //                         elevation: 2,
// // //                         shape: RoundedRectangleBorder(
// // //                           borderRadius: BorderRadius.circular(12),
// // //                         ),
// // //                         child: InkWell(
// // //                           borderRadius: BorderRadius.circular(12),
// // //                           onTap: () {
// // //                             setState(() {
// // //                               _selectedMedicine = medicine;
// // //                               _searchResults = [];
// // //                               _searchController.clear();
// // //                             });
// // //                           },
// // //                           child: Padding(
// // //                             padding: const EdgeInsets.all(12),
// // //                             child: Row(
// // //                               children: [
// // //                                 // Medicine Image
// // //                                 Container(
// // //                                   width: 80,
// // //                                   height: 80,
// // //                                   decoration: BoxDecoration(
// // //                                     color: Colors.grey[100],
// // //                                     borderRadius: BorderRadius.circular(8),
// // //                                   ),
// // //                                   child: medicine.images.isNotEmpty
// // //                                       ? ClipRRect(
// // //                                           borderRadius: BorderRadius.circular(8),
// // //                                           child: Image.network(
// // //                                             medicine.images.first,
// // //                                             fit: BoxFit.cover,
// // //                                             errorBuilder: (context, error, stackTrace) {
// // //                                               return const Icon(
// // //                                                 Icons.medication,
// // //                                                 color: Color(0xFF5931DD),
// // //                                                 size: 40,
// // //                                               );
// // //                                             },
// // //                                           ),
// // //                                         )
// // //                                       : const Icon(
// // //                                           Icons.medication,
// // //                                           color: Color(0xFF5931DD),
// // //                                           size: 40,
// // //                                         ),
// // //                                 ),
// // //                                 const SizedBox(width: 12),

// // //                                 // Medicine Details
// // //                                 Expanded(
// // //                                   child: Column(
// // //                                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                                     children: [
// // //                                       Text(
// // //                                         medicine.name,
// // //                                         style: const TextStyle(
// // //                                           fontWeight: FontWeight.bold,
// // //                                           fontSize: 16,
// // //                                         ),
// // //                                         maxLines: 2,
// // //                                         overflow: TextOverflow.ellipsis,
// // //                                       ),
// // //                                       const SizedBox(height: 4),
// // //                                       Text(
// // //                                         medicine.description,
// // //                                         style: TextStyle(
// // //                                           color: Colors.grey[600],
// // //                                           fontSize: 12,
// // //                                         ),
// // //                                         maxLines: 2,
// // //                                         overflow: TextOverflow.ellipsis,
// // //                                       ),
// // //                                       const SizedBox(height: 8),
// // //                                       Row(
// // //                                         children: [
// // //                                           Text(
// // //                                             '₹${medicine.price}',
// // //                                             style: const TextStyle(
// // //                                               color: Color(0xFF5931DD),
// // //                                               fontWeight: FontWeight.bold,
// // //                                               fontSize: 16,
// // //                                             ),
// // //                                           ),
// // //                                           const SizedBox(width: 8),
// // //                                           if (medicine.mrp > medicine.price)
// // //                                             Text(
// // //                                               '₹${medicine.mrp}',
// // //                                               style: TextStyle(
// // //                                                 color: Colors.grey[500],
// // //                                                 fontSize: 12,
// // //                                                 decoration: TextDecoration.lineThrough,
// // //                                               ),
// // //                                             ),
// // //                                         ],
// // //                                       ),
// // //                                       const SizedBox(height: 4),
// // //                                       Text(
// // //                                         medicine.pharmacy.name,
// // //                                         style: TextStyle(
// // //                                           color: Colors.grey[600],
// // //                                           fontSize: 11,
// // //                                         ),
// // //                                       ),
// // //                                     ],
// // //                                   ),
// // //                                 ),

// // //                                 // Select indicator
// // //                                 const Icon(
// // //                                   Icons.arrow_forward_ios,
// // //                                   color: Color(0xFF5931DD),
// // //                                   size: 16,
// // //                                 ),
// // //                               ],
// // //                             ),
// // //                           ),
// // //                         ),
// // //                       );
// // //                     },
// // //                   )
// // //                 : _selectedMedicine != null
// // //                     ? _buildSelectedMedicineDetails()
// // //                     : _buildEmptyState(),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildEmptyState() {
// // //     return Center(
// // //       child: Column(
// // //         mainAxisAlignment: MainAxisAlignment.center,
// // //         children: [
// // //           Icon(
// // //             Icons.search,
// // //             size: 80,
// // //             color: Colors.grey[300],
// // //           ),
// // //           const SizedBox(height: 16),
// // //           Text(
// // //             'Search for medicines',
// // //             style: TextStyle(
// // //               fontSize: 18,
// // //               color: Colors.grey[600],
// // //               fontWeight: FontWeight.w500,
// // //             ),
// // //           ),
// // //           const SizedBox(height: 8),
// // //           Text(
// // //             'Type in the search box to find medicines\nfor your periodic plan',
// // //             textAlign: TextAlign.center,
// // //             style: TextStyle(
// // //               color: Colors.grey[500],
// // //               fontSize: 14,
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // Widget _buildSelectedMedicineDetails() {
// // //   final medicine = _selectedMedicine!;
// // //   return Padding(
// // //     padding: const EdgeInsets.all(16),
// // //     child: Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         const Text(
// // //           'Selected Medicine',
// // //           style: TextStyle(
// // //             fontSize: 18,
// // //             fontWeight: FontWeight.bold,
// // //           ),
// // //         ),

// // //         const SizedBox(height: 16),

// // //         // Medicine details card
// // //         Container(
// // //           width: double.infinity,
// // //           decoration: BoxDecoration(
// // //             border: Border.all(color: Colors.grey[300]!),
// // //             borderRadius: BorderRadius.circular(12),
// // //           ),
// // //           child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               // Medicine image
// // //               if (medicine.images.isNotEmpty)
// // //                 Container(
// // //                   width: double.infinity,
// // //                   height: 200,
// // //                   decoration: const BoxDecoration(
// // //                     borderRadius: BorderRadius.only(
// // //                       topLeft: Radius.circular(12),
// // //                       topRight: Radius.circular(12),
// // //                     ),
// // //                   ),
// // //                   child: ClipRRect(
// // //                     borderRadius: const BorderRadius.only(
// // //                       topLeft: Radius.circular(12),
// // //                       topRight: Radius.circular(12),
// // //                     ),
// // //                     child: Image.network(
// // //                       medicine.images.first,
// // //                       fit: BoxFit.cover,
// // //                       errorBuilder: (context, error, stackTrace) {
// // //                         return Container(
// // //                           color: Colors.grey[100],
// // //                           child: const Icon(
// // //                             Icons.medication,
// // //                             color: Color(0xFF5931DD),
// // //                             size: 80,
// // //                           ),
// // //                         );
// // //                       },
// // //                     ),
// // //                   ),
// // //                 ),

// // //               // Medicine info
// // //               Padding(
// // //                 padding: const EdgeInsets.all(16),
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     Text(
// // //                       medicine.name,
// // //                       style: const TextStyle(
// // //                         fontSize: 18,
// // //                         fontWeight: FontWeight.bold,
// // //                         color: Color(0xFF5931DD),
// // //                       ),
// // //                     ),
// // //                     const SizedBox(height: 8),
// // //                     // Text(
// // //                     //   medicine.description,
// // //                     //   style: TextStyle(
// // //                     //     color: Colors.grey[600],
// // //                     //     fontSize: 14,
// // //                     //     height: 1.4,
// // //                     //   ),
// // //                     // ),
// // //                     const SizedBox(height: 12),

// // //                     // Price row
// // //                     Row(
// // //                       children: [
// // //                         const Text(
// // //                           'Price: ',
// // //                           style: TextStyle(
// // //                             fontWeight: FontWeight.w600,
// // //                             fontSize: 16,
// // //                           ),
// // //                         ),
// // //                         Text(
// // //                           '₹${medicine.price}',
// // //                           style: const TextStyle(
// // //                             fontSize: 18,
// // //                             fontWeight: FontWeight.bold,
// // //                             color: Color(0xFF5931DD),
// // //                           ),
// // //                         ),
// // //                         const SizedBox(width: 8),
// // //                         if (medicine.mrp > medicine.price)
// // //                           Text(
// // //                             '₹${medicine.mrp}',
// // //                             style: TextStyle(
// // //                               color: Colors.grey[500],
// // //                               fontSize: 14,
// // //                               decoration: TextDecoration.lineThrough,
// // //                             ),
// // //                           ),
// // //                       ],
// // //                     ),

// // //                     const SizedBox(height: 12),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),

// // //         const Spacer(),

// // //         // Continue button - Updated to pass selected medicine data to CheckoutScreen
// // //         SizedBox(
// // //           width: double.infinity,
// // //           child: ElevatedButton(
// // //             onPressed: () {
// // //               // Close the modal first
// // //               Navigator.of(context).pop();

// // //               // Create medication data from selected medicine
// // //               final medicationData = {
// // //                 "medicineId": medicine.medicineId,
// // //                 "name": medicine.name,
// // //                 "quantity": "1 Strip", // Default quantity, can be customized
// // //                 "count": 1,
// // //                 "pharmacyName": medicine.pharmacy.name,
// // //                 "pharmacyImage": medicine.images.isNotEmpty ? medicine.images.first : "assets/tablet.png",
// // //                 "price": medicine.price.toString(),
// // //                 "mrp": medicine.mrp.toString(),
// // //                 "description": medicine.description,
// // //                 "categoryName": medicine.categoryName,
// // //               };

// // //               // Navigate to CheckoutScreen with the selected medicine data
// // //               Navigator.push(
// // //                 context,
// // //                 MaterialPageRoute(
// // //                   builder: (context) => CheckoutScreen(
// // //                     medicineId: medicine.medicineId,
// // //                     medicineName: medicine.name,
// // //                     medicinePrice: medicine.price.toString(),
// // //                     pharmacyName: medicine.pharmacy.name,
// // //                     pharmacyImage: medicine.images.isNotEmpty ? medicine.images.first : null,
// // //                     medicationsList: [medicationData], // Pass as a list for consistency
// // //                   ),
// // //                 ),
// // //               );
// // //             },
// // //             style: ElevatedButton.styleFrom(
// // //               backgroundColor: const Color(0xFF5931DD),
// // //               foregroundColor: Colors.white,
// // //               padding: const EdgeInsets.symmetric(vertical: 16),
// // //               shape: RoundedRectangleBorder(
// // //                 borderRadius: BorderRadius.circular(12),
// // //               ),
// // //             ),
// // //             child: const Text(
// // //               'Continue to Periodic Plan',
// // //               style: TextStyle(
// // //                 fontSize: 16,
// // //                 fontWeight: FontWeight.w600,
// // //               ),
// // //             ),
// // //           ),
// // //         ),
// // //       ],
// // //     ),
// // //   );
// // // }

// // //   @override
// // //   void dispose() {
// // //     _searchController.dispose();
// // //     super.dispose();
// // //   }
// // // }

// // // class CurvedClipper extends CustomClipper<Path> {
// // //   @override
// // //   Path getClip(Size size) {
// // //     final path = Path();

// // //     path.moveTo(size.width, 0);
// // //     path.lineTo(size.width, size.height);
// // //     path.quadraticBezierTo(
// // //       size.width * 0.3,
// // //       size.height * 0.85,
// // //       size.width * 0.2,
// // //       size.height * 0.5,
// // //     );
// // //     path.quadraticBezierTo(
// // //       size.width * 0.3,
// // //       size.height * 0.15,
// // //       size.width,
// // //       0,
// // //     );
// // //     path.close();
// // //     return path;
// // //   }

// // //   @override
// // //   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// // import 'package:medical_user_app/utils/shared_preferences_helper.dart';
// // import 'package:medical_user_app/view/checkout_screen.dart';

// // // Medicine Models
// // class Medicine {
// //   final String medicineId;
// //   final String name;
// //   final List<String> images;
// //   final int price;
// //   final int mrp;
// //   final String description;
// //   final String categoryName;
// //   final Pharmacy pharmacy;

// //   Medicine({
// //     required this.medicineId,
// //     required this.name,
// //     required this.images,
// //     required this.price,
// //     required this.mrp,
// //     required this.description,
// //     required this.categoryName,
// //     required this.pharmacy,
// //   });

// //   factory Medicine.fromJson(Map<String, dynamic> json) {
// //     return Medicine(
// //       medicineId: json['medicineId'] ?? '',
// //       name: json['name'] ?? '',
// //       images: List<String>.from(json['images'] ?? []),
// //       price: json['price'] ?? 0,
// //       mrp: json['mrp'] ?? 0,
// //       description: json['description'] ?? '',
// //       categoryName: json['categoryName'] ?? '',
// //       pharmacy: Pharmacy.fromJson(json['pharmacy'] ?? {}),
// //     );
// //   }
// // }

// // class Pharmacy {
// //   final String id;
// //   final String name;
// //   final Location location;

// //   Pharmacy({
// //     required this.id,
// //     required this.name,
// //     required this.location,
// //   });

// //   factory Pharmacy.fromJson(Map<String, dynamic> json) {
// //     return Pharmacy(
// //       id: json['_id'] ?? '',
// //       name: json['name'] ?? '',
// //       location: Location.fromJson(json['location'] ?? {}),
// //     );
// //   }
// // }

// // class Location {
// //   final String type;
// //   final List<double> coordinates;

// //   Location({
// //     required this.type,
// //     required this.coordinates,
// //   });

// //   factory Location.fromJson(Map<String, dynamic> json) {
// //     return Location(
// //       type: json['type'] ?? '',
// //       coordinates: List<double>.from(json['coordinates'] ?? []),
// //     );
// //   }
// // }

// // class ApiResponse {
// //   final String message;
// //   final int total;
// //   final List<Medicine> medicines;

// //   ApiResponse({
// //     required this.message,
// //     required this.total,
// //     required this.medicines,
// //   });

// //   factory ApiResponse.fromJson(Map<String, dynamic> json) {
// //     return ApiResponse(
// //       message: json['message'] ?? '',
// //       total: json['total'] ?? 0,
// //       medicines: (json['medicines'] as List? ?? [])
// //           .map((medicine) => Medicine.fromJson(medicine))
// //           .toList(),
// //     );
// //   }
// // }

// // class PeriodicMedsPlanCardSimple extends StatelessWidget {
// //   const PeriodicMedsPlanCardSimple({Key? key}) : super(key: key);

// //   // Method to activate periodic meds plan
// //   Future<bool> _activatePeriodicMedsPlan() async {
// //     try {
// //       // Get user ID from SharedPreferences
// //       final user = await SharedPreferencesHelper.getUser();
// //       final token = await SharedPreferencesHelper.getToken();

// //       if (user == null || token == null) {
// //         print('Error: User or token not found');
// //         return false;
// //       }

// //       final url = 'http://31.97.206.144:7021/api/users/periodicmedsplan/${user.id}';

// //       final response = await http.put(
// //         Uri.parse(url),
// //         headers: {
// //           'Content-Type': 'application/json',
// //           'Authorization': 'Bearer $token',
// //         },
// //         body: json.encode({
// //           'isActive': true,
// //         }),
// //       );

// //       if (response.statusCode == 200) {
// //         print('Periodic meds plan activated successfully');
// //         return true;
// //       } else {
// //         print('Failed to activate periodic meds plan: ${response.statusCode}');
// //         print('Response body: ${response.body}');
// //         return false;
// //       }
// //     } catch (e) {
// //       print('Error activating periodic meds plan: $e');
// //       return false;
// //     }
// //   }

// //   // Method to show bottom modal with medicine details and search functionality
// //   void _showMedicineDetailsModal(
// //     BuildContext context, {
// //     bool showAfterActivation = false,
// //   }) {
// //     showModalBottomSheet(
// //       context: context,
// //       isScrollControlled: true,
// //       backgroundColor: Colors.transparent,
// //       builder: (context) => MedicineDetailsModalWithSearch(
// //         showAfterActivation: showAfterActivation,
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       width: double.infinity,
// //       height: 160,
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.grey.withOpacity(0.1),
// //             spreadRadius: 1,
// //             blurRadius: 4,
// //             offset: const Offset(0, 1),
// //           ),
// //         ],
// //       ),
// //       child: Stack(
// //         clipBehavior: Clip.none,
// //         children: [
// //           // Purple curved background
// //           Positioned(
// //             right: 0,
// //             top: 0,
// //             bottom: 0,
// //             child: ClipPath(
// //               clipper: CurvedClipper(),
// //               child: Container(
// //                 width: 150,
// //                 decoration: const BoxDecoration(
// //                   color: Color(0xFF5931DD),
// //                 ),
// //                 child: Center(
// //                   child: Padding(
// //                     padding: const EdgeInsets.only(left: 20),
// //                     child: Image.asset(
// //                       'assets/doctor.png',
// //                       width: 80,
// //                       height: 80,
// //                       fit: BoxFit.contain,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),

// //           // Content (text + buttons)
// //           Padding(
// //             padding: const EdgeInsets.all(16),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 const Text(
// //                   "Periodic Meds",
// //                   style: TextStyle(
// //                     fontSize: 20,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 2),
// //                 const Text(
// //                   "Plan",
// //                   style: TextStyle(
// //                     fontSize: 20,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //                 const Spacer(),

// //                 // Buttons row
// //                 Row(
// //                   children: [
// //                     // Activate button - Calls API and shows modal
// //                     Expanded(
// //                       flex: 5,
// //                       child: ElevatedButton(
// //                         onPressed: () async {
// //                           // Show loading
// //                           showDialog(
// //                             context: context,
// //                             barrierDismissible: false,
// //                             builder: (context) => const Center(
// //                               child: CircularProgressIndicator(
// //                                 color: Color(0xFF5931DD),
// //                               ),
// //                             ),
// //                           );

// //                           // Call API to activate periodic meds plan
// //                           final success = await _activatePeriodicMedsPlan();

// //                           // Hide loading
// //                           Navigator.of(context).pop();

// //                           if (success) {
// //                             // Show success message
// //                             ScaffoldMessenger.of(context).showSnackBar(
// //                               const SnackBar(
// //                                 content: Text('Periodic Meds Plan activated successfully!'),
// //                                 backgroundColor: Colors.green,
// //                               ),
// //                             );

// //                             // Show modal after successful activation
// //                             _showMedicineDetailsModal(
// //                               context,
// //                               showAfterActivation: true,
// //                             );
// //                           } else {
// //                             // Show error message
// //                             ScaffoldMessenger.of(context).showSnackBar(
// //                               const SnackBar(
// //                                 content: Text('Failed to activate Periodic Meds Plan. Please try again.'),
// //                                 backgroundColor: Colors.red,
// //                               ),
// //                             );
// //                           }
// //                         },
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: const Color(0xFF5931DD),
// //                           foregroundColor: Colors.white,
// //                           padding: const EdgeInsets.symmetric(vertical: 12),
// //                           shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(24),
// //                           ),
// //                         ),
// //                         child: const Text(
// //                           "Activate",
// //                           style: TextStyle(
// //                             fontSize: 16,
// //                             fontWeight: FontWeight.w500,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                     const SizedBox(width: 8),

// //                     // Details button
// //                     Expanded(
// //                       flex: 4,
// //                       child: OutlinedButton(
// //                         onPressed: () {
// //                           _showMedicineDetailsModal(context);
// //                         },
// //                         style: OutlinedButton.styleFrom(
// //                           side: const BorderSide(color: Color(0xFF5931DD)),
// //                           foregroundColor: const Color(0xFF5931DD),
// //                           padding: const EdgeInsets.symmetric(vertical: 12),
// //                           shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(24),
// //                           ),
// //                           backgroundColor: Colors.white,
// //                           elevation: 0,
// //                         ),
// //                         child: const Text(
// //                           "Details",
// //                           style: TextStyle(
// //                             fontSize: 16,
// //                             fontWeight: FontWeight.w500,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // // New Modal Widget with Search Functionality and Multi-Selection
// // class MedicineDetailsModalWithSearch extends StatefulWidget {
// //   final bool showAfterActivation;

// //   const MedicineDetailsModalWithSearch({
// //     Key? key,
// //     this.showAfterActivation = false,
// //   }) : super(key: key);

// //   @override
// //   State<MedicineDetailsModalWithSearch> createState() => _MedicineDetailsModalWithSearchState();
// // }

// // class _MedicineDetailsModalWithSearchState extends State<MedicineDetailsModalWithSearch> {
// //   final TextEditingController _searchController = TextEditingController();
// //   List<Medicine> _searchResults = [];
// //   bool _isSearching = false;
// //   bool _isActive = true; // Toggle state
// //   List<Medicine> _selectedMedicines = []; // Changed to support multiple selections
// //   bool _isMultiSelectMode = false; // Toggle between single and multi-select modes

// //   @override
// //   void initState() {
// //     super.initState();
// //     if (widget.showAfterActivation) {
// //       // Set initial state as active if coming from activation
// //       _isActive = true;
// //     }
// //   }

// //   // Method to search medicines
// //   Future<void> _searchMedicines(String query) async {
// //     if (query.trim().isEmpty) {
// //       setState(() {
// //         _searchResults = [];
// //       });
// //       return;
// //     }

// //     setState(() {
// //       _isSearching = true;
// //     });

// //     try {
// //       final token = await SharedPreferencesHelper.getToken();
// //       final url = 'http://31.97.206.144:7021/api/pharmacy/allmedicine?name=${Uri.encodeComponent(query)}';

// //       final response = await http.get(
// //         Uri.parse(url),
// //         headers: {
// //           'Content-Type': 'application/json',
// //           if (token != null) 'Authorization': 'Bearer $token',
// //         },
// //       );

// //       if (response.statusCode == 200) {
// //         final data = json.decode(response.body);
// //         final apiResponse = ApiResponse.fromJson(data);
// //         setState(() {
// //           _searchResults = apiResponse.medicines;
// //         });
// //       } else {
// //         print('Failed to search medicines: ${response.statusCode}');
// //         setState(() {
// //           _searchResults = [];
// //         });
// //       }
// //     } catch (e) {
// //       print('Error searching medicines: $e');
// //       setState(() {
// //         _searchResults = [];
// //       });
// //     } finally {
// //       setState(() {
// //         _isSearching = false;
// //       });
// //     }
// //   }

// //   // Method to update periodic meds plan status
// //   Future<void> _updatePeriodicMedsPlan(bool isActive) async {
// //     try {
// //       final user = await SharedPreferencesHelper.getUser();
// //       final token = await SharedPreferencesHelper.getToken();

// //       if (user == null || token == null) {
// //         print('Error: User or token not found');
// //         return;
// //       }

// //       final url = 'http://31.97.206.144:7021/api/users/periodicmedsplan/${user.id}';

// //       final response = await http.put(
// //         Uri.parse(url),
// //         headers: {
// //           'Content-Type': 'application/json',
// //           'Authorization': 'Bearer $token',
// //         },
// //         body: json.encode({
// //           'isActive': isActive,
// //         }),
// //       );

// //       if (response.statusCode == 200) {
// //         print('Periodic meds plan updated successfully: $isActive');
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text(isActive
// //                 ? 'Periodic Meds Plan activated!'
// //                 : 'Periodic Meds Plan deactivated!'),
// //             backgroundColor: isActive ? Colors.green : Colors.orange,
// //           ),
// //         );
// //       } else {
// //         print('Failed to update periodic meds plan: ${response.statusCode}');
// //         // Revert toggle state on failure
// //         setState(() {
// //           _isActive = !isActive;
// //         });

// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(
// //             content: Text('Failed to update plan status. Please try again.'),
// //             backgroundColor: Colors.red,
// //           ),
// //         );
// //       }
// //     } catch (e) {
// //       print('Error updating periodic meds plan: $e');
// //       // Revert toggle state on error
// //       setState(() {
// //         _isActive = !isActive;
// //       });

// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(
// //           content: Text('Error updating plan status. Please try again.'),
// //           backgroundColor: Colors.red,
// //         ),
// //       );
// //     }
// //   }

// //   // Method to handle medicine selection
// //   void _toggleMedicineSelection(Medicine medicine) {
// //     setState(() {
// //       if (_isMultiSelectMode) {
// //         // Multi-select mode
// //         final index = _selectedMedicines.indexWhere((m) => m.medicineId == medicine.medicineId);
// //         if (index >= 0) {
// //           _selectedMedicines.removeAt(index);
// //         } else {
// //           _selectedMedicines.add(medicine);
// //         }
// //       } else {
// //         // Single select mode
// //         _selectedMedicines = [medicine];
// //         _searchResults = [];
// //         _searchController.clear();
// //       }
// //     });
// //   }

// //   // Method to check if medicine is selected
// //   bool _isMedicineSelected(Medicine medicine) {
// //     return _selectedMedicines.any((m) => m.medicineId == medicine.medicineId);
// //   }

// //   // Method to remove selected medicine
// //   void _removeSelectedMedicine(Medicine medicine) {
// //     setState(() {
// //       _selectedMedicines.removeWhere((m) => m.medicineId == medicine.medicineId);
// //     });
// //   }

// //   // Method to clear all selections
// //   void _clearAllSelections() {
// //     setState(() {
// //       _selectedMedicines.clear();
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       height: MediaQuery.of(context).size.height * 0.85,
// //       decoration: const BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.only(
// //           topLeft: Radius.circular(20),
// //           topRight: Radius.circular(20),
// //         ),
// //       ),
// //       child: Column(
// //         children: [
// //           // Handle bar
// //           Container(
// //             width: 40,
// //             height: 4,
// //             margin: const EdgeInsets.symmetric(vertical: 8),
// //             decoration: BoxDecoration(
// //               color: Colors.grey[300],
// //               borderRadius: BorderRadius.circular(2),
// //             ),
// //           ),

// //           // Header with toggle
// //           Padding(
// //             padding: const EdgeInsets.all(16),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 const Text(
// //                   'Periodic Meds Plan',
// //                   style: TextStyle(
// //                     fontSize: 20,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //                 Row(
// //                   children: [
// //                     Text(
// //                       _isActive ? 'Active' : 'Inactive',
// //                       style: TextStyle(
// //                         color: _isActive ? Colors.green : Colors.grey,
// //                         fontWeight: FontWeight.w500,
// //                       ),
// //                     ),
// //                     const SizedBox(width: 8),
// //                     Switch(
// //                       value: _isActive,
// //                       onChanged: (value) {
// //                         setState(() {
// //                           _isActive = value;
// //                         });
// //                         _updatePeriodicMedsPlan(value);
// //                       },
// //                       activeColor: const Color(0xFF5931DD),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),

// //           // Multi-select mode toggle and selection counter
// //           if (_searchResults.isEmpty && _selectedMedicines.isEmpty)
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 16),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Row(
// //                     children: [
// //                       Text(
// //                         'Multi-Select Mode',
// //                         style: TextStyle(
// //                           color: Colors.grey[700],
// //                           fontWeight: FontWeight.w500,
// //                         ),
// //                       ),
// //                       const SizedBox(width: 8),
// //                       Switch(
// //                         value: _isMultiSelectMode,
// //                         onChanged: (value) {
// //                           setState(() {
// //                             _isMultiSelectMode = value;
// //                             if (!value) {
// //                               // If turning off multi-select, keep only the first selected medicine
// //                               if (_selectedMedicines.isNotEmpty) {
// //                                 _selectedMedicines = [_selectedMedicines.first];
// //                               }
// //                             }
// //                           });
// //                         },
// //                         activeColor: const Color(0xFF5931DD),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),

// //           // Selected medicines counter and clear button
// //           if (_selectedMedicines.isNotEmpty)
// //             Container(
// //               margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// //               decoration: BoxDecoration(
// //                 color: const Color(0xFF5931DD).withOpacity(0.1),
// //                 borderRadius: BorderRadius.circular(8),
// //               ),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Text(
// //                     '${_selectedMedicines.length} medicine${_selectedMedicines.length > 1 ? 's' : ''} selected',
// //                     style: const TextStyle(
// //                       color: Color(0xFF5931DD),
// //                       fontWeight: FontWeight.w600,
// //                     ),
// //                   ),
// //                   TextButton(
// //                     onPressed: _clearAllSelections,
// //                     child: const Text(
// //                       'Clear All',
// //                       style: TextStyle(
// //                         color: Color(0xFF5931DD),
// //                         fontWeight: FontWeight.w500,
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),

// //           // Search field
// //           Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 16),
// //             child: TextField(
// //               controller: _searchController,
// //               onChanged: (value) {
// //                 _searchMedicines(value);
// //               },
// //               decoration: InputDecoration(
// //                 hintText: _isMultiSelectMode
// //                     ? 'Search and select multiple medicines...'
// //                     : 'Search your medicine...',
// //                 prefixIcon: const Icon(Icons.search, color: Color(0xFF5931DD)),
// //                 suffixIcon: _isSearching
// //                     ? const SizedBox(
// //                         width: 20,
// //                         height: 20,
// //                         child: Padding(
// //                           padding: EdgeInsets.all(12),
// //                           child: CircularProgressIndicator(
// //                             strokeWidth: 2,
// //                             color: Color(0xFF5931DD),
// //                           ),
// //                         ),
// //                       )
// //                     : _searchController.text.isNotEmpty
// //                         ? IconButton(
// //                             icon: const Icon(Icons.clear),
// //                             onPressed: () {
// //                               _searchController.clear();
// //                               setState(() {
// //                                 _searchResults = [];
// //                               });
// //                             },
// //                           )
// //                         : null,
// //                 border: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(12),
// //                   borderSide: const BorderSide(color: Color(0xFF5931DD)),
// //                 ),
// //                 focusedBorder: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(12),
// //                   borderSide: const BorderSide(color: Color(0xFF5931DD), width: 2),
// //                 ),
// //               ),
// //             ),
// //           ),

// //           const SizedBox(height: 16),

// //           // Search results or selected medicines display
// //           Expanded(
// //             child: _searchResults.isNotEmpty
// //                 ? _buildSearchResults()
// //                 : _selectedMedicines.isNotEmpty
// //                     ? _buildSelectedMedicines()
// //                     : _buildEmptyState(),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildSearchResults() {
// //     return ListView.builder(
// //       padding: const EdgeInsets.symmetric(horizontal: 16),
// //       itemCount: _searchResults.length,
// //       itemBuilder: (context, index) {
// //         final medicine = _searchResults[index];
// //         final isSelected = _isMedicineSelected(medicine);

// //         return Card(
// //           margin: const EdgeInsets.only(bottom: 12),
// //           elevation: 2,
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(12),
// //             side: isSelected
// //                 ? const BorderSide(color: Color(0xFF5931DD), width: 2)
// //                 : BorderSide.none,
// //           ),
// //           child: InkWell(
// //             borderRadius: BorderRadius.circular(12),
// //             onTap: () => _toggleMedicineSelection(medicine),
// //             child: Padding(
// //               padding: const EdgeInsets.all(12),
// //               child: Row(
// //                 children: [
// //                   // Checkbox for multi-select mode
// //                   if (_isMultiSelectMode) ...[
// //                     Checkbox(
// //                       value: isSelected,
// //                       onChanged: (value) => _toggleMedicineSelection(medicine),
// //                       activeColor: const Color(0xFF5931DD),
// //                     ),
// //                     const SizedBox(width: 8),
// //                   ],

// //                   // Medicine Image
// //                   Container(
// //                     width: 80,
// //                     height: 80,
// //                     decoration: BoxDecoration(
// //                       color: Colors.grey[100],
// //                       borderRadius: BorderRadius.circular(8),
// //                     ),
// //                     child: medicine.images.isNotEmpty
// //                         ? ClipRRect(
// //                             borderRadius: BorderRadius.circular(8),
// //                             child: Image.network(
// //                               medicine.images.first,
// //                               fit: BoxFit.cover,
// //                               errorBuilder: (context, error, stackTrace) {
// //                                 return const Icon(
// //                                   Icons.medication,
// //                                   color: Color(0xFF5931DD),
// //                                   size: 40,
// //                                 );
// //                               },
// //                             ),
// //                           )
// //                         : const Icon(
// //                             Icons.medication,
// //                             color: Color(0xFF5931DD),
// //                             size: 40,
// //                           ),
// //                   ),
// //                   const SizedBox(width: 12),

// //                   // Medicine Details
// //                   Expanded(
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text(
// //                           medicine.name,
// //                           style: const TextStyle(
// //                             fontWeight: FontWeight.bold,
// //                             fontSize: 16,
// //                           ),
// //                           maxLines: 2,
// //                           overflow: TextOverflow.ellipsis,
// //                         ),
// //                         const SizedBox(height: 4),
// //                         Text(
// //                           medicine.description,
// //                           style: TextStyle(
// //                             color: Colors.grey[600],
// //                             fontSize: 12,
// //                           ),
// //                           maxLines: 2,
// //                           overflow: TextOverflow.ellipsis,
// //                         ),
// //                         const SizedBox(height: 8),
// //                         Row(
// //                           children: [
// //                             Text(
// //                               '₹${medicine.price}',
// //                               style: const TextStyle(
// //                                 color: Color(0xFF5931DD),
// //                                 fontWeight: FontWeight.bold,
// //                                 fontSize: 16,
// //                               ),
// //                             ),
// //                             const SizedBox(width: 8),
// //                             if (medicine.mrp > medicine.price)
// //                               Text(
// //                                 '₹${medicine.mrp}',
// //                                 style: TextStyle(
// //                                   color: Colors.grey[500],
// //                                   fontSize: 12,
// //                                   decoration: TextDecoration.lineThrough,
// //                                 ),
// //                               ),
// //                           ],
// //                         ),
// //                         const SizedBox(height: 4),
// //                         Text(
// //                           medicine.pharmacy.name,
// //                           style: TextStyle(
// //                             color: Colors.grey[600],
// //                             fontSize: 11,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),

// //                   // Select indicator
// //                   if (!_isMultiSelectMode)
// //                     Icon(
// //                       isSelected ? Icons.check_circle : Icons.arrow_forward_ios,
// //                       color: const Color(0xFF5931DD),
// //                       size: 16,
// //                     ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   Widget _buildSelectedMedicines() {
// //     return Column(
// //       children: [
// //         // Selected medicines list
// //         Expanded(
// //           child: ListView.builder(
// //             padding: const EdgeInsets.symmetric(horizontal: 16),
// //             itemCount: _selectedMedicines.length,
// //             itemBuilder: (context, index) {
// //               final medicine = _selectedMedicines[index];
// //               return Card(
// //                 margin: const EdgeInsets.only(bottom: 12),
// //                 elevation: 2,
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(12),
// //                   side: const BorderSide(color: Color(0xFF5931DD), width: 1),
// //                 ),
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(12),
// //                   child: Row(
// //                     children: [
// //                       // Medicine Image
// //                       Container(
// //                         width: 60,
// //                         height: 60,
// //                         decoration: BoxDecoration(
// //                           color: Colors.grey[100],
// //                           borderRadius: BorderRadius.circular(8),
// //                         ),
// //                         child: medicine.images.isNotEmpty
// //                             ? ClipRRect(
// //                                 borderRadius: BorderRadius.circular(8),
// //                                 child: Image.network(
// //                                   medicine.images.first,
// //                                   fit: BoxFit.cover,
// //                                   errorBuilder: (context, error, stackTrace) {
// //                                     return const Icon(
// //                                       Icons.medication,
// //                                       color: Color(0xFF5931DD),
// //                                       size: 30,
// //                                     );
// //                                   },
// //                                 ),
// //                               )
// //                             : const Icon(
// //                                 Icons.medication,
// //                                 color: Color(0xFF5931DD),
// //                                 size: 30,
// //                               ),
// //                       ),
// //                       const SizedBox(width: 12),

// //                       // Medicine Details
// //                       Expanded(
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text(
// //                               medicine.name,
// //                               style: const TextStyle(
// //                                 fontWeight: FontWeight.bold,
// //                                 fontSize: 14,
// //                                 color: Color(0xFF5931DD),
// //                               ),
// //                               maxLines: 2,
// //                               overflow: TextOverflow.ellipsis,
// //                             ),
// //                             const SizedBox(height: 4),
// //                             Text(
// //                               '₹${medicine.price}',
// //                               style: const TextStyle(
// //                                 fontWeight: FontWeight.bold,
// //                                 fontSize: 14,
// //                               ),
// //                             ),
// //                             Text(
// //                               medicine.pharmacy.name,
// //                               style: TextStyle(
// //                                 color: Colors.grey[600],
// //                                 fontSize: 11,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),

// //                       // Remove button
// //                       IconButton(
// //                         onPressed: () => _removeSelectedMedicine(medicine),
// //                         icon: const Icon(
// //                           Icons.remove_circle,
// //                           color: Colors.red,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               );
// //             },
// //           ),
// //         ),

// //         // Continue button
// //         Padding(
// //           padding: const EdgeInsets.all(16),
// //           child: SizedBox(
// //             width: double.infinity,
// //             child: ElevatedButton(
// //               onPressed: _selectedMedicines.isNotEmpty ? () {
// //                 // Close the modal first
// //                 Navigator.of(context).pop();

// //                 // Create medication data list from selected medicines
// //                 final medicationsList = _selectedMedicines.map((medicine) {
// //                   return {
// //                     "medicineId": medicine.medicineId,
// //                     "name": medicine.name,
// //                     "quantity": "1 Strip", // Default quantity, can be customized
// //                     "count": 1,
// //                     "pharmacyName": medicine.pharmacy.name,
// //                     "pharmacyImage": medicine.images.isNotEmpty ? medicine.images.first : "assets/tablet.png",
// //                     "price": medicine.price.toString(),
// //                     "mrp": medicine.mrp.toString(),
// //                     "description": medicine.description,
// //                     "categoryName": medicine.categoryName,
// //                   };
// //                 }).toList();

// //                 // Navigate to CheckoutScreen with the selected medicines data
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                     builder: (context) => CheckoutScreen(
// //                       medicineId: _selectedMedicines.first.medicineId,
// //                       medicineName: _selectedMedicines.length > 1
// //                           ? '${_selectedMedicines.length} medicines'
// //                           : _selectedMedicines.first.name,
// //                       medicinePrice: _selectedMedicines
// //                           .map((m) => m.price)
// //                           .reduce((a, b) => a + b)
// //                           .toString(),
// //                       pharmacyName: _selectedMedicines.first.pharmacy.name,
// //                       pharmacyImage: _selectedMedicines.first.images.isNotEmpty
// //                           ? _selectedMedicines.first.images.first
// //                           : null,
// //                       medicationsList: medicationsList, // Pass the complete list
// //                     ),
// //                   ),
// //                 );
// //               } : null,
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: _selectedMedicines.isNotEmpty
// //                     ? const Color(0xFF5931DD)
// //                     : Colors.grey,
// //                 foregroundColor: Colors.white,
// //                 padding: const EdgeInsets.symmetric(vertical: 16),
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(12),
// //                 ),
// //               ),
// //               child: Text(
// //                 _selectedMedicines.isEmpty
// //                     ? 'Select medicines to continue'
// //                     : _selectedMedicines.length == 1
// //                         ? 'Continue with Selected Medicine'
// //                         : 'Continue with ${_selectedMedicines.length} Medicines',
// //                 style: const TextStyle(
// //                   fontSize: 16,
// //                   fontWeight: FontWeight.w600,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildEmptyState() {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(
// //             _isMultiSelectMode ? Icons.checklist : Icons.search,
// //             size: 80,
// //             color: Colors.grey[300],
// //           ),
// //           const SizedBox(height: 16),
// //           Text(
// //             _isMultiSelectMode ? 'Select multiple medicines' : 'Search for medicines',
// //             style: TextStyle(
// //               fontSize: 18,
// //               color: Colors.grey[600],
// //               fontWeight: FontWeight.w500,
// //             ),
// //           ),
// //           const SizedBox(height: 8),
// //           Text(
// //             _isMultiSelectMode
// //                 ? 'Turn on multi-select mode and search\nto select multiple medicines for your periodic plan'
// //                 : 'Type in the search box to find medicines\nfor your periodic plan',
// //             textAlign: TextAlign.center,
// //             style: TextStyle(
// //               color: Colors.grey[500],
// //               fontSize: 14,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _searchController.dispose();
// //     super.dispose();
// //   }
// // }

// // class CurvedClipper extends CustomClipper<Path> {
// //   @override
// //   Path getClip(Size size) {
// //     final path = Path();

// //     path.moveTo(size.width, 0);
// //     path.lineTo(size.width, size.height);
// //     path.quadraticBezierTo(
// //       size.width * 0.3,
// //       size.height * 0.85,
// //       size.width * 0.2,
// //       size.height * 0.5,
// //     );
// //     path.quadraticBezierTo(
// //       size.width * 0.3,
// //       size.height * 0.15,
// //       size.width,
// //       0,
// //     );
// //     path.close();
// //     return path;
// //   }

// //   @override
// //   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// // }




// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:medical_user_app/providers/periodic_plan_provider.dart';
// import 'dart:convert';
// import 'package:medical_user_app/utils/shared_preferences_helper.dart';
// import 'package:medical_user_app/view/checkout_screen.dart';
// import 'package:medical_user_app/view/detail/periodic_detail.dart';
// import 'package:provider/provider.dart';

// // Medicine Models
// class Medicine {
//   final String medicineId;
//   final String name;
//   final List<String> images;
//   final int price;
//   final int mrp;
//   final String description;
//   final String categoryName;
//   final Pharmacy pharmacy;

//   Medicine({
//     required this.medicineId,
//     required this.name,
//     required this.images,
//     required this.price,
//     required this.mrp,
//     required this.description,
//     required this.categoryName,
//     required this.pharmacy,
//   });

//   factory Medicine.fromJson(Map<String, dynamic> json) {
//     return Medicine(
//       medicineId: json['medicineId'] ?? '',
//       name: json['name'] ?? '',
//       images: List<String>.from(json['images'] ?? []),
//       price: json['price'] ?? 0,
//       mrp: json['mrp'] ?? 0,
//       description: json['description'] ?? '',
//       categoryName: json['categoryName'] ?? '',
//       pharmacy: Pharmacy.fromJson(json['pharmacy'] ?? {}),
//     );
//   }
// }

// class Pharmacy {
//   final String id;
//   final String name;
//   final Location location;

//   Pharmacy({
//     required this.id,
//     required this.name,
//     required this.location,
//   });

//   factory Pharmacy.fromJson(Map<String, dynamic> json) {
//     return Pharmacy(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? '',
//       location: Location.fromJson(json['location'] ?? {}),
//     );
//   }
// }

// class Location {
//   final String type;
//   final List<double> coordinates;

//   Location({
//     required this.type,
//     required this.coordinates,
//   });

//   factory Location.fromJson(Map<String, dynamic> json) {
//     return Location(
//       type: json['type'] ?? '',
//       coordinates: List<double>.from(json['coordinates'] ?? []),
//     );
//   }
// }

// class ApiResponse {
//   final String message;
//   final int total;
//   final List<Medicine> medicines;

//   ApiResponse({
//     required this.message,
//     required this.total,
//     required this.medicines,
//   });

//   factory ApiResponse.fromJson(Map<String, dynamic> json) {
//     return ApiResponse(
//       message: json['message'] ?? '',
//       total: json['total'] ?? 0,
//       medicines: (json['medicines'] as List? ?? [])
//           .map((medicine) => Medicine.fromJson(medicine))
//           .toList(),
//     );
//   }
// }

// class PeriodicMedsPlanCardSimple extends StatelessWidget {
//   const PeriodicMedsPlanCardSimple({Key? key}) : super(key: key);

//   // Method to activate periodic meds plan
//   Future<bool> _activatePeriodicMedsPlan() async {
//     try {
//       // Get user ID from SharedPreferences
//       final user = await SharedPreferencesHelper.getUser();
//       final token = await SharedPreferencesHelper.getToken();

//       if (user == null || token == null) {
//         print('Error: User or token not found');
//         return false;
//       }

//       final url =
//           'http://31.97.206.144:7021/api/users/periodicmedsplan/${user.id}';


//           print('hhhhvvvvvvvvvvvvvvvvvvvvvvvvvvv$url');

//       final response = await http.put(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: json.encode({
//           'isActive': true,
//         }),
//       );


//       print('response statussssssssssssssssssssssssss codeeeeeeeeeeeeeeeeeeee${response.statusCode}');

//       if (response.statusCode == 200) {
//         print('Periodic meds plan activated successfully');
//         return true;
//       } else {
//         print('Failed to activate periodic meds plan: ${response.statusCode}');
//         print('Response body: ${response.body}');
//         return false;
//       }
//     } catch (e) {
//       print('Error activating periodic meds plan: $e');
//       return false;
//     }
//   }




//   // In your PeriodicMedsPlanCardSimple widget
// Future<Map<String, dynamic>?> _fetchCurrentPlanData() async {
//   try {
//     final user = await SharedPreferencesHelper.getUser();
//     final token = await SharedPreferencesHelper.getToken();

//     if (user == null || token == null) {
//       print('Error: User or token not found');
//       return null;
//     }

//     final url = 'http://31.97.206.144:7021/api/users/periodicmedsplan/${user.id}';

//     final response = await http.get(
//       Uri.parse(url),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return data; // Return the plan data
//     } else {
//       print('Failed to fetch plan data: ${response.statusCode}');
//       return null;
//     }
//   } catch (e) {
//     print('Error fetching plan data: $e');
//     return null;
//   }
// }

//   // Method to show bottom modal with medicine details and search functionality
//   void _showMedicineDetailsModal(
//     BuildContext context, {
//     bool showAfterActivation = false,
//   }) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => MedicineDetailsModalWithSearch(
//         showAfterActivation: showAfterActivation,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 160,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 4,
//             offset: const Offset(0, 1),
//           ),
//         ],
//       ),
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           // Purple curved background
//           Positioned(
//             right: 0,
//             top: 0,
//             bottom: 0,
//             child: ClipPath(
//               clipper: CurvedClipper(),
//               child: Container(
//                 width: 150,
//                 decoration: const BoxDecoration(
//                   color: Color(0xFF5931DD),
//                 ),
//                 child: Center(
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 20),
//                     child: Image.asset(
//                       'assets/doctor.png',
//                       width: 80,
//                       height: 80,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Content (text + buttons)
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Periodic Meds",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 const Text(
//                   "Plan",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const Spacer(),

//                 // Buttons row
//                 Row(
//                   children: [
//                     // Activate button - Calls API and shows modal
//                     Expanded(
//                       flex: 5,
//                       child: ElevatedButton(
//                         onPressed: () async {
//                           // Show loading
//                           showDialog(
//                             context: context,
//                             barrierDismissible: false,
//                             builder: (context) => const Center(
//                               child: CircularProgressIndicator(
//                                 color: Color(0xFF5931DD),
//                               ),
//                             ),
//                           );

//                           // Call API to activate periodic meds plan
//                           final success = await _activatePeriodicMedsPlan();

//                           // Hide loading
//                           Navigator.of(context).pop();

//                           if (success) {
//                             // Show success message
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text(
//                                     'Periodic Meds Plan activated successfully!'),
//                                 backgroundColor: Colors.green,
//                               ),
//                             );

//                             // Show modal after successful activation
//                             _showMedicineDetailsModal(
//                               context,
//                               showAfterActivation: true,
//                             );
//                           } else {
//                             // Show error message
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text(
//                                     'Failed to activate Periodic Meds Plan. Please try again.'),
//                                 backgroundColor: Colors.red,
//                               ),
//                             );
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF5931DD),
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(24),
//                           ),
//                         ),
//                         child: const Text(
//                           "Activate",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8),

//                     // Details button
//                     Expanded(
//                       flex: 4,
//                       child: OutlinedButton(
//                         onPressed: () {

//                           Navigator.push(context, MaterialPageRoute(builder: (context)=>const PeriodicDetail()));
                       
//                           // _showMedicineDetailsModal(context);
//                         },
//                         style: OutlinedButton.styleFrom(
//                           side: const BorderSide(color: Color(0xFF5931DD)),
//                           foregroundColor: const Color(0xFF5931DD),
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(24),
//                           ),
//                           backgroundColor: Colors.white,
//                           elevation: 0,
//                         ),
//                         child: const Text(
//                           "Details",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // New Modal Widget with Search Functionality and Multi-Selection
// class MedicineDetailsModalWithSearch extends StatefulWidget {
//   final bool showAfterActivation;

//   const MedicineDetailsModalWithSearch({
//     Key? key,
//     this.showAfterActivation = false,
//   }) : super(key: key);

//   @override
//   State<MedicineDetailsModalWithSearch> createState() =>
//       _MedicineDetailsModalWithSearchState();
// }

// class _MedicineDetailsModalWithSearchState
//     extends State<MedicineDetailsModalWithSearch> {
//   final TextEditingController _searchController = TextEditingController();
//   List<Medicine> _searchResults = [];
//   bool _isSearching = false;
//   bool _isActive = true; // Toggle state
//   List<Medicine> _selectedMedicines = []; // Support multiple selections

//   @override
//   void initState() {
//     super.initState();
//     if (widget.showAfterActivation) {
//       // Set initial state as active if coming from activation
//       _isActive = true;
//     }
//   }

//   // Method to search medicines
//   Future<void> _searchMedicines(String query) async {
//     if (query.trim().isEmpty) {
//       setState(() {
//         _searchResults = [];
//       });
//       return;
//     }

//     setState(() {
//       _isSearching = true;
//     });

//     try {
//       final token = await SharedPreferencesHelper.getToken();
//       final url =
//           'http://31.97.206.144:7021/api/pharmacy/allmedicine?name=${Uri.encodeComponent(query)}';

//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           if (token != null) 'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         final apiResponse = ApiResponse.fromJson(data);
//         setState(() {
//           _searchResults = apiResponse.medicines;
//         });
//       } else {
//         print('Failed to search medicines: ${response.statusCode}');
//         setState(() {
//           _searchResults = [];
//         });
//       }
//     } catch (e) {
//       print('Error searching medicines: $e');
//       setState(() {
//         _searchResults = [];
//       });
//     } finally {
//       setState(() {
//         _isSearching = false;
//       });
//     }
//   }

//   // Method to update periodic meds plan status
//   Future<void> _updatePeriodicMedsPlan(bool isActive) async {
//     try {
//       final user = await SharedPreferencesHelper.getUser();
//       final token = await SharedPreferencesHelper.getToken();

//       if (user == null || token == null) {
//         print('Error: User or token not found');
//         return;
//       }

//       final url =
//           'http://31.97.206.144:7021/api/users/periodicmedsplan/${user.id}';

//       final response = await http.put(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: json.encode({
//           'isActive': isActive,
//         }),
//       );

//       if (response.statusCode == 200) {
//         print('Periodic meds plan updated successfully: $isActive');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(isActive
//                 ? 'Periodic Meds Plan activated!'
//                 : 'Periodic Meds Plan deactivated!'),
//             backgroundColor: isActive ? Colors.green : Colors.orange,
//           ),
//         );
//       } else {
//         print('Failed to update periodic meds plan: ${response.statusCode}');
//         // Revert toggle state on failure
//         setState(() {
//           _isActive = !isActive;
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Failed to update plan status. Please try again.'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } catch (e) {
//       print('Error updating periodic meds plan: $e');
//       // Revert toggle state on error
//       setState(() {
//         _isActive = !isActive;
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Error updating plan status. Please try again.'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   // Method to handle medicine selection
//   void _toggleMedicineSelection(Medicine medicine) {
//     setState(() {
//       // Always use multi-select mode
//       final index = _selectedMedicines
//           .indexWhere((m) => m.medicineId == medicine.medicineId);
//       if (index >= 0) {
//         _selectedMedicines.removeAt(index);
//       } else {
//         _selectedMedicines.add(medicine);
//       }
//     });
//   }

//   // Method to check if medicine is selected
//   bool _isMedicineSelected(Medicine medicine) {
//     return _selectedMedicines.any((m) => m.medicineId == medicine.medicineId);
//   }

//   // Method to remove selected medicine
//   void _removeSelectedMedicine(Medicine medicine) {
//     setState(() {
//       _selectedMedicines
//           .removeWhere((m) => m.medicineId == medicine.medicineId);
//     });
//   }

//   // Method to clear all selections
//   void _clearAllSelections() {
//     setState(() {
//       _selectedMedicines.clear();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.85,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: Column(
//         children: [
//           // Handle bar
//           Container(
//             width: 40,
//             height: 4,
//             margin: const EdgeInsets.symmetric(vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(2),
//             ),
//           ),

//           // Header with toggle
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Periodic Meds Plan',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       _isActive ? 'Active' : 'Inactive',
//                       style: TextStyle(
//                         color: _isActive ? Colors.green : Colors.grey,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Switch(
//                       value: _isActive,
//                       onChanged: (value) {
//                         setState(() {
//                           _isActive = value;
//                         });
//                         _updatePeriodicMedsPlan(value);
//                       },
//                       activeColor: const Color(0xFF5931DD),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           // Multi-select mode toggle and selection counter
//           if (_searchResults.isEmpty && _selectedMedicines.isEmpty)
//             const SizedBox(height: 8),

//           // Selected medicines counter and clear button
//           if (_selectedMedicines.isNotEmpty)
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF5931DD).withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     '${_selectedMedicines.length} medicine${_selectedMedicines.length > 1 ? 's' : ''} selected',
//                     style: const TextStyle(
//                       color: Color(0xFF5931DD),
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: _clearAllSelections,
//                     child: const Text(
//                       'Clear All',
//                       style: TextStyle(
//                         color: Color(0xFF5931DD),
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//           // Search field
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: TextField(
//               controller: _searchController,
//               onChanged: (value) {
//                 _searchMedicines(value);
//               },
//               decoration: InputDecoration(
//                 hintText: 'Search and select medicines...',
//                 prefixIcon: const Icon(Icons.search, color: Color(0xFF5931DD)),
//                 suffixIcon: _isSearching
//                     ? const SizedBox(
//                         width: 20,
//                         height: 20,
//                         child: Padding(
//                           padding: EdgeInsets.all(12),
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             color: Color(0xFF5931DD),
//                           ),
//                         ),
//                       )
//                     : _searchController.text.isNotEmpty
//                         ? IconButton(
//                             icon: const Icon(Icons.clear),
//                             onPressed: () {
//                               _searchController.clear();
//                               setState(() {
//                                 _searchResults = [];
//                               });
//                             },
//                           )
//                         : null,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: Color(0xFF5931DD)),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide:
//                       const BorderSide(color: Color(0xFF5931DD), width: 2),
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(height: 16),

//           // Search results or selected medicines display
//           Expanded(
//             child: _searchResults.isNotEmpty
//                 ? _buildSearchResults()
//                 : _selectedMedicines.isNotEmpty
//                     ? _buildSelectedMedicines()
//                     : _buildEmptyState(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchResults() {
//     return ListView.builder(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       itemCount: _searchResults.length,
//       itemBuilder: (context, index) {
//         final medicine = _searchResults[index];
//         final isSelected = _isMedicineSelected(medicine);

//         return Card(
//           margin: const EdgeInsets.only(bottom: 12),
//           elevation: 2,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//             side: isSelected
//                 ? const BorderSide(color: Color(0xFF5931DD), width: 2)
//                 : BorderSide.none,
//           ),
//           child: InkWell(
//             borderRadius: BorderRadius.circular(12),
//             onTap: () => _toggleMedicineSelection(medicine),
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Row(
//                 children: [
//                   // Checkbox for selection
//                   Checkbox(
//                     value: isSelected,
//                     onChanged: (value) => _toggleMedicineSelection(medicine),
//                     activeColor: const Color(0xFF5931DD),
//                   ),
//                   const SizedBox(width: 8),

//                   // Medicine Image
//                   Container(
//                     width: 80,
//                     height: 80,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[100],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: medicine.images.isNotEmpty
//                         ? ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: Image.network(
//                               medicine.images.first,
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return const Icon(
//                                   Icons.medication,
//                                   color: Color(0xFF5931DD),
//                                   size: 40,
//                                 );
//                               },
//                             ),
//                           )
//                         : const Icon(
//                             Icons.medication,
//                             color: Color(0xFF5931DD),
//                             size: 40,
//                           ),
//                   ),
//                   const SizedBox(width: 12),

//                   // Medicine Details
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           medicine.name,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           medicine.description,
//                           style: TextStyle(
//                             color: Colors.grey[600],
//                             fontSize: 12,
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         const SizedBox(height: 8),
//                         Row(
//                           children: [
//                             Text(
//                               '₹${medicine.price}',
//                               style: const TextStyle(
//                                 color: Color(0xFF5931DD),
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             if (medicine.mrp > medicine.price)
//                               Text(
//                                 '₹${medicine.mrp}',
//                                 style: TextStyle(
//                                   color: Colors.grey[500],
//                                   fontSize: 12,
//                                   decoration: TextDecoration.lineThrough,
//                                 ),
//                               ),
//                           ],
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           medicine.pharmacy.name,
//                           style: TextStyle(
//                             color: Colors.grey[600],
//                             fontSize: 11,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Select indicator - Always show check for selected items
//                   Icon(
//                     isSelected ? Icons.check_circle : Icons.add_circle_outline,
//                     color: const Color(0xFF5931DD),
//                     size: 20,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSelectedMedicines() {
//     return Column(
//       children: [
//         // Selected medicines list
//         Expanded(
//           child: ListView.builder(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             itemCount: _selectedMedicines.length,
//             itemBuilder: (context, index) {
//               final medicine = _selectedMedicines[index];
//               return Card(
//                 margin: const EdgeInsets.only(bottom: 12),
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   side: const BorderSide(color: Color(0xFF5931DD), width: 1),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Row(
//                     children: [
//                       // Medicine Image
//                       Container(
//                         width: 60,
//                         height: 60,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[100],
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: medicine.images.isNotEmpty
//                             ? ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: Image.network(
//                                   medicine.images.first,
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (context, error, stackTrace) {
//                                     return const Icon(
//                                       Icons.medication,
//                                       color: Color(0xFF5931DD),
//                                       size: 30,
//                                     );
//                                   },
//                                 ),
//                               )
//                             : const Icon(
//                                 Icons.medication,
//                                 color: Color(0xFF5931DD),
//                                 size: 30,
//                               ),
//                       ),
//                       const SizedBox(width: 12),

//                       // Medicine Details
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               medicine.name,
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 14,
//                                 color: Color(0xFF5931DD),
//                               ),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               '₹${medicine.price}',
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 14,
//                               ),
//                             ),
//                             Text(
//                               medicine.pharmacy.name,
//                               style: TextStyle(
//                                 color: Colors.grey[600],
//                                 fontSize: 11,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       // Remove button
//                       IconButton(
//                         onPressed: () => _removeSelectedMedicine(medicine),
//                         icon: const Icon(
//                           Icons.remove_circle,
//                           color: Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),

//         // Continue button
//         Padding(
//           padding: const EdgeInsets.all(16),
//           child: SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: _selectedMedicines.isNotEmpty
//                   ? () {
//                       // Close the modal first
//                       Navigator.of(context).pop();

//                       // Create medication data list from selected medicines
//                       final medicationsList =
//                           _selectedMedicines.map((medicine) {
//                         return {
//                           "medicineId": medicine.medicineId,
//                           "name": medicine.name,
//                           "quantity":
//                               "1 Strip",
//                           "count": 1,
//                           "pharmacyName": medicine.pharmacy.name,
//                           "pharmacyImage": medicine.images.isNotEmpty
//                               ? medicine.images.first
//                               : "assets/tablet.png",
//                           "price": medicine.price.toString(),
//                           "mrp": medicine.mrp.toString(),
//                           "description": medicine.description,
//                           "categoryName": medicine.categoryName,
//                         };
//                       }).toList();

//                       // Navigate to CheckoutScreen with the selected medicines data
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CheckoutScreen(
//                             medicineId: _selectedMedicines.first.medicineId,
//                             medicineName: _selectedMedicines.length > 1
//                                 ? '${_selectedMedicines.length} medicines'
//                                 : _selectedMedicines.first.name,
//                             medicinePrice: _selectedMedicines
//                                 .map((m) => m.price)
//                                 .reduce((a, b) => a + b)
//                                 .toString(),
//                             pharmacyName:
//                                 _selectedMedicines.first.pharmacy.name,
//                             pharmacyImage:
//                                 _selectedMedicines.first.images.isNotEmpty
//                                     ? _selectedMedicines.first.images.first
//                                     : null,
//                             medicationsList:
//                                 medicationsList, // Pass the complete list
//                           ),
//                         ),
//                       );
//                     }
//                   : null,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: _selectedMedicines.isNotEmpty
//                     ? const Color(0xFF5931DD)
//                     : Colors.grey,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: Text(
//                 _selectedMedicines.isEmpty
//                     ? 'Select medicines to continue'
//                     : _selectedMedicines.length == 1
//                         ? 'Continue with Selected Medicine'
//                         : 'Continue with ${_selectedMedicines.length} Medicines',
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.checklist,
//             size: 80,
//             color: Colors.grey[300],
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'Select medicines',
//             style: TextStyle(
//               fontSize: 18,
//               color: Colors.grey[600],
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Search and select medicines\nfor your periodic plan',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.grey[500],
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
// }

// class CurvedClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();

//     path.moveTo(size.width, 0);
//     path.lineTo(size.width, size.height);
//     path.quadraticBezierTo(
//       size.width * 0.3,
//       size.height * 0.85,
//       size.width * 0.2,
//       size.height * 0.5,
//     );
//     path.quadraticBezierTo(
//       size.width * 0.3,
//       size.height * 0.15,
//       size.width,
//       0,
//     );
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
























import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:medical_user_app/providers/periodic_plan_provider.dart';
import 'dart:convert';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';
import 'package:medical_user_app/view/checkout_screen.dart';
import 'package:medical_user_app/view/detail/periodic_detail.dart';
import 'package:provider/provider.dart';

// Medicine Models
class Medicine {
  final String medicineId;
  final String name;
  final List<String> images;
  final int price;
  final int mrp;
  final String description;
  final String categoryName;
  final Pharmacy pharmacy;

  Medicine({
    required this.medicineId,
    required this.name,
    required this.images,
    required this.price,
    required this.mrp,
    required this.description,
    required this.categoryName,
    required this.pharmacy,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      medicineId: json['medicineId'] ?? '',
      name: json['name'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      price: json['price'] ?? 0,
      mrp: json['mrp'] ?? 0,
      description: json['description'] ?? '',
      categoryName: json['categoryName'] ?? '',
      pharmacy: Pharmacy.fromJson(json['pharmacy'] ?? {}),
    );
  }
}

class Pharmacy {
  final String id;
  final String name;
  final Location location;

  Pharmacy({
    required this.id,
    required this.name,
    required this.location,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      location: Location.fromJson(json['location'] ?? {}),
    );
  }
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'] ?? '',
      coordinates: List<double>.from(json['coordinates'] ?? []),
    );
  }
}

class ApiResponse {
  final String message;
  final int total;
  final List<Medicine> medicines;

  ApiResponse({
    required this.message,
    required this.total,
    required this.medicines,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json['message'] ?? '',
      total: json['total'] ?? 0,
      medicines: (json['medicines'] as List? ?? [])
          .map((medicine) => Medicine.fromJson(medicine))
          .toList(),
    );
  }
}

class PeriodicMedsPlanCardSimple extends StatelessWidget {
  const PeriodicMedsPlanCardSimple({Key? key}) : super(key: key);

  // Method to activate periodic meds plan
  Future<bool> _activatePeriodicMedsPlan() async {
    try {
      final user = await SharedPreferencesHelper.getUser();
      final token = await SharedPreferencesHelper.getToken();

      if (user == null || token == null) {
        print('Error: User or token not found');
        return false;
      }



      final url = 'http://31.97.206.144:7021/api/users/periodicmedsplan/${user.id}';


      print('urrrrlllllllllllllllllllllllllllll$url');

      print('Activating plan at URL: $url');

      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'isActive': true,
        }),
      );

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        print('Periodic meds plan activated successfully');
        return true;
      } else {
        print('Failed to activate periodic meds plan: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error activating periodic meds plan: $e');
      return false;
    }
  }


  // Future<Map<String, dynamic>?> _fetchCurrentPlanData() async {
  //   try {
  //     final user = await SharedPreferencesHelper.getUser();
  //     final token = await SharedPreferencesHelper.getToken();

  //     if (user == null || token == null) {
  //       print('Error: User or token not found');
  //       return null;
  //     }

  //     final url = 'http://31.97.206.144:7021/api/users/periodicmedsplan/${user.id}';

  //     final response = await http.get(
  //       Uri.parse(url),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       return data;
  //     } else {
  //       print('Failed to fetch plan data: ${response.statusCode}');
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Error fetching plan data: $e');
  //     return null;
  //   }
  // }

  void _showMedicineDetailsModal(
    BuildContext context, {
    bool showAfterActivation = false,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MedicineDetailsModalWithSearch(
        showAfterActivation: showAfterActivation,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
      bool _isCheckingPharmacy = false;


      

    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: ClipPath(
              clipper: CurvedClipper(),
              child: Container(
                width: 150,
                decoration: const BoxDecoration(
                  color: Color(0xFF5931DD),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Image.asset(
                      'assets/doctor.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Periodic Meds",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  "Plan",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ElevatedButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF5931DD),
                              ),
                            ),
                          );

                          final success = await _activatePeriodicMedsPlan();
                          Navigator.of(context).pop();

                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Periodic Meds Plan activated successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            _showMedicineDetailsModal(
                              context,
                              showAfterActivation: true,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Failed to activate Periodic Meds Plan. Please try again.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const  Color(0xFF5931DD),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text(
                          "Activate",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 4,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PeriodicDetail()));
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF5931DD)),
                          foregroundColor: const Color(0xFF5931DD),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          backgroundColor: Colors.white,
                          elevation: 0,
                        ),
                        child: const Text(
                          "Details",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class MedicineDetailsModalWithSearch extends StatefulWidget {
//   final bool showAfterActivation;

//   const MedicineDetailsModalWithSearch({
//     Key? key,
//     this.showAfterActivation = false,
//   }) : super(key: key);

//   @override
//   State<MedicineDetailsModalWithSearch> createState() =>
//       _MedicineDetailsModalWithSearchState();
// }

// class _MedicineDetailsModalWithSearchState
//     extends State<MedicineDetailsModalWithSearch> {
//   final TextEditingController _searchController = TextEditingController();
//   List<Medicine> _searchResults = [];
//   bool _isSearching = false;
//   bool _isActive = true;
//   List<Medicine> _selectedMedicines = [];
//   bool _isLoadingStatus = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadCurrentPlanStatus();
//   }

//   // Load current plan status from API
//   Future<void> _loadCurrentPlanStatus() async {
//     try {
//       final user = await SharedPreferencesHelper.getUser();
//       final token = await SharedPreferencesHelper.getToken();

//       if (user == null || token == null) {
//         setState(() {
//           _isLoadingStatus = false;
//         });
//         return;
//       }

//       final url =
//           'http://31.97.206.144:7021/api/users/periodicmedsplan/${user.id}';


//           print('uuuuuurllllllllllllllllllllllllllll$url');

//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );


//        print('status codeeeeeeeeeeeeeeeeeeeeeeeeeeeeee ${response.statusCode}');
//               print('response bodyyyyyyyyyyyyyyyyyyyy ${response.statusCode}');

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           _isActive = data['isActive'] ?? true;
//           _isLoadingStatus = false;
//         });
//       } else {
//         setState(() {
//           _isLoadingStatus = false;
//         });
//       }
//     } catch (e) {
//       print('Error loading plan status: $e');
//       setState(() {
//         _isLoadingStatus = false;
//       });
//     }
//   }

//   // Modified search method - only works when active
//   Future<void> _searchMedicines(String query) async {
//     // Block search if plan is inactive
//     if (!_isActive) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please activate the plan to search medicines'),
//           backgroundColor: Colors.orange,
//           duration: Duration(seconds: 2),
//         ),
//       );
//       return;
//     }

//     if (query.trim().isEmpty) {
//       setState(() {
//         _searchResults = [];
//       });
//       return;
//     }

//     setState(() {
//       _isSearching = true;
//     });

//     try {
//       final token = await SharedPreferencesHelper.getToken();
//       final url =
//           'http://31.97.206.144:7021/api/pharmacy/allmedicine?name=${Uri.encodeComponent(query)}';

//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           if (token != null) 'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         final apiResponse = ApiResponse.fromJson(data);
//         setState(() {
//           _searchResults = apiResponse.medicines;
//         });
//       } else {
//         print('Failed to search medicines: ${response.statusCode}');
//         setState(() {
//           _searchResults = [];
//         });
//       }
//     } catch (e) {
//       print('Error searching medicines: $e');
//       setState(() {
//         _searchResults = [];
//       });
//     } finally {
//       setState(() {
//         _isSearching = false;
//       });
//     }
//   }

//   // Updated method with correct endpoint
//   Future<void> _updatePeriodicMedsPlan(bool isActive) async {
//     try {
//       final user = await SharedPreferencesHelper.getUser();
//       final token = await SharedPreferencesHelper.getToken();

//       if (user == null || token == null) {
//         print('Error: User or token not found');
//         setState(() {
//           _isActive = !isActive;
//         });
//         return;
//       }

//       // Use the correct endpoint
//       final url = 'http://31.97.206.144:7021/api/users/periodicmedsplan/${user.id}';

//       print('Updating plan status to: $isActive');
//       print('URL: $url');

//       final response = await http.put(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: json.encode({
//           'isActive': isActive,
//         }),
//       );

//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         print('Periodic meds plan updated successfully: $isActive');

//         // Clear everything when deactivating
//         if (!isActive) {
//           setState(() {
//             _searchResults = [];
//             _selectedMedicines = [];
//             _searchController.clear();
//           });
//         }

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(isActive
//                 ? 'Periodic Meds Plan activated!'
//                 : 'Periodic Meds Plan deactivated!'),
//             backgroundColor: isActive ? Colors.green : Colors.orange,
//           ),
//         );
//       } else {
//         print('Failed to update periodic meds plan: ${response.statusCode}');
//         setState(() {
//           _isActive = !isActive;
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Failed to update plan status. Please try again.'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } catch (e) {
//       print('Error updating periodic meds plan: $e');
//       setState(() {
//         _isActive = !isActive;
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Error updating plan status. Please try again.'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   void _toggleMedicineSelection(Medicine medicine) {
//     setState(() {
//       final index = _selectedMedicines
//           .indexWhere((m) => m.medicineId == medicine.medicineId);
//       if (index >= 0) {
//         _selectedMedicines.removeAt(index);
//       } else {
//         _selectedMedicines.add(medicine);
//       }
//     });
//   }

//   bool _isMedicineSelected(Medicine medicine) {
//     return _selectedMedicines.any((m) => m.medicineId == medicine.medicineId);
//   }

//   void _removeSelectedMedicine(Medicine medicine) {
//     setState(() {
//       _selectedMedicines
//           .removeWhere((m) => m.medicineId == medicine.medicineId);
//     });
//   }

//   void _clearAllSelections() {
//     setState(() {
//       _selectedMedicines.clear();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.85,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: Column(
//         children: [
//           Container(
//             width: 40,
//             height: 4,
//             margin: const EdgeInsets.symmetric(vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(2),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Periodic Meds Plan',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     if (_isLoadingStatus)
//                       const SizedBox(
//                         width: 16,
//                         height: 16,
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2,
//                           color: Color(0xFF5931DD),
//                         ),
//                       )
//                     else
//                       Text(
//                         _isActive ? 'Active' : 'Inactive',
//                         style: TextStyle(
//                           color: _isActive ? Colors.green : Colors.grey,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     const SizedBox(width: 8),
//                     Switch(
//                       value: _isActive,
//                       onChanged: (value) {
//                         setState(() {
//                           _isActive = value;
//                         });
//                         _updatePeriodicMedsPlan(value);
//                       },
//                       activeColor: const Color(0xFF5931DD),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           if (_searchResults.isEmpty && _selectedMedicines.isEmpty)
//             const SizedBox(height: 8),
//           if (_selectedMedicines.isNotEmpty)
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF5931DD).withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     '${_selectedMedicines.length} medicine${_selectedMedicines.length > 1 ? 's' : ''} selected',
//                     style: const TextStyle(
//                       color: Color(0xFF5931DD),
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: _clearAllSelections,
//                     child: const Text(
//                       'Clear All',
//                       style: TextStyle(
//                         color: Color(0xFF5931DD),
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: TextField(
//               controller: _searchController,
//               enabled: _isActive, // Disable when inactive
//               onChanged: (value) {
//                 _searchMedicines(value);
//               },
//               decoration: InputDecoration(
//                 hintText: _isActive
//                     ? 'Search and select medicines...'
//                     : 'Activate plan to search medicines',
//                 hintStyle: TextStyle(
//                   color: _isActive ? Colors.grey : Colors.grey[400],
//                 ),
//                 prefixIcon: Icon(
//                   Icons.search,
//                   color: _isActive ? const Color(0xFF5931DD) : Colors.grey,
//                 ),
//                 suffixIcon: _isSearching
//                     ? const SizedBox(
//                         width: 20,
//                         height: 20,
//                         child: Padding(
//                           padding: EdgeInsets.all(12),
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             color: Color(0xFF5931DD),
//                           ),
//                         ),
//                       )
//                     : _searchController.text.isNotEmpty
//                         ? IconButton(
//                             icon: const Icon(Icons.clear),
//                             onPressed: () {
//                               _searchController.clear();
//                               setState(() {
//                                 _searchResults = [];
//                               });
//                             },
//                           )
//                         : null,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(
//                     color: _isActive ? const Color(0xFF5931DD) : Colors.grey,
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(
//                     color: _isActive ? const Color(0xFF5931DD) : Colors.grey,
//                     width: 2,
//                   ),
//                 ),
//                 disabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(
//                     color: Colors.grey[300]!,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Expanded(
//             child: _searchResults.isNotEmpty
//                 ? _buildSearchResults()
//                 : _selectedMedicines.isNotEmpty
//                     ? _buildSelectedMedicines()
//                     : _buildEmptyState(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchResults() {
//     return ListView.builder(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       itemCount: _searchResults.length,
//       itemBuilder: (context, index) {
//         final medicine = _searchResults[index];
//         final isSelected = _isMedicineSelected(medicine);

//         return Card(
//           margin: const EdgeInsets.only(bottom: 12),
//           elevation: 2,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//             side: isSelected
//                 ? const BorderSide(color: Color(0xFF5931DD), width: 2)
//                 : BorderSide.none,
//           ),
//           child: InkWell(
//             borderRadius: BorderRadius.circular(12),
//             onTap: () => _toggleMedicineSelection(medicine),
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Row(
//                 children: [
//                   Checkbox(
//                     value: isSelected,
//                     onChanged: (value) => _toggleMedicineSelection(medicine),
//                     activeColor: const Color(0xFF5931DD),
//                   ),
//                   const SizedBox(width: 8),
//                   Container(
//                     width: 80,
//                     height: 80,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[100],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: medicine.images.isNotEmpty
//                         ? ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: Image.network(
//                               medicine.images.first,
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return const Icon(
//                                   Icons.medication,
//                                   color: Color(0xFF5931DD),
//                                   size: 40,
//                                 );
//                               },
//                             ),
//                           )
//                         : const Icon(
//                             Icons.medication,
//                             color: Color(0xFF5931DD),
//                             size: 40,
//                           ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           medicine.name,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           medicine.description,
//                           style: TextStyle(
//                             color: Colors.grey[600],
//                             fontSize: 12,
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         const SizedBox(height: 8),
//                         Row(
//                           children: [
//                             Text(
//                               '₹${medicine.mrp}',
//                               style: const TextStyle(
//                                 color: Color(0xFF5931DD),
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             // if (medicine.mrp > medicine.price)
//                               // Text(
//                               //   '₹${medicine.mrp}',
//                               //   style: TextStyle(
//                               //     color: Colors.grey[500],
//                               //     fontSize: 12,
//                               //     decoration: TextDecoration.lineThrough,
//                               //   ),
//                               // ),
//                           ],
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           medicine.pharmacy.name,
//                           style: TextStyle(
//                             color: Colors.grey[600],
//                             fontSize: 11,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Icon(
//                     isSelected ? Icons.check_circle : Icons.add_circle_outline,
//                     color: const Color(0xFF5931DD),
//                     size: 20,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSelectedMedicines() {
//     return Column(
//       children: [
//         Expanded(
//           child: ListView.builder(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             itemCount: _selectedMedicines.length,
//             itemBuilder: (context, index) {
//               final medicine = _selectedMedicines[index];
//               return Card(
//                 margin: const EdgeInsets.only(bottom: 12),
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   side: const BorderSide(color: Color(0xFF5931DD), width: 1),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 60,
//                         height: 60,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[100],
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: medicine.images.isNotEmpty
//                             ? ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: Image.network(
//                                   medicine.images.first,
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (context, error, stackTrace) {
//                                     return const Icon(
//                                       Icons.medication,
//                                       color: Color(0xFF5931DD),
//                                       size: 30,
//                                     );
//                                   },
//                                 ),
//                               )
//                             : const Icon(
//                                 Icons.medication,
//                                 color: Color(0xFF5931DD),
//                                 size: 30,
//                               ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               medicine.name,
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 14,
//                                 color: Color(0xFF5931DD),
//                               ),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               '₹${medicine.mrp}',
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 14,
//                               ),
//                             ),
//                             // Text(
//                             //   '₹${medicine.price}',
//                             //   style: const TextStyle(
//                             //     fontWeight: FontWeight.bold,
//                             //     fontSize: 14,
//                             //   ),
//                             // ),
//                             Text(
//                               medicine.pharmacy.name,
//                               style: TextStyle(
//                                 color: Colors.grey[600],
//                                 fontSize: 11,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () => _removeSelectedMedicine(medicine),
//                         icon: const Icon(
//                           Icons.remove_circle,
//                           color: Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(16),
//           child: SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: _selectedMedicines.isNotEmpty
//                   ? () {
//                       Navigator.of(context).pop();

//                       final medicationsList =
//                           _selectedMedicines.map((medicine) {
//                         return {
//                           "medicineId": medicine.medicineId,
//                           "name": medicine.name,
//                           "quantity": "1 Strip",
//                           "count": 1,
//                           "pharmacyName": medicine.pharmacy.name,
//                           "pharmacyImage": medicine.images.isNotEmpty
//                               ? medicine.images.first
//                               : "assets/tablet.png",
//                           "price": medicine.price.toString(),
//                           "mrp": medicine.mrp.toString(),
//                           "description": medicine.description,
//                           "categoryName": medicine.categoryName,
//                         };
//                       }).toList();

//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CheckoutScreen(
//                             medicineId: _selectedMedicines.first.medicineId,
//                             medicineName: _selectedMedicines.length > 1
//                                 ? '${_selectedMedicines.length} medicines'
//                                 : _selectedMedicines.first.name,
//                             medicinePrice: _selectedMedicines
//                                 .map((m) => m.price)
//                                 .reduce((a, b) => a + b)
//                                 .toString(),
//                             pharmacyName:
//                                 _selectedMedicines.first.pharmacy.name,
//                             pharmacyImage:
//                                 _selectedMedicines.first.images.isNotEmpty
//                                     ? _selectedMedicines.first.images.first
//                                     : null,
//                             medicationsList: medicationsList,
//                             mrp: _selectedMedicines.first.mrp.toString(),
//                           ),
//                         ),
//                       );
//                     }
//                   : null,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: _selectedMedicines.isNotEmpty
//                     ? const Color(0xFF5931DD)
//                     : Colors.grey,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: Text(
//                 _selectedMedicines.isEmpty
//                     ? 'Select medicines to continue'
//                     : _selectedMedicines.length == 1
//                         ? 'Continue with Selected Medicine'
//                         : 'Continue with ${_selectedMedicines.length} Medicines',
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             _isActive ? Icons.checklist : Icons.lock_outline,
//             size: 80,
//             color: Colors.grey[300],
//           ),
//           const SizedBox(height: 16),
//           Text(
//             _isActive ? 'Select medicines' : 'Plan Inactive',
//             style: TextStyle(
//               fontSize: 18,
//               color: Colors.grey[600],
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             _isActive
//                 ? 'Search and select medicines\nfor your periodic plan'
//                 : 'Activate the plan to start\nsearching for medicines',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.grey[500],
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
// }

// class CurvedClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();

//     path.moveTo(size.width, 0);
//     path.lineTo(size.width, size.height);
//     path.quadraticBezierTo(
//       size.width * 0.3,
//       size.height * 0.85,
//       size.width * 0.2,
//       size.height * 0.5,
//     );
//     path.quadraticBezierTo(
//       size.width * 0.3,
//       size.height * 0.15,
//       size.width,
//       0,
//     );
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }












class MedicineDetailsModalWithSearch extends StatefulWidget {
  final bool showAfterActivation;
  final List<Medicine>? previouslySelectedMedicines; // Add this parameter

  const MedicineDetailsModalWithSearch({
    Key? key,
    this.showAfterActivation = false,
    this.previouslySelectedMedicines, // Accept previously selected medicines
  }) : super(key: key);

  @override
  State<MedicineDetailsModalWithSearch> createState() =>
      _MedicineDetailsModalWithSearchState();
}

class _MedicineDetailsModalWithSearchState
    extends State<MedicineDetailsModalWithSearch> {
  final TextEditingController _searchController = TextEditingController();
  List<Medicine> _searchResults = [];
  bool _isSearching = false;
  bool _isActive = true;
  List<Medicine> _selectedMedicines = [];
  bool _isLoadingStatus = true;

  @override
  void initState() {
    super.initState();
    _loadCurrentPlanStatus();
    
    // Load previously selected medicines if available
    if (widget.previouslySelectedMedicines != null) {
      _selectedMedicines = List<Medicine>.from(widget.previouslySelectedMedicines!);
    }
  }
  

  // Load current plan status from API
  Future<void> _loadCurrentPlanStatus() async {
    try {
      final user = await SharedPreferencesHelper.getUser();
      final token = await SharedPreferencesHelper.getToken();

      if (user == null || token == null) {
        setState(() {
          _isLoadingStatus = false;
        });
        return;
      }

      final url =
          'http://31.97.206.144:7021/api/users/periodicmedsplan/${user.id}';

      print('uuuuuurllllllllllllllllllllllllllll$url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('status codeeeeeeeeeeeeeeeeeeeeeeeeeeeeee ${response.statusCode}');
      print('response bodyyyyyyyyyyyyyyyyyyyy ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _isActive = data['isActive'] ?? true;
          _isLoadingStatus = false;
        });
      } else {
        setState(() {
          _isLoadingStatus = false;
        });
      }
    } catch (e) {
      print('Error loading plan status: $e');
      setState(() {
        _isLoadingStatus = false;
      });
    }
  }

  // Modified search method - only works when active
  Future<void> _searchMedicines(String query) async {
    // Block search if plan is inactive
    if (!_isActive) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please activate the plan to search medicines'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      final token = await SharedPreferencesHelper.getToken();
      final url =
          'http://31.97.206.144:7021/api/pharmacy/allmedicine?name=${Uri.encodeComponent(query)}';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final apiResponse = ApiResponse.fromJson(data);
        setState(() {
          _searchResults = apiResponse.medicines;
        });
      } else {
        print('Failed to search medicines: ${response.statusCode}');
        setState(() {
          _searchResults = [];
        });
      }
    } catch (e) {
      print('Error searching medicines: $e');
      setState(() {
        _searchResults = [];
      });
    } finally {
      setState(() {
        _isSearching = false;
      });
    }
  }

  // Updated method with correct endpoint
  Future<void> _updatePeriodicMedsPlan(bool isActive) async {
    try {
      final user = await SharedPreferencesHelper.getUser();
      final token = await SharedPreferencesHelper.getToken();

      if (user == null || token == null) {
        print('Error: User or token not found');
        setState(() {
          _isActive = !isActive;
        });
        return;
      }

      final url = 'http://31.97.206.144:7021/api/users/periodicmedsplan/${user.id}';

      print('Updating plan status to: $isActive');
      print('URL: $url');

      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'isActive': isActive,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('Periodic meds plan updated successfully: $isActive');

        // Clear everything when deactivating
        if (!isActive) {
          setState(() {
            _searchResults = [];
            _selectedMedicines = [];
            _searchController.clear();
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isActive
                ? 'Periodic Meds Plan activated!'
                : 'Periodic Meds Plan deactivated!'),
            backgroundColor: isActive ? Colors.green : Colors.orange,
          ),
        );
      } else {
        print('Failed to update periodic meds plan: ${response.statusCode}');
        setState(() {
          _isActive = !isActive;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update plan status. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error updating periodic meds plan: $e');
      setState(() {
        _isActive = !isActive;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error updating plan status. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _toggleMedicineSelection(Medicine medicine) {
    setState(() {
      final index = _selectedMedicines
          .indexWhere((m) => m.medicineId == medicine.medicineId);
      if (index >= 0) {
        _selectedMedicines.removeAt(index);
      } else {
        _selectedMedicines.add(medicine);
      }
    });
  }

  bool _isMedicineSelected(Medicine medicine) {
    return _selectedMedicines.any((m) => m.medicineId == medicine.medicineId);
  }

  void _removeSelectedMedicine(Medicine medicine) {
    setState(() {
      _selectedMedicines
          .removeWhere((m) => m.medicineId == medicine.medicineId);
    });
  }

  void _clearAllSelections() {
    setState(() {
      _selectedMedicines.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Periodic Meds Plan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    if (_isLoadingStatus)
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFF5931DD),
                        ),
                      )
                    else
                      Text(
                        _isActive ? 'Active' : 'Inactive',
                        style: TextStyle(
                          color: _isActive ? Colors.green : Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    const SizedBox(width: 8),
                    Switch(
                      value: _isActive,
                      onChanged: (value) {
                        setState(() {
                          _isActive = value;
                        });
                        _updatePeriodicMedsPlan(value);
                      },
                      activeColor: const Color(0xFF5931DD),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_searchResults.isEmpty && _selectedMedicines.isEmpty)
            const SizedBox(height: 8),
          if (_selectedMedicines.isNotEmpty)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF5931DD).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_selectedMedicines.length} medicine${_selectedMedicines.length > 1 ? 's' : ''} selected',
                    style: const TextStyle(
                      color: Color(0xFF5931DD),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: _clearAllSelections,
                    child: const Text(
                      'Clear All',
                      style: TextStyle(
                        color: Color(0xFF5931DD),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              enabled: _isActive,
              onChanged: (value) {
                _searchMedicines(value);
              },
              decoration: InputDecoration(
                hintText: _isActive
                    ? 'Search and select medicines...'
                    : 'Activate plan to search medicines',
                hintStyle: TextStyle(
                  color: _isActive ? Colors.grey : Colors.grey[400],
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: _isActive ? const Color(0xFF5931DD) : Colors.grey,
                ),
                suffixIcon: _isSearching
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF5931DD),
                          ),
                        ),
                      )
                    : _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchResults = [];
                              });
                            },
                          )
                        : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: _isActive ? const Color(0xFF5931DD) : Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: _isActive ? const Color(0xFF5931DD) : Colors.grey,
                    width: 2,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.grey[300]!,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _searchResults.isNotEmpty
                ? _buildSearchResults()
                : _selectedMedicines.isNotEmpty
                    ? _buildSelectedMedicines()
                    : _buildEmptyState(),
          ),
        ],
      ),
    );
  }

  // Widget _buildSearchResults() {
  //   return ListView.builder(
  //     padding: const EdgeInsets.symmetric(horizontal: 16),
  //     itemCount: _searchResults.length,
  //     itemBuilder: (context, index) {
  //       final medicine = _searchResults[index];
  //       final isSelected = _isMedicineSelected(medicine);

  //       return Card(
  //         margin: const EdgeInsets.only(bottom: 12),
  //         elevation: 2,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(12),
  //           side: isSelected
  //               ? const BorderSide(color: Color(0xFF5931DD), width: 2)
  //               : BorderSide.none,
  //         ),
  //         child: InkWell(
  //           borderRadius: BorderRadius.circular(12),
  //           onTap: () => _toggleMedicineSelection(medicine),
  //           child: Padding(
  //             padding: const EdgeInsets.all(12),
  //             child: Row(
  //               children: [
  //                 Checkbox(
  //                   value: isSelected,
  //                   onChanged: (value) => _toggleMedicineSelection(medicine),
  //                   activeColor: const Color(0xFF5931DD),
  //                 ),
  //                 const SizedBox(width: 8),
  //                 Container(
  //                   width: 80,
  //                   height: 80,
  //                   decoration: BoxDecoration(
  //                     color: Colors.grey[100],
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                   child: medicine.images.isNotEmpty
  //                       ? ClipRRect(
  //                           borderRadius: BorderRadius.circular(8),
  //                           child: Image.network(
  //                             medicine.images.first,
  //                             fit: BoxFit.cover,
  //                             errorBuilder: (context, error, stackTrace) {
  //                               return const Icon(
  //                                 Icons.medication,
  //                                 color: Color(0xFF5931DD),
  //                                 size: 40,
  //                               );
  //                             },
  //                           ),
  //                         )
  //                       : const Icon(
  //                           Icons.medication,
  //                           color: Color(0xFF5931DD),
  //                           size: 40,
  //                         ),
  //                 ),
  //                 const SizedBox(width: 12),
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         medicine.name,
  //                         style: const TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 16,
  //                         ),
  //                         maxLines: 2,
  //                         overflow: TextOverflow.ellipsis,
  //                       ),
  //                       const SizedBox(height: 4),
  //                       Text(
  //                         medicine.description,
  //                         style: TextStyle(
  //                           color: Colors.grey[600],
  //                           fontSize: 12,
  //                         ),
  //                         maxLines: 2,
  //                         overflow: TextOverflow.ellipsis,
  //                       ),
  //                       const SizedBox(height: 8),
  //                       Row(
  //                         children: [
  //                           Text(
  //                             '₹${medicine.mrp}',
  //                             style: const TextStyle(
  //                               color: Color(0xFF5931DD),
  //                               fontWeight: FontWeight.bold,
  //                               fontSize: 16,
  //                             ),
  //                           ),
  //                           const SizedBox(width: 8),
  //                         ],
  //                       ),
  //                       const SizedBox(height: 4),
  //                       Text(
  //                         medicine.pharmacy.name,
  //                         style: TextStyle(
  //                           color: Colors.grey[600],
  //                           fontSize: 11,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 Icon(
  //                   isSelected ? Icons.check_circle : Icons.add_circle_outline,
  //                   color: const Color(0xFF5931DD),
  //                   size: 20,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _buildSearchResults() {
  return Column(
    children: [
      Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _searchResults.length,
          itemBuilder: (context, index) {
            final medicine = _searchResults[index];
            final isSelected = _isMedicineSelected(medicine);

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: isSelected
                    ? const BorderSide(color: Color(0xFF5931DD), width: 2)
                    : BorderSide.none,
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => _toggleMedicineSelection(medicine),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Checkbox(
                        value: isSelected,
                        onChanged: (value) => _toggleMedicineSelection(medicine),
                        activeColor: const Color(0xFF5931DD),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: medicine.images.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  medicine.images.first,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.medication,
                                      color: Color(0xFF5931DD),
                                      size: 40,
                                    );
                                  },
                                ),
                              )
                            : const Icon(
                                Icons.medication,
                                color: Color(0xFF5931DD),
                                size: 40,
                              ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              medicine.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              medicine.description,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  '₹${medicine.mrp}',
                                  style: const TextStyle(
                                    color: Color(0xFF5931DD),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              medicine.pharmacy.name,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        isSelected ? Icons.check_circle : Icons.add_circle_outline,
                        color: const Color(0xFF5931DD),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      // Fixed Continue Button at the bottom
      if (_selectedMedicines.isNotEmpty)
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _searchResults = [];
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5931DD),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                _selectedMedicines.length == 1
                    ? 'Continue with Selected Medicine'
                    : 'Continue with ${_selectedMedicines.length} Medicines',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
    ],
  );
}

  Widget _buildSelectedMedicines() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _selectedMedicines.length,
            itemBuilder: (context, index) {
              final medicine = _selectedMedicines[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFF5931DD), width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: medicine.images.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  medicine.images.first,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.medication,
                                      color: Color(0xFF5931DD),
                                      size: 30,
                                    );
                                  },
                                ),
                              )
                            : const Icon(
                                Icons.medication,
                                color: Color(0xFF5931DD),
                                size: 30,
                              ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              medicine.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xFF5931DD),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '₹${medicine.mrp}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              medicine.pharmacy.name,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => _removeSelectedMedicine(medicine),
                        icon: const Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selectedMedicines.isNotEmpty
                  ? () {
                      // Return the selected medicines to the previous screen
                      Navigator.of(context).pop(_selectedMedicines);

                      final medicationsList =
                          _selectedMedicines.map((medicine) {
                        return {
                          "medicineId": medicine.medicineId,
                          "name": medicine.name,
                          "quantity": "1 Strip",
                          "count": 1,
                          "pharmacyName": medicine.pharmacy.name,
                          "pharmacyImage": medicine.images.isNotEmpty
                              ? medicine.images.first
                              : "assets/tablet.png",
                          "price": medicine.price.toString(),
                          "mrp": medicine.mrp.toString(),
                          "description": medicine.description,
                          "categoryName": medicine.categoryName,
                        };
                      }).toList();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutScreen(
                            medicineId: _selectedMedicines.first.medicineId,
                            medicineName: _selectedMedicines.length > 1
                                ? '${_selectedMedicines.length} medicines'
                                : _selectedMedicines.first.name,
                            medicinePrice: _selectedMedicines
                                .map((m) => m.price)
                                .reduce((a, b) => a + b)
                                .toString(),
                            pharmacyName:
                                _selectedMedicines.first.pharmacy.name,
                            pharmacyImage:
                                _selectedMedicines.first.images.isNotEmpty
                                    ? _selectedMedicines.first.images.first
                                    : null,
                            medicationsList: medicationsList,
                            mrp: _selectedMedicines.first.mrp.toString(),
                            selectedMedicines: _selectedMedicines, // Pass the selected medicines
                          ),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedMedicines.isNotEmpty
                    ? const Color(0xFF5931DD)
                    : Colors.grey,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                _selectedMedicines.isEmpty
                    ? 'Select medicines to continue'
                    : _selectedMedicines.length == 1
                        ? 'Continue with Selected Medicine'
                        : 'Continue with ${_selectedMedicines.length} Medicines',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _isActive ? Icons.checklist : Icons.lock_outline,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            _isActive ? 'Select medicines' : 'Plan Inactive',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _isActive
                ? 'Search and select medicines\nfor your periodic plan'
                : 'Activate the plan to start\nsearching for medicines',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}


class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.85,
      size.width * 0.2,
      size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.15,
      size.width,
      0,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
