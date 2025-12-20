// ignore_for_file: deprecated_member_use

// Updated ScannedMedicineScreen with Cart Integration
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/constant/api_constants.dart';
import 'package:medical_user_app/models/medicine_model.dart';
import 'package:medical_user_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:medical_user_app/view/cart_screen.dart';
import 'package:medical_user_app/view/payment_screen.dart';

class ScannedMedicineScreen extends StatefulWidget {
  final int? mrp;
  final String? medicineId;
  final String? address;

  const ScannedMedicineScreen(
      {Key? key, this.medicineId, this.address, this.mrp})
      : super(key: key);

  @override
  State<ScannedMedicineScreen> createState() => _ScannedMedicineScreenState();
}

class _ScannedMedicineScreenState extends State<ScannedMedicineScreen> {
  MedicineModel? medicine;
  bool isLoading = true;
  String? errorMessage;
  int currentImageIndex = 0;
  bool isAddingToCart = false;
  bool isOrderingNow = false;

  @override
  void initState() {
    super.initState();
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

  Future<void> fetchMedicineDetails() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      // Check if medicineId is null
      if (widget.medicineId == null || widget.medicineId!.isEmpty) {
        setState(() {
          errorMessage = 'Medicine ID is required';
          isLoading = false;
        });
        return;
      }

      // Replace the placeholder in the URL with actual medicineId
      final String url = ApiConstants.singleMedicine
          .replaceAll(':medicineId', widget.medicineId!);

      print('Fetching medicine from URL: $url'); // Debug log

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
          // 'Authorization': 'Bearer $token',
        },
      );

      print('Response status: ${response.statusCode}'); // Debug log
      print('Response body: ${response.body}'); // Debug log

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Debug: Print the actual API response structure
        print('API Response structure: $data');

        // Handle different API response structures
        Map<String, dynamic>? medicineData;

        if (data.containsKey('medicine') && data['medicine'] != null) {
          medicineData = data['medicine'] as Map<String, dynamic>;
        } else if (data.containsKey('data') && data['data'] != null) {
          medicineData = data['data'] as Map<String, dynamic>;
        } else if (data.containsKey('result') && data['result'] != null) {
          medicineData = data['result'] as Map<String, dynamic>;
        } else {
          // Assume the entire response is the medicine data
          medicineData = data;
        }

        if (medicineData != null) {
          setState(() {
            medicine = MedicineModel.fromJson(medicineData!);
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = 'Invalid API response structure';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage =
              'Failed to load medicine details. Status: ${response.statusCode}\nResponse: ${response.body}';
          isLoading = false;
        });
      }
    } catch (e, stackTrace) {
      print('Error fetching medicine details: $e');
      print('Stack trace: $stackTrace');

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
          content: Text('${medicine!.name} added to cart'),
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
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: fetchMedicineDetails,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Stack(
                        children: [
                          // Product Image
                          Container(
                            height: 300,
                            width: double.infinity,
                            child: medicine!.images.isNotEmpty
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
                                            image: NetworkImage(
                                                medicine!.images[index]),
                                            fit: BoxFit.cover,
                                            onError: (exception, stackTrace) {
                                              // Fallback to asset image if network image fails
                                            },
                                          ),
                                        ),
                                        child: medicine!.images[index].isEmpty
                                            ? Container(
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/tablet.png'),
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
                          ),
                          // Back Button
                          Positioned(
                            top: 16,
                            left: 16,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          // Cart Button with Badge
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Consumer<CartProvider>(
                              builder: (context, cartProvider, child) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.8),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Stack(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                            Icons.shopping_cart_outlined),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CartScreen(
                                                        amount: widget.mrp,
                                                      )));
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
                                  ),
                                );
                              },
                            ),
                          ),
                          // Image Pagination Dots
                          if (medicine!.images.length > 1)
                            Positioned(
                              bottom: 16,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  medicine!.images.length,
                                  (index) => Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
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

                      // Product Details
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Title
                              Text(
                                medicine!.name,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              // Pharmacy Info
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Address with Flexible to prevent overflow
                                  Flexible(
                                    child: Row(
                                      children: [
                                        const Icon(Icons.location_on,
                                            size: 16, color: Colors.grey),
                                        const SizedBox(width: 4),
                                        Flexible(
                                          child: Text(
                                            '${widget.address}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Price
                                  Text(
                                    '₹${widget.mrp}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              // Pharmacy Info
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Column(
                              //       children: [
                              //         Row(
                              //           children: [
                              //             const Icon(Icons.location_on,
                              //                 size: 16, color: Colors.grey),
                              //             const SizedBox(width: 4),
                              //             Text(
                              //               '${widget.address}',
                              //               style: const TextStyle(
                              //                 fontSize: 14,
                              //                 color: Colors.grey,
                              //               ),
                              //             ),
                              //           ],
                              //         )
                              //       ],
                              //     ),
                              //     Column(
                              //       children: [
                              //         Text(
                              //           '₹${medicine!.price}',
                              //           style: const TextStyle(
                              //             fontSize: 24,
                              //             fontWeight: FontWeight.bold,
                              //           ),
                              //         ),
                              //       ],
                              //     )
                              //   ],
                              // ),

                              const SizedBox(height: 16),

                              // Stats Row
                              // Container(
                              //   width: 343,
                              //   height: 62,
                              //   padding: const EdgeInsets.all(5),
                              //   decoration: BoxDecoration(
                              //     color: const Color(0xFFEFF3F7),
                              //     borderRadius: BorderRadius.circular(10)
                              //   ),
                              //   child: const Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       // Reviews
                              //       Column(
                              //         children: [
                              //           Text(
                              //             '1k+',
                              //             style: TextStyle(
                              //               fontSize: 16,
                              //               fontWeight: FontWeight.bold,
                              //             ),
                              //           ),
                              //           Text(
                              //             'Orders',
                              //             style: TextStyle(
                              //               fontSize: 14,
                              //               color: Colors.grey,
                              //             ),
                              //           ),
                              //         ],
                              //       ),

                              //       SizedBox(width: 20),

                              //       SizedBox(
                              //         height: 40,
                              //         width: 1,
                              //         child: DecoratedBox(
                              //           decoration: BoxDecoration(color: Colors.grey),
                              //         ),
                              //       ),

                              //       SizedBox(width: 20),

                              //       // Delivery Time
                              //       Column(
                              //         children: [
                              //           Row(
                              //             children: [
                              //               Icon(
                              //                 Icons.access_time_filled,
                              //                 color: Color.fromARGB(255, 31, 17, 136),
                              //                 size: 16,
                              //               ),
                              //               Text(
                              //                 '15 min',
                              //                 style: TextStyle(
                              //                   fontSize: 16,
                              //                   fontWeight: FontWeight.bold,
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //           Text(
                              //             'Delivery',
                              //             style: TextStyle(
                              //               fontSize: 14,
                              //               color: Colors.grey,
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // ),

                              // Container(
                              //   width: 343,
                              //   height: 62,
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 20),
                              //   decoration: BoxDecoration(
                              //     color: const Color(0xFFEFF3F7),
                              //     borderRadius: BorderRadius.circular(10),
                              //   ),
                              //   child: const Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceEvenly,
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     children: [
                              //       // Orders
                              //       Column(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.center,
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.center,
                              //         children: [
                              //           Text(
                              //             '1k+',
                              //             style: TextStyle(
                              //               fontSize: 16,
                              //               fontWeight: FontWeight.bold,
                              //             ),
                              //           ),
                              //           SizedBox(height: 4),
                              //           Text(
                              //             'Orders',
                              //             style: TextStyle(
                              //               fontSize: 14,
                              //               color: Colors.grey,
                              //             ),
                              //           ),
                              //         ],
                              //       ),

                              //       // // Divider
                              //       // Container(
                              //       //   height: 40,
                              //       //   width: 1,
                              //       //   color: Colors.grey,
                              //       // ),

                              //       // Delivery
                              //       // const  Column(
                              //       //     mainAxisAlignment:
                              //       //         MainAxisAlignment.center,
                              //       //     crossAxisAlignment:
                              //       //         CrossAxisAlignment.center,
                              //       //     children:  [
                              //       //       Row(
                              //       //         mainAxisAlignment:
                              //       //             MainAxisAlignment.center,
                              //       //         children: [
                              //       //           Icon(
                              //       //             Icons.access_time_filled,
                              //       //             color: Color.fromARGB(
                              //       //                 255, 31, 17, 136),
                              //       //             size: 16,
                              //       //           ),
                              //       //           SizedBox(width: 4),
                              //       //           Text(
                              //       //             '15 min',
                              //       //             style: TextStyle(
                              //       //               fontSize: 16,
                              //       //               fontWeight: FontWeight.bold,
                              //       //             ),
                              //       //           ),
                              //       //         ],
                              //       //       ),
                              //       //       SizedBox(height: 4),
                              //       //       Text(
                              //       //         'Delivery',
                              //       //         style: TextStyle(
                              //       //           fontSize: 14,
                              //       //           color: Colors.grey,
                              //       //         ),
                              //       //       ),
                              //       //     ],
                              //       //   ),
                              //     ],
                              //   ),
                              // ),

                              const SizedBox(height: 24),

                              // Description Section
                              const Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                medicine!.description.isNotEmpty
                                    ? medicine!.description
                                    : 'Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  height: 1.5,
                                ),
                              ),

                              const Spacer(),
                              // Price and Order Buttons
                              Consumer<CartProvider>(
                                builder: (context, cartProvider, child) {
                                  final totalAmount = cartProvider.totalAmount;
                                  final isInCart = widget.medicineId != null
                                      ? cartProvider
                                          .isInCart(widget.medicineId!)
                                      : false;

                                  return Row(
                                    children: [
                                      const SizedBox(width: 16),
                                      // Add to Cart Button
                                      // Expanded(
                                      //   child: OutlinedButton(
                                      //     onPressed: isAddingToCart ||
                                      //             cartProvider.isLoading
                                      //         ? null
                                      //         : _addToCart,
                                      //     style: OutlinedButton.styleFrom(
                                      //       padding: const EdgeInsets.symmetric(
                                      //           vertical: 12),
                                      //       side: BorderSide(
                                      //         color: isInCart
                                      //             ? Colors.green
                                      //             : Colors.black,
                                      //       ),
                                      //       shape: RoundedRectangleBorder(
                                      //         borderRadius:
                                      //             BorderRadius.circular(30),
                                      //       ),
                                      //     ),
                                      //     child: isAddingToCart
                                      //         ? const SizedBox(
                                      //             width: 20,
                                      //             height: 20,
                                      //             child:
                                      //                 CircularProgressIndicator(
                                      //               strokeWidth: 2,
                                      //               valueColor:
                                      //                   AlwaysStoppedAnimation<
                                      //                           Color>(
                                      //                       Colors.black),
                                      //             ),
                                      //           )
                                      //         : Text(
                                      //             isInCart
                                      //                 ? 'In Cart (${cartProvider.getItemQuantity(widget.medicineId!)})'
                                      //                 : 'Add to Cart',
                                      //             style: TextStyle(
                                      //               color: isInCart
                                      //                   ? Colors.green
                                      //                   : Colors.black,
                                      //               fontWeight: FontWeight.bold,
                                      //             ),
                                      //           ),
                                      //   ),
                                      // ),

                                      Expanded(
                                        child: OutlinedButton(
                                          onPressed: isAddingToCart ||
                                                  cartProvider.isLoading ||
                                                  isInCart // disable if item already in cart
                                              ? null
                                              : () async {
                                                  if (!isInCart) {
                                                    setState(() =>
                                                        isAddingToCart = true);
                                                    await _addToCart(); // your existing function
                                                    setState(() =>
                                                        isAddingToCart = false);
                                                  }
                                                },
                                          style: OutlinedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            side: BorderSide(
                                              color: isInCart
                                                  ? const Color.fromARGB(255, 73, 67, 255)
                                                  : const Color(0xFF5931DD),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                          child: isAddingToCart
                                              ? const SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Colors.black),
                                                  ),
                                                )
                                              : Text(
                                                  isInCart
                                                      ? 'In Cart (${cartProvider.getItemQuantity(widget.medicineId!)})'
                                                      : 'Add to Cart',
                                                  style: TextStyle(
                                                    color: isInCart
                                                        ? Colors.black
                                                        : Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                        ),
                                      ),

                                      const SizedBox(width: 12),

                                      // Order Now Button
                                      // Expanded(
                                      //   child: ElevatedButton(
                                      //     // onPressed: () {
                                      //     //    Navigator.push(
                                      //     //           context,
                                      //     //           MaterialPageRoute(builder: (context) => const PaymentSuccessfullScreeen())
                                      //     //         );
                                      //     // },
                                      //     onPressed: isAddingToCart ||
                                      //             cartProvider.isLoading
                                      //         ? null
                                      //         : () {
                                      //             // Navigator.push(
                                      //             //     context,
                                      //             //     MaterialPageRoute(
                                      //             //         builder: (context) =>
                                      //             //             PaymentScreen(
                                      //             //               amount: totalAmount
                                      //             //                   .toString(),
                                      //             //             )));

                                      //             Navigator.push(
                                      //                 context,
                                      //                 MaterialPageRoute(
                                      //                     builder: (context) =>
                                      //                         CartScreen(
                                      //                             amount: medicine
                                      //                                 ?.price)));
                                      //           },
                                      //     style: ElevatedButton.styleFrom(
                                      //       padding: const EdgeInsets.symmetric(
                                      //           vertical: 12),
                                      //       backgroundColor: Colors.deepPurple,
                                      //       shape: RoundedRectangleBorder(
                                      //         borderRadius:
                                      //             BorderRadius.circular(30),
                                      //       ),
                                      //     ),
                                      //     child: const Text(
                                      //       'Order Now',
                                      //       style: TextStyle(
                                      //         color: Colors.white,
                                      //         fontWeight: FontWeight.bold,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),

                                      // Order Now Button with Add to Cart functionality
                                      // Expanded(
                                      //   child: ElevatedButton(
                                      //     onPressed: isAddingToCart ||
                                      //             cartProvider.isLoading
                                      //         ? null
                                      //         : () async {
                                      //             // First add to cart
                                      //             if (medicine != null &&
                                      //                 widget.medicineId !=
                                      //                     null) {
                                      //               setState(() {
                                      //                 isAddingToCart = true;
                                      //               });

                                      //               final success =
                                      //                   await cartProvider
                                      //                       .addToCart(widget
                                      //                           .medicineId!);

                                      //               setState(() {
                                      //                 isAddingToCart = false;
                                      //               });

                                      //               if (success) {
                                      //                 // Navigate to CartScreen immediately
                                      //                 if (mounted) {
                                      //                   Navigator.push(
                                      //                     context,
                                      //                     MaterialPageRoute(
                                      //                       builder:
                                      //                           (context) =>
                                      //                               CartScreen(
                                      //                         amount: medicine
                                      //                             ?.price,
                                      //                       ),
                                      //                     ),
                                      //                   );
                                      //                 }
                                      //               } else {
                                      //                 // Show error message only if widget is still mounted
                                      //                 if (mounted) {
                                      //                   ScaffoldMessenger.of(
                                      //                           context)
                                      //                       .showSnackBar(
                                      //                     SnackBar(
                                      //                       content: Text(cartProvider
                                      //                               .errorMessage ??
                                      //                           'Failed to add to cart'),
                                      //                       backgroundColor:
                                      //                           Colors.red,
                                      //                       duration:
                                      //                           const Duration(
                                      //                               seconds: 2),
                                      //                     ),
                                      //                   );
                                      //                 }
                                      //               }
                                      //             }
                                      //           },
                                      //     style: ElevatedButton.styleFrom(
                                      //       padding: const EdgeInsets.symmetric(
                                      //           vertical: 12),
                                      //       backgroundColor: Colors.deepPurple,
                                      //       shape: RoundedRectangleBorder(
                                      //         borderRadius:
                                      //             BorderRadius.circular(30),
                                      //       ),
                                      //     ),
                                      //     child: isAddingToCart
                                      //         ? const SizedBox(
                                      //             width: 20,
                                      //             height: 20,
                                      //             child:
                                      //                 CircularProgressIndicator(
                                      //               strokeWidth: 2,
                                      //               valueColor:
                                      //                   AlwaysStoppedAnimation<
                                      //                           Color>(
                                      //                       Colors.white),
                                      //             ),
                                      //           )
                                      //         : const Text(
                                      //             'Order Now',
                                      //             style: TextStyle(
                                      //               color: Colors.white,
                                      //               fontWeight: FontWeight.bold,
                                      //             ),
                                      //           ),
                                      //   ),
                                      // ),

                                      // Order Now Button with Add to Cart functionality
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: isOrderingNow ||
                                                  cartProvider.isLoading
                                              ? null
                                              : () async {
                                                  if (medicine != null &&
                                                      widget.medicineId !=
                                                          null) {
                                                    // Check if item is already in cart
                                                    final isInCart =
                                                        cartProvider.isInCart(
                                                            widget.medicineId!);

                                                    if (isInCart) {
                                                      // If already in cart, just navigate to CartScreen
                                                      if (mounted) {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    CartScreen(
                                                              amount: medicine
                                                                  ?.price,
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    } else {
                                                      // If not in cart, add to cart first then navigate
                                                      setState(() {
                                                        isOrderingNow = true;
                                                      });

                                                      final success =
                                                          await cartProvider
                                                              .addToCart(widget
                                                                  .medicineId!);

                                                      setState(() {
                                                        isOrderingNow = false;
                                                      });

                                                      if (success) {
                                                        // Navigate to CartScreen immediately
                                                        if (mounted) {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      CartScreen(
                                                                amount: medicine
                                                                    ?.price,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      } else {
                                                        // Show error message only if widget is still mounted
                                                        if (mounted) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(cartProvider
                                                                      .errorMessage ??
                                                                  'Failed to add to cart'),
                                                              backgroundColor:
                                                                  Colors.red,
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          2),
                                                            ),
                                                          );
                                                        }
                                                      }
                                                    }
                                                  }
                                                },
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            backgroundColor:const Color(0xFF5931DD),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                          child: isOrderingNow
                                              ? const SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Colors.white),
                                                  ),
                                                )
                                              : const Text(
                                                  'Order Now',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                        ),
                                      ),

                                      // Order Now Button
                                      // Expanded(
                                      //   child: ElevatedButton(
                                      //     onPressed: isAddingToCart ||
                                      //             cartProvider.isLoading
                                      //         ? null
                                      //         : () {
                                      //             if (cartProvider.itemCount >
                                      //                 0) {
                                      //               Navigator.push(
                                      //                 context,
                                      //                 MaterialPageRoute(
                                      //                   builder: (context) =>
                                      //                       PaymentScreen(
                                      //                     amount: cartProvider
                                      //                         .totalAmount
                                      //                         .toString(),
                                      //                   ),
                                      //                 ),
                                      //               );
                                      //             } else {
                                      //               ScaffoldMessenger.of(
                                      //                       context)
                                      //                   .showSnackBar(
                                      //                 const SnackBar(
                                      //                   content: Text(
                                      //                       "Your cart is empty. Add items first."),
                                      //                   backgroundColor:
                                      //                       Colors.red,
                                      //                   duration: Duration(
                                      //                       seconds: 2),
                                      //                 ),
                                      //               );
                                      //             }
                                      //           },
                                      //     style: ElevatedButton.styleFrom(
                                      //       padding: const EdgeInsets.symmetric(
                                      //           vertical: 12),
                                      //       backgroundColor: Colors.deepPurple,
                                      //       shape: RoundedRectangleBorder(
                                      //         borderRadius:
                                      //             BorderRadius.circular(30),
                                      //       ),
                                      //     ),
                                      //     child: const Text(
                                      //       'Order Now',
                                      //       style: TextStyle(
                                      //         color: Colors.white,
                                      //         fontWeight: FontWeight.bold,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
