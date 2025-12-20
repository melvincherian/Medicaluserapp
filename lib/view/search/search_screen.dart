// // import 'dart:async';
// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:medical_user_app/models/search_model.dart';

// // // Model classes for the API response


// // class SearchScreen extends StatefulWidget {
// //   const SearchScreen({super.key});

// //   @override
// //   State<SearchScreen> createState() => _SearchScreenState();
// // }

// // class _SearchScreenState extends State<SearchScreen> {
// //   final TextEditingController _searchController = TextEditingController();
// //   Timer? _debounceTimer;
// //   List<Medicine> _medicines = [];
// //   bool _isLoading = false;
// //   String? _errorMessage;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _searchController.addListener(_onSearchChanged);
// //   }

// //   @override
// //   void dispose() {
// //     _searchController.removeListener(_onSearchChanged);
// //     _searchController.dispose();
// //     _debounceTimer?.cancel();
// //     super.dispose();
// //   }

// //   void _onSearchChanged() {
// //     // Cancel previous timer
// //     _debounceTimer?.cancel();
    
// //     // Start new timer with 500ms delay
// //     _debounceTimer = Timer(const Duration(milliseconds: 500), () {
// //       if (_searchController.text.isNotEmpty) {
// //         _searchMedicines(_searchController.text);
// //       } else {
// //         setState(() {
// //           _medicines.clear();
// //           _errorMessage = null;
// //         });
// //       }
// //     });
// //   }

// //   Future<void> _searchMedicines(String query) async {
// //     setState(() {
// //       _isLoading = true;
// //       _errorMessage = null;
// //     });

// //     try {
// //       final encodedQuery = Uri.encodeComponent(query);
// //       final url = 'http://31.97.206.144:7021/api/pharmacy/allmedicine?name=$encodedQuery';
      
// //       final response = await http.get(
// //         Uri.parse(url),
// //         headers: {'Content-Type': 'application/json'},
// //       );

// //       if (response.statusCode == 200) {
// //         final jsonResponse = json.decode(response.body);
// //         final apiResponse = ApiResponse.fromJson(jsonResponse);
        
// //         setState(() {
// //           _medicines = apiResponse.medicines;
// //           _isLoading = false;
// //         });
// //       } else {
// //         setState(() {
// //           _errorMessage = 'Failed to load medicines. Status: ${response.statusCode}';
// //           _isLoading = false;
// //         });
// //       }
// //     } catch (e) {
// //       setState(() {
// //         _errorMessage = 'Error: ${e.toString()}';
// //         _isLoading = false;
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Search Medicines'),
// //         backgroundColor: Colors.blue.shade600,
// //         foregroundColor: Colors.white,
// //         elevation: 0,
// //       ),
// //       body: Column(
// //         children: [
// //           // Search Bar
// //           Container(
// //             padding: const EdgeInsets.all(16),
// //             decoration: BoxDecoration(
// //               color: Colors.blue.shade600,
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: Colors.grey.withOpacity(0.3),
// //                   blurRadius: 4,
// //                   offset: const Offset(0, 2),
// //                 ),
// //               ],
// //             ),
// //             child: TextField(
// //               controller: _searchController,
// //               decoration: InputDecoration(
// //                 hintText: 'Search for medicines...',
// //                 prefixIcon: const Icon(Icons.search),
// //                 suffixIcon: _searchController.text.isNotEmpty
// //                     ? IconButton(
// //                         icon: const Icon(Icons.clear),
// //                         onPressed: () {
// //                           _searchController.clear();
// //                           setState(() {
// //                             _medicines.clear();
// //                             _errorMessage = null;
// //                           });
// //                         },
// //                       )
// //                     : null,
// //                 filled: true,
// //                 fillColor: Colors.white,
// //                 border: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(25),
// //                   borderSide: BorderSide.none,
// //                 ),
// //                 contentPadding: const EdgeInsets.symmetric(
// //                   horizontal: 20,
// //                   vertical: 15,
// //                 ),
// //               ),
// //             ),
// //           ),
          
// //           // Content Area
// //           Expanded(
// //             child: _buildContent(),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildContent() {
// //     if (_isLoading) {
// //       return const Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             CircularProgressIndicator(),
// //             SizedBox(height: 16),
// //             Text('Searching medicines...'),
// //           ],
// //         ),
// //       );
// //     }

// //     if (_errorMessage != null) {
// //       return Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Icon(
// //               Icons.error_outline,
// //               size: 64,
// //               color: Colors.red.shade300,
// //             ),
// //             const SizedBox(height: 16),
// //             Text(
// //               _errorMessage!,
// //               style: TextStyle(color: Colors.red.shade600),
// //               textAlign: TextAlign.center,
// //             ),
// //             const SizedBox(height: 16),
// //             ElevatedButton(
// //               onPressed: () {
// //                 if (_searchController.text.isNotEmpty) {
// //                   _searchMedicines(_searchController.text);
// //                 }
// //               },
// //               child: const Text('Retry'),
// //             ),
// //           ],
// //         ),
// //       );
// //     }

// //     if (_searchController.text.isEmpty) {
// //       return const Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Icon(
// //               Icons.search,
// //               size: 64,
// //               color: Colors.grey,
// //             ),
// //             SizedBox(height: 16),
// //             Text(
// //               'Search for medicines',
// //               style: TextStyle(
// //                 fontSize: 18,
// //                 color: Colors.grey,
// //               ),
// //             ),
// //           ],
// //         ),
// //       );
// //     }

// //     if (_medicines.isEmpty) {
// //       return const Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Icon(
// //               Icons.search_off,
// //               size: 64,
// //               color: Colors.grey,
// //             ),
// //             SizedBox(height: 16),
// //             Text(
// //               'No medicines found',
// //               style: TextStyle(
// //                 fontSize: 18,
// //                 color: Colors.grey,
// //               ),
// //             ),
// //           ],
// //         ),
// //       );
// //     }

// //     return ListView.builder(
// //       padding: const EdgeInsets.all(16),
// //       itemCount: _medicines.length,
// //       itemBuilder: (context, index) {
// //         final medicine = _medicines[index];
// //         return _buildMedicineCard(medicine);
// //       },
// //     );
// //   }

// //   Widget _buildMedicineCard(Medicine medicine) {
// //     final discount = ((medicine.mrp - medicine.price) / medicine.mrp * 100).round();
    
// //     return Card(
// //       margin: const EdgeInsets.only(bottom: 16),
// //       elevation: 4,
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.circular(12),
// //       ),
// //       child: Padding(
// //         padding: const EdgeInsets.all(16),
// //         child: Row(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             // Medicine Image
// //             ClipRRect(
// //               borderRadius: BorderRadius.circular(8),
// //               child: medicine.images.isNotEmpty
// //                   ? Image.network(
// //                       medicine.images.first,
// //                       width: 80,
// //                       height: 80,
// //                       fit: BoxFit.cover,
// //                       errorBuilder: (context, error, stackTrace) {
// //                         return Container(
// //                           width: 80,
// //                           height: 80,
// //                           color: Colors.grey.shade200,
// //                           child: const Icon(
// //                             Icons.medical_services,
// //                             color: Colors.grey,
// //                           ),
// //                         );
// //                       },
// //                     )
// //                   : Container(
// //                       width: 80,
// //                       height: 80,
// //                       color: Colors.grey.shade200,
// //                       child: const Icon(
// //                         Icons.medical_services,
// //                         color: Colors.grey,
// //                       ),
// //                     ),
// //             ),
// //             const SizedBox(width: 16),
            
// //             // Medicine Details
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     medicine.name,
// //                     style: const TextStyle(
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 4),
// //                   Text(
// //                     medicine.categoryName,
// //                     style: TextStyle(
// //                       fontSize: 12,
// //                       color: Colors.blue.shade600,
// //                       fontWeight: FontWeight.w500,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 8),
// //                   Text(
// //                     medicine.description,
// //                     style: TextStyle(
// //                       fontSize: 12,
// //                       color: Colors.grey.shade600,
// //                     ),
// //                     maxLines: 2,
// //                     overflow: TextOverflow.ellipsis,
// //                   ),
// //                   const SizedBox(height: 8),
// //                   Row(
// //                     children: [
// //                       Text(
// //                         '₹${medicine.price}',
// //                         style: const TextStyle(
// //                           fontSize: 16,
// //                           fontWeight: FontWeight.bold,
// //                           color: Colors.green,
// //                         ),
// //                       ),
// //                       const SizedBox(width: 8),
// //                       Text(
// //                         '₹${medicine.mrp}',
// //                         style: TextStyle(
// //                           fontSize: 12,
// //                           decoration: TextDecoration.lineThrough,
// //                           color: Colors.grey.shade600,
// //                         ),
// //                       ),
// //                       const SizedBox(width: 8),
// //                       Container(
// //                         padding: const EdgeInsets.symmetric(
// //                           horizontal: 6,
// //                           vertical: 2,
// //                         ),
// //                         decoration: BoxDecoration(
// //                           color: Colors.green.shade100,
// //                           borderRadius: BorderRadius.circular(4),
// //                         ),
// //                         child: Text(
// //                           '$discount% OFF',
// //                           style: TextStyle(
// //                             fontSize: 10,
// //                             fontWeight: FontWeight.bold,
// //                             color: Colors.green.shade700,
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 4),
// //                   Text(
// //                     'Available at: ${medicine.pharmacy.name}',
// //                     style: TextStyle(
// //                       fontSize: 11,
// //                       color: Colors.grey.shade600,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

















// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:medical_user_app/models/search_model.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   Timer? _debounceTimer;
//   List<Medicine> _medicines = [];
//   bool _isLoading = false;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(_onSearchChanged);
//   }

//   @override
//   void dispose() {
//     _searchController.removeListener(_onSearchChanged);
//     _searchController.dispose();
//     _debounceTimer?.cancel();
//     super.dispose();
//   }

//   void _onSearchChanged() {
//     // Cancel previous timer
//     _debounceTimer?.cancel();
    
//     // Start new timer with 500ms delay
//     _debounceTimer = Timer(const Duration(milliseconds: 500), () {
//       if (_searchController.text.isNotEmpty) {
//         _searchMedicines(_searchController.text);
//       } else {
//         setState(() {
//           _medicines.clear();
//           _errorMessage = null;
//         });
//       }
//     });
//   }

//   Future<void> _searchMedicines(String query) async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     try {
//       final encodedQuery = Uri.encodeComponent(query);
//       final url = 'http://31.97.206.144:7021/api/pharmacy/allmedicine?name=$encodedQuery';
      
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);
//         final apiResponse = ApiResponse.fromJson(jsonResponse);
        
//         setState(() {
//           _medicines = apiResponse.medicines;
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = 'Failed to load medicines. Status: ${response.statusCode}';
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Error: ${e.toString()}';
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search Medicines'),
//         backgroundColor: Colors.blue.shade600,
//         foregroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           // Search Bar
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.blue.shade600,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   blurRadius: 4,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search for medicines...',
//                 prefixIcon: const Icon(Icons.search),
//                 suffixIcon: _searchController.text.isNotEmpty
//                     ? IconButton(
//                         icon: const Icon(Icons.clear),
//                         onPressed: () {
//                           _searchController.clear();
//                           setState(() {
//                             _medicines.clear();
//                             _errorMessage = null;
//                           });
//                         },
//                       )
//                     : null,
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide.none,
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 15,
//                 ),
//               ),
//             ),
//           ),
          
//           // Content Area
//           Expanded(
//             child: _buildContent(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildContent() {
//     if (_isLoading) {
//       return const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(),
//             SizedBox(height: 16),
//             Text('Searching medicines...'),
//           ],
//         ),
//       );
//     }

//     if (_errorMessage != null) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.error_outline,
//               size: 64,
//               color: Colors.red.shade300,
//             ),
//             const SizedBox(height: 16),
//             Text(
//               _errorMessage!,
//               style: TextStyle(color: Colors.red.shade600),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 if (_searchController.text.isNotEmpty) {
//                   _searchMedicines(_searchController.text);
//                 }
//               },
//               child: const Text('Retry'),
//             ),
//           ],
//         ),
//       );
//     }

//     if (_searchController.text.isEmpty) {
//       return const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.search,
//               size: 64,
//               color: Colors.grey,
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Search for medicines',
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.grey,
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     if (_medicines.isEmpty) {
//       return const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.search_off,
//               size: 64,
//               color: Colors.grey,
//             ),
//             SizedBox(height: 16),
//             Text(
//               'No medicines found',
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.grey,
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: _medicines.length,
//       itemBuilder: (context, index) {
//         final medicine = _medicines[index];
//         return _buildMedicineCard(medicine);
//       },
//     );
//   }

//   Widget _buildMedicineCard(Medicine medicine) {
//     final discount = medicine.mrp > 0 
//         ? ((medicine.mrp - medicine.price) / medicine.mrp * 100).round()
//         : 0;
    
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Medicine Image
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: medicine.images.isNotEmpty
//                   ? Image.network(
//                       medicine.images.first,
//                       width: 80,
//                       height: 80,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return Container(
//                           width: 80,
//                           height: 80,
//                           color: Colors.grey.shade200,
//                           child: const Icon(
//                             Icons.medical_services,
//                             color: Colors.grey,
//                           ),
//                         );
//                       },
//                     )
//                   : Container(
//                       width: 80,
//                       height: 80,
//                       color: Colors.grey.shade200,
//                       child: const Icon(
//                         Icons.medical_services,
//                         color: Colors.grey,
//                       ),
//                     ),
//             ),
//             const SizedBox(width: 16),
            
//             // Medicine Details
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     medicine.name,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     medicine.categoryName,
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.blue.shade600,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     medicine.description,
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey.shade600,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Text(
//                         '₹${medicine.price}',
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.green,
//                         ),
//                       ),
//                       if (medicine.mrp > medicine.price) ...[
//                         const SizedBox(width: 8),
//                         Text(
//                           '₹${medicine.mrp}',
//                           style: TextStyle(
//                             fontSize: 12,
//                             decoration: TextDecoration.lineThrough,
//                             color: Colors.grey.shade600,
//                           ),
//                         ),
//                       ],
//                       if (discount > 0) ...[
//                         const SizedBox(width: 8),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 6,
//                             vertical: 2,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.green.shade100,
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           child: Text(
//                             '$discount% OFF',
//                             style: TextStyle(
//                               fontSize: 10,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.green.shade700,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     'Available at: ${medicine.pharmacy.name}',
//                     style: TextStyle(
//                       fontSize: 11,
//                       color: Colors.grey.shade600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
















// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:medical_user_app/models/search_model.dart';
// import 'package:medical_user_app/providers/cart_provider.dart';
// import 'package:medical_user_app/view/cart_screen.dart';
// import 'package:provider/provider.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   Timer? _debounceTimer;
//   List<Medicine> _medicines = [];
//   bool _isLoading = false;
//   String? _errorMessage;
//   Set<String> _loadingItems = {}; // Track which items are being added to cart

//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(_onSearchChanged);
//   }

//   @override
//   void dispose() {
//     _searchController.removeListener(_onSearchChanged);
//     _searchController.dispose();
//     _debounceTimer?.cancel();
//     super.dispose();
//   }

//   void _onSearchChanged() {
//     // Cancel previous timer
//     _debounceTimer?.cancel();
    
//     // Start new timer with 500ms delay
//     _debounceTimer = Timer(const Duration(milliseconds: 500), () {
//       if (_searchController.text.isNotEmpty) {
//         _searchMedicines(_searchController.text);
//       } else {
//         setState(() {
//           _medicines.clear();
//           _errorMessage = null;
//         });
//       }
//     });
//   }

//   Future<void> _searchMedicines(String query) async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     try {
//       final encodedQuery = Uri.encodeComponent(query);
//       final url = 'http://31.97.206.144:7021/api/pharmacy/allmedicine?name=$encodedQuery';
      
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);
//         final apiResponse = ApiResponse.fromJson(jsonResponse);
        
//         setState(() {
//           _medicines = apiResponse.medicines;
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = 'Failed to load medicines. Status: ${response.statusCode}';
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Error: ${e.toString()}';
//         _isLoading = false;
//       });
//     }
//   }

//   Future<void> _addToCart(String medicineId, String medicineName) async {
//     setState(() {
//       _loadingItems.add(medicineId);
//     });

//     final cartProvider = Provider.of<CartProvider>(context, listen: false);
//     final success = await cartProvider.addToCart(medicineId);

//     setState(() {
//       _loadingItems.remove(medicineId);
//     });

//     if (success) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('$medicineName added to cart'),
//           backgroundColor: Colors.green,
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(cartProvider.errorMessage ?? 'Failed to add to cart'),
//           backgroundColor: Colors.red,
//           duration: const Duration(seconds: 3),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search Medicines'),
//         backgroundColor: Colors.blue.shade600,
//         foregroundColor: Colors.white,
//         elevation: 0,
//         actions: [
//           // Cart Icon with Badge
//           Consumer<CartProvider>(
//             builder: (context, cartProvider, child) {
//               return Stack(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.shopping_cart_outlined),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => const CartScreen()),
//                       );
//                     },
//                   ),
//                   if (cartProvider.itemCount > 0)
//                     Positioned(
//                       right: 8,
//                       top: 8,
//                       child: Container(
//                         padding: const EdgeInsets.all(2),
//                         decoration: const BoxDecoration(
//                           color: Colors.red,
//                           shape: BoxShape.circle,
//                         ),
//                         constraints: const BoxConstraints(
//                           minWidth: 16,
//                           minHeight: 16,
//                         ),
//                         child: Text(
//                           '${cartProvider.itemCount}',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 10,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Search Bar
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.blue.shade600,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   blurRadius: 4,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search for medicines...',
//                 prefixIcon: const Icon(Icons.search),
//                 suffixIcon: _searchController.text.isNotEmpty
//                     ? IconButton(
//                         icon: const Icon(Icons.clear),
//                         onPressed: () {
//                           _searchController.clear();
//                           setState(() {
//                             _medicines.clear();
//                             _errorMessage = null;
//                           });
//                         },
//                       )
//                     : null,
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide.none,
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 15,
//                 ),
//               ),
//             ),
//           ),
          
//           // Content Area
//           Expanded(
//             child: _buildContent(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildContent() {
//     if (_isLoading) {
//       return const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(),
//             SizedBox(height: 16),
//             Text('Searching medicines...'),
//           ],
//         ),
//       );
//     }

//     if (_errorMessage != null) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.error_outline,
//               size: 64,
//               color: Colors.red.shade300,
//             ),
//             const SizedBox(height: 16),
//             Text(
//               _errorMessage!,
//               style: TextStyle(color: Colors.red.shade600),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 if (_searchController.text.isNotEmpty) {
//                   _searchMedicines(_searchController.text);
//                 }
//               },
//               child: const Text('Retry'),
//             ),
//           ],
//         ),
//       );
//     }

//     if (_searchController.text.isEmpty) {
//       return const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.search,
//               size: 64,
//               color: Colors.grey,
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Search for medicines',
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.grey,
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     if (_medicines.isEmpty) {
//       return const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.search_off,
//               size: 64,
//               color: Colors.grey,
//             ),
//             SizedBox(height: 16),
//             Text(
//               'No medicines found',
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.grey,
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: _medicines.length,
//       itemBuilder: (context, index) {
//         final medicine = _medicines[index];
//         return _buildMedicineCard(medicine);
//       },
//     );
//   }

//   Widget _buildMedicineCard(Medicine medicine) {
//     final discount = medicine.mrp > 0 
//         ? ((medicine.mrp - medicine.price) / medicine.mrp * 100).round()
//         : 0;
    
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Medicine Image
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: medicine.images.isNotEmpty
//                       ? Image.network(
//                           medicine.images.first,
//                           width: 80,
//                           height: 80,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Container(
//                               width: 80,
//                               height: 80,
//                               color: Colors.grey.shade200,
//                               child: const Icon(
//                                 Icons.medical_services,
//                                 color: Colors.grey,
//                               ),
//                             );
//                           },
//                         )
//                       : Container(
//                           width: 80,
//                           height: 80,
//                           color: Colors.grey.shade200,
//                           child: const Icon(
//                             Icons.medical_services,
//                             color: Colors.grey,
//                           ),
//                         ),
//                 ),
//                 const SizedBox(width: 16),
                
//                 // Medicine Details
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         medicine.name,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         medicine.categoryName,
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.blue.shade600,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         medicine.description,
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey.shade600,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Text(
//                             '₹${medicine.price}',
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.green,
//                             ),
//                           ),
//                           if (medicine.mrp > medicine.price) ...[
//                             const SizedBox(width: 8),
//                             Text(
//                               '₹${medicine.mrp}',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 decoration: TextDecoration.lineThrough,
//                                 color: Colors.grey.shade600,
//                               ),
//                             ),
//                           ],
//                           if (discount > 0) ...[
//                             const SizedBox(width: 8),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 6,
//                                 vertical: 2,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Colors.green.shade100,
//                                 borderRadius: BorderRadius.circular(4),
//                               ),
//                               child: Text(
//                                 '$discount% OFF',
//                                 style: TextStyle(
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.green.shade700,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ],
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         'Available at: ${medicine.pharmacy.name}',
//                         style: TextStyle(
//                           fontSize: 11,
//                           color: Colors.grey.shade600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
            
//             const SizedBox(height: 12),
            
//             // Add to Cart Button
//             Consumer<CartProvider>(
//               builder: (context, cartProvider, child) {
//                 final isInCart = cartProvider.isInCart(medicine.medicineId);
//                 final isLoading = _loadingItems.contains(medicine.medicineId);
                
//                 return SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton.icon(
//                     onPressed: isLoading ? null : () {
//                       _addToCart(medicine.medicineId, medicine.name);
//                     },
//                     icon: isLoading
//                         ? const SizedBox(
//                             width: 16,
//                             height: 16,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                             ),
//                           )
//                         : Icon(
//                             isInCart ? Icons.check_circle : Icons.shopping_cart,
//                             size: 18,
//                           ),
//                     label: Text(
//                       isLoading
//                           ? 'Adding...'
//                           : isInCart
//                               ? 'In Cart (${cartProvider.getItemQuantity(medicine.medicineId)})'
//                               : 'Add to Cart',
//                       style: const TextStyle(fontWeight: FontWeight.w600),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: isInCart ? Colors.green : Colors.deepPurple,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






















// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:medical_user_app/models/search_model.dart';
// import 'package:medical_user_app/providers/cart_provider.dart';
// import 'package:medical_user_app/view/cart_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:permission_handler/permission_handler.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   Timer? _debounceTimer;
//   List<Medicine> _medicines = [];
//   bool _isLoading = false;
//   String? _errorMessage;
//   Set<String> _loadingItems = {}; // Track which items are being added to cart
  
//   // Voice search related variables
//   late stt.SpeechToText _speechToText;
//   bool _isListening = false;
//   bool _speechEnabled = false;
//   String _lastWords = '';

//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(_onSearchChanged);
//     _initSpeech();
//   }

//   @override
//   void dispose() {
//     _searchController.removeListener(_onSearchChanged);
//     _searchController.dispose();
//     _debounceTimer?.cancel();
//     super.dispose();
//   }

//   /// Initialize speech recognition
//   void _initSpeech() async {
//     _speechToText = stt.SpeechToText();
//     bool available = await _speechToText.initialize(
//       onStatus: (val) => setState(() {
//         if (val == 'done' || val == 'notListening') {
//           _isListening = false;
//         }
//       }),
//       onError: (val) => setState(() {
//         _isListening = false;
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Speech recognition error: ${val.errorMsg}'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }),
//     );
//     setState(() {
//       _speechEnabled = available;
//     });
//   }

//   /// Start listening for speech
//   void _startListening() async {
//     // Request microphone permission
//     final status = await Permission.microphone.request();
//     if (status != PermissionStatus.granted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Microphone permission is required for voice search'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     if (!_isListening && _speechEnabled) {
//       setState(() {
//         _isListening = true;
//         _lastWords = '';
//       });
      
//       await _speechToText.listen(
//         onResult: (val) => setState(() {
//           _lastWords = val.recognizedWords;
//           if (val.hasConfidenceRating && val.confidence > 0) {
//             _searchController.text = _lastWords;
//             // Trigger search immediately when speech is recognized
//             if (_lastWords.isNotEmpty) {
//               _searchMedicines(_lastWords);
//             }
//           }
//         }),
//         listenFor: const Duration(seconds: 10),
//         pauseFor: const Duration(seconds: 3),
//         partialResults: true,
//         localeId: "en_US",
//         onSoundLevelChange: null,
//         cancelOnError: true,
//         listenMode: stt.ListenMode.confirmation,
//       );
//     }
//   }

//   /// Stop listening for speech
//   void _stopListening() async {
//     if (_isListening) {
//       await _speechToText.stop();
//       setState(() {
//         _isListening = false;
//       });
//     }
//   }

//   void _onSearchChanged() {
//     // Cancel previous timer
//     _debounceTimer?.cancel();
    
//     // Start new timer with 500ms delay
//     _debounceTimer = Timer(const Duration(milliseconds: 500), () {
//       if (_searchController.text.isNotEmpty) {
//         _searchMedicines(_searchController.text);
//       } else {
//         setState(() {
//           _medicines.clear();
//           _errorMessage = null;
//         });
//       }
//     });
//   }

//   Future<void> _searchMedicines(String query) async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     try {
//       final encodedQuery = Uri.encodeComponent(query);
//       final url = 'http://31.97.206.144:7021/api/pharmacy/allmedicine?name=$encodedQuery';
      
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);
//         final apiResponse = ApiResponse.fromJson(jsonResponse);
        
//         setState(() {
//           _medicines = apiResponse.medicines;
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = 'Failed to load medicines. Status: ${response.statusCode}';
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Error: ${e.toString()}';
//         _isLoading = false;
//       });
//     }
//   }

//   Future<void> _addToCart(String medicineId, String medicineName) async {
//     setState(() {
//       _loadingItems.add(medicineId);
//     });

//     final cartProvider = Provider.of<CartProvider>(context, listen: false);
//     final success = await cartProvider.addToCart(medicineId);

//     setState(() {
//       _loadingItems.remove(medicineId);
//     });

//     if (success) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('$medicineName added to cart'),
//           backgroundColor: Colors.green,
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(cartProvider.errorMessage ?? 'Failed to add to cart'),
//           backgroundColor: Colors.red,
//           duration: const Duration(seconds: 3),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:  Text('Search Medicines',style: TextStyle(fontWeight:FontWeight.bold ),),
//         backgroundColor: const Color(0xFF5931DD),

//         foregroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(onPressed: (){
//           Navigator.of(context).pop();
//         }, icon: Icon(Icons.arrow_back_ios)),
//         actions: [
//           // Cart Icon with Badge
//           Consumer<CartProvider>(
//             builder: (context, cartProvider, child) {
//               return Stack(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.shopping_cart_outlined),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => const CartScreen()),
//                       );
//                     },
//                   ),
//                   if (cartProvider.itemCount > 0)
//                     Positioned(
//                       right: 8,
//                       top: 8,
//                       child: Container(
//                         padding: const EdgeInsets.all(2),
//                         decoration: const BoxDecoration(
//                           color: Colors.red,
//                           shape: BoxShape.circle,
//                         ),
//                         constraints: const BoxConstraints(
//                           minWidth: 16,
//                           minHeight: 16,
//                         ),
//                         child: Text(
//                           '${cartProvider.itemCount}',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 10,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Search Bar with Voice Search
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: const Color(0xFF5931DD)
// ,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   blurRadius: 4,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _searchController,
//                     decoration: InputDecoration(
//                       hintText: 'Search for medicines...',
//                       prefixIcon: const Icon(Icons.search),
//                       suffixIcon: _searchController.text.isNotEmpty
//                           ? IconButton(
//                               icon: const Icon(Icons.clear),
//                               onPressed: () {
//                                 _searchController.clear();
//                                 setState(() {
//                                   _medicines.clear();
//                                   _errorMessage = null;
//                                 });
//                               },
//                             )
//                           : null,
//                       filled: true,
//                       fillColor: const Color(0xFFEFF3F7)
// ,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(25),
//                         borderSide: BorderSide.none,
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 20,
//                         vertical: 15,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 // Voice Search Button
//                 GestureDetector(
//                   onTap: _speechEnabled
//                       ? (_isListening ? _stopListening : _startListening)
//                       : null,
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 200),
//                     width: 50,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: _isListening 
//                           ? Colors.red.shade400 
//                           : _speechEnabled 
//                               ? Colors.white 
//                               : Colors.grey.shade400,
//                       shape: BoxShape.circle,
//                       boxShadow: _isListening
//                           ? [
//                               BoxShadow(
//                                 color: Colors.red.shade200,
//                                 blurRadius: 10,
//                                 spreadRadius: 2,
//                               ),
//                             ]
//                           : [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.3),
//                                 blurRadius: 4,
//                                 offset: const Offset(0, 2),
//                               ),
//                             ],
//                     ),
//                     child: Icon(
//                       _isListening ? Icons.mic : Icons.mic_none,
//                       color: _isListening 
//                           ? Colors.white 
//                           : _speechEnabled 
//                               ? const Color(0xFF5931DD)
//                               : Colors.grey.shade600,
//                       size: 24,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
          
//           // Voice Recognition Status
//           if (_isListening)
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               color: Colors.red.shade50,
//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.mic,
//                     color: Colors.red.shade400,
//                     size: 16,
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     'Listening...',
//                     style: TextStyle(
//                       color: Colors.red.shade600,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const Spacer(),
//                   SizedBox(
//                     width: 12,
//                     height: 12,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 2,
//                       valueColor: AlwaysStoppedAnimation<Color>(Colors.red.shade400),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
          
//           // Content Area
//           Expanded(
//             child: _buildContent(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildContent() {
//     if (_isLoading) {
//       return const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(),
//             SizedBox(height: 16),
//             Text('Searching medicines...'),
//           ],
//         ),
//       );
//     }

//     if (_errorMessage != null) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.error_outline,
//               size: 64,
//               color: Colors.red.shade300,
//             ),
//             const SizedBox(height: 16),
//             Text(
//               _errorMessage!,
//               style: TextStyle(color: Colors.red.shade600),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 if (_searchController.text.isNotEmpty) {
//                   _searchMedicines(_searchController.text);
//                 }
//               },
//               child: const Text('Retry'),
//             ),
//           ],
//         ),
//       );
//     }

//     if (_searchController.text.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(
//               Icons.search,
//               size: 64,
//               color: Colors.grey,
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Search for medicines',
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.grey,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Type or tap the mic to search by voice',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey.shade600,
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     if (_medicines.isEmpty) {
//       return const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.search_off,
//               size: 64,
//               color: Colors.grey,
//             ),
//             SizedBox(height: 16),
//             Text(
//               'No medicines found',
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.grey,
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: _medicines.length,
//       itemBuilder: (context, index) {
//         final medicine = _medicines[index];
//         return _buildMedicineCard(medicine);
//       },
//     );
//   }

//   Widget _buildMedicineCard(Medicine medicine) {
//     final discount = medicine.mrp > 0 
//         ? ((medicine.mrp - medicine.price) / medicine.mrp * 100).round()
//         : 0;
    
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Medicine Image
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: medicine.images.isNotEmpty
//                       ? Image.network(
//                           medicine.images.first,
//                           width: 80,
//                           height: 80,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Container(
//                               width: 80,
//                               height: 80,
//                               color: Colors.grey.shade200,
//                               child: const Icon(
//                                 Icons.medical_services,
//                                 color: Colors.grey,
//                               ),
//                             );
//                           },
//                         )
//                       : Container(
//                           width: 80,
//                           height: 80,
//                           color: Colors.grey.shade200,
//                           child: const Icon(
//                             Icons.medical_services,
//                             color: Colors.grey,
//                           ),
//                         ),
//                 ),
//                 const SizedBox(width: 16),
                
//                 // Medicine Details
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         medicine.name,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         medicine.categoryName,
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.blue.shade600,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         medicine.description,
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey.shade600,
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
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.green,
//                             ),
//                           ),
//                           // if (medicine.mrp > medicine.price) ...[
//                           //   const SizedBox(width: 8),
//                           //   Text(
//                           //     '₹${medicine.mrp}',
//                           //     style: TextStyle(
//                           //       fontSize: 12,
//                           //       decoration: TextDecoration.lineThrough,
//                           //       color: Colors.grey.shade600,
//                           //     ),
//                           //   ),
//                           // ],
//                           // if (discount > 0) ...[
//                           //   const SizedBox(width: 8),
//                           //   Container(
//                           //     padding: const EdgeInsets.symmetric(
//                           //       horizontal: 6,
//                           //       vertical: 2,
//                           //     ),
//                           //     decoration: BoxDecoration(
//                           //       color: Colors.green.shade100,
//                           //       borderRadius: BorderRadius.circular(4),
//                           //     ),
//                           //     child: Text(
//                           //       '$discount% OFF',
//                           //       style: TextStyle(
//                           //         fontSize: 10,
//                           //         fontWeight: FontWeight.bold,
//                           //         color: Colors.green.shade700,
//                           //       ),
//                           //     ),
//                           //   ),
//                           // ],
//                         ],
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         'Available at: ${medicine.pharmacy.name}',
//                         style: TextStyle(
//                           fontSize: 11,
//                           color: Colors.grey.shade600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
            
//             const SizedBox(height: 12),
            
//             // Add to Cart Button
//             Consumer<CartProvider>(
//               builder: (context, cartProvider, child) {
//                 final isInCart = cartProvider.isInCart(medicine.medicineId);
//                 final isLoading = _loadingItems.contains(medicine.medicineId);
                
//                 return SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton.icon(
//                     onPressed: isLoading ? null : () {
//                       _addToCart(medicine.medicineId, medicine.name);
//                     },
//                     icon: isLoading
//                         ? const SizedBox(
//                             width: 16,
//                             height: 16,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                             ),
//                           )
//                         : Icon(
//                             isInCart ? Icons.check_circle : Icons.shopping_cart,
//                             size: 18,
//                           ),
//                     label: Text(
//                       isLoading
//                           ? 'Adding...'
//                           : isInCart
//                               ? 'In Cart (${cartProvider.getItemQuantity(medicine.medicineId)})'
//                               : 'Add to Cart',
//                       style: const TextStyle(fontWeight: FontWeight.w600),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: isInCart ? Colors.green : const Color(0xFF5931DD)
// ,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }












import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/models/search_model.dart';
import 'package:medical_user_app/providers/cart_provider.dart';
import 'package:medical_user_app/view/cart_screen.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;
  List<Medicine> _medicines = [];
  bool _isLoading = false;
  String? _errorMessage;
  Set<String> _loadingItems = {}; // Track which items are being added to cart
  
  // Voice search related variables
  late stt.SpeechToText _speechToText;
  bool _isListening = false;
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _initSpeech();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  /// Initialize speech recognition
  void _initSpeech() async {
    _speechToText = stt.SpeechToText();
    bool available = await _speechToText.initialize(
      onStatus: (val) => setState(() {
        if (val == 'done' || val == 'notListening') {
          _isListening = false;
        }
      }),
      onError: (val) => setState(() {
        _isListening = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Speech recognition error: ${val.errorMsg}'),
            backgroundColor: Colors.red,
          ),
        );
      }),
    );
    setState(() {
      _speechEnabled = available;
    });
  }

  /// Start listening for speech
  void _startListening() async {
    // Request microphone permission
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Microphone permission is required for voice search'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!_isListening && _speechEnabled) {
      setState(() {
        _isListening = true;
        _lastWords = '';
      });
      
      await _speechToText.listen(
        onResult: (val) => setState(() {
          _lastWords = val.recognizedWords;
          if (val.hasConfidenceRating && val.confidence > 0) {
            _searchController.text = _lastWords;
            // Trigger search immediately when speech is recognized
            if (_lastWords.isNotEmpty) {
              _searchMedicines(_lastWords);
            }
          }
        }),
        listenFor: const Duration(seconds: 10),
        pauseFor: const Duration(seconds: 3),
        partialResults: true,
        localeId: "en_US",
        onSoundLevelChange: null,
        cancelOnError: true,
        listenMode: stt.ListenMode.confirmation,
      );
    }
  }

  /// Stop listening for speech
  void _stopListening() async {
    if (_isListening) {
      await _speechToText.stop();
      setState(() {
        _isListening = false;
      });
    }
  }

  void _onSearchChanged() {
    // Cancel previous timer
    _debounceTimer?.cancel();
    
    // Start new timer with 500ms delay
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (_searchController.text.isNotEmpty) {
        _searchMedicines(_searchController.text);
      } else {
        setState(() {
          _medicines.clear();
          _errorMessage = null;
        });
      }
    });
  }

  Future<void> _searchMedicines(String query) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final encodedQuery = Uri.encodeComponent(query);
      final url = 'http://31.97.206.144:7021/api/pharmacy/allmedicine?name=$encodedQuery';
      
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final apiResponse = ApiResponse.fromJson(jsonResponse);
        
        setState(() {
          _medicines = apiResponse.medicines;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load medicines. Status: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  Future<void> _addToCart(String medicineId, String medicineName) async {
    setState(() {
      _loadingItems.add(medicineId);
    });

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final success = await cartProvider.addToCart(medicineId);

    setState(() {
      _loadingItems.remove(medicineId);
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$medicineName added to cart'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(cartProvider.errorMessage ?? 'Failed to add to cart'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Search Medicines',style: TextStyle(fontWeight:FontWeight.bold ),),
        backgroundColor: const Color(0xFF5931DD),

        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back_ios)),
        actions: [
          // Cart Icon with Badge
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CartScreen()),
                      );
                    },
                  ),
                  if (cartProvider.itemCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${cartProvider.itemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar with Voice Search
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF5931DD)
,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for medicines...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _medicines.clear();
                                  _errorMessage = null;
                                });
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: const Color(0xFFEFF3F7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Voice Search Button
                // GestureDetector(
                //   onTap: _speechEnabled
                //       ? (_isListening ? _stopListening : _startListening)
                //       : null,
                //   child: AnimatedContainer(
                //     duration: const Duration(milliseconds: 200),
                //     width: 50,
                //     height: 50,
                //     decoration: BoxDecoration(
                //       color: _isListening 
                //           ? Colors.red.shade400 
                //           : _speechEnabled 
                //               ? Colors.white 
                //               : Colors.grey.shade400,
                //       shape: BoxShape.circle,
                //       boxShadow: _isListening
                //           ? [
                //               BoxShadow(
                //                 color: Colors.red.shade200,
                //                 blurRadius: 10,
                //                 spreadRadius: 2,
                //               ),
                //             ]
                //           : [
                //               BoxShadow(
                //                 color: Colors.grey.withOpacity(0.3),
                //                 blurRadius: 4,
                //                 offset: const Offset(0, 2),
                //               ),
                //             ],
                //     ),
                //     child: Icon(
                //       _isListening ? Icons.mic : Icons.mic_none,
                //       color: _isListening 
                //           ? Colors.white 
                //           : _speechEnabled 
                //               ? const Color(0xFF5931DD)
                //               : Colors.grey.shade600,
                //       size: 24,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          
          // Voice Recognition Status
          if (_isListening)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.red.shade50,
              child: Row(
                children: [
                  Icon(
                    Icons.mic,
                    color: Colors.red.shade400,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Listening...',
                    style: TextStyle(
                      color: Colors.red.shade600,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red.shade400),
                    ),
                  ),
                ],
              ),
            ),
          
          // Content Area
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Searching medicines...'),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              style: TextStyle(color: Colors.red.shade600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_searchController.text.isNotEmpty) {
                  _searchMedicines(_searchController.text);
                }
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_searchController.text.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              'Search for medicines',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Type or tap the mic to search by voice',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    if (_medicines.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No medicines found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _medicines.length,
      itemBuilder: (context, index) {
        final medicine = _medicines[index];
        return _buildMedicineCard(medicine);
      },
    );
  }

  Widget _buildMedicineCard(Medicine medicine) {
    final discount = medicine.mrp > 0 
        ? ((medicine.mrp - medicine.price) / medicine.mrp * 100).round()
        : 0;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Medicine Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: medicine.images.isNotEmpty
                      ? Image.network(
                          medicine.images.first,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey.shade200,
                              child: const Icon(
                                Icons.medical_services,
                                color: Colors.grey,
                              ),
                            );
                          },
                        )
                      : Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey.shade200,
                          child: const Icon(
                            Icons.medical_services,
                            color: Colors.grey,
                          ),
                        ),
                ),
                const SizedBox(width: 16),
                
                // Medicine Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medicine.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        medicine.categoryName,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        medicine.description,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
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
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Available at: ${medicine.pharmacy.name}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Add to Cart Button
            Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                final isInCart = cartProvider.isInCart(medicine.medicineId);
                final isLoading = _loadingItems.contains(medicine.medicineId);
                
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: isLoading ? null : () {
                      if (isInCart) {
                        // Navigate to cart if item is already in cart
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CartScreen()),
                        );
                      } else {
                        // Add to cart if item is not in cart
                        _addToCart(medicine.medicineId, medicine.name);
                      }
                    },
                    icon: isLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Icon(
                            isInCart ? Icons.check_circle : Icons.shopping_cart,
                            size: 18,
                          ),
                    label: Text(
                      isLoading
                          ? 'Adding...'
                          : isInCart
                              ? 'In Cart (${cartProvider.getItemQuantity(medicine.medicineId)})'
                              : 'Add to Cart',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isInCart ? Colors.green : const Color(0xFF5931DD),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}