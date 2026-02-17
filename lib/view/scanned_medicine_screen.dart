// // ignore_for_file: deprecated_member_use

// // Updated ScannedMedicineScreen with Cart Integration
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:medical_user_app/constant/api_constants.dart';
// import 'package:medical_user_app/models/medicine_model.dart';
// import 'package:medical_user_app/providers/cart_provider.dart';
// import 'package:provider/provider.dart';
// import 'dart:convert';
// import 'package:medical_user_app/view/cart_screen.dart';

// class ScannedMedicineScreen extends StatefulWidget {
//   final int? mrp;
//   final String? medicineId;
//   final String? address;

//   const ScannedMedicineScreen(
//       {Key? key, this.medicineId, this.address, this.mrp})
//       : super(key: key);

//   @override
//   State<ScannedMedicineScreen> createState() => _ScannedMedicineScreenState();
// }

// class _ScannedMedicineScreenState extends State<ScannedMedicineScreen> {
//   MedicineModel? medicine;
//   bool isLoading = true;
//   String? errorMessage;
//   int currentImageIndex = 0;
//   bool isAddingToCart = false;
//   bool isOrderingNow = false;

//   @override
//   void initState() {
//     super.initState();
//     // Only fetch if medicineId is provided
//     if (widget.medicineId != null && widget.medicineId!.isNotEmpty) {
//       fetchMedicineDetails();
//     } else {
//       setState(() {
//         isLoading = false;
//         errorMessage = 'No medicine ID provided';
//       });
//     }
//   }

//   Future<void> fetchMedicineDetails() async {
//     try {
//       setState(() {
//         isLoading = true;
//         errorMessage = null;
//       });

//       // Check if medicineId is null
//       if (widget.medicineId == null || widget.medicineId!.isEmpty) {
//         setState(() {
//           errorMessage = 'Medicine ID is required';
//           isLoading = false;
//         });
//         return;
//       }

//       // Replace the placeholder in the URL with actual medicineId
//       final String url = ApiConstants.singleMedicine
//           .replaceAll(':medicineId', widget.medicineId!);

//       print('Fetching medicine from URL: $url'); // Debug log

//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           // Add authorization header if needed
//           // 'Authorization': 'Bearer $token',
//         },
//       );

//       print('Response status: ${response.statusCode}'); // Debug log
//       print('Response body: ${response.body}'); // Debug log

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);

//         // Debug: Print the actual API response structure
//         print('API Response structure: $data');

//         // Handle different API response structures
//         Map<String, dynamic>? medicineData;

//         if (data.containsKey('medicine') && data['medicine'] != null) {
//           medicineData = data['medicine'] as Map<String, dynamic>;
//         } else if (data.containsKey('data') && data['data'] != null) {
//           medicineData = data['data'] as Map<String, dynamic>;
//         } else if (data.containsKey('result') && data['result'] != null) {
//           medicineData = data['result'] as Map<String, dynamic>;
//         } else {
//           // Assume the entire response is the medicine data
//           medicineData = data;
//         }

//         if (medicineData != null) {
//           setState(() {
//             medicine = MedicineModel.fromJson(medicineData!);
//             isLoading = false;
//           });
//         } else {
//           setState(() {
//             errorMessage = 'Invalid API response structure';
//             isLoading = false;
//           });
//         }
//       } else {
//         setState(() {
//           errorMessage =
//               'Failed to load medicine details. Status: ${response.statusCode}\nResponse: ${response.body}';
//           isLoading = false;
//         });
//       }
//     } catch (e, stackTrace) {
//       print('Error fetching medicine details: $e');
//       print('Stack trace: $stackTrace');

//       setState(() {
//         errorMessage = 'Error: ${e.toString()}';
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> _addToCart() async {
//     if (medicine == null || widget.medicineId == null) return;

//     setState(() {
//       isAddingToCart = true;
//     });

//     final cartProvider = Provider.of<CartProvider>(context, listen: false);
//     final success = await cartProvider.addToCart(widget.medicineId!);

//     setState(() {
//       isAddingToCart = false;
//     });

//     if (success) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar( 
//           content: Text('${medicine!.name} added to cart'),
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
//       body: SafeArea(
//         child: isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : errorMessage != null
//                 ? Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.error_outline,
//                           size: 64,
//                           color: Colors.grey[400],
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           errorMessage!,
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             color: Colors.grey,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         ElevatedButton(
//                           onPressed: fetchMedicineDetails,
//                           child: const Text('Retry'),
//                         ),
//                       ],
//                     ),
//                   )
//                 : Column(
//                     children: [
//                       Stack(
//                         children: [
//                           // Product Image
//                           Container(
//                             height: 300,
//                             width: double.infinity,
//                             child: medicine!.images.isNotEmpty
//                                 ? PageView.builder(
//                                     itemCount: medicine!.images.length,
//                                     onPageChanged: (index) {
//                                       setState(() {
//                                         currentImageIndex = index;
//                                       });
//                                     },
//                                     itemBuilder: (context, index) {
//                                       return Container(
//                                         decoration: BoxDecoration(
//                                           image: DecorationImage(
//                                             image: NetworkImage(
//                                                 medicine!.images[index]),
//                                             fit: BoxFit.cover,
//                                             onError: (exception, stackTrace) {
//                                               // Fallback to asset image if network image fails
//                                             },
//                                           ),
//                                         ),
//                                         child: medicine!.images[index].isEmpty
//                                             ? Container(
//                                                 decoration: const BoxDecoration(
//                                                   image: DecorationImage(
//                                                     image: AssetImage(
//                                                         'assets/tablet.png'),
//                                                     fit: BoxFit.cover,
//                                                   ),
//                                                 ),
//                                               )
//                                             : null,
//                                       );
//                                     },
//                                   )
//                                 : Container(
//                                     decoration: const BoxDecoration(
//                                       image: DecorationImage(
//                                         image: AssetImage('assets/tablet.png'),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                           ),
//                           // Back Button
//                           Positioned(
//                             top: 16,
//                             left: 16,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.8),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: IconButton(
//                                 icon: const Icon(Icons.arrow_back),
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                               ),
//                             ),
//                           ),
//                           // Cart Button with Badge
//                           Positioned(
//                             top: 16,
//                             right: 16,
//                             child: Consumer<CartProvider>(
//                               builder: (context, cartProvider, child) {
//                                 return Container(
//                                   decoration: BoxDecoration(
//                                     color: Colors.white.withOpacity(0.8),
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Stack(
//                                     children: [
//                                       IconButton(
//                                         icon: const Icon(
//                                             Icons.shopping_cart_outlined),
//                                         onPressed: () {
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       CartScreen(
//                                                         amount: widget.mrp,
//                                                       )));
//                                         },
//                                       ),
//                                       if (cartProvider.itemCount > 0)
//                                         Positioned(
//                                           right: 8,
//                                           top: 8,
//                                           child: Container(
//                                             padding: const EdgeInsets.all(2),
//                                             decoration: const BoxDecoration(
//                                               color: Colors.red,
//                                               shape: BoxShape.circle,
//                                             ),
//                                             constraints: const BoxConstraints(
//                                               minWidth: 16,
//                                               minHeight: 16,
//                                             ),
//                                             child: Text(
//                                               '${cartProvider.itemCount}',
//                                               style: const TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                               textAlign: TextAlign.center,
//                                             ),
//                                           ),
//                                         ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                           // Image Pagination Dots
//                           if (medicine!.images.length > 1)
//                             Positioned(
//                               bottom: 16,
//                               left: 0,
//                               right: 0,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: List.generate(
//                                   medicine!.images.length,
//                                   (index) => Container(
//                                     margin: const EdgeInsets.symmetric(
//                                         horizontal: 4),
//                                     width: 8,
//                                     height: 8,
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       color: index == currentImageIndex
//                                           ? Colors.white
//                                           : Colors.white.withOpacity(0.5),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),

//                       // Product Details
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Product Title
//                               Text(
//                                 medicine!.name,
//                                 style: const TextStyle(
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),

//                               // Pharmacy Info
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   // Address with Flexible to prevent overflow
//                                   Flexible(
//                                     child: Row(
//                                       children: [
//                                         const Icon(Icons.location_on,
//                                             size: 16, color: Colors.grey),
//                                         const SizedBox(width: 4),
//                                         Flexible(
//                                           child: Text(
//                                             '${widget.address}',
//                                             style: const TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.grey,
//                                             ),
//                                             overflow: TextOverflow.ellipsis,
//                                             maxLines: 1,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),

//                                   // Price
//                                   Text(
//                                     '₹${widget.mrp}',
//                                     style: const TextStyle(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),

//                               const SizedBox(height: 16),

             

//                               const SizedBox(height: 24),

//                               // Description Section
//                               const Text(
//                                 'Description',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               Text(
//                                 medicine!.description.isNotEmpty
//                                     ? medicine!.description
//                                     : 'Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey,
//                                   height: 1.5,
//                                 ),
//                               ),

//                               const Spacer(),
//                               // Price and Order Buttons
//                               Consumer<CartProvider>(
//                                 builder: (context, cartProvider, child) {
//                                   final totalAmount = cartProvider.totalAmount;
//                                   final isInCart = widget.medicineId != null
//                                       ? cartProvider
//                                           .isInCart(widget.medicineId!)
//                                       : false;

//                                   return Row(
//                                     children: [
//                                       const SizedBox(width: 16),
  

//                                       Expanded(
//                                         child: OutlinedButton(
//                                           onPressed: isAddingToCart ||
//                                                   cartProvider.isLoading ||
//                                                   isInCart // disable if item already in cart
//                                               ? null
//                                               : () async {
//                                                   if (!isInCart) {
//                                                     setState(() =>
//                                                         isAddingToCart = true);
//                                                     await _addToCart(); // your existing function
//                                                     setState(() =>
//                                                         isAddingToCart = false);
//                                                   }
//                                                 },
//                                           style: OutlinedButton.styleFrom(
//                                             padding: const EdgeInsets.symmetric(
//                                                 vertical: 12),
//                                             side: BorderSide(
//                                               color: isInCart
//                                                   ? const Color.fromARGB(255, 73, 67, 255)
//                                                   : const Color(0xFF5931DD),
//                                             ),
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(30),
//                                             ),
//                                           ),
//                                           child: isAddingToCart
//                                               ? const SizedBox(
//                                                   width: 20,
//                                                   height: 20,
//                                                   child:
//                                                       CircularProgressIndicator(
//                                                     strokeWidth: 2,
//                                                     valueColor:
//                                                         AlwaysStoppedAnimation<
//                                                                 Color>(
//                                                             Colors.black),
//                                                   ),
//                                                 )
//                                               : Text(
//                                                   isInCart
//                                                       ? 'In Cart (${cartProvider.getItemQuantity(widget.medicineId!)})'
//                                                       : 'Add to Cart',
//                                                   style: TextStyle(
//                                                     color: isInCart
//                                                         ? Colors.black
//                                                         : Colors.black,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 ),
//                                         ),
//                                       ),

//                                       const SizedBox(width: 12),

//                                       // Order Now Button with Add to Cart functionality
//                                       Expanded(
//                                         child: ElevatedButton(
//                                           onPressed: isOrderingNow ||
//                                                   cartProvider.isLoading
//                                               ? null
//                                               : () async {
//                                                   if (medicine != null &&
//                                                       widget.medicineId !=
//                                                           null) {
//                                                     // Check if item is already in cart
//                                                     final isInCart =
//                                                         cartProvider.isInCart(
//                                                             widget.medicineId!);

//                                                     if (isInCart) {
//                                                       // If already in cart, just navigate to CartScreen
//                                                       if (mounted) {
//                                                         Navigator.push(
//                                                           context,
//                                                           MaterialPageRoute(
//                                                             builder:
//                                                                 (context) =>
//                                                                     CartScreen(
//                                                               amount: medicine
//                                                                   ?.price,
//                                                             ),
//                                                           ),
//                                                         );
//                                                       }
//                                                     } else {
//                                                       // If not in cart, add to cart first then navigate
//                                                       setState(() {
//                                                         isOrderingNow = true;
//                                                       });

//                                                       final success =
//                                                           await cartProvider
//                                                               .addToCart(widget
//                                                                   .medicineId!);

//                                                       setState(() {
//                                                         isOrderingNow = false;
//                                                       });

//                                                       if (success) {
//                                                         // Navigate to CartScreen immediately
//                                                         if (mounted) {
//                                                           Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                               builder:
//                                                                   (context) =>
//                                                                       CartScreen(
//                                                                 amount: medicine
//                                                                     ?.price,
//                                                               ),
//                                                             ),
//                                                           );
//                                                         }
//                                                       } else {
//                                                         // Show error message only if widget is still mounted
//                                                         if (mounted) {
//                                                           ScaffoldMessenger.of(
//                                                                   context)
//                                                               .showSnackBar(
//                                                             SnackBar(
//                                                               content: Text(cartProvider
//                                                                       .errorMessage ??
//                                                                   'Failed to add to cart'),
//                                                               backgroundColor:
//                                                                   Colors.red,
//                                                               duration:
//                                                                   const Duration(
//                                                                       seconds:
//                                                                           2),
//                                                             ),
//                                                           );
//                                                         }
//                                                       }
//                                                     }
//                                                   }
//                                                 },
//                                           style: ElevatedButton.styleFrom(
//                                             padding: const EdgeInsets.symmetric(
//                                                 vertical: 12),
//                                             backgroundColor:const Color(0xFF5931DD),
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(30),
//                                             ),
//                                           ),
//                                           child: isOrderingNow
//                                               ? const SizedBox(
//                                                   width: 20,
//                                                   height: 20,
//                                                   child:
//                                                       CircularProgressIndicator(
//                                                     strokeWidth: 2,
//                                                     valueColor:
//                                                         AlwaysStoppedAnimation<
//                                                                 Color>(
//                                                             Colors.white),
//                                                   ),
//                                                 )
//                                               : const Text(
//                                                   'Order Now',
//                                                   style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 ),
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//       ),
//     );
//   }
// }

















// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/constant/api_constants.dart';
import 'package:medical_user_app/models/medicine_model.dart';
import 'package:medical_user_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:medical_user_app/view/cart_screen.dart';

class ScannedMedicineScreen extends StatefulWidget {
  final double? mrp;
  final String? medicineId;
  final String? address;

  const ScannedMedicineScreen({
    Key? key,
    this.medicineId,
    this.address,
    this.mrp,
  }) : super(key: key);

  @override
  State<ScannedMedicineScreen> createState() => _ScannedMedicineScreenState();
}

class _ScannedMedicineScreenState extends State<ScannedMedicineScreen>
    with SingleTickerProviderStateMixin {
  MedicineModel? medicine;
  bool isLoading = true;
  String? errorMessage;
  int currentImageIndex = 0;
  bool isAddingToCart = false;
  bool isOrderingNow = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animations
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    // Only fetch if medicineId is provided
    if (widget.medicineId != null && widget.medicineId!.isNotEmpty) {
      fetchMedicineDetails();
    } else {
      setState(() {
        isLoading = false;
        errorMessage = 'No medicine ID provided';
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> fetchMedicineDetails() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      if (widget.medicineId == null || widget.medicineId!.isEmpty) {
        setState(() {
          errorMessage = 'Medicine ID is required';
          isLoading = false;
        });
        return;
      }

      final String url = ApiConstants.singleMedicine
          .replaceAll(':medicineId', widget.medicineId!);

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        Map<String, dynamic>? medicineData;

        if (data.containsKey('medicine') && data['medicine'] != null) {
          medicineData = data['medicine'] as Map<String, dynamic>;
        } else if (data.containsKey('data') && data['data'] != null) {
          medicineData = data['data'] as Map<String, dynamic>;
        } else if (data.containsKey('result') && data['result'] != null) {
          medicineData = data['result'] as Map<String, dynamic>;
        } else {
          medicineData = data;
        }

        if (medicineData != null) {
          setState(() {
            medicine = MedicineModel.fromJson(medicineData!);
            isLoading = false;
          });
          _animationController.forward();
        } else {
          setState(() {
            errorMessage = 'Invalid API response structure';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Failed to load medicine details';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  Future<void> _addToCart() async {
    if (medicine == null || widget.medicineId == null) return;

    setState(() {
      isAddingToCart = true;
    });

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final success = await cartProvider.addToCart(widget.medicineId!);

    setState(() {
      isAddingToCart = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '${medicine!.name} added to cart',
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF4CAF50),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  cartProvider.errorMessage ?? 'Failed to add to cart',
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFFE53935),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: isLoading
            ? _buildLoadingState()
            : errorMessage != null
                ? _buildErrorState()
                : _buildMainContent(),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF5931DD).withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF5931DD)),
              strokeWidth: 3,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Loading medicine details...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 64,
                color: Colors.red.shade400,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Oops! Something went wrong',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              errorMessage!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: fetchMedicineDetails,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5931DD),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: [
          _buildImageSection(),
          Expanded(
            child: SlideTransition(
              position: _slideAnimation,
              child: _buildDetailsSection(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      height: 380,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Product Images
          medicine!.images.isNotEmpty
              ? PageView.builder(
                  itemCount: medicine!.images.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentImageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(medicine!.images[index]),
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) {},
                        ),
                      ),
                      child: medicine!.images[index].isEmpty
                          ? Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/tablet.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : null,
                    );
                  },
                )
              : Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/tablet.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

          // Gradient overlay at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                  ],
                ),
              ),
            ),
          ),

          // Top buttons
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIconButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onPressed: () => Navigator.pop(context),
                ),
                _buildCartButton(),
              ],
            ),
          ),

          // Image pagination dots
          if (medicine!.images.length > 1)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  medicine!.images.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: index == currentImageIndex ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: index == currentImageIndex
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, size: 20),
        onPressed: onPressed,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildCartButton() {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, size: 22),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(amount: widget.mrp),
                    ),
                  );
                },
                color: Colors.black87,
              ),
              if (cartProvider.itemCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFF5931DD),
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
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
          ),
        );
      },
    );
  }

  Widget _buildDetailsSection() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Medicine name
            Text(
              medicine!.name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                height: 1.2,
              ),
            ),

            const SizedBox(height: 16),

            // Location and Price Row
            Row(
              children: [
                // Location
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 18,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            widget.address ?? 'Location',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Price
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5931DD).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '₹${widget.mrp}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5931DD),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Info Cards
            // Row(
            //   children: [
            //     Expanded(
            //       child: _buildInfoCard(
            //         icon: Icons.verified_user_rounded,
            //         label: 'Verified',
            //         color: const Color(0xFF4CAF50),
            //       ),
            //     ),
            //     const SizedBox(width: 12),
            //     Expanded(
            //       child: _buildInfoCard(
            //         icon: Icons.local_shipping_rounded,
            //         label: 'Fast Delivery',
            //         color: const Color(0xFF2196F3),
            //       ),
            //     ),
            //     const SizedBox(width: 12),
            //     Expanded(
            //       child: _buildInfoCard(
            //         icon: Icons.assignment_return_rounded,
            //         label: 'Easy Return',
            //         color: const Color(0xFFFF9800),
            //       ),
            //     ),
            //   ],
            // ),

            const SizedBox(height: 28),

            // Description
            Text(
              'Description',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              medicine!.description.isNotEmpty
                  ? medicine!.description
                  : 'This medicine is carefully formulated to provide effective treatment. Always consult with your healthcare provider before use and follow the prescribed dosage instructions. Store in a cool, dry place away from direct sunlight.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
                height: 1.6,
              ),
            ),

            const SizedBox(height: 32),

            // Action Buttons
            _buildActionButtons(),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        final isInCart = widget.medicineId != null
            ? cartProvider.isInCart(widget.medicineId!)
            : false;

        return Row(
          children: [
            // Add to Cart Button
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 56,
                child: OutlinedButton(
                  onPressed: isAddingToCart ||
                          cartProvider.isLoading ||
                          isInCart
                      ? null
                      : () async {
                          if (!isInCart) {
                            await _addToCart();
                          }
                        },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: isInCart
                          ? const Color(0xFF4CAF50)
                          : const Color(0xFF5931DD),
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: isInCart
                        ? const Color(0xFF4CAF50).withOpacity(0.1)
                        : Colors.transparent,
                  ),
                  child: isAddingToCart
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF5931DD),
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isInCart
                                  ? Icons.check_circle_rounded
                                  : Icons.shopping_cart_outlined,
                              color: isInCart
                                  ? const Color(0xFF4CAF50)
                                  : const Color(0xFF5931DD),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isInCart
                                  ? 'In Cart (${cartProvider.getItemQuantity(widget.medicineId!)})'
                                  : 'Add to Cart',
                              style: TextStyle(
                                color: isInCart
                                    ? const Color(0xFF4CAF50)
                                    : const Color(0xFF5931DD),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Order Now Button
            Expanded(
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF5931DD), Color(0xFF7B52ED)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF5931DD).withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed:
                      isOrderingNow || cartProvider.isLoading
                          ? null
                          : () async {
                              if (medicine != null &&
                                  widget.medicineId != null) {
                                final isInCart = cartProvider
                                    .isInCart(widget.medicineId!);

                                if (isInCart) {
                                  if (mounted) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CartScreen(amount: medicine?.price.toDouble()),
                                      ),
                                    );
                                  }
                                } else {
                                  setState(() => isOrderingNow = true);
                                  final success = await cartProvider
                                      .addToCart(widget.medicineId!);
                                  setState(() => isOrderingNow = false);

                                  if (success && mounted) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CartScreen(amount: medicine?.price.toDouble()),
                                      ),
                                    );
                                  } else if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          cartProvider.errorMessage ??
                                              'Failed to add to cart',
                                        ),
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    );
                                  }
                                }
                              }
                            },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: isOrderingNow
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.shopping_bag_rounded,
                                color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Order Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}