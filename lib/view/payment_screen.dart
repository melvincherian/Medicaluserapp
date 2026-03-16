// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:medical_user_app/providers/language_provider.dart';
// import 'package:medical_user_app/providers/order_provider.dart';
// import 'package:medical_user_app/providers/cart_provider.dart';
// import 'package:medical_user_app/utils/shared_preferences_helper.dart';
// import 'package:medical_user_app/view/booking_successfull_screen.dart';
// import 'package:medical_user_app/view/card_details_screen.dart';
// import 'package:medical_user_app/view/change_address_screen.dart';
// import 'package:medical_user_app/view/payment_successfull_screeen.dart';
// import 'package:provider/provider.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class PaymentScreen extends StatefulWidget {
//   final String? subtotal;
//   final String? amount;
//   final String? coupouncode;
//   const PaymentScreen({Key? key, this.amount, this.coupouncode, this.subtotal})
//       : super(
//           key: key,
//         );

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   int?
//       _selectedPaymentMethod;
//   final TextEditingController _notesController = TextEditingController();
//   bool _isListening = false;
//   String _transcription = '';
//   bool _showNoteInput = false;
//   bool _isProcessingOrder = false;

//   String? userId;
//   bool isLoading = true;

//   // Razorpay instance
//   late Razorpay razorpay;

//   // Store selected address
//   Map<String, dynamic>? selectedAddress;
//   String displayAddress = ''; // Default address
//   String? selectedAddressId; // Default address ID

//   final paymentMethods = [
//     {'name': 'Online', 'icon': Icons.credit_card, 'value': 'Credit/Debit Card'},
//     {
//       'name': 'Cash on Delivery',
//       'icon': Icons.money,
//       'value': 'Cash on Delivery'
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     // Initialize Razorpay
//     razorpay = Razorpay();
//     razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
//     razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
//     razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);

//     // Don't set default payment method - user must select one
//     _selectedPaymentMethod = null;
//     _initUserAndAddress();
//   }

//   @override
//   void dispose() {
//     _notesController.dispose();
//     razorpay.clear(); // Clear razorpay listeners
//     super.dispose();
//   }

//   Future<void> _saveSelectedAddress() async {
//     if (selectedAddress != null && userId != null) {
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString(
//           '${userId}_selected_address_id', selectedAddressId ?? '');
//       await prefs.setString('${userId}_display_address', displayAddress);
//       await prefs.setString(
//           '${userId}_selected_address_data', jsonEncode(selectedAddress));
//     }
//   }

//   Future<void> _initUserAndAddress() async {
//     await _loadUserId();
//     if (userId != null) {
//       await _restoreSelectedAddress();
//     }
//   }

//   Future<void> _loadUserId() async {
//     try {
//       final storedUser = await SharedPreferencesHelper.getUser();
//       setState(() {
//         userId = storedUser?.id;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       print('Error loading user: $e');
//     }
//   }

//   Future<void> _restoreSelectedAddress() async {
//     if (userId == null) return;
//     final prefs = await SharedPreferences.getInstance();
//     final addressId = prefs.getString('${userId}_selected_address_id');
//     final displayAddr = prefs.getString('${userId}_display_address');
//     final addressData = prefs.getString('${userId}_selected_address_data');

//     if (addressId != null &&
//         addressId.isNotEmpty &&
//         displayAddr != null &&
//         addressData != null) {
//       setState(() {
//         selectedAddressId = addressId;
//         displayAddress = displayAddr;
//         selectedAddress = jsonDecode(addressData);
//       });
//     }
//   }

//   // Razorpay event handlers
//   void handlePaymentErrorResponse(PaymentFailureResponse response) {
//     setState(() {
//       _isProcessingOrder = false;
//     });
//     _showErrorSnackBar("Payment Failed: ${response.message}");
//   }

//   void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
//     // Payment successful, now process the order
//     try {
//       await _processOrder(response.paymentId);
//     } catch (e) {
//       setState(() {
//         _isProcessingOrder = false;
//       });
//       _showErrorSnackBar("Order processing failed after payment: $e");
//     }
//   }

//   void handleExternalWalletSelected(ExternalWalletResponse response) {
//     _showErrorSnackBar("External wallet selected: ${response.walletName}");
//   }

//   // Method to initiate Razorpay payment
//   void _initiateRazorpayPayment() {
//     final cartProvider = Provider.of<CartProvider>(context, listen: false);

//     var options = {
//       'key': 'rzp_test_BxtRNvflG06PTV',
//       'amount': (cartProvider.totalAmount * 100).toInt(),
//       'name': 'CLYNIX',
//       'description': 'Medicine Order Payment',
//       'retry': {'enabled': true, 'max_count': 1},
//       'send_sms_hash': true,
//       'prefill': {
//         'contact': "8309056333",
//         'email': "Simcurarx@gmail.com",
//       },
//       'external': {
//         'wallets': ['paytm']
//       }
//     };

//     try {
//       print("Opeeeeeeeeeeeeeeeeen$_selectedPaymentMethod");

//       razorpay.open(options);
//       print("gsddsdjsdsjdhslkdlsdj$_selectedPaymentMethod");
//     } catch (e) {
//       setState(() {
//         _isProcessingOrder = false;
//       });
//       _showErrorSnackBar("Failed to open payment gateway: $e");
//     }
//   }

//   // Method to build address string from selected address
//   String _buildAddressString(Map<String, dynamic> address) {
//     final house = address['house'] ?? '';
//     final street = address['street'] ?? '';
//     final city = address['city'] ?? '';
//     final state = address['state'] ?? '';
//     final pincode = address['pincode'] ?? '';

//     List<String> parts = [];
//     if (house.isNotEmpty) parts.add(house);
//     if (street.isNotEmpty) parts.add(street);
//     if (city.isNotEmpty) parts.add(city);
//     if (state.isNotEmpty) parts.add(state);
//     if (pincode.isNotEmpty) parts.add(pincode);

//     return parts.isNotEmpty ? parts.join(', ') : 'Gandhi nagar,1-2-12';
//   }

//   void _navigateToChangeAddress() async {
//     final result = await Navigator.push<Map<String, dynamic>>(
//       context,
//       MaterialPageRoute(builder: (context) => const ChangeAddressScreen()),
//     );

//     if (result != null) {
//       setState(() {
//         selectedAddress = result;
//         displayAddress = _buildAddressString(result);

//         // Fix: Handle both saved addresses and map locations
//         if (result['_id'] != null || result['id'] != null) {
//           // This is a saved address from database
//           selectedAddressId = result['_id'] ?? result['id'];
//         } else if (result['latitude'] != null && result['longitude'] != null) {
//           // This is a map location - generate a temporary ID or use coordinates
//           selectedAddressId =
//               'map_location_${result['latitude']}_${result['longitude']}';
//         } else if (result['fullAddress'] != null) {
//           // This is a map location with fullAddress
//           selectedAddressId = 'map_location_temp';
//         } else {
//           selectedAddressId = 'temp_address';
//         }
//       });

//       _saveSelectedAddress();

//       print('Selected address ID: $selectedAddressId');
//       print('Display address: $displayAddress');
//     }
//   }

//   // Method to handle initial order confirmation (before payment)
//   Future<void> _confirmOrder() async {
//     print("ppppppppppppppppppppppppppppppp$_isProcessingOrder");
//     if (_isProcessingOrder) return;

//     print("ppppppppppppppppppppppppppppppp$_selectedPaymentMethod");

//     // Check if payment method is selected
//     if (_selectedPaymentMethod == null) {
//       _showErrorSnackBar('Please select a payment method');
//       return;
//     }

//     if (selectedAddressId == null || selectedAddressId!.isEmpty) {
//       _showErrorSnackBar('Please select a valid address');
//       return;
//     }

//     print('ssssssssssssssssssssssssssssssssss$selectedAddressId');

//     setState(() {
//       _isProcessingOrder = true;
//     });

//     final cartProvider = Provider.of<CartProvider>(context, listen: false);

//     if (cartProvider.itemCount == 0) {
//       _showErrorSnackBar('Your cart is empty');
//       setState(() {
//         _isProcessingOrder = false;
//       });
//       return;
//     }

//     try {
//       print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmm$_selectedPaymentMethod");

//       if (_selectedPaymentMethod == 0) {
//         print("hhhhhhhhhhhhhhhhhhhhhhhh$_selectedPaymentMethod");

//         // Online payment - initiate Razorpay
//         _initiateRazorpayPayment();
//       } else {
//         print("jjjjjjjjjjjjjjjjjjjjjjjjjj$_selectedPaymentMethod");

//         // Cash on Delivery - process order directly
//         await _processOrder(null);
//       }
//     } catch (e) {
//       setState(() {
//         _isProcessingOrder = false;
//       });
//       _showErrorSnackBar('An error occurred: $e');
//     }
//   }

//   // Method to process the order (after payment or directly for COD)
//   Future<void> _processOrder(String? paymentId) async {
//     try {
//       final orderProvider = Provider.of<OrderProvider>(context, listen: false);
//       final cartProvider = Provider.of<CartProvider>(context, listen: false);

//       // Validate order requirements
//       if (orderProvider.currentUser == null) {
//         _showErrorSnackBar('Please log in to place an order');
//         setState(() {
//           _isProcessingOrder = false;
//         });
//         return;
//       }

//       // Get selected payment method
//       String paymentMethod =
//           paymentMethods[_selectedPaymentMethod!]['value'].toString();

//       // Show loading dialog only for COD (Razorpay has its own loading)
//       if (_selectedPaymentMethod == 1) {
//         _showLoadingDialog();
//       }

//       // Create order using OrderProvider
//       final order = await orderProvider.createOrder(
//           addressId: selectedAddressId.toString(),
//           notes: _notesController.text.trim(),
//           voiceNoteUrl: '', // Add voice note URL if implemented
//           paymentMethod: paymentMethod,
//           paymentId: paymentId,
//           coupon: widget.coupouncode);

//       // Hide loading dialog for COD
//       if (_selectedPaymentMethod == 1 && Navigator.of(context).canPop()) {
//         Navigator.of(context).pop();
//       }

//       if (order != null) {
//         // Order created successfully
//         _showSuccessSnackBar('Order placed successfully!');

//         // Clear cart after successful order
//         await cartProvider.clearCart();

//         // Navigate based on payment method
//         if (_selectedPaymentMethod == 0) {
//           // Online payment - Navigate to PaymentSuccessfullScreeen
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => PaymentSuccessfullScreeen(
//                 orderId: order.id,
//                 orderAmount: order.totalAmount,
//                 paymentMethod: paymentMethod,
//               ),
//             ),
//           );
//         } else {
//           // Cash on Delivery - Navigate to BookingSuccessfullScreen
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => BookingSuccessfullScreen(
//                 orderId: order.id,
//                 orderAmount: order.totalAmount,
//                 paymentMethod: paymentMethod,
//                 addressId: selectedAddressId,
//               ),
//             ),
//           );
//         }
//       } else {
//         // Order creation failed
//         String errorMsg = orderProvider.errorMessage ??
//             'Payment processing failed. Please try again or use a different payment method';
//         _showErrorSnackBar(errorMsg);
//         setState(() {
//           _isProcessingOrder = false;
//         });
//       }
//     } catch (e) {
//       // Hide loading dialog if still showing
//       if (Navigator.of(context).canPop()) {
//         Navigator.of(context).pop();
//       }

//       print('Error processing order: $e');
//       _showErrorSnackBar('An error occurred while placing the order');
//       setState(() {
//         _isProcessingOrder = false;
//       });
//     }
//   }

//   // Show loading dialog
//   void _showLoadingDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return Dialog(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const CircularProgressIndicator(),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'Processing your order...',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // Show success snackbar
//   void _showSuccessSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.green,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   // Show error snackbar
//   void _showErrorSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   // Check if confirm order button should be enabled
//   bool _isConfirmOrderEnabled() {
//     final cartProvider = Provider.of<CartProvider>(context, listen: false);
//     return _selectedPaymentMethod != null &&
//         !_isProcessingOrder &&
//         cartProvider.itemCount > 0 &&
//         (selectedAddressId != null && selectedAddressId!.isNotEmpty);
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('coupoun codeeeeeeeeeeeeeeeeeeee ${widget.coupouncode}');
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text(
//           'Checkout',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
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
//       body: Consumer2<OrderProvider, CartProvider>(
//         builder: (context, orderProvider, cartProvider, child) {
//           return Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Delivery address
//                       Container(
//                         margin: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 8),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.3),
//                               spreadRadius: 1,
//                               blurRadius: 2,
//                               offset: const Offset(0, 1),
//                             ),
//                           ],
//                         ),
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 4),
//                           title: const Text(
//                             'Add Address',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           subtitle: Row(
//                             children: [
//                               // const Icon(Icons.location_on, size: 16, color: Colors.black54),
//                               const SizedBox(width: 4),
//                               Expanded(
//                                 child: Text(
//                                   displayAddress,
//                                   style: const TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           // trailing: const Icon(Icons.chevron_right, color: Colors.black54),
//                           onTap: _navigateToChangeAddress,
//                         ),
//                       ),

//                       const Divider(thickness: 1),

//                       // Order details - Dynamic cart content
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 8),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   'Your Order',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 RichText(
//                                   text: const TextSpan(
//                                     children: [
//                                       // TextSpan(
//                                       //   text:
//                                       //       '${cartProvider.itemCount} Items from ',
//                                       //   style: TextStyle(
//                                       //     color: Colors.grey,
//                                       //     fontSize: 14,
//                                       //     fontWeight: FontWeight.w400,
//                                       //   ),
//                                       // ),
//                                       // TextSpan(
//                                       //   text: 'Apollo',
//                                       //   style: TextStyle(
//                                       //     color: Colors.black,
//                                       //     fontSize: 14,
//                                       //     fontWeight: FontWeight.bold,
//                                       //   ),
//                                       // ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 16),
//                             // Display cart items
//                             // ...cartProvider.cart.items.map((item) {
//                             //   return Padding(
//                             //     padding: const EdgeInsets.only(bottom: 8),
//                             //     child: Row(
//                             //       mainAxisAlignment:
//                             //           MainAxisAlignment.spaceBetween,
//                             //       children: [
//                             //         Expanded(
//                             //           child: RichText(
//                             //             text: TextSpan(
//                             //               children: [
//                             //                 TextSpan(
//                             //                   text: '${item.quantity}x ',
//                             //                   style:const TextStyle(
//                             //                     color: Colors.purple,
//                             //                     fontSize: 14,
//                             //                     fontWeight: FontWeight.bold,
//                             //                   ),
//                             //                 ),
//                             //                 TextSpan(
//                             //                   text: item.name,
//                             //                   style:const TextStyle(
//                             //                     color: Colors.black,
//                             //                     fontSize: 14,
//                             //                     fontWeight: FontWeight.bold,
//                             //                   ),
//                             //                 ),
//                             //               ],
//                             //             ),
//                             //           ),
//                             //         ),

//                             //         // Text(
//                             //         //   '₹${widget.amount}',
//                             //         //   style: const TextStyle(
//                             //         //     fontSize: 14,
//                             //         //     fontWeight: FontWeight.w500,
//                             //         //   ),
//                             //         // ),

//                             //         //  Text(
//                             //         //   '₹${widget.subtotal}',
//                             //         //   style: const TextStyle(
//                             //         //     fontSize: 14,
//                             //         //     fontWeight: FontWeight.w500,
//                             //         //   ),
//                             //         // ),

//                             //          Text(
//                             //           '₹${item.totalPrice}',
//                             //           style: const TextStyle(
//                             //             fontSize: 14,
//                             //             fontWeight: FontWeight.w500,
//                             //           ),
//                             //         ),
//                             //         // Text(
//                             //         //   '₹${(item.total).toStringAsFixed(2)}',
//                             //         //   style: const TextStyle(
//                             //         //     fontSize: 14,
//                             //         //     fontWeight: FontWeight.w500,
//                             //         //   ),
//                             //         // ),
//                             //       ],
//                             //     ),
//                             //   );
//                             // }).toList(),

//                             // Replace the existing cart items mapping section with this:
//                             ...cartProvider.cart.items.map((item) {
//                               return Padding(
//                                 padding: const EdgeInsets.only(bottom: 12),
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     // Product Image
//                                     Container(
//                                       width: 60,
//                                       height: 60,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(8),
//                                         color: Colors.grey.shade200,
//                                       ),
//                                       child: ClipRRect(
//                                         borderRadius: BorderRadius.circular(8),
//                                         child: item.images != null &&
//                                                 item.images!.isNotEmpty
//                                             ? Image.network(
//                                                 item.images[0],
//                                                 fit: BoxFit.cover,
//                                                 errorBuilder: (context, error,
//                                                     stackTrace) {
//                                                   return Icon(
//                                                     Icons.medication,
//                                                     color: Colors.grey.shade400,
//                                                     size: 30,
//                                                   );
//                                                 },
//                                               )
//                                             : Icon(
//                                                 Icons.medication,
//                                                 color: Colors.grey.shade400,
//                                                 size: 30,
//                                               ),
//                                       ),
//                                     ),
//                                     const SizedBox(width: 12),

//                                     // Product Details
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           RichText(
//                                             text: TextSpan(
//                                               children: [
//                                                 TextSpan(
//                                                   text: '${item.quantity}x ',
//                                                   style: const TextStyle(
//                                                     color: Colors.purple,
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 ),
//                                                 TextSpan(
//                                                   text: item.name,
//                                                   style: const TextStyle(
//                                                     color: Colors.black,
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           const SizedBox(height: 4),
//                                           Text(
//                                             '₹${item.totalPrice}',
//                                             style: const TextStyle(
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w500,
//                                               color: Colors.black87,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }).toList(),
//                           ],
//                         ),
//                       ),

//                       _buildOrderSummary(cartProvider),

//                       const SizedBox(height: 20),

//                       // Notes section
//                       const Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 16),
//                         child: Row(
//                           children: [
//                             Text(
//                               'Order Notes',
//                               style: TextStyle(
//                                 color: Color(0XFF000080),
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Container(
//                           height: 90,
//                           decoration: BoxDecoration(
//                             color: const Color(
//                                 0xFFF1F2F6), // light gray background
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: TextField(
//                             controller: _notesController,
//                             style: const TextStyle(
//                               fontSize: 15.5,
//                               color: Colors.black87,
//                             ),
//                             decoration: InputDecoration(
//                               hintText: 'Add notes about your order',
//                               hintStyle: TextStyle(
//                                 color: Colors.grey.shade600,
//                                 fontSize: 15.5,
//                               ),
//                               prefixIcon: Padding(
//                                 padding:
//                                     const EdgeInsets.only(left: 12, right: 8),
//                                 child: Icon(
//                                   Icons.edit_note,
//                                   color: Colors.grey.shade600,
//                                   size: 20,
//                                 ),
//                               ),
//                               prefixIconConstraints: const BoxConstraints(
//                                   minWidth: 36, minHeight: 36),
//                               border: InputBorder.none,
//                               contentPadding: const EdgeInsets.symmetric(
//                                   vertical: 14, horizontal: 0),
//                             ),
//                             onChanged: (value) {
//                               setState(() {});
//                             },
//                           ),
//                         ),
//                       ),

//                       // Payment methods
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 8),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Payment Method',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 12),
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(12),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.1),
//                                     spreadRadius: 1,
//                                     blurRadius: 2,
//                                     offset: const Offset(0, 1),
//                                   ),
//                                 ],
//                               ),
//                               child: Column(
//                                 children: List.generate(
//                                   paymentMethods.length,
//                                   (index) => RadioListTile(
//                                     title: Row(
//                                       children: [
//                                         Text(
//                                           paymentMethods[index]['name']
//                                               .toString(),
//                                           style: const TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                         const Spacer(),
//                                         _getPaymentIcon(index),
//                                       ],
//                                     ),
//                                     value: index,
//                                     groupValue: _selectedPaymentMethod,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         _selectedPaymentMethod = value as int;
//                                       });
//                                     },
//                                     activeColor: Colors.deepPurple,
//                                     contentPadding: const EdgeInsets.symmetric(
//                                         horizontal: 12, vertical: 2),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       const SizedBox(height: 20),
//                     ],
//                   ),
//                 ),
//               ),

//               // Proceed button with updated logic
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _isConfirmOrderEnabled() ? _confirmOrder : null,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: _isConfirmOrderEnabled()
//                           ? Color(0XFF5931DD)
//                           : Colors.grey.shade400,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: _isProcessingOrder || orderProvider.isCreatingOrder
//                         ? const Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                 width: 20,
//                                 height: 20,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                   valueColor: AlwaysStoppedAnimation<Color>(
//                                       Colors.white),
//                                 ),
//                               ),
//                               SizedBox(width: 12),
//                               Text(
//                                 'Processing Order...',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           )
//                         : Text(
//                             _getConfirmButtonText(cartProvider),
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   // Get confirm button text based on current state
//   String _getConfirmButtonText(CartProvider cartProvider) {
//     if (cartProvider.itemCount == 0) {
//       return 'Cart is Empty';
//     } else if (_selectedPaymentMethod == null) {
//       return 'Select Payment Method';
//     } else if (selectedAddressId == null || selectedAddressId!.isEmpty) {
//       return 'Select Delivery Address';
//     } else {
//       return 'Confirm Order - ₹${widget.amount}';

//       // return 'Confirm Order - ₹${cartProvider.totalAmount.toStringAsFixed(2)}';
//     }
//   }

//   // Add this widget method in your _PaymentScreenState class

//   Widget _buildOrderSummary(CartProvider cartProvider) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: const Color(0xFFEFF3F7),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Order Summary',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 12),
//           _buildSummaryRow(
//             'Total Items',
//             cartProvider.cart.totalItems.toString().padLeft(2, '0'),
//           ),
//           const SizedBox(height: 8),
//           _buildSummaryRow(
//             'Subtotal',
//             '₹${cartProvider.cart.subTotal.toStringAsFixed(2)}',
//           ),
//           const SizedBox(height: 8),
//           _buildSummaryRow(
//             'Platform Fee',
//             '₹${cartProvider.cart.platformFee.toStringAsFixed(2)}',
//           ),
//           const SizedBox(height: 8),
//           _buildSummaryRow(
//             'Delivery Charge',
//             '₹${cartProvider.cart.deliveryCharge.toStringAsFixed(2)}',
//           ),
//           const Divider(height: 24, thickness: 1),
//           _buildSummaryRow(
//             'Total Payable',
//             '₹${widget.amount}',
//             isTotal: true,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//             color: isTotal
//                 ? const Color(0xFF5931DD)
//                 : Colors.black.withOpacity(0.5),
//           ),
//         ),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: isTotal ? FontWeight.bold : FontWeight.bold,
//             color: isTotal ? const Color(0xFF5931DD) : Colors.black,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _getPaymentIcon(int index) {
//     switch (index) {
//       case 0: // Credit/Debit card
//         return Container(
//           width: 32,
//           height: 24,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(4),
//           ),
//           child: Image.asset(
//             'assets/icons/card.png',
//             fit: BoxFit.contain,
//           ),
//         );
//       case 1: // Cash on Delivery
//         return Container(
//           width: 24,
//           height: 24,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Image.asset(
//             'assets/icons/cash.png',
//             fit: BoxFit.contain,
//           ),
//         );
//       default:
//         return const SizedBox();
//     }
//   }
// }



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/providers/language_provider.dart';
import 'package:medical_user_app/providers/order_provider.dart';
import 'package:medical_user_app/providers/cart_provider.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';
import 'package:medical_user_app/view/booking_successfull_screen.dart';
import 'package:medical_user_app/view/payment_successfull_screeen.dart';
import 'package:medical_user_app/view/radar_animation_screen.dart';
import 'package:medical_user_app/view/card_details_screen.dart';
import 'package:medical_user_app/view/change_address_screen.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentScreen extends StatefulWidget {
  final String? subtotal;
  final String? amount;
  final String? coupouncode;
  const PaymentScreen({Key? key, this.amount, this.coupouncode, this.subtotal})
      : super(
          key: key,
        );

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int? _selectedPaymentMethod;
  final TextEditingController _notesController = TextEditingController();
  bool _isListening = false;
  String _transcription = '';
  bool _showNoteInput = false;
  bool _isProcessingOrder = false;

  String? userId;
  bool isLoading = true;

  // Razorpay instance
  late Razorpay razorpay;

  // Store selected address
  Map<String, dynamic>? selectedAddress;
  String displayAddress = ''; // Default address
  String? selectedAddressId; // Default address ID

  final paymentMethods = [
    {'name': 'Online', 'icon': Icons.credit_card, 'value': 'Credit/Debit Card'},
    {
      'name': 'Cash on Delivery',
      'icon': Icons.money,
      'value': 'Cash on Delivery'
    },
  ];

  @override
  void initState() {
    super.initState();
    // Initialize Razorpay
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);

    // Don't set default payment method - user must select one
    _selectedPaymentMethod = null;
    _initUserAndAddress();
  }

  @override
  void dispose() {
    _notesController.dispose();
    razorpay.clear(); // Clear razorpay listeners
    super.dispose();
  }

  Future<void> _saveSelectedAddress() async {
    if (selectedAddress != null && userId != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          '${userId}_selected_address_id', selectedAddressId ?? '');
      await prefs.setString('${userId}_display_address', displayAddress);
      await prefs.setString(
          '${userId}_selected_address_data', jsonEncode(selectedAddress));
    }
  }

  Future<void> _initUserAndAddress() async {
    await _loadUserId();
    if (userId != null) {
      await _restoreSelectedAddress();
    }
  }

  Future<void> _loadUserId() async {
    try {
      final storedUser = await SharedPreferencesHelper.getUser();
      setState(() {
        userId = storedUser?.id;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error loading user: $e');
    }
  }

  Future<void> _restoreSelectedAddress() async {
    if (userId == null) return;
    final prefs = await SharedPreferences.getInstance();
    final addressId = prefs.getString('${userId}_selected_address_id');
    final displayAddr = prefs.getString('${userId}_display_address');
    final addressData = prefs.getString('${userId}_selected_address_data');

    if (addressId != null &&
        addressId.isNotEmpty &&
        displayAddr != null &&
        addressData != null) {
      setState(() {
        selectedAddressId = addressId;
        displayAddress = displayAddr;
        selectedAddress = jsonDecode(addressData);
      });
    }
  }

  // Razorpay event handlers
  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    setState(() {
      _isProcessingOrder = false;
    });
    _showErrorSnackBar("Payment Failed: ${response.message}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    // Show non-dismissible loading dialog immediately after payment success
    _showLoadingDialog();

    // Payment successful, now process the order
    try {
      await _processOrder(response.paymentId);
    } catch (e) {
      // Hide loading dialog on error
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      setState(() {
        _isProcessingOrder = false;
      });
      _showErrorSnackBar("Order processing failed after payment: $e");
    }
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    _showErrorSnackBar("External wallet selected: ${response.walletName}");
  }

  // Method to initiate Razorpay payment
  void _initiateRazorpayPayment() {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    var options = {
      'key': 'rzp_test_BxtRNvflG06PTV',
      // 'amount': (cartProvider.totalAmount * 100).toInt(),
      'amount': (double.parse(widget.amount!) * 100).toInt(),
      'name': 'CLYNIX',
      'description': 'Medicine Order Payment',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': "8309056333",
        'email': "Simcurarx@gmail.com",
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      print("Opening Razorpay: $_selectedPaymentMethod");
      razorpay.open(options);
    } catch (e) {
      setState(() {
        _isProcessingOrder = false;
      });
      _showErrorSnackBar("Failed to open payment gateway: $e");
    }
  }

  // Method to build address string from selected address
  String _buildAddressString(Map<String, dynamic> address) {
    final house = address['house'] ?? '';
    final street = address['street'] ?? '';
    final city = address['city'] ?? '';
    final state = address['state'] ?? '';
    final pincode = address['pincode'] ?? '';

    List<String> parts = [];
    if (house.isNotEmpty) parts.add(house);
    if (street.isNotEmpty) parts.add(street);
    if (city.isNotEmpty) parts.add(city);
    if (state.isNotEmpty) parts.add(state);
    if (pincode.isNotEmpty) parts.add(pincode);

    return parts.isNotEmpty ? parts.join(', ') : 'Gandhi nagar,1-2-12';
  }

  void _navigateToChangeAddress() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (context) => const ChangeAddressScreen()),
    );

    if (result != null) {
      setState(() {
        selectedAddress = result;
        displayAddress = _buildAddressString(result);

        // Fix: Handle both saved addresses and map locations
        if (result['_id'] != null || result['id'] != null) {
          // This is a saved address from database
          selectedAddressId = result['_id'] ?? result['id'];
        } else if (result['latitude'] != null && result['longitude'] != null) {
          // This is a map location - generate a temporary ID or use coordinates
          selectedAddressId =
              'map_location_${result['latitude']}_${result['longitude']}';
        } else if (result['fullAddress'] != null) {
          // This is a map location with fullAddress
          selectedAddressId = 'map_location_temp';
        } else {
          selectedAddressId = 'temp_address';
        }
      });

      _saveSelectedAddress();

      print('Selected address ID: $selectedAddressId');
      print('Display address: $displayAddress');
    }
  }

  // Method to handle initial order confirmation (before payment)
  Future<void> _confirmOrder() async {
    if (_isProcessingOrder) return;

    // Check if payment method is selected
    if (_selectedPaymentMethod == null) {
      _showErrorSnackBar('Please select a payment method');
      return;
    }

    if (selectedAddressId == null || selectedAddressId!.isEmpty) {
      _showErrorSnackBar('Please select a valid address');
      return;
    }

    setState(() {
      _isProcessingOrder = true;
    });

    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    if (cartProvider.itemCount == 0) {
      _showErrorSnackBar('Your cart is empty');
      setState(() {
        _isProcessingOrder = false;
      });
      return;
    }

    try {
      if (_selectedPaymentMethod == 0) {
        // Online payment - initiate Razorpay
        // Loading will be shown after payment success in handlePaymentSuccessResponse
        _initiateRazorpayPayment();
      } else {
        // Cash on Delivery - show loading and process order directly
        _showLoadingDialog();
        await _processOrder(null);
      }
    } catch (e) {
      setState(() {
        _isProcessingOrder = false;
      });
      _showErrorSnackBar('An error occurred: $e');
    }
  }

  // Method to process the order (after payment or directly for COD)
  Future<void> _processOrder(String? paymentId) async {
    try {
      final orderProvider = Provider.of<OrderProvider>(context, listen: false);
      final cartProvider = Provider.of<CartProvider>(context, listen: false);

      // Validate order requirements
      if (orderProvider.currentUser == null) {
        _showErrorSnackBar('Please log in to place an order');
        setState(() {
          _isProcessingOrder = false;
        });
        return;
      }

      // Get selected payment method
      String paymentMethod =
          paymentMethods[_selectedPaymentMethod!]['value'].toString();

      // Create order using OrderProvider
      final order = await orderProvider.createOrder(
          addressId: selectedAddressId.toString(),
          notes: _notesController.text.trim(),
          voiceNoteUrl: '', // Add voice note URL if implemented
          paymentMethod: paymentMethod,
          paymentId: paymentId,
          coupon: widget.coupouncode);



            if (_selectedPaymentMethod == 1 && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }

      if (order != null) {
        // Order created successfully
        _showSuccessSnackBar('Order placed successfully!');

        // Clear cart after successful order
        await cartProvider.clearCart();

        // Navigate based on payment method
        if (_selectedPaymentMethod == 0) {
          // Online payment - Navigate to PaymentSuccessfullScreeen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentSuccessfullScreeen(
                orderId: order.id,
                orderAmount: order.totalAmount,
                paymentMethod: paymentMethod,
              ),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BookingSuccessfullScreen(
                orderId: order.id,
                orderAmount: order.totalAmount,
                paymentMethod: paymentMethod,
                addressId: selectedAddressId,
              ),
            ),
          );
        }
      } else {
        // Order creation failed
        String errorMsg = orderProvider.errorMessage ??
            'Payment processing failed. Please try again or use a different payment method';
        _showErrorSnackBar(errorMsg);
        setState(() {
          _isProcessingOrder = false;
        });
      }
    } catch (e) {
      // Hide loading dialog if still showing
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }

      print('Error processing order: $e');
      _showErrorSnackBar('An error occurred while placing the order');
      setState(() {
        _isProcessingOrder = false;
      });
    }
  }


      // Hide loading dialog
  //     if (Navigator.of(context).canPop()) {
  //       Navigator.of(context).pop();
  //     }

  //     if (order != null) {
  //       // Order created successfully
  //       _showSuccessSnackBar('Order placed successfully!');

  //       // Clear cart after successful order
  //       await cartProvider.clearCart();

  //       // Navigate directly to RadarAnimationScreen for both payment methods
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => RadarAnimationScreen(
  //               // orderId: order.id,
  //               // orderAmount: order.totalAmount,
  //               // paymentMethod: paymentMethod,
  //               // addressId: selectedAddressId,
  //               ),
  //         ),
  //       );
  //     } else {
  //       // Order creation failed
  //       String errorMsg = orderProvider.errorMessage ??
  //           'Payment processing failed. Please try again or use a different payment method';
  //       _showErrorSnackBar(errorMsg);
  //       setState(() {
  //         _isProcessingOrder = false;
  //       });
  //     }
  //   } catch (e) {
  //     // Hide loading dialog if still showing
  //     if (Navigator.of(context).canPop()) {
  //       Navigator.of(context).pop();
  //     }

  //     print('Error processing order: $e');
  //     _showErrorSnackBar('An error occurred while placing the order');
  //     setState(() {
  //       _isProcessingOrder = false;
  //     });
  //   }
  // }

  // Show non-dismissible loading dialog
  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // User cannot dismiss by tapping outside
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false, // Prevent back button
          child: Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0XFF5931DD)),
                    strokeWidth: 3,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Processing your order...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please wait, do not close the app',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Show success snackbar
  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Show error snackbar
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Check if confirm order button should be enabled
  bool _isConfirmOrderEnabled() {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return _selectedPaymentMethod != null &&
        !_isProcessingOrder &&
        cartProvider.itemCount > 0 &&
        (selectedAddressId != null && selectedAddressId!.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    print('coupoun code: ${widget.coupouncode}');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
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
      body: Consumer2<OrderProvider, CartProvider>(
        builder: (context, orderProvider, cartProvider, child) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Delivery address
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          title: const Text(
                            'Add Address',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  displayAddress,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          onTap: _navigateToChangeAddress,
                        ),
                      ),

                      const Divider(thickness: 1),

                      // Order details - Dynamic cart content
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Your Order',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                RichText(
                                  text: const TextSpan(
                                    children: [],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Cart items with images
                            ...cartProvider.cart.items.map((item) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Product Image
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey.shade200,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: item.images != null &&
                                                item.images!.isNotEmpty
                                            ? Image.network(
                                                item.images[0],
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Icon(
                                                    Icons.medication,
                                                    color: Colors.grey.shade400,
                                                    size: 30,
                                                  );
                                                },
                                              )
                                            : Icon(
                                                Icons.medication,
                                                color: Colors.grey.shade400,
                                                size: 30,
                                              ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),

                                    // Product Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: '${item.quantity}x ',
                                                  style: const TextStyle(
                                                    color: Colors.purple,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: item.name,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '₹${item.totalPrice}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),

                      _buildOrderSummary(cartProvider),

                      const SizedBox(height: 20),

                      // Notes section
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Text(
                              'Order Notes',
                              style: TextStyle(
                                color: Color(0XFF000080),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          height: 90,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F2F6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: _notesController,
                            style: const TextStyle(
                              fontSize: 15.5,
                              color: Colors.black87,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Add notes about your order',
                              hintStyle: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 15.5,
                              ),
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, right: 8),
                                child: Icon(
                                  Icons.edit_note,
                                  color: Colors.grey.shade600,
                                  size: 20,
                                ),
                              ),
                              prefixIconConstraints: const BoxConstraints(
                                  minWidth: 36, minHeight: 36),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 0),
                            ),
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                      ),

                      // Payment methods
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Payment Method',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: List.generate(
                                  paymentMethods.length,
                                  (index) => RadioListTile(
                                    title: Row(
                                      children: [
                                        Text(
                                          paymentMethods[index]['name']
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const Spacer(),
                                        _getPaymentIcon(index),
                                      ],
                                    ),
                                    value: index,
                                    groupValue: _selectedPaymentMethod,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedPaymentMethod = value as int;
                                      });
                                    },
                                    activeColor: Colors.deepPurple,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 2),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // Proceed button with updated logic
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isConfirmOrderEnabled() ? _confirmOrder : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isConfirmOrderEnabled()
                          ? Color(0XFF5931DD)
                          : Colors.grey.shade400,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isProcessingOrder || orderProvider.isCreatingOrder
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Processing Order...',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            _getConfirmButtonText(cartProvider),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Get confirm button text based on current state
  String _getConfirmButtonText(CartProvider cartProvider) {
    if (cartProvider.itemCount == 0) {
      return 'Cart is Empty';
    } else if (_selectedPaymentMethod == null) {
      return 'Select Payment Method';
    } else if (selectedAddressId == null || selectedAddressId!.isEmpty) {
      return 'Select Delivery Address';
    } else {
      return 'Confirm Order - ₹${widget.amount}';
    }
  }

  Widget _buildOrderSummary(CartProvider cartProvider) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF3F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(
            'Total Items',
            cartProvider.cart.totalItems.toString().padLeft(2, '0'),
          ),
          const SizedBox(height: 8),
          _buildSummaryRow(
            'Subtotal',
            '₹${cartProvider.cart.subTotal.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 8),
          _buildSummaryRow(
            'Platform Fee',
            '₹${cartProvider.cart.platformFee.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 8),
          _buildSummaryRow(
            'Delivery Charge',
            '₹${cartProvider.cart.deliveryCharge.toStringAsFixed(2)}',
          ),
          const Divider(height: 24, thickness: 1),
          _buildSummaryRow(
            'Total Payable',
            '₹${widget.amount}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal
                ? const Color(0xFF5931DD)
                : Colors.black.withOpacity(0.5),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.bold,
            color: isTotal ? const Color(0xFF5931DD) : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _getPaymentIcon(int index) {
    switch (index) {
      case 0: // Credit/Debit card
        return Container(
          width: 32,
          height: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Image.asset(
            'assets/icons/card.png',
            fit: BoxFit.contain,
          ),
        );
      case 1: // Cash on Delivery
        return Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset(
            'assets/icons/cash.png',
            fit: BoxFit.contain,
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
