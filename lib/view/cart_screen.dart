// // // // // // // Updated CartScreen with Provider Integration

// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:intl/intl.dart';
// // // // // // import 'package:medical_user_app/models/medicine_model.dart';
// // // // // // import 'package:medical_user_app/providers/language_provider.dart';
// // // // // // import 'package:medical_user_app/providers/cart_provider.dart';
// // // // // // import 'package:medical_user_app/models/cart_model.dart';
// // // // // // import 'package:medical_user_app/view/main_layout.dart';
// // // // // // import 'package:medical_user_app/view/near_pharmacy_screen.dart';
// // // // // // import 'package:medical_user_app/view/payment_screen.dart';
// // // // // // import 'package:medical_user_app/widgets/bottom_navigation.dart';
// // // // // // import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// // // // // // import 'package:provider/provider.dart';

// // // // // // class CartScreen extends StatefulWidget {
// // // // // //   final int? amount;
// // // // // //   const CartScreen({super.key, this.amount});

// // // // // //   @override
// // // // // //   State<CartScreen> createState() => _CartScreenState();
// // // // // // }

// // // // // // class _CartScreenState extends State<CartScreen> {
// // // // // //   bool isWeeklySelected = true;
// // // // // //   int selectedDateIndex = 0;
// // // // // //   List<String> dates = ["22 Mar", "22 Mar", "22 Mar", "22 Mar"];

// // // // // //   @override
// // // // // //   void initState() {
// // // // // //     super.initState();
// // // // // //     // Initialize cart when screen loads
// // // // // //     WidgetsBinding.instance.addPostFrameCallback((_) {
// // // // // //       Provider.of<CartProvider>(context, listen: false).initializeCart();
// // // // // //     });
// // // // // //   }

// // // // // //   double calculateSubtotal(CartProvider cartProvider) {
// // // // // //     double subtotal = 0.0;
// // // // // //     for (var item in cartProvider.cart.items) {
// // // // // //       // Use the item's price multiplied by quantity
// // // // // //       // If item has a price property, use it. Otherwise, use widget.amount as fallback
// // // // // //       double itemPrice = item.totalPrice ?? (widget.amount?.toDouble() ?? 0.0);
// // // // // //       subtotal += itemPrice * item.quantity;
// // // // // //     }
// // // // // //     return subtotal;
// // // // // //   }

// // // // // //   double calculateTotalPayable(CartProvider cartProvider) {
// // // // // //     double subtotal = calculateSubtotal(cartProvider);
// // // // // //     double platformFee = cartProvider.cart.platformFee;
// // // // // //     double deliveryCharge = cartProvider.cart.deliveryCharge;

// // // // // //     return subtotal + platformFee + deliveryCharge;
// // // // // //   }

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Scaffold(
// // // // // //       backgroundColor: Colors.grey[50],
// // // // // //       body: SafeArea(
// // // // // //         child: Consumer<CartProvider>(
// // // // // //           builder: (context, cartProvider, child) {
// // // // // //             if (cartProvider.isLoading) {
// // // // // //               return const Center(child: CircularProgressIndicator());
// // // // // //             }

// // // // // //             if (cartProvider.errorMessage != null) {
// // // // // //               return Center(
// // // // // //                 child: Column(
// // // // // //                   mainAxisAlignment: MainAxisAlignment.center,
// // // // // //                   children: [
// // // // // //                     Icon(
// // // // // //                       Icons.error_outline,
// // // // // //                       size: 64,
// // // // // //                       color: Colors.grey[400],
// // // // // //                     ),
// // // // // //                     const SizedBox(height: 16),
// // // // // //                     Text(
// // // // // //                       cartProvider.errorMessage!,
// // // // // //                       textAlign: TextAlign.center,
// // // // // //                       style: const TextStyle(
// // // // // //                         fontSize: 16,
// // // // // //                         color: Colors.grey,
// // // // // //                       ),
// // // // // //                     ),
// // // // // //                     const SizedBox(height: 16),
// // // // // //                     ElevatedButton(
// // // // // //                       onPressed: () {
// // // // // //                         cartProvider.clearError();
// // // // // //                         cartProvider.initializeCart();
// // // // // //                       },
// // // // // //                       child: const Text('Retry'),
// // // // // //                     ),
// // // // // //                   ],
// // // // // //                 ),
// // // // // //               );
// // // // // //             }

// // // // // //             if (cartProvider.isEmpty) {
// // // // // //               return Center(
// // // // // //                 child: Column(
// // // // // //                   mainAxisAlignment: MainAxisAlignment.center,
// // // // // //                   children: [
// // // // // //                     Icon(
// // // // // //                       Icons.shopping_cart_outlined,
// // // // // //                       size: 64,
// // // // // //                       color: Colors.grey[400],
// // // // // //                     ),
// // // // // //                     const SizedBox(height: 16),
// // // // // //                     const Text(
// // // // // //                       'Your cart is empty',
// // // // // //                       style: TextStyle(
// // // // // //                         fontSize: 18,
// // // // // //                         fontWeight: FontWeight.bold,
// // // // // //                         color: Colors.grey,
// // // // // //                       ),
// // // // // //                     ),
// // // // // //                     const SizedBox(height: 8),
// // // // // //                     const Text(
// // // // // //                       'Add some medicines to get started',
// // // // // //                       style: TextStyle(
// // // // // //                         fontSize: 14,
// // // // // //                         color: Colors.grey,
// // // // // //                       ),
// // // // // //                     ),
// // // // // //                     const SizedBox(height: 24),
// // // // // //                     ElevatedButton(
// // // // // //                       onPressed: () {
// // // // // //                         Navigator.push(
// // // // // //                             context,
// // // // // //                             MaterialPageRoute(
// // // // // //                                 builder: (context) => MainLayout()));
// // // // // //                       },
// // // // // //                       style: ElevatedButton.styleFrom(
// // // // // //                         backgroundColor: const Color(0xFF5931DD),
// // // // // //                         shape: RoundedRectangleBorder(
// // // // // //                           borderRadius: BorderRadius.circular(8),
// // // // // //                         ),
// // // // // //                       ),
// // // // // //                       child: const Text(
// // // // // //                         'Continue Shopping',
// // // // // //                         style: TextStyle(color: Colors.white),
// // // // // //                       ),
// // // // // //                     ),
// // // // // //                   ],
// // // // // //                 ),
// // // // // //               );
// // // // // //             }

// // // // // //             return Column(
// // // // // //               children: [
// // // // // //                 Expanded(
// // // // // //                   child: SingleChildScrollView(
// // // // // //                     child: Padding(
// // // // // //                       padding: const EdgeInsets.all(16.0),
// // // // // //                       child: Column(
// // // // // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //                         children: [
// // // // // //                           const SizedBox(height: 10),
// // // // // //                           Row(
// // // // // //                             children: [
// // // // // //                               Container(
// // // // // //                                 width: 48,
// // // // // //                                 height: 48,
// // // // // //                                 decoration: BoxDecoration(
// // // // // //                                     color: const Color(0XFFEFF3F7),
// // // // // //                                     borderRadius: BorderRadius.circular(48)),
// // // // // //                                 child: const Icon(Icons.shopping_cart),
// // // // // //                               ),
// // // // // //                               const SizedBox(width: 10),
// // // // // //                               const AppText(
// // // // // //                                 "my_cart",
// // // // // //                                 style: TextStyle(
// // // // // //                                     fontSize: 20, fontWeight: FontWeight.bold),
// // // // // //                               ),
// // // // // //                               const Spacer(),
// // // // // //                               // Text(
// // // // // //                               //   '${cartProvider.itemCount} items',
// // // // // //                               //   style: const TextStyle(
// // // // // //                               //     fontSize: 14,
// // // // // //                               //     color: Colors.grey,
// // // // // //                               //   ),
// // // // // //                               // ),
// // // // // //                             ],
// // // // // //                           ),
// // // // // //                           const SizedBox(height: 34),
// // // // // //                           _buildMedicationList(cartProvider),
// // // // // //                           const SizedBox(height: 34),
// // // // // //                           _buildCouponInputField(),
// // // // // //                           const SizedBox(height: 34),
// // // // // //                           _buildCheckoutContainer(cartProvider),
// // // // // //                         ],
// // // // // //                       ),
// // // // // //                     ),
// // // // // //                   ),
// // // // // //                 ),
// // // // // //                 _buildCheckoutButton(cartProvider),
// // // // // //                 const SizedBox(height: 40),
// // // // // //               ],
// // // // // //             );
// // // // // //           },
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   Future<void> _selectFromCalendar({required bool isStartDate}) async {
// // // // // //     final DateTime today = DateTime.now();
// // // // // //     final DateTime? picked = await showDatePicker(
// // // // // //       context: context,
// // // // // //       initialDate: today,
// // // // // //       firstDate: today,
// // // // // //       lastDate: DateTime(today.year + 1),
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _buildFrequencyToggle() {
// // // // // //     return Container(
// // // // // //       decoration: const BoxDecoration(
// // // // // //         color: Color.fromARGB(
// // // // // //             255, 237, 234, 245), // Light violet color for center background
// // // // // //         borderRadius: BorderRadius.horizontal(
// // // // // //           left: Radius.circular(24),
// // // // // //           right: Radius.circular(24),
// // // // // //         ),
// // // // // //       ),
// // // // // //       width: double.infinity,
// // // // // //       child: Row(
// // // // // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // // //         children: [
// // // // // //           InkWell(
// // // // // //             onTap: () {
// // // // // //               setState(() {
// // // // // //                 isWeeklySelected = true;
// // // // // //               });
// // // // // //             },
// // // // // //             child: Container(
// // // // // //               height: 48,
// // // // // //               width: 166,
// // // // // //               decoration: BoxDecoration(
// // // // // //                 color: isWeeklySelected
// // // // // //                     ? const Color(0xFF5931DD)
// // // // // //                     : Colors.transparent,
// // // // // //                 borderRadius: const BorderRadius.horizontal(
// // // // // //                   left: Radius.circular(24),
// // // // // //                   right: Radius.circular(24),
// // // // // //                 ),
// // // // // //                 border: Border.all(
// // // // // //                   color: const Color(0xFF5931DD),
// // // // // //                   width: 1,
// // // // // //                 ),
// // // // // //               ),
// // // // // //               alignment: Alignment.center,
// // // // // //               child: Text(
// // // // // //                 'Weekly',
// // // // // //                 style: TextStyle(
// // // // // //                   color: isWeeklySelected ? Colors.white : Colors.black,
// // // // // //                   fontWeight: FontWeight.w500,
// // // // // //                 ),
// // // // // //               ),
// // // // // //             ),
// // // // // //           ),
// // // // // //           InkWell(
// // // // // //             onTap: () {
// // // // // //               setState(() {
// // // // // //                 isWeeklySelected = false;
// // // // // //               });
// // // // // //             },
// // // // // //             child: Container(
// // // // // //               height: 48,
// // // // // //               width: 166,
// // // // // //               decoration: BoxDecoration(
// // // // // //                 color: !isWeeklySelected
// // // // // //                     ? const Color(0xFF5931DD)
// // // // // //                     : Colors.transparent,
// // // // // //                 borderRadius: const BorderRadius.horizontal(
// // // // // //                   left: Radius.circular(24),
// // // // // //                   right: Radius.circular(24),
// // // // // //                 ),
// // // // // //                 border: Border.all(
// // // // // //                   color: const Color(0xFF5931DD),
// // // // // //                   width: 1,
// // // // // //                 ),
// // // // // //               ),
// // // // // //               alignment: Alignment.center,
// // // // // //               child: Text(
// // // // // //                 'Monthly',
// // // // // //                 style: TextStyle(
// // // // // //                   color: !isWeeklySelected ? Colors.white : Colors.black,
// // // // // //                   fontWeight: FontWeight.w500,
// // // // // //                 ),
// // // // // //               ),
// // // // // //             ),
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _buildMedicationList(CartProvider cartProvider) {
// // // // // //     final items = cartProvider.cart.items;

// // // // // //     if (items.isEmpty) {
// // // // // //       return const Center(
// // // // // //         child: Text(
// // // // // //           'No items in cart',
// // // // // //           style: TextStyle(
// // // // // //             fontSize: 16,
// // // // // //             color: Colors.grey,
// // // // // //           ),
// // // // // //         ),
// // // // // //       );
// // // // // //     }

// // // // // //     return Column(
// // // // // //       children: List.generate(
// // // // // //         items.length * 2 - 1,
// // // // // //         (i) {
// // // // // //           if (i.isEven) {
// // // // // //             final item = items[i ~/ 2];
// // // // // //             return _buildMedicationItem(item, cartProvider);
// // // // // //           } else {
// // // // // //             return const Divider(
// // // // // //               color: Color.fromARGB(255, 221, 221, 221),
// // // // // //               height: 1,
// // // // // //               thickness: 1,
// // // // // //             );
// // // // // //           }
// // // // // //         },
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _buildMedicationItem(CartItem item, CartProvider cartProvider) {
// // // // // //     final cart = cartProvider.cart;

// // // // // //     return Container(
// // // // // //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// // // // // //       child: Row(
// // // // // //         children: [
// // // // // //           Container(
// // // // // //             width: 60,
// // // // // //             height: 60,
// // // // // //             decoration: BoxDecoration(
// // // // // //               color: Colors.blue.shade100,
// // // // // //               borderRadius: BorderRadius.circular(8),
// // // // // //             ),
// // // // // //             child: item.images.isNotEmpty
// // // // // //                 ? ClipRRect(
// // // // // //                     borderRadius: BorderRadius.circular(8),
// // // // // //                     child: Image.network(
// // // // // //                       item.images.first,
// // // // // //                       fit: BoxFit.cover,
// // // // // //                       errorBuilder: (context, error, stackTrace) {
// // // // // //                         return Image.asset(
// // // // // //                           'assets/tablet.png',
// // // // // //                           fit: BoxFit.cover,
// // // // // //                         );
// // // // // //                       },
// // // // // //                     ),
// // // // // //                   )
// // // // // //                 : Image.asset(
// // // // // //                     'assets/tablet.png',
// // // // // //                     fit: BoxFit.cover,
// // // // // //                   ),
// // // // // //           ),
// // // // // //           const SizedBox(width: 12),
// // // // // //           Expanded(
// // // // // //             child: Column(
// // // // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //               children: [
// // // // // //                 Text(
// // // // // //                   item.name,
// // // // // //                   style: const TextStyle(
// // // // // //                     fontWeight: FontWeight.bold,
// // // // // //                     fontSize: 14,
// // // // // //                   ),
// // // // // //                 ),
// // // // // //                 // Text(
// // // // // //                 //   'Price: ₹${widget.amount ?? 100}',
// // // // // //                 //   style: TextStyle(
// // // // // //                 //     fontSize: 12,
// // // // // //                 //     color: Colors.grey.shade600,
// // // // // //                 //   ),
// // // // // //                 // )

// // // // // //                 // Text(
// // // // // //                 //   'Price: ₹${cart.subTotal}',
// // // // // //                 //   style: TextStyle(
// // // // // //                 //     fontSize: 12,
// // // // // //                 //     color: Colors.grey.shade600,
// // // // // //                 //   ),
// // // // // //                 // )

// // // // // //                 Text(
// // // // // //                   'Price: ₹${item.price}',
// // // // // //                   style: TextStyle(
// // // // // //                     fontSize: 12,
// // // // // //                     color: Colors.grey.shade600,
// // // // // //                   ),
// // // // // //                 )

// // // // // //                 //  Text(
// // // // // //                 //   'Price: ₹${item.totalPrice}',
// // // // // //                 //   style: TextStyle(
// // // // // //                 //     fontSize: 12,
// // // // // //                 //     color: Colors.grey.shade600,
// // // // // //                 //   ),
// // // // // //                 // )

// // // // // //                 // Text(
// // // // // //                 //   'Total: ₹${item.total.toStringAsFixed(2)}',
// // // // // //                 //   style: TextStyle(
// // // // // //                 //     fontSize: 12,
// // // // // //                 //     color: Colors.grey.shade600,
// // // // // //                 //     fontWeight: FontWeight.w500,
// // // // // //                 //   ),
// // // // // //                 // ),
// // // // // //               ],
// // // // // //             ),
// // // // // //           ),
// // // // // //           Row(
// // // // // //             children: [
// // // // // //               Container(
// // // // // //                 width: 24,
// // // // // //                 height: 24,
// // // // // //                 decoration: BoxDecoration(
// // // // // //                   color: const Color.fromARGB(255, 221, 221, 221),
// // // // // //                   borderRadius: BorderRadius.circular(12),
// // // // // //                 ),
// // // // // //                 child: IconButton(
// // // // // //                   icon: const Icon(Icons.remove, size: 20),
// // // // // //                   onPressed: item.quantity <= 1
// // // // // //                       ? null
// // // // // //                       : () async {
// // // // // //                           await cartProvider.decreaseQuantity(item.medicineId);
// // // // // //                         },
// // // // // //                   padding: EdgeInsets.zero,
// // // // // //                   constraints: const BoxConstraints(),
// // // // // //                 ),
// // // // // //               ),
// // // // // //               const SizedBox(width: 8),
// // // // // //               Text(
// // // // // //                 '${item.quantity.toString().padLeft(2, '0')}',
// // // // // //                 style: const TextStyle(fontWeight: FontWeight.bold),
// // // // // //               ),
// // // // // //               const SizedBox(width: 8),
// // // // // //               Container(
// // // // // //                 width: 24,
// // // // // //                 height: 24,
// // // // // //                 decoration: BoxDecoration(
// // // // // //                   color: const Color(0xFF5931DD),
// // // // // //                   borderRadius: BorderRadius.circular(12),
// // // // // //                 ),
// // // // // //                 child: IconButton(
// // // // // //                   icon: const Icon(Icons.add, size: 16, color: Colors.white),
// // // // // //                   onPressed: () async {
// // // // // //                     await cartProvider.increaseQuantity(item.medicineId);
// // // // // //                   },
// // // // // //                   padding: EdgeInsets.zero,
// // // // // //                   constraints: const BoxConstraints(),
// // // // // //                 ),
// // // // // //               ),
// // // // // //               const SizedBox(width: 25),
// // // // // //               Container(
// // // // // //                 width: 24,
// // // // // //                 height: 24,
// // // // // //                 decoration: BoxDecoration(
// // // // // //                   border: Border.all(
// // // // // //                       color: const Color.fromARGB(255, 221, 221, 221)),
// // // // // //                   color: const Color.fromARGB(255, 255, 255, 255),
// // // // // //                   borderRadius: BorderRadius.circular(12),
// // // // // //                 ),
// // // // // //                 child: IconButton(
// // // // // //                   icon: Icon(MdiIcons.trashCanOutline,
// // // // // //                       color: Colors.red.shade400, size: 20),
// // // // // //                   onPressed: () async {
// // // // // //                     // Show confirmation dialog
// // // // // //                     final confirm = await showDialog<bool>(
// // // // // //                       context: context,
// // // // // //                       builder: (context) => AlertDialog(
// // // // // //                         title: const Text('Remove Item'),
// // // // // //                         content: Text('Remove ${item.name} from cart?'),
// // // // // //                         actions: [
// // // // // //                           TextButton(
// // // // // //                             onPressed: () => Navigator.pop(context, false),
// // // // // //                             child: const Text('Cancel'),
// // // // // //                           ),
// // // // // //                           TextButton(
// // // // // //                             onPressed: () => Navigator.pop(context, true),
// // // // // //                             child: const Text(
// // // // // //                               'Remove',
// // // // // //                               style: TextStyle(color: Colors.red),
// // // // // //                             ),
// // // // // //                           ),
// // // // // //                         ],
// // // // // //                       ),
// // // // // //                     );

// // // // // //                     if (confirm == true) {
// // // // // //                       await cartProvider.removeFromCart(item.medicineId);
// // // // // //                     }
// // // // // //                   },
// // // // // //                   padding: EdgeInsets.zero,
// // // // // //                   constraints: const BoxConstraints(),
// // // // // //                 ),
// // // // // //               ),
// // // // // //             ],
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _buildDateSelector() {
// // // // // //     return Column(
// // // // // //       crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //       children: [
// // // // // //         const Text(
// // // // // //           'Select Date For Meds Delivery',
// // // // // //           style: TextStyle(
// // // // // //             fontWeight: FontWeight.bold,
// // // // // //             fontSize: 16,
// // // // // //           ),
// // // // // //         ),
// // // // // //         const SizedBox(height: 12),
// // // // // //         Row(
// // // // // //           children: List.generate(
// // // // // //             dates.length,
// // // // // //             (index) => Expanded(
// // // // // //               child: GestureDetector(
// // // // // //                 onTap: () {
// // // // // //                   setState(() {
// // // // // //                     selectedDateIndex = index;
// // // // // //                   });
// // // // // //                 },
// // // // // //                 child: Container(
// // // // // //                   margin: const EdgeInsets.symmetric(horizontal: 4),
// // // // // //                   decoration: BoxDecoration(
// // // // // //                     border: Border.all(
// // // // // //                       color: selectedDateIndex == index
// // // // // //                           ? const Color(0xFF5931DD)
// // // // // //                           : Colors.grey.shade300,
// // // // // //                     ),
// // // // // //                     borderRadius: BorderRadius.circular(8),
// // // // // //                   ),
// // // // // //                   child: Column(
// // // // // //                     children: [
// // // // // //                       Container(
// // // // // //                         padding: const EdgeInsets.symmetric(vertical: 8),
// // // // // //                         decoration: BoxDecoration(
// // // // // //                           color: selectedDateIndex == index
// // // // // //                               ? const Color(0xFF5931DD)
// // // // // //                               : Colors.grey.shade100,
// // // // // //                           borderRadius: const BorderRadius.vertical(
// // // // // //                             top: Radius.circular(8),
// // // // // //                           ),
// // // // // //                         ),
// // // // // //                         alignment: Alignment.center,
// // // // // //                         child: Text(
// // // // // //                           dates[index].split(' ')[0],
// // // // // //                           style: TextStyle(
// // // // // //                             fontWeight: FontWeight.bold,
// // // // // //                             color: selectedDateIndex == index
// // // // // //                                 ? Colors.white
// // // // // //                                 : Colors.black,
// // // // // //                           ),
// // // // // //                         ),
// // // // // //                       ),
// // // // // //                       Padding(
// // // // // //                         padding: const EdgeInsets.symmetric(vertical: 8),
// // // // // //                         child: Text(
// // // // // //                           dates[index].split(' ')[1],
// // // // // //                           style: const TextStyle(
// // // // // //                             fontSize: 12,
// // // // // //                           ),
// // // // // //                         ),
// // // // // //                       ),
// // // // // //                     ],
// // // // // //                   ),
// // // // // //                 ),
// // // // // //               ),
// // // // // //             ),
// // // // // //           ),
// // // // // //         ),
// // // // // //       ],
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _buildCouponInputField() {
// // // // // //     return Container(
// // // // // //       padding: const EdgeInsets.symmetric(horizontal: 12),
// // // // // //       decoration: BoxDecoration(
// // // // // //         color: Colors.grey.shade100,
// // // // // //         borderRadius: BorderRadius.circular(12),
// // // // // //       ),
// // // // // //       child: Row(
// // // // // //         children: [
// // // // // //           Expanded(
// // // // // //             child: TextField(
// // // // // //               decoration: InputDecoration(
// // // // // //                 hintText: AppText.translate(context, 'enter_coupon'),
// // // // // //                 border: InputBorder.none,
// // // // // //               ),
// // // // // //             ),
// // // // // //           ),
// // // // // //           Container(
// // // // // //             height: 48,
// // // // // //             width: 48,
// // // // // //             decoration: BoxDecoration(
// // // // // //               color: const Color(0xFF6C4DFF),
// // // // // //               borderRadius: BorderRadius.circular(12),
// // // // // //             ),
// // // // // //             child: IconButton(
// // // // // //               icon: const Icon(Icons.arrow_forward, color: Colors.white),
// // // // // //               onPressed: () {
// // // // // //                 // Handle coupon submission here
// // // // // //                 // ScaffoldMessenger.of(context).showSnackBar(
// // // // // //                 //   const SnackBar(
// // // // // //                 //     content: Text('Coupon feature coming soon!'),
// // // // // //                 //     duration: Duration(seconds: 2),
// // // // // //                 //   ),
// // // // // //                 // );
// // // // // //               },
// // // // // //             ),
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _buildCheckoutButton(CartProvider cartProvider) {
// // // // // //     return Padding(
// // // // // //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // // // // //       child: SizedBox(
// // // // // //         width: double.infinity,
// // // // // //         height: 50,
// // // // // //         child: ElevatedButton(
// // // // // //           onPressed: cartProvider.isEmpty || cartProvider.isLoading
// // // // // //               ? null
// // // // // //               : () {
// // // // // //                   Navigator.push(
// // // // // //                     context,
// // // // // //                     MaterialPageRoute(
// // // // // //                         builder: (context) => PaymentScreen(
// // // // // //                               amount: cartProvider.cart.totalPayable.toString(),
// // // // // //                             )),
// // // // // //                   );
// // // // // //                 },
// // // // // //           style: ElevatedButton.styleFrom(
// // // // // //             backgroundColor: const Color(0xFF5931DD),
// // // // // //             shape: RoundedRectangleBorder(
// // // // // //               borderRadius: BorderRadius.circular(8),
// // // // // //             ),
// // // // // //           ),
// // // // // //           child: cartProvider.isLoading
// // // // // //               ? const SizedBox(
// // // // // //                   width: 20,
// // // // // //                   height: 20,
// // // // // //                   child: CircularProgressIndicator(
// // // // // //                     strokeWidth: 2,
// // // // // //                     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
// // // // // //                   ),
// // // // // //                 )
// // // // // //               : AppText(
// // // // // //                   'checkout',
// // // // // //                   style: TextStyle(
// // // // // //                     fontSize: 18,
// // // // // //                     fontWeight: FontWeight.bold,
// // // // // //                     color: cartProvider.isEmpty ? Colors.grey : Colors.white,
// // // // // //                   ),
// // // // // //                 ),
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _buildBottomNavPlaceholder() {
// // // // // //     return Container(
// // // // // //       padding: const EdgeInsets.symmetric(vertical: 12),
// // // // // //       decoration: const BoxDecoration(
// // // // // //         color: Colors.white,
// // // // // //         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
// // // // // //       ),
// // // // // //       child: Row(
// // // // // //         mainAxisAlignment: MainAxisAlignment.center,
// // // // // //         children: [
// // // // // //           IconButton(
// // // // // //             icon: const Icon(Icons.home_outlined, color: Colors.grey),
// // // // // //             onPressed: () {},
// // // // // //           ),
// // // // // //           const SizedBox(width: 24),
// // // // // //           Container(
// // // // // //             padding: const EdgeInsets.all(12),
// // // // // //             decoration: BoxDecoration(
// // // // // //               color: const Color(0xFF5931DD),
// // // // // //               borderRadius: BorderRadius.circular(8),
// // // // // //             ),
// // // // // //             child:
// // // // // //                 const Icon(Icons.shopping_cart_outlined, color: Colors.white),
// // // // // //           ),
// // // // // //           const SizedBox(width: 24),
// // // // // //           IconButton(
// // // // // //             icon: const Icon(Icons.shopping_cart_outlined, color: Colors.grey),
// // // // // //             onPressed: () {},
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _buildCheckoutContainer(CartProvider cartProvider) {
// // // // // //     final cart = cartProvider.cart;
// // // // // //     // final subtotal = calculateSubtotal(cartProvider);
// // // // // //     // final totalPayable = calculateTotalPayable(cartProvider);

// // // // // //     return Container(
// // // // // //       width: 343,
// // // // // //       padding: const EdgeInsets.all(16),
// // // // // //       decoration: BoxDecoration(
// // // // // //         color: const Color(0xFFEFF3F7),
// // // // // //         borderRadius: BorderRadius.circular(12),
// // // // // //       ),
// // // // // //       child: Column(
// // // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //         children: [
// // // // // //           _buildPriceRow(
// // // // // //               'total_items', '${cart.totalItems.toString().padLeft(2, '0')}'),
// // // // // //           const SizedBox(height: 8),
// // // // // //           _buildPriceRow('sub_total', '₹${cart.subTotal}'),
// // // // // //           const SizedBox(height: 8),
// // // // // //           _buildPriceRow(
// // // // // //               'platform_fee', '₹${cart.platformFee.toStringAsFixed(2)}'),
// // // // // //           const SizedBox(height: 8),
// // // // // //           _buildPriceRow(
// // // // // //               'delivery_charge', '₹${cart.deliveryCharge.toStringAsFixed(2)}'),
// // // // // //           const Divider(height: 24, thickness: 1),
// // // // // //           _buildPriceRow(
// // // // // //               'total_payable', '₹${cart.totalPayable.toStringAsFixed(2)}',
// // // // // //               isTotal: true),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
// // // // // //     return Row(
// // // // // //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // // //       children: [
// // // // // //         AppText(
// // // // // //           label,
// // // // // //           style: TextStyle(
// // // // // //             fontSize: 14,
// // // // // //             fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
// // // // // //             color: isTotal
// // // // // //                 ? const Color(0xFF5931DD)
// // // // // //                 : Colors.black.withOpacity(0.5),
// // // // // //           ),
// // // // // //         ),
// // // // // //         Text(
// // // // // //           value,
// // // // // //           style: TextStyle(
// // // // // //             fontSize: 14,
// // // // // //             fontWeight: isTotal ? FontWeight.bold : FontWeight.bold,
// // // // // //             color: isTotal ? const Color(0xFF5931DD) : Colors.black,
// // // // // //           ),
// // // // // //         ),
// // // // // //       ],
// // // // // //     );
// // // // // //   }
// // // // // // }

// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:intl/intl.dart';
// // // // // import 'package:medical_user_app/models/medicine_model.dart';
// // // // // import 'package:medical_user_app/providers/language_provider.dart';
// // // // // import 'package:medical_user_app/providers/cart_provider.dart';
// // // // // import 'package:medical_user_app/models/cart_model.dart';
// // // // // import 'package:medical_user_app/view/main_layout.dart';
// // // // // import 'package:medical_user_app/view/near_pharmacy_screen.dart';
// // // // // import 'package:medical_user_app/view/payment_screen.dart';
// // // // // import 'package:medical_user_app/widgets/bottom_navigation.dart';
// // // // // import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// // // // // import 'package:provider/provider.dart';
// // // // // import 'package:http/http.dart' as http;
// // // // // import 'dart:convert';

// // // // // class CartScreen extends StatefulWidget {
// // // // //   final int? amount;
// // // // //   const CartScreen({super.key, this.amount});

// // // // //   @override
// // // // //   State<CartScreen> createState() => _CartScreenState();
// // // // // }

// // // // // class _CartScreenState extends State<CartScreen> {
// // // // //   bool isWeeklySelected = true;
// // // // //   int selectedDateIndex = 0;
// // // // //   List<String> dates = ["22 Mar", "22 Mar", "22 Mar", "22 Mar"];

// // // // //   TextEditingController couponController = TextEditingController();
// // // // //   List<dynamic> coupons = [];
// // // // //   bool isLoadingCoupons = false;
// // // // //   String? appliedCoupon;
// // // // //   double discountAmount = 0.0;

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     WidgetsBinding.instance.addPostFrameCallback((_) {
// // // // //       Provider.of<CartProvider>(context, listen: false).initializeCart();
// // // // //     });
// // // // //   }

// // // // //   Future<void> fetchCoupons() async {
// // // // //     setState(() {
// // // // //       isLoadingCoupons = true;
// // // // //     });

// // // // //     try {
// // // // //       final response = await http.get(
// // // // //         Uri.parse('http://31.97.206.144:7021/api/admin/getcoupons'),
// // // // //         headers: {'Content-Type': 'application/json'},
// // // // //       ).timeout(const Duration(seconds: 10));

// // // // //       print('response status codeeeeeeeeeeeeeeeee ${response.statusCode}');
// // // // //             print('response bodyyyyyyyyyyyyyyyy ${response.body}');

// // // // //       if (response.statusCode == 200) {
// // // // //         final data = jsonDecode(response.body);
// // // // //         setState(() {
// // // // //           coupons = data['coupons'] ?? [];
// // // // //         });

// // // // //         if (coupons.isEmpty) {
// // // // //           ScaffoldMessenger.of(context).showSnackBar(
// // // // //             const SnackBar(
// // // // //               content: Text('No coupons available'),
// // // // //               duration: Duration(seconds: 2),
// // // // //             ),
// // // // //           );
// // // // //         }
// // // // //       } else {
// // // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // // //           const SnackBar(
// // // // //             content: Text('Failed to fetch coupons'),
// // // // //             duration: Duration(seconds: 2),
// // // // //           ),
// // // // //         );
// // // // //       }
// // // // //     } catch (e) {
// // // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // // //         SnackBar(
// // // // //           content: Text('Error: $e'),
// // // // //           duration: const Duration(seconds: 2),
// // // // //         ),
// // // // //       );
// // // // //     } finally {
// // // // //       setState(() {
// // // // //         isLoadingCoupons = false;
// // // // //       });
// // // // //     }
// // // // //   }

// // // // //   bool isCouponValid(dynamic coupon) {
// // // // //     final expirationDate =
// // // // //         DateTime.parse(coupon['expirationDate'].toString());
// // // // //     return expirationDate.isAfter(DateTime.now());
// // // // //   }

// // // // //   void applyCoupon(String couponCode) {
// // // // //     try {
// // // // //       final coupon = coupons.firstWhere(
// // // // //         (c) => c['couponCode'].toString().toLowerCase() == couponCode.toLowerCase(),
// // // // //         orElse: () => null,
// // // // //       );

// // // // //       if (coupon == null) {
// // // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // // //           const SnackBar(
// // // // //             content: Text('Coupon not found'),
// // // // //             duration: Duration(seconds: 2),
// // // // //           ),
// // // // //         );
// // // // //         return;
// // // // //       }

// // // // //       if (!isCouponValid(coupon)) {
// // // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // // //           const SnackBar(
// // // // //             content: Text('Coupon has expired'),
// // // // //             duration: Duration(seconds: 2),
// // // // //           ),
// // // // //         );
// // // // //         return;
// // // // //       }

// // // // //       final cartProvider = Provider.of<CartProvider>(context, listen: false);
// // // // //       final discount = (cartProvider.cart.subTotal *
// // // // //               (coupon['discountPercentage'] as num).toDouble() /
// // // // //               100)
// // // // //           .toStringAsFixed(2);

// // // // //       setState(() {
// // // // //         appliedCoupon = couponCode;
// // // // //         discountAmount = double.parse(discount);
// // // // //       });

// // // // //       couponController.clear();

// // // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // // //         SnackBar(
// // // // //           content: Text(
// // // // //               'Coupon applied! Discount: ₹${discountAmount.toStringAsFixed(2)}'),
// // // // //           duration: const Duration(seconds: 2),
// // // // //           backgroundColor: Colors.green,
// // // // //         ),
// // // // //       );
// // // // //     } catch (e) {
// // // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // // //         SnackBar(
// // // // //           content: Text('Error applying coupon: $e'),
// // // // //           duration: const Duration(seconds: 2),
// // // // //         ),
// // // // //       );
// // // // //     }
// // // // //   }

// // // // //   void removeCoupon() {
// // // // //     setState(() {
// // // // //       appliedCoupon = null;
// // // // //       discountAmount = 0.0;
// // // // //     });

// // // // //     ScaffoldMessenger.of(context).showSnackBar(
// // // // //       const SnackBar(
// // // // //         content: Text('Coupon removed'),
// // // // //         duration: Duration(seconds: 1),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   double calculateSubtotal(CartProvider cartProvider) {
// // // // //     double subtotal = 0.0;
// // // // //     for (var item in cartProvider.cart.items) {
// // // // //       double itemPrice = item.totalPrice ?? (widget.amount?.toDouble() ?? 0.0);
// // // // //       subtotal += itemPrice * item.quantity;
// // // // //     }
// // // // //     return subtotal;
// // // // //   }

// // // // //   double calculateTotalPayable(CartProvider cartProvider) {
// // // // //     double subtotal = calculateSubtotal(cartProvider);
// // // // //     double platformFee = cartProvider.cart.platformFee;
// // // // //     double deliveryCharge = cartProvider.cart.deliveryCharge;
// // // // //     double afterDiscount = subtotal + platformFee + deliveryCharge - discountAmount;

// // // // //     return afterDiscount < 0 ? 0 : afterDiscount;
// // // // //   }

// // // // //   @override
// // // // //   void dispose() {
// // // // //     couponController.dispose();
// // // // //     super.dispose();
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       backgroundColor: Colors.grey[50],
// // // // //       body: SafeArea(
// // // // //         child: Consumer<CartProvider>(
// // // // //           builder: (context, cartProvider, child) {
// // // // //             if (cartProvider.isLoading) {
// // // // //               return const Center(child: CircularProgressIndicator());
// // // // //             }

// // // // //             if (cartProvider.errorMessage != null) {
// // // // //               return Center(
// // // // //                 child: Column(
// // // // //                   mainAxisAlignment: MainAxisAlignment.center,
// // // // //                   children: [
// // // // //                     Icon(
// // // // //                       Icons.error_outline,
// // // // //                       size: 64,
// // // // //                       color: Colors.grey[400],
// // // // //                     ),
// // // // //                     const SizedBox(height: 16),
// // // // //                     Text(
// // // // //                       cartProvider.errorMessage!,
// // // // //                       textAlign: TextAlign.center,
// // // // //                       style: const TextStyle(
// // // // //                         fontSize: 16,
// // // // //                         color: Colors.grey,
// // // // //                       ),
// // // // //                     ),
// // // // //                     const SizedBox(height: 16),
// // // // //                     ElevatedButton(
// // // // //                       onPressed: () {
// // // // //                         cartProvider.clearError();
// // // // //                         cartProvider.initializeCart();
// // // // //                       },
// // // // //                       child: const Text('Retry'),
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),
// // // // //               );
// // // // //             }

// // // // //             if (cartProvider.isEmpty) {
// // // // //               return Center(
// // // // //                 child: Column(
// // // // //                   mainAxisAlignment: MainAxisAlignment.center,
// // // // //                   children: [
// // // // //                     Icon(
// // // // //                       Icons.shopping_cart_outlined,
// // // // //                       size: 64,
// // // // //                       color: Colors.grey[400],
// // // // //                     ),
// // // // //                     const SizedBox(height: 16),
// // // // //                     const Text(
// // // // //                       'Your cart is empty',
// // // // //                       style: TextStyle(
// // // // //                         fontSize: 18,
// // // // //                         fontWeight: FontWeight.bold,
// // // // //                         color: Colors.grey,
// // // // //                       ),
// // // // //                     ),
// // // // //                     const SizedBox(height: 8),
// // // // //                     const Text(
// // // // //                       'Add some medicines to get started',
// // // // //                       style: TextStyle(
// // // // //                         fontSize: 14,
// // // // //                         color: Colors.grey,
// // // // //                       ),
// // // // //                     ),
// // // // //                     const SizedBox(height: 24),
// // // // //                     ElevatedButton(
// // // // //                       onPressed: () {
// // // // //                         Navigator.push(
// // // // //                             context,
// // // // //                             MaterialPageRoute(
// // // // //                                 builder: (context) => MainLayout()));
// // // // //                       },
// // // // //                       style: ElevatedButton.styleFrom(
// // // // //                         backgroundColor: const Color(0xFF5931DD),
// // // // //                         shape: RoundedRectangleBorder(
// // // // //                           borderRadius: BorderRadius.circular(8),
// // // // //                         ),
// // // // //                       ),
// // // // //                       child: const Text(
// // // // //                         'Continue Shopping',
// // // // //                         style: TextStyle(color: Colors.white),
// // // // //                       ),
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),
// // // // //               );
// // // // //             }

// // // // //             return Column(
// // // // //               children: [
// // // // //                 Expanded(
// // // // //                   child: SingleChildScrollView(
// // // // //                     child: Padding(
// // // // //                       padding: const EdgeInsets.all(16.0),
// // // // //                       child: Column(
// // // // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                         children: [
// // // // //                           const SizedBox(height: 10),
// // // // //                           Row(
// // // // //                             children: [
// // // // //                               Container(
// // // // //                                 width: 48,
// // // // //                                 height: 48,
// // // // //                                 decoration: BoxDecoration(
// // // // //                                     color: const Color(0XFFEFF3F7),
// // // // //                                     borderRadius: BorderRadius.circular(48)),
// // // // //                                 child: const Icon(Icons.shopping_cart),
// // // // //                               ),
// // // // //                               const SizedBox(width: 10),
// // // // //                               const AppText(
// // // // //                                 "my_cart",
// // // // //                                 style: TextStyle(
// // // // //                                     fontSize: 20, fontWeight: FontWeight.bold),
// // // // //                               ),
// // // // //                               const Spacer(),
// // // // //                             ],
// // // // //                           ),
// // // // //                           const SizedBox(height: 34),
// // // // //                           _buildMedicationList(cartProvider),
// // // // //                           const SizedBox(height: 34),
// // // // //                           _buildCouponSection(),
// // // // //                           const SizedBox(height: 34),
// // // // //                           _buildCheckoutContainer(cartProvider),
// // // // //                         ],
// // // // //                       ),
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),
// // // // //                 _buildCheckoutButton(cartProvider),
// // // // //                 const SizedBox(height: 40),
// // // // //               ],
// // // // //             );
// // // // //           },
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Future<void> _selectFromCalendar({required bool isStartDate}) async {
// // // // //     final DateTime today = DateTime.now();
// // // // //     final DateTime? picked = await showDatePicker(
// // // // //       context: context,
// // // // //       initialDate: today,
// // // // //       firstDate: today,
// // // // //       lastDate: DateTime(today.year + 1),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildFrequencyToggle() {
// // // // //     return Container(
// // // // //       decoration: const BoxDecoration(
// // // // //         color: Color.fromARGB(255, 237, 234, 245),
// // // // //         borderRadius: BorderRadius.horizontal(
// // // // //           left: Radius.circular(24),
// // // // //           right: Radius.circular(24),
// // // // //         ),
// // // // //       ),
// // // // //       width: double.infinity,
// // // // //       child: Row(
// // // // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //         children: [
// // // // //           InkWell(
// // // // //             onTap: () {
// // // // //               setState(() {
// // // // //                 isWeeklySelected = true;
// // // // //               });
// // // // //             },
// // // // //             child: Container(
// // // // //               height: 48,
// // // // //               width: 166,
// // // // //               decoration: BoxDecoration(
// // // // //                 color: isWeeklySelected
// // // // //                     ? const Color(0xFF5931DD)
// // // // //                     : Colors.transparent,
// // // // //                 borderRadius: const BorderRadius.horizontal(
// // // // //                   left: Radius.circular(24),
// // // // //                   right: Radius.circular(24),
// // // // //                 ),
// // // // //                 border: Border.all(
// // // // //                   color: const Color(0xFF5931DD),
// // // // //                   width: 1,
// // // // //                 ),
// // // // //               ),
// // // // //               alignment: Alignment.center,
// // // // //               child: Text(
// // // // //                 'Weekly',
// // // // //                 style: TextStyle(
// // // // //                   color: isWeeklySelected ? Colors.white : Colors.black,
// // // // //                   fontWeight: FontWeight.w500,
// // // // //                 ),
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //           InkWell(
// // // // //             onTap: () {
// // // // //               setState(() {
// // // // //                 isWeeklySelected = false;
// // // // //               });
// // // // //             },
// // // // //             child: Container(
// // // // //               height: 48,
// // // // //               width: 166,
// // // // //               decoration: BoxDecoration(
// // // // //                 color: !isWeeklySelected
// // // // //                     ? const Color(0xFF5931DD)
// // // // //                     : Colors.transparent,
// // // // //                 borderRadius: const BorderRadius.horizontal(
// // // // //                   left: Radius.circular(24),
// // // // //                   right: Radius.circular(24),
// // // // //                 ),
// // // // //                 border: Border.all(
// // // // //                   color: const Color(0xFF5931DD),
// // // // //                   width: 1,
// // // // //                 ),
// // // // //               ),
// // // // //               alignment: Alignment.center,
// // // // //               child: Text(
// // // // //                 'Monthly',
// // // // //                 style: TextStyle(
// // // // //                   color: !isWeeklySelected ? Colors.white : Colors.black,
// // // // //                   fontWeight: FontWeight.w500,
// // // // //                 ),
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildMedicationList(CartProvider cartProvider) {
// // // // //     final items = cartProvider.cart.items;

// // // // //     if (items.isEmpty) {
// // // // //       return const Center(
// // // // //         child: Text(
// // // // //           'No items in cart',
// // // // //           style: TextStyle(
// // // // //             fontSize: 16,
// // // // //             color: Colors.grey,
// // // // //           ),
// // // // //         ),
// // // // //       );
// // // // //     }

// // // // //     return Column(
// // // // //       children: List.generate(
// // // // //         items.length * 2 - 1,
// // // // //         (i) {
// // // // //           if (i.isEven) {
// // // // //             final item = items[i ~/ 2];
// // // // //             return _buildMedicationItem(item, cartProvider);
// // // // //           } else {
// // // // //             return const Divider(
// // // // //               color: Color.fromARGB(255, 221, 221, 221),
// // // // //               height: 1,
// // // // //               thickness: 1,
// // // // //             );
// // // // //           }
// // // // //         },
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildMedicationItem(CartItem item, CartProvider cartProvider) {
// // // // //     final cart = cartProvider.cart;

// // // // //     return Container(
// // // // //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// // // // //       child: Row(
// // // // //         children: [
// // // // //           Container(
// // // // //             width: 60,
// // // // //             height: 60,
// // // // //             decoration: BoxDecoration(
// // // // //               color: Colors.blue.shade100,
// // // // //               borderRadius: BorderRadius.circular(8),
// // // // //             ),
// // // // //             child: item.images.isNotEmpty
// // // // //                 ? ClipRRect(
// // // // //                     borderRadius: BorderRadius.circular(8),
// // // // //                     child: Image.network(
// // // // //                       item.images.first,
// // // // //                       fit: BoxFit.cover,
// // // // //                       errorBuilder: (context, error, stackTrace) {
// // // // //                         return Image.asset(
// // // // //                           'assets/tablet.png',
// // // // //                           fit: BoxFit.cover,
// // // // //                         );
// // // // //                       },
// // // // //                     ),
// // // // //                   )
// // // // //                 : Image.asset(
// // // // //                     'assets/tablet.png',
// // // // //                     fit: BoxFit.cover,
// // // // //                   ),
// // // // //           ),
// // // // //           const SizedBox(width: 12),
// // // // //           Expanded(
// // // // //             child: Column(
// // // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // // //               children: [
// // // // //                 Text(
// // // // //                   item.name,
// // // // //                   style: const TextStyle(
// // // // //                     fontWeight: FontWeight.bold,
// // // // //                     fontSize: 14,
// // // // //                   ),
// // // // //                 ),
// // // // //                 Text(
// // // // //                   'Price: ₹${item.price}',
// // // // //                   style: TextStyle(
// // // // //                     fontSize: 12,
// // // // //                     color: Colors.grey.shade600,
// // // // //                   ),
// // // // //                 )
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //           Row(
// // // // //             children: [
// // // // //               Container(
// // // // //                 width: 24,
// // // // //                 height: 24,
// // // // //                 decoration: BoxDecoration(
// // // // //                   color: const Color.fromARGB(255, 221, 221, 221),
// // // // //                   borderRadius: BorderRadius.circular(12),
// // // // //                 ),
// // // // //                 child: IconButton(
// // // // //                   icon: const Icon(Icons.remove, size: 20),
// // // // //                   onPressed: item.quantity <= 1
// // // // //                       ? null
// // // // //                       : () async {
// // // // //                           await cartProvider.decreaseQuantity(item.medicineId);
// // // // //                         },
// // // // //                   padding: EdgeInsets.zero,
// // // // //                   constraints: const BoxConstraints(),
// // // // //                 ),
// // // // //               ),
// // // // //               const SizedBox(width: 8),
// // // // //               Text(
// // // // //                 '${item.quantity.toString().padLeft(2, '0')}',
// // // // //                 style: const TextStyle(fontWeight: FontWeight.bold),
// // // // //               ),
// // // // //               const SizedBox(width: 8),
// // // // //               Container(
// // // // //                 width: 24,
// // // // //                 height: 24,
// // // // //                 decoration: BoxDecoration(
// // // // //                   color: const Color(0xFF5931DD),
// // // // //                   borderRadius: BorderRadius.circular(12),
// // // // //                 ),
// // // // //                 child: IconButton(
// // // // //                   icon: const Icon(Icons.add, size: 16, color: Colors.white),
// // // // //                   onPressed: () async {
// // // // //                     await cartProvider.increaseQuantity(item.medicineId);
// // // // //                   },
// // // // //                   padding: EdgeInsets.zero,
// // // // //                   constraints: const BoxConstraints(),
// // // // //                 ),
// // // // //               ),
// // // // //               const SizedBox(width: 25),
// // // // //               Container(
// // // // //                 width: 24,
// // // // //                 height: 24,
// // // // //                 decoration: BoxDecoration(
// // // // //                   border: Border.all(
// // // // //                       color: const Color.fromARGB(255, 221, 221, 221)),
// // // // //                   color: const Color.fromARGB(255, 255, 255, 255),
// // // // //                   borderRadius: BorderRadius.circular(12),
// // // // //                 ),
// // // // //                 child: IconButton(
// // // // //                   icon: Icon(MdiIcons.trashCanOutline,
// // // // //                       color: Colors.red.shade400, size: 20),
// // // // //                   onPressed: () async {
// // // // //                     final confirm = await showDialog<bool>(
// // // // //                       context: context,
// // // // //                       builder: (context) => AlertDialog(
// // // // //                         title: const Text('Remove Item'),
// // // // //                         content: Text('Remove ${item.name} from cart?'),
// // // // //                         actions: [
// // // // //                           TextButton(
// // // // //                             onPressed: () => Navigator.pop(context, false),
// // // // //                             child: const Text('Cancel'),
// // // // //                           ),
// // // // //                           TextButton(
// // // // //                             onPressed: () => Navigator.pop(context, true),
// // // // //                             child: const Text(
// // // // //                               'Remove',
// // // // //                               style: TextStyle(color: Colors.red),
// // // // //                             ),
// // // // //                           ),
// // // // //                         ],
// // // // //                       ),
// // // // //                     );

// // // // //                     if (confirm == true) {
// // // // //                       await cartProvider.removeFromCart(item.medicineId);
// // // // //                     }
// // // // //                   },
// // // // //                   padding: EdgeInsets.zero,
// // // // //                   constraints: const BoxConstraints(),
// // // // //                 ),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildCouponSection() {
// // // // //     return Column(
// // // // //       crossAxisAlignment: CrossAxisAlignment.start,
// // // // //       children: [
// // // // //         if (appliedCoupon != null)
// // // // //           Container(
// // // // //             padding: const EdgeInsets.all(12),
// // // // //             decoration: BoxDecoration(
// // // // //               color: Colors.green.shade50,
// // // // //               border: Border.all(color: Colors.green.shade300),
// // // // //               borderRadius: BorderRadius.circular(8),
// // // // //             ),
// // // // //             child: Row(
// // // // //               children: [
// // // // //                 Icon(Icons.check_circle, color: Colors.green.shade600),
// // // // //                 const SizedBox(width: 12),
// // // // //                 Expanded(
// // // // //                   child: Column(
// // // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                     children: [
// // // // //                       Text(
// // // // //                         'Coupon Applied: $appliedCoupon',
// // // // //                         style: TextStyle(
// // // // //                           fontWeight: FontWeight.bold,
// // // // //                           color: Colors.green.shade700,
// // // // //                         ),
// // // // //                       ),
// // // // //                       Text(
// // // // //                         'Discount: -₹${discountAmount.toStringAsFixed(2)}',
// // // // //                         style: TextStyle(
// // // // //                           fontSize: 12,
// // // // //                           color: Colors.green.shade600,
// // // // //                         ),
// // // // //                       ),
// // // // //                     ],
// // // // //                   ),
// // // // //                 ),
// // // // //                 IconButton(
// // // // //                   icon: const Icon(Icons.close),
// // // // //                   onPressed: removeCoupon,
// // // // //                   constraints: const BoxConstraints(),
// // // // //                   padding: EdgeInsets.zero,
// // // // //                 )
// // // // //               ],
// // // // //             ),
// // // // //           )
// // // // //         else
// // // // //           Container(
// // // // //             padding: const EdgeInsets.symmetric(horizontal: 12),
// // // // //             decoration: BoxDecoration(
// // // // //               color: Colors.grey.shade100,
// // // // //               borderRadius: BorderRadius.circular(12),
// // // // //             ),
// // // // //             child: Row(
// // // // //               children: [
// // // // //                 Expanded(
// // // // //                   child: TextField(
// // // // //                     controller: couponController,
// // // // //                     decoration: InputDecoration(
// // // // //                       hintText: AppText.translate(context, 'enter_coupon'),
// // // // //                       border: InputBorder.none,
// // // // //                       enabled: !isLoadingCoupons,
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),
// // // // //                 Container(
// // // // //                   height: 48,
// // // // //                   width: 48,
// // // // //                   decoration: BoxDecoration(
// // // // //                     color: const Color(0xFF6C4DFF),
// // // // //                     borderRadius: BorderRadius.circular(12),
// // // // //                   ),
// // // // //                   child: isLoadingCoupons
// // // // //                       ? const Padding(
// // // // //                           padding: EdgeInsets.all(12.0),
// // // // //                           child: CircularProgressIndicator(
// // // // //                             strokeWidth: 2,
// // // // //                             valueColor:
// // // // //                                 AlwaysStoppedAnimation<Color>(Colors.white),
// // // // //                           ),
// // // // //                         )
// // // // //                       : IconButton(
// // // // //                           icon: const Icon(Icons.arrow_forward,
// // // // //                               color: Colors.white),
// // // // //                           onPressed: () {
// // // // //                             if (couponController.text.isEmpty) {
// // // // //                               ScaffoldMessenger.of(context).showSnackBar(
// // // // //                                 const SnackBar(
// // // // //                                   content: Text('Please enter a coupon code'),
// // // // //                                   duration: Duration(seconds: 2),
// // // // //                                 ),
// // // // //                               );
// // // // //                               return;
// // // // //                             }

// // // // //                             if (coupons.isEmpty) {
// // // // //                               fetchCoupons().then((_) {
// // // // //                                 if (coupons.isNotEmpty) {
// // // // //                                   applyCoupon(couponController.text.trim());
// // // // //                                 }
// // // // //                               });
// // // // //                             } else {
// // // // //                               applyCoupon(couponController.text.trim());
// // // // //                             }
// // // // //                           },
// // // // //                         ),
// // // // //                 )
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //       ],
// // // // //     );
// // // // //   }

// // // // //   Widget _buildCheckoutButton(CartProvider cartProvider) {
// // // // //     return Padding(
// // // // //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // // // //       child: SizedBox(
// // // // //         width: double.infinity,
// // // // //         height: 50,
// // // // //         child: ElevatedButton(
// // // // //           onPressed: cartProvider.isEmpty || cartProvider.isLoading
// // // // //               ? null
// // // // //               : () {
// // // // //                   final totalAmount = calculateTotalPayable(cartProvider);
// // // // //                   Navigator.push(
// // // // //                     context,
// // // // //                     MaterialPageRoute(
// // // // //                         builder: (context) => PaymentScreen(
// // // // //                               amount: totalAmount.toString(),
// // // // //                             )),
// // // // //                   );
// // // // //                 },
// // // // //           style: ElevatedButton.styleFrom(
// // // // //             backgroundColor: const Color(0xFF5931DD),
// // // // //             shape: RoundedRectangleBorder(
// // // // //               borderRadius: BorderRadius.circular(8),
// // // // //             ),
// // // // //           ),
// // // // //           child: cartProvider.isLoading
// // // // //               ? const SizedBox(
// // // // //                   width: 20,
// // // // //                   height: 20,
// // // // //                   child: CircularProgressIndicator(
// // // // //                     strokeWidth: 2,
// // // // //                     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
// // // // //                   ),
// // // // //                 )
// // // // //               : AppText(
// // // // //                   'checkout',
// // // // //                   style: TextStyle(
// // // // //                     fontSize: 18,
// // // // //                     fontWeight: FontWeight.bold,
// // // // //                     color: cartProvider.isEmpty ? Colors.grey : Colors.white,
// // // // //                   ),
// // // // //                 ),
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildCheckoutContainer(CartProvider cartProvider) {
// // // // //     final cart = cartProvider.cart;
// // // // //     final totalAfterDiscount =
// // // // //         (cart.subTotal + cart.platformFee + cart.deliveryCharge - discountAmount);

// // // // //     return Container(
// // // // //       width: 343,
// // // // //       padding: const EdgeInsets.all(16),
// // // // //       decoration: BoxDecoration(
// // // // //         color: const Color(0xFFEFF3F7),
// // // // //         borderRadius: BorderRadius.circular(12),
// // // // //       ),
// // // // //       child: Column(
// // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // //         children: [
// // // // //           _buildPriceRow(
// // // // //               'total_items', '${cart.totalItems.toString().padLeft(2, '0')}'),
// // // // //           const SizedBox(height: 8),
// // // // //           _buildPriceRow('sub_total', '₹${cart.subTotal}'),
// // // // //           const SizedBox(height: 8),
// // // // //           _buildPriceRow(
// // // // //               'platform_fee', '₹${cart.platformFee.toStringAsFixed(2)}'),
// // // // //           const SizedBox(height: 8),
// // // // //           _buildPriceRow(
// // // // //               'delivery_charge', '₹${cart.deliveryCharge.toStringAsFixed(2)}'),
// // // // //           if (discountAmount > 0)
// // // // //             Column(
// // // // //               children: [
// // // // //                 const SizedBox(height: 8),
// // // // //                 _buildPriceRow('discount', '-₹${discountAmount.toStringAsFixed(2)}',
// // // // //                     isDiscount: true),
// // // // //               ],
// // // // //             ),
// // // // //           const Divider(height: 24, thickness: 1),
// // // // //           _buildPriceRow('total_payable',
// // // // //               '₹${totalAfterDiscount.toStringAsFixed(2)}',
// // // // //               isTotal: true),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildPriceRow(String label, String value,
// // // // //       {bool isTotal = false, bool isDiscount = false}) {
// // // // //     return Row(
// // // // //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //       children: [
// // // // //         AppText(
// // // // //           label,
// // // // //           style: TextStyle(
// // // // //             fontSize: 14,
// // // // //             fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
// // // // //             color: isDiscount
// // // // //                 ? Colors.green.shade600
// // // // //                 : isTotal
// // // // //                     ? const Color(0xFF5931DD)
// // // // //                     : Colors.black.withOpacity(0.5),
// // // // //           ),
// // // // //         ),
// // // // //         Text(
// // // // //           value,
// // // // //           style: TextStyle(
// // // // //             fontSize: 14,
// // // // //             fontWeight: isTotal ? FontWeight.bold : FontWeight.bold,
// // // // //             color: isDiscount
// // // // //                 ? Colors.green.shade600
// // // // //                 : isTotal
// // // // //                     ? const Color(0xFF5931DD)
// // // // //                     : Colors.black,
// // // // //           ),
// // // // //         ),
// // // // //       ],
// // // // //     );
// // // // //   }
// // // // // }

// // // // import 'package:flutter/material.dart';
// // // // import 'package:intl/intl.dart';
// // // // import 'package:medical_user_app/models/medicine_model.dart';
// // // // import 'package:medical_user_app/providers/language_provider.dart';
// // // // import 'package:medical_user_app/providers/cart_provider.dart';
// // // // import 'package:medical_user_app/models/cart_model.dart';
// // // // import 'package:medical_user_app/view/main_layout.dart';
// // // // import 'package:medical_user_app/view/near_pharmacy_screen.dart';
// // // // import 'package:medical_user_app/view/payment_screen.dart';
// // // // import 'package:medical_user_app/widgets/bottom_navigation.dart';
// // // // import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// // // // import 'package:provider/provider.dart';
// // // // import 'package:http/http.dart' as http;
// // // // import 'dart:convert';

// // // // class CartScreen extends StatefulWidget {
// // // //   final int? amount;
// // // //   const CartScreen({super.key, this.amount});

// // // //   @override
// // // //   State<CartScreen> createState() => _CartScreenState();
// // // // }

// // // // class _CartScreenState extends State<CartScreen> {
// // // //   bool isWeeklySelected = true;
// // // //   int selectedDateIndex = 0;
// // // //   List<String> dates = ["22 Mar", "22 Mar", "22 Mar", "22 Mar"];

// // // //   TextEditingController couponController = TextEditingController();
// // // //   List<dynamic> coupons = [];
// // // //   bool isLoadingCoupons = false;
// // // //   String? appliedCoupon;
// // // //   double discountAmount = 0.0;

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     WidgetsBinding.instance.addPostFrameCallback((_) {
// // // //       Provider.of<CartProvider>(context, listen: false).initializeCart();
// // // //     });
// // // //   }

// // // //   Future<void> fetchCoupons() async {
// // // //     setState(() {
// // // //       isLoadingCoupons = true;
// // // //     });

// // // //     try {
// // // //       final response = await http.get(
// // // //         Uri.parse('http://31.97.206.144:7021/api/admin/getcoupons'),
// // // //         headers: {'Content-Type': 'application/json'},
// // // //       ).timeout(const Duration(seconds: 10));

// // // //       print('response status codeeeeeeeeeeeeeeeee ${response.statusCode}');
// // // //       print('response bodyyyyyyyyyyyyyyyy ${response.body}');

// // // //       if (response.statusCode == 200) {
// // // //         final data = jsonDecode(response.body);
// // // //         setState(() {
// // // //           coupons = data['coupons'] ?? [];
// // // //         });

// // // //         if (coupons.isEmpty) {
// // // //           ScaffoldMessenger.of(context).showSnackBar(
// // // //             const SnackBar(
// // // //               content: Text('No coupons available'),
// // // //               duration: Duration(seconds: 2),
// // // //             ),
// // // //           );
// // // //         }
// // // //       } else {
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           const SnackBar(
// // // //             content: Text('Failed to fetch coupons'),
// // // //             duration: Duration(seconds: 2),
// // // //           ),
// // // //         );
// // // //       }
// // // //     } catch (e) {
// // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // //         SnackBar(
// // // //           content: Text('Error: $e'),
// // // //           duration: const Duration(seconds: 2),
// // // //         ),
// // // //       );
// // // //     } finally {
// // // //       setState(() {
// // // //         isLoadingCoupons = false;
// // // //       });
// // // //     }
// // // //   }

// // // //   bool isCouponValid(dynamic coupon) {
// // // //     final expirationDate = DateTime.parse(coupon['expirationDate'].toString());
// // // //     return expirationDate.isAfter(DateTime.now());
// // // //   }

// // // //   void applyCoupon(String couponCode) {
// // // //     try {
// // // //       final coupon = coupons.firstWhere(
// // // //         (c) =>
// // // //             c['couponCode'].toString().toLowerCase() ==
// // // //             couponCode.toLowerCase(),
// // // //         orElse: () => null,
// // // //       );

// // // //       if (coupon == null) {
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           const SnackBar(
// // // //             content: Text('Coupon not found'),
// // // //             duration: Duration(seconds: 2),
// // // //           ),
// // // //         );
// // // //         return;
// // // //       }

// // // //       if (!isCouponValid(coupon)) {
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           const SnackBar(
// // // //             content: Text('Coupon has expired'),
// // // //             duration: Duration(seconds: 2),
// // // //           ),
// // // //         );
// // // //         return;
// // // //       }

// // // //       final cartProvider = Provider.of<CartProvider>(context, listen: false);
// // // //       // final discount = (cartProvider.cart.subTotal *
// // // //       //         (coupon['discountPercentage'] as num).toDouble() /
// // // //       //         100)
// // // //       //     .toStringAsFixed(2);

// // // //       final discountPercentage =
// // // //           (coupon['discountPercentage'] as num).toDouble();
// // // //       final discount = (cartProvider.cart.subTotal * discountPercentage / 100);

// // // //       setState(() {
// // // //         appliedCoupon = couponCode;
// // // //         discountAmount = double.parse(discount.toString());
// // // //       });

// // // //       couponController.clear();

// // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // //         SnackBar(
// // // //           content: Text(
// // // //               'Coupon applied! Discount: ₹${discountAmount.toStringAsFixed(2)}'),
// // // //           duration: const Duration(seconds: 2),
// // // //           backgroundColor: Colors.green,
// // // //         ),
// // // //       );
// // // //     } catch (e) {
// // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // //         SnackBar(
// // // //           content: Text('Error applying coupon: $e'),
// // // //           duration: const Duration(seconds: 2),
// // // //         ),
// // // //       );
// // // //     }
// // // //   }

// // // //   void removeCoupon() {
// // // //     setState(() {
// // // //       appliedCoupon = null;
// // // //       discountAmount = 0.0;
// // // //     });

// // // //     ScaffoldMessenger.of(context).showSnackBar(
// // // //       const SnackBar(
// // // //         content: Text('Coupon removed'),
// // // //         duration: Duration(seconds: 1),
// // // //       ),
// // // //     );
// // // //   }

// // // //   void showCouponsModal() async {
// // // //     if (coupons.isEmpty) {
// // // //       await fetchCoupons();
// // // //     }

// // // //     if (!mounted) return;

// // // //     showModalBottomSheet(
// // // //       context: context,
// // // //       isScrollControlled: true,
// // // //       backgroundColor: Colors.transparent,
// // // //       builder: (context) => Container(
// // // //         height: MediaQuery.of(context).size.height * 0.7,
// // // //         decoration: const BoxDecoration(
// // // //           color: Colors.white,
// // // //           borderRadius: BorderRadius.only(
// // // //             topLeft: Radius.circular(20),
// // // //             topRight: Radius.circular(20),
// // // //           ),
// // // //         ),
// // // //         child: Column(
// // // //           children: [
// // // //             Container(
// // // //               margin: const EdgeInsets.only(top: 8),
// // // //               width: 40,
// // // //               height: 4,
// // // //               decoration: BoxDecoration(
// // // //                 color: Colors.grey[300],
// // // //                 borderRadius: BorderRadius.circular(2),
// // // //               ),
// // // //             ),
// // // //             Padding(
// // // //               padding: const EdgeInsets.all(16.0),
// // // //               child: Row(
// // // //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //                 children: [
// // // //                   const Text(
// // // //                     'Available Coupons',
// // // //                     style: TextStyle(
// // // //                       fontSize: 20,
// // // //                       fontWeight: FontWeight.bold,
// // // //                     ),
// // // //                   ),
// // // //                   IconButton(
// // // //                     icon: const Icon(Icons.close),
// // // //                     onPressed: () => Navigator.pop(context),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //             const Divider(height: 1),
// // // //             Expanded(
// // // //               child: isLoadingCoupons
// // // //                   ? const Center(child: CircularProgressIndicator())
// // // //                   : coupons.isEmpty
// // // //                       ? const Center(
// // // //                           child: Text(
// // // //                             'No coupons available',
// // // //                             style: TextStyle(
// // // //                               fontSize: 16,
// // // //                               color: Colors.grey,
// // // //                             ),
// // // //                           ),
// // // //                         )
// // // //                       : ListView.builder(
// // // //                           padding: const EdgeInsets.all(16),
// // // //                           itemCount: coupons.length,
// // // //                           itemBuilder: (context, index) {
// // // //                             final coupon = coupons[index];
// // // //                             final isValid = isCouponValid(coupon);
// // // //                             final expiryDate = DateTime.parse(
// // // //                                 coupon['expirationDate'].toString());

// // // //                             return Container(
// // // //                               margin: const EdgeInsets.only(bottom: 12),
// // // //                               decoration: BoxDecoration(
// // // //                                 color: isValid
// // // //                                     ? Colors.white
// // // //                                     : Colors.grey.shade100,
// // // //                                 borderRadius: BorderRadius.circular(12),
// // // //                                 border: Border.all(
// // // //                                   color: isValid
// // // //                                       ? const Color(0xFF5931DD)
// // // //                                       : Colors.grey.shade300,
// // // //                                   width: 1.5,
// // // //                                 ),
// // // //                                 boxShadow: [
// // // //                                   BoxShadow(
// // // //                                     color: Colors.grey.withOpacity(0.1),
// // // //                                     spreadRadius: 1,
// // // //                                     blurRadius: 4,
// // // //                                     offset: const Offset(0, 2),
// // // //                                   ),
// // // //                                 ],
// // // //                               ),
// // // //                               child: Material(
// // // //                                 color: Colors.transparent,
// // // //                                 child: InkWell(
// // // //                                   borderRadius: BorderRadius.circular(12),
// // // //                                   onTap: isValid
// // // //                                       ? () {
// // // //                                           Navigator.pop(context);
// // // //                                           couponController.text =
// // // //                                               coupon['couponCode'];
// // // //                                           applyCoupon(coupon['couponCode']);
// // // //                                         }
// // // //                                       : null,
// // // //                                   child: Padding(
// // // //                                     padding: const EdgeInsets.all(16),
// // // //                                     child: Column(
// // // //                                       crossAxisAlignment:
// // // //                                           CrossAxisAlignment.start,
// // // //                                       children: [
// // // //                                         Row(
// // // //                                           children: [
// // // //                                             Container(
// // // //                                               padding:
// // // //                                                   const EdgeInsets.symmetric(
// // // //                                                       horizontal: 12,
// // // //                                                       vertical: 6),
// // // //                                               decoration: BoxDecoration(
// // // //                                                 color: isValid
// // // //                                                     ? const Color(0xFF5931DD)
// // // //                                                     : Colors.grey,
// // // //                                                 borderRadius:
// // // //                                                     BorderRadius.circular(6),
// // // //                                               ),
// // // //                                               child: Text(
// // // //                                                 coupon['couponCode'],
// // // //                                                 style: const TextStyle(
// // // //                                                   color: Colors.white,
// // // //                                                   fontWeight: FontWeight.bold,
// // // //                                                   fontSize: 16,
// // // //                                                   letterSpacing: 1.2,
// // // //                                                 ),
// // // //                                               ),
// // // //                                             ),
// // // //                                             const Spacer(),
// // // //                                             if (!isValid)
// // // //                                               Container(
// // // //                                                 padding:
// // // //                                                     const EdgeInsets.symmetric(
// // // //                                                         horizontal: 8,
// // // //                                                         vertical: 4),
// // // //                                                 decoration: BoxDecoration(
// // // //                                                   color: Colors.red.shade50,
// // // //                                                   borderRadius:
// // // //                                                       BorderRadius.circular(4),
// // // //                                                 ),
// // // //                                                 child: Text(
// // // //                                                   'EXPIRED',
// // // //                                                   style: TextStyle(
// // // //                                                     color: Colors.red.shade700,
// // // //                                                     fontSize: 10,
// // // //                                                     fontWeight: FontWeight.bold,
// // // //                                                   ),
// // // //                                                 ),
// // // //                                               ),
// // // //                                           ],
// // // //                                         ),
// // // //                                         const SizedBox(height: 12),
// // // //                                         Text(
// // // //                                           '${coupon['discountPercentage']}% OFF',
// // // //                                           style: TextStyle(
// // // //                                             fontSize: 20,
// // // //                                             fontWeight: FontWeight.bold,
// // // //                                             color: isValid
// // // //                                                 ? const Color(0xFF5931DD)
// // // //                                                 : Colors.grey,
// // // //                                           ),
// // // //                                         ),
// // // //                                         const SizedBox(height: 8),
// // // //                                         Row(
// // // //                                           children: [
// // // //                                             Icon(
// // // //                                               Icons.calendar_today,
// // // //                                               size: 14,
// // // //                                               color: Colors.grey.shade600,
// // // //                                             ),
// // // //                                             const SizedBox(width: 4),
// // // //                                             Text(
// // // //                                               'Valid till ${DateFormat('dd MMM yyyy').format(expiryDate)}',
// // // //                                               style: TextStyle(
// // // //                                                 fontSize: 12,
// // // //                                                 color: Colors.grey.shade600,
// // // //                                               ),
// // // //                                             ),
// // // //                                           ],
// // // //                                         ),
// // // //                                         if (isValid) ...[
// // // //                                           const SizedBox(height: 12),
// // // //                                           Row(
// // // //                                             mainAxisAlignment:
// // // //                                                 MainAxisAlignment.end,
// // // //                                             children: [
// // // //                                               Text(
// // // //                                                 'Tap to apply',
// // // //                                                 style: TextStyle(
// // // //                                                   fontSize: 12,
// // // //                                                   color:
// // // //                                                       const Color(0xFF5931DD),
// // // //                                                   fontWeight: FontWeight.w600,
// // // //                                                 ),
// // // //                                               ),
// // // //                                               const SizedBox(width: 4),
// // // //                                               const Icon(
// // // //                                                 Icons.arrow_forward,
// // // //                                                 size: 16,
// // // //                                                 color: Color(0xFF5931DD),
// // // //                                               ),
// // // //                                             ],
// // // //                                           ),
// // // //                                         ],
// // // //                                       ],
// // // //                                     ),
// // // //                                   ),
// // // //                                 ),
// // // //                               ),
// // // //                             );
// // // //                           },
// // // //                         ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   double calculateSubtotal(CartProvider cartProvider) {
// // // //     double subtotal = 0.0;
// // // //     for (var item in cartProvider.cart.items) {
// // // //       double itemPrice = item.totalPrice ?? (widget.amount?.toDouble() ?? 0.0);
// // // //       subtotal += itemPrice * item.quantity;
// // // //     }
// // // //     return subtotal;
// // // //   }

// // // //   // double calculateTotalPayable(CartProvider cartProvider) {
// // // //   //   double subtotal = calculateSubtotal(cartProvider);
// // // //   //   double platformFee = cartProvider.cart.platformFee;
// // // //   //   double deliveryCharge = cartProvider.cart.deliveryCharge;
// // // //   //   double afterDiscount =
// // // //   //       subtotal + platformFee + deliveryCharge - discountAmount;

// // // //   //   return afterDiscount < 0 ? 0 : afterDiscount;
// // // //   // }

// // // //   double calculateTotalPayable(CartProvider cartProvider) {
// // // //     final cart = cartProvider.cart;
// // // //     double subtotal = cart.subTotal;
// // // //     double platformFee = cart.platformFee;
// // // //     double deliveryCharge = cart.deliveryCharge;

// // // //     double totalBeforeDiscount = subtotal + platformFee + deliveryCharge;
// // // //     double afterDiscount = totalBeforeDiscount - discountAmount;

// // // //     return afterDiscount < 0
// // // //         ? 0
// // // //         : double.parse(afterDiscount.toStringAsFixed(2));
// // // //   }

// // // //   @override
// // // //   void dispose() {
// // // //     couponController.dispose();
// // // //     super.dispose();
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       backgroundColor: Colors.grey[50],
// // // //       body: SafeArea(
// // // //         child: Consumer<CartProvider>(
// // // //           builder: (context, cartProvider, child) {
// // // //             if (cartProvider.isLoading) {
// // // //               return const Center(child: CircularProgressIndicator());
// // // //             }

// // // //             if (cartProvider.errorMessage != null) {
// // // //               return Center(
// // // //                 child: Column(
// // // //                   mainAxisAlignment: MainAxisAlignment.center,
// // // //                   children: [
// // // //                     // Icon(
// // // //                     //   Icons.error_outline,
// // // //                     //   size: 64,
// // // //                     //   color: Colors.grey[400],
// // // //                     // ),
// // // //                     const SizedBox(height: 16),
// // // //                     Text(
// // // //                       'Please provide your internet connection',
// // // //                       textAlign: TextAlign.center,
// // // //                       style: const TextStyle(
// // // //                         fontSize: 16,
// // // //                         color: Colors.grey,
// // // //                       ),
// // // //                     ),
// // // //                     const SizedBox(height: 16),
// // // //                     // ElevatedButton(
// // // //                     //   onPressed: () {
// // // //                     //     cartProvider.clearError();
// // // //                     //     cartProvider.initializeCart();
// // // //                     //   },
// // // //                     //   child: const Text('Retry'),
// // // //                     // ),
// // // //                   ],
// // // //                 ),
// // // //               );
// // // //             }

// // // //             if (cartProvider.isEmpty) {
// // // //               return Center(
// // // //                 child: Column(
// // // //                   mainAxisAlignment: MainAxisAlignment.center,
// // // //                   children: [
// // // //                     Icon(
// // // //                       Icons.shopping_cart_outlined,
// // // //                       size: 64,
// // // //                       color: Colors.grey[400],
// // // //                     ),
// // // //                     const SizedBox(height: 16),
// // // //                     const Text(
// // // //                       'Your cart is empty',
// // // //                       style: TextStyle(
// // // //                         fontSize: 18,
// // // //                         fontWeight: FontWeight.bold,
// // // //                         color: Colors.grey,
// // // //                       ),
// // // //                     ),
// // // //                     const SizedBox(height: 8),
// // // //                     const Text(
// // // //                       'Add some medicines to get started',
// // // //                       style: TextStyle(
// // // //                         fontSize: 14,
// // // //                         color: Colors.grey,
// // // //                       ),
// // // //                     ),
// // // //                     const SizedBox(height: 24),
// // // //                     ElevatedButton(
// // // //                       onPressed: () {
// // // //                         Navigator.push(
// // // //                             context,
// // // //                             MaterialPageRoute(
// // // //                                 builder: (context) => MainLayout()));
// // // //                       },
// // // //                       style: ElevatedButton.styleFrom(
// // // //                         backgroundColor: const Color(0xFF5931DD),
// // // //                         shape: RoundedRectangleBorder(
// // // //                           borderRadius: BorderRadius.circular(8),
// // // //                         ),
// // // //                       ),
// // // //                       child: const Text(
// // // //                         'Continue Shopping',
// // // //                         style: TextStyle(color: Colors.white),
// // // //                       ),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               );
// // // //             }

// // // //             return Column(
// // // //               children: [
// // // //                 Expanded(
// // // //                   child: SingleChildScrollView(
// // // //                     child: Padding(
// // // //                       padding: const EdgeInsets.all(16.0),
// // // //                       child: Column(
// // // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // // //                         children: [
// // // //                           const SizedBox(height: 10),
// // // //                           Row(
// // // //                             children: [
// // // //                               Container(
// // // //                                 width: 48,
// // // //                                 height: 48,
// // // //                                 decoration: BoxDecoration(
// // // //                                     color: const Color(0XFFEFF3F7),
// // // //                                     borderRadius: BorderRadius.circular(48)),
// // // //                                 child: const Icon(Icons.shopping_cart),
// // // //                               ),
// // // //                               const SizedBox(width: 10),
// // // //                               const AppText(
// // // //                                 "my_cart",
// // // //                                 style: TextStyle(
// // // //                                     fontSize: 20, fontWeight: FontWeight.bold),
// // // //                               ),
// // // //                               const Spacer(),
// // // //                             ],
// // // //                           ),
// // // //                           const SizedBox(height: 34),
// // // //                           _buildMedicationList(cartProvider),
// // // //                           const SizedBox(height: 34),
// // // //                           _buildCouponSection(),
// // // //                           const SizedBox(height: 34),
// // // //                           _buildCheckoutContainer(cartProvider),
// // // //                         ],
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                 ),
// // // //                 _buildCheckoutButton(cartProvider),
// // // //                 const SizedBox(height: 40),
// // // //               ],
// // // //             );
// // // //           },
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   // Future<void> _selectFromCalendar({required bool isStartDate}) async {
// // // //   //   final DateTime today = DateTime.now();
// // // //   //   final DateTime? picked = await showDatePicker(
// // // //   //     context: context,
// // // //   //     initialDate: today,
// // // //   //     firstDate: today,
// // // //   //     lastDate: DateTime(today.year + 1),
// // // //   //   );
// // // //   // }

// // // //   // Widget _buildFrequencyToggle() {
// // // //   //   return Container(
// // // //   //     decoration: const BoxDecoration(
// // // //   //       color: Color.fromARGB(255, 237, 234, 245),
// // // //   //       borderRadius: BorderRadius.horizontal(
// // // //   //         left: Radius.circular(24),
// // // //   //         right: Radius.circular(24),
// // // //   //       ),
// // // //   //     ),
// // // //   //     width: double.infinity,
// // // //   //     child: Row(
// // // //   //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //   //       children: [
// // // //   //         InkWell(
// // // //   //           onTap: () {
// // // //   //             setState(() {
// // // //   //               isWeeklySelected = true;
// // // //   //             });
// // // //   //           },
// // // //   //           child: Container(
// // // //   //             height: 48,
// // // //   //             width: 166,
// // // //   //             decoration: BoxDecoration(
// // // //   //               color: isWeeklySelected
// // // //   //                   ? const Color(0xFF5931DD)
// // // //   //                   : Colors.transparent,
// // // //   //               borderRadius: const BorderRadius.horizontal(
// // // //   //                 left: Radius.circular(24),
// // // //   //                 right: Radius.circular(24),
// // // //   //               ),
// // // //   //               border: Border.all(
// // // //   //                 color: const Color(0xFF5931DD),
// // // //   //                 width: 1,
// // // //   //               ),
// // // //   //             ),
// // // //   //             alignment: Alignment.center,
// // // //   //             child: Text(
// // // //   //               'Weekly',
// // // //   //               style: TextStyle(
// // // //   //                 color: isWeeklySelected ? Colors.white : Colors.black,
// // // //   //                 fontWeight: FontWeight.w500,
// // // //   //               ),
// // // //   //             ),
// // // //   //           ),
// // // //   //         ),
// // // //   //         InkWell(
// // // //   //           onTap: () {
// // // //   //             setState(() {
// // // //   //               isWeeklySelected = false;
// // // //   //             });
// // // //   //           },
// // // //   //           child: Container(
// // // //   //             height: 48,
// // // //   //             width: 166,
// // // //   //             decoration: BoxDecoration(
// // // //   //               color: !isWeeklySelected
// // // //   //                   ? const Color(0xFF5931DD)
// // // //   //                   : Colors.transparent,
// // // //   //               borderRadius: const BorderRadius.horizontal(
// // // //   //                 left: Radius.circular(24),
// // // //   //                 right: Radius.circular(24),
// // // //   //               ),
// // // //   //               border: Border.all(
// // // //   //                 color: const Color(0xFF5931DD),
// // // //   //                 width: 1,
// // // //   //               ),
// // // //   //             ),
// // // //   //             alignment: Alignment.center,
// // // //   //             child: Text(
// // // //   //               'Monthly',
// // // //   //               style: TextStyle(
// // // //   //                 color: !isWeeklySelected ? Colors.white : Colors.black,
// // // //   //                 fontWeight: FontWeight.w500,
// // // //   //               ),
// // // //   //             ),
// // // //   //           ),
// // // //   //         ),
// // // //   //       ],
// // // //   //     ),
// // // //   //   );
// // // //   // }

// // // //   Widget _buildMedicationList(CartProvider cartProvider) {
// // // //     final items = cartProvider.cart.items;

// // // //     if (items.isEmpty) {
// // // //       return const Center(
// // // //         child: Text(
// // // //           'No items in cart',
// // // //           style: TextStyle(
// // // //             fontSize: 16,
// // // //             color: Colors.grey,
// // // //           ),
// // // //         ),
// // // //       );
// // // //     }

// // // //     return Column(
// // // //       children: List.generate(
// // // //         items.length * 2 - 1,
// // // //         (i) {
// // // //           if (i.isEven) {
// // // //             final item = items[i ~/ 2];
// // // //             return _buildMedicationItem(item, cartProvider);
// // // //           } else {
// // // //             return const Divider(
// // // //               color: Color.fromARGB(255, 221, 221, 221),
// // // //               height: 1,
// // // //               thickness: 1,
// // // //             );
// // // //           }
// // // //         },
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildMedicationItem(CartItem item, CartProvider cartProvider) {
// // // //     final cart = cartProvider.cart;

// // // //     return Container(
// // // //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// // // //       child: Row(
// // // //         children: [
// // // //           Container(
// // // //             width: 60,
// // // //             height: 60,
// // // //             decoration: BoxDecoration(
// // // //               color: Colors.blue.shade100,
// // // //               borderRadius: BorderRadius.circular(8),
// // // //             ),
// // // //             child: item.images.isNotEmpty
// // // //                 ? ClipRRect(
// // // //                     borderRadius: BorderRadius.circular(8),
// // // //                     child: Image.network(
// // // //                       item.images.first,
// // // //                       fit: BoxFit.cover,
// // // //                       errorBuilder: (context, error, stackTrace) {
// // // //                         return Image.asset(
// // // //                           'assets/tablet.png',
// // // //                           fit: BoxFit.cover,
// // // //                         );
// // // //                       },
// // // //                     ),
// // // //                   )
// // // //                 : Image.asset(
// // // //                     'assets/tablet.png',
// // // //                     fit: BoxFit.cover,
// // // //                   ),
// // // //           ),
// // // //           const SizedBox(width: 12),
// // // //           Expanded(
// // // //             child: Column(
// // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // //               children: [
// // // //                 Text(
// // // //                   item.name,
// // // //                   style: const TextStyle(
// // // //                     fontWeight: FontWeight.bold,
// // // //                     fontSize: 14,
// // // //                   ),
// // // //                 ),
// // // //                 Text(
// // // //                   'Price: ₹${item.totalPrice}',
// // // //                   style: TextStyle(
// // // //                     fontSize: 12,
// // // //                     color: Colors.grey.shade600,
// // // //                   ),
// // // //                 )
// // // //               ],
// // // //             ),
// // // //           ),
// // // //           Row(
// // // //             children: [
// // // //               Container(
// // // //                 width: 24,
// // // //                 height: 24,
// // // //                 decoration: BoxDecoration(
// // // //                   color: const Color.fromARGB(255, 221, 221, 221),
// // // //                   borderRadius: BorderRadius.circular(12),
// // // //                 ),
// // // //                 child: IconButton(
// // // //                   icon: const Icon(Icons.remove, size: 20),
// // // //                   onPressed: item.quantity <= 1
// // // //                       ? null
// // // //                       : () async {
// // // //                           await cartProvider.decreaseQuantity(item.medicineId);
// // // //                         },
// // // //                   padding: EdgeInsets.zero,
// // // //                   constraints: const BoxConstraints(),
// // // //                 ),
// // // //               ),
// // // //               const SizedBox(width: 8),
// // // //               Text(
// // // //                 '${item.quantity.toString().padLeft(2, '0')}',
// // // //                 style: const TextStyle(fontWeight: FontWeight.bold),
// // // //               ),
// // // //               const SizedBox(width: 8),
// // // //               Container(
// // // //                 width: 24,
// // // //                 height: 24,
// // // //                 decoration: BoxDecoration(
// // // //                   color: const Color(0xFF5931DD),
// // // //                   borderRadius: BorderRadius.circular(12),
// // // //                 ),
// // // //                 child: IconButton(
// // // //                   icon: const Icon(Icons.add, size: 16, color: Colors.white),
// // // //                   onPressed: () async {
// // // //                     await cartProvider.increaseQuantity(item.medicineId);
// // // //                   },
// // // //                   padding: EdgeInsets.zero,
// // // //                   constraints: const BoxConstraints(),
// // // //                 ),
// // // //               ),
// // // //               const SizedBox(width: 25),
// // // //               Container(
// // // //                 width: 24,
// // // //                 height: 24,
// // // //                 decoration: BoxDecoration(
// // // //                   border: Border.all(
// // // //                       color: const Color.fromARGB(255, 221, 221, 221)),
// // // //                   color: const Color.fromARGB(255, 255, 255, 255),
// // // //                   borderRadius: BorderRadius.circular(12),
// // // //                 ),
// // // //                 child: IconButton(
// // // //                   icon: Icon(MdiIcons.trashCanOutline,
// // // //                       color: Colors.red.shade400, size: 20),
// // // //                   onPressed: () async {
// // // //                     final confirm = await showDialog<bool>(
// // // //                       context: context,
// // // //                       builder: (context) => AlertDialog(
// // // //                         title: const Text('Remove Item'),
// // // //                         content: Text('Remove ${item.name} from cart?'),
// // // //                         actions: [
// // // //                           TextButton(
// // // //                             onPressed: () => Navigator.pop(context, false),
// // // //                             child: const Text('Cancel'),
// // // //                           ),
// // // //                           TextButton(
// // // //                             onPressed: () => Navigator.pop(context, true),
// // // //                             child: const Text(
// // // //                               'Remove',
// // // //                               style: TextStyle(color: Colors.red),
// // // //                             ),
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                     );

// // // //                     if (confirm == true) {
// // // //                       await cartProvider.removeFromCart(item.medicineId);
// // // //                     }
// // // //                   },
// // // //                   padding: EdgeInsets.zero,
// // // //                   constraints: const BoxConstraints(),
// // // //                 ),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildCouponSection() {
// // // //     return Column(
// // // //       crossAxisAlignment: CrossAxisAlignment.start,
// // // //       children: [
// // // //         if (appliedCoupon != null)
// // // //           Container(
// // // //             padding: const EdgeInsets.all(12),
// // // //             decoration: BoxDecoration(
// // // //               color: Colors.green.shade50,
// // // //               border: Border.all(color: Colors.green.shade300),
// // // //               borderRadius: BorderRadius.circular(8),
// // // //             ),
// // // //             child: Row(
// // // //               children: [
// // // //                 Icon(Icons.check_circle, color: Colors.green.shade600),
// // // //                 const SizedBox(width: 12),
// // // //                 Expanded(
// // // //                   child: Column(
// // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // //                     children: [
// // // //                       Text(
// // // //                         'Coupon Applied: $appliedCoupon',
// // // //                         style: TextStyle(
// // // //                           fontWeight: FontWeight.bold,
// // // //                           color: Colors.green.shade700,
// // // //                         ),
// // // //                       ),
// // // //                       Text(
// // // //                         'Discount: -₹${discountAmount.toStringAsFixed(2)}',
// // // //                         style: TextStyle(
// // // //                           fontSize: 12,
// // // //                           color: Colors.green.shade600,
// // // //                         ),
// // // //                       ),
// // // //                     ],
// // // //                   ),
// // // //                 ),
// // // //                 IconButton(
// // // //                   icon: const Icon(Icons.close),
// // // //                   onPressed: removeCoupon,
// // // //                   constraints: const BoxConstraints(),
// // // //                   padding: EdgeInsets.zero,
// // // //                 )
// // // //               ],
// // // //             ),
// // // //           )
// // // //         else
// // // //           Column(
// // // //             children: [
// // // //               Container(
// // // //                 padding: const EdgeInsets.symmetric(horizontal: 12),
// // // //                 decoration: BoxDecoration(
// // // //                   color: Colors.grey.shade100,
// // // //                   borderRadius: BorderRadius.circular(12),
// // // //                 ),
// // // //                 child: Row(
// // // //                   children: [
// // // //                     Expanded(
// // // //                       child: TextField(
// // // //                         controller: couponController,
// // // //                         decoration: InputDecoration(
// // // //                           hintText: AppText.translate(context, 'enter_coupon'),
// // // //                           border: InputBorder.none,
// // // //                           enabled: !isLoadingCoupons,
// // // //                         ),
// // // //                       ),
// // // //                     ),
// // // //                     Container(
// // // //                       height: 48,
// // // //                       width: 48,
// // // //                       decoration: BoxDecoration(
// // // //                         color: const Color(0xFF6C4DFF),
// // // //                         borderRadius: BorderRadius.circular(12),
// // // //                       ),
// // // //                       child: isLoadingCoupons
// // // //                           ? const Padding(
// // // //                               padding: EdgeInsets.all(12.0),
// // // //                               child: CircularProgressIndicator(
// // // //                                 strokeWidth: 2,
// // // //                                 valueColor:
// // // //                                     AlwaysStoppedAnimation<Color>(Colors.white),
// // // //                               ),
// // // //                             )
// // // //                           : IconButton(
// // // //                               icon: const Icon(Icons.arrow_forward,
// // // //                                   color: Colors.white),
// // // //                               onPressed: () {
// // // //                                 if (couponController.text.isEmpty) {
// // // //                                   ScaffoldMessenger.of(context).showSnackBar(
// // // //                                     const SnackBar(
// // // //                                       content:
// // // //                                           Text('Please enter a coupon code'),
// // // //                                       duration: Duration(seconds: 2),
// // // //                                     ),
// // // //                                   );
// // // //                                   return;
// // // //                                 }

// // // //                                 if (coupons.isEmpty) {
// // // //                                   fetchCoupons().then((_) {
// // // //                                     if (coupons.isNotEmpty) {
// // // //                                       applyCoupon(couponController.text.trim());
// // // //                                     }
// // // //                                   });
// // // //                                 } else {
// // // //                                   applyCoupon(couponController.text.trim());
// // // //                                 }
// // // //                               },
// // // //                             ),
// // // //                     )
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //               const SizedBox(height: 12),
// // // //               Align(
// // // //                 alignment: Alignment.centerRight,
// // // //                 child: TextButton.icon(
// // // //                   onPressed: showCouponsModal,
// // // //                   icon: const Icon(
// // // //                     Icons.local_offer,
// // // //                     size: 18,
// // // //                     color: Color(0xFF5931DD),
// // // //                   ),
// // // //                   label: const Text(
// // // //                     'View All Coupons',
// // // //                     style: TextStyle(
// // // //                       color: Color(0xFF5931DD),
// // // //                       fontWeight: FontWeight.w600,
// // // //                       fontSize: 14,
// // // //                     ),
// // // //                   ),
// // // //                   style: TextButton.styleFrom(
// // // //                     padding: const EdgeInsets.symmetric(
// // // //                       horizontal: 12,
// // // //                       vertical: 8,
// // // //                     ),
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //       ],
// // // //     );
// // // //   }

// // // //   Widget _buildCheckoutButton(CartProvider cartProvider) {
// // // //     return Padding(
// // // //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // // //       child: SizedBox(
// // // //         width: double.infinity,
// // // //         height: 50,
// // // //         child: ElevatedButton(
// // // //           onPressed: cartProvider.isEmpty || cartProvider.isLoading
// // // //               ? null
// // // //               : () {
// // // //                   final totalAmount = calculateTotalPayable(cartProvider);
// // // //                   Navigator.push(
// // // //                     context,
// // // //                     MaterialPageRoute(
// // // //                         builder: (context) => PaymentScreen(
// // // //                               amount: totalAmount.toString(),
// // // //                               coupouncode: appliedCoupon,
// // // //                             )),
// // // //                   );
// // // //                 },

// // // //           // onPressed: cartProvider.isEmpty || cartProvider.isLoading
// // // //           //     ? null
// // // //           //     : () {
// // // //           //         final cart = cartProvider.cart;
// // // //           //         final totalAmount = cart.subTotal +
// // // //           //             cart.platformFee +
// // // //           //             // cart.deliveryCharge -
// // // //           //             discountAmount;

// // // //           //         Navigator.push(
// // // //           //           context,
// // // //           //           MaterialPageRoute(
// // // //           //             builder: (context) => PaymentScreen(
// // // //           //               amount: (totalAmount < 0 ? 0 : totalAmount)
// // // //           //                   .toStringAsFixed(2),
// // // //           //               coupouncode: appliedCoupon,
// // // //           //               subtotal: cart.subTotal.toString(),
// // // //           //             ),
// // // //           //           ),
// // // //           //         );
// // // //           //       },

// // // //           style: ElevatedButton.styleFrom(
// // // //             backgroundColor: const Color(0xFF5931DD),
// // // //             shape: RoundedRectangleBorder(
// // // //               borderRadius: BorderRadius.circular(8),
// // // //             ),
// // // //           ),
// // // //           child: cartProvider.isLoading
// // // //               ? const SizedBox(
// // // //                   width: 20,
// // // //                   height: 20,
// // // //                   child: CircularProgressIndicator(
// // // //                     strokeWidth: 2,
// // // //                     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
// // // //                   ),
// // // //                 )
// // // //               : AppText(
// // // //                   'checkout',
// // // //                   style: TextStyle(
// // // //                     fontSize: 18,
// // // //                     fontWeight: FontWeight.bold,
// // // //                     color: cartProvider.isEmpty ? Colors.grey : Colors.white,
// // // //                   ),
// // // //                 ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildCheckoutContainer(CartProvider cartProvider) {
// // // //     final cart = cartProvider.cart;
// // // //     final totalAfterDiscount = (cart.subTotal +
// // // //         cart.platformFee +
// // // //         cart.deliveryCharge -
// // // //         discountAmount);

// // // //     final totalAmount = calculateTotalPayable(cartProvider);

// // // //     return Container(
// // // //       width: 343,
// // // //       padding: const EdgeInsets.all(16),
// // // //       decoration: BoxDecoration(
// // // //         color: const Color(0xFFEFF3F7),
// // // //         borderRadius: BorderRadius.circular(12),
// // // //       ),
// // // //       child: Column(
// // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // //         children: [
// // // //           _buildPriceRow(
// // // //               'total_items', '${cart.totalItems.toString().padLeft(2, '0')}'),
// // // //           const SizedBox(height: 8),
// // // //           _buildPriceRow('sub_total', '₹${cart.subTotal}'),
// // // //           const SizedBox(height: 8),
// // // //           _buildPriceRow(
// // // //               'platform_fee', '₹${cart.platformFee.toStringAsFixed(2)}'),
// // // //           const SizedBox(height: 8),

// // // //           if (discountAmount > 0) ...[
// // // //             const SizedBox(height: 8),
// // // //             _buildPriceRow(
// // // //               'discount',
// // // //               '-₹${discountAmount.toStringAsFixed(2)}',
// // // //               isDiscount: true,
// // // //             ),
// // // //           ],
// // // //           const SizedBox(height: 8),

// // // //           _buildPriceRow(
// // // //               'delivery_charge', '₹${cart.deliveryCharge.toStringAsFixed(2)}'),
// // // //           if (discountAmount > 0)
// // // //             Column(
// // // //               children: [
// // // //                 const SizedBox(height: 8),
// // // //                 // _buildPriceRow(
// // // //                 //     'discount', '-₹${discountAmount.toStringAsFixed(2)}',
// // // //                 //     isDiscount: true),
// // // //               ],
// // // //             ),
// // // //           const Divider(height: 24, thickness: 1),
// // // //           // _buildPriceRow(
// // // //           //     'total_payable', '₹${totalAfterDiscount.toStringAsFixed(2)}',
// // // //           //     isTotal: true),
// // // //           //  _buildPriceRow(
// // // //           // 'total_payable', '₹${cart.totalPayable}',
// // // //           // isTotal: true),

// // // //           _buildPriceRow(
// // // //             'total_payable',
// // // //             '₹${totalAmount.toString()}',
// // // //             isTotal: true,
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildPriceRow(String label, String value,
// // // //       {bool isTotal = false, bool isDiscount = false}) {
// // // //     return Row(
// // // //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //       children: [
// // // //         AppText(
// // // //           label,
// // // //           style: TextStyle(
// // // //             fontSize: 14,
// // // //             fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
// // // //             color: isDiscount
// // // //                 ? Colors.green.shade600
// // // //                 : isTotal
// // // //                     ? const Color(0xFF5931DD)
// // // //                     : Colors.black.withOpacity(0.5),
// // // //           ),
// // // //         ),
// // // //         Text(
// // // //           value,
// // // //           style: TextStyle(
// // // //             fontSize: 14,
// // // //             fontWeight: isTotal ? FontWeight.bold : FontWeight.bold,
// // // //             color: isDiscount
// // // //                 ? Colors.green.shade600
// // // //                 : isTotal
// // // //                     ? const Color(0xFF5931DD)
// // // //                     : Colors.black,
// // // //           ),
// // // //         ),
// // // //       ],
// // // //     );
// // // //   }
// // // // }



























// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:medical_user_app/providers/language_provider.dart';
// import 'package:medical_user_app/providers/cart_provider.dart';
// import 'package:medical_user_app/models/cart_model.dart';
// import 'package:medical_user_app/view/main_layout.dart';
// import 'package:medical_user_app/view/payment_screen.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class CartScreen extends StatefulWidget {
//   final double? amount;
//   const CartScreen({super.key, this.amount});

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen>
//     with SingleTickerProviderStateMixin {
//   bool isWeeklySelected = true;
//   int selectedDateIndex = 0;

//   TextEditingController couponController = TextEditingController();
//   List<dynamic> coupons = [];
//   bool isLoadingCoupons = false;
//   String? appliedCoupon;
//   double discountAmount = 0.0;

//   // Track loading state for each item
//   Map<String, bool> loadingItems = {};
  

//   // Animation controller for smooth transitions
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();

//     // Initialize animation controller
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );

//     _animationController.forward();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<CartProvider>(context, listen: false).initializeCart();
//     });
//   }

//   Future<void> fetchCoupons() async {
//     setState(() {
//       isLoadingCoupons = true;
//     });

//     try {
//       final response = await http.get(
//         Uri.parse('http://31.97.206.144:7021/api/admin/getcoupons'),
//         headers: {'Content-Type': 'application/json'},
//       ).timeout(const Duration(seconds: 10));

//       print('response status codeeeeeeeeeeeeeeeee ${response.statusCode}');
//       print('response bodyyyyyyyyyyyyyyyy ${response.body}');

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           coupons = data['coupons'] ?? [];
//         });

//         if (coupons.isEmpty) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('No coupons available'),
//               duration: Duration(seconds: 2),
//             ),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Failed to fetch coupons'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error: $e'),
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     } finally {
//       setState(() {
//         isLoadingCoupons = false;
//       });
//     }
//   }

//   bool isCouponValid(dynamic coupon) {
//     final expirationDate = DateTime.parse(coupon['expirationDate'].toString());
//     return expirationDate.isAfter(DateTime.now());
//   }

//   void applyCoupon(String couponCode) {
//     try {
//       final coupon = coupons.firstWhere(
//         (c) =>
//             c['couponCode'].toString().toLowerCase() ==
//             couponCode.toLowerCase(),
//         orElse: () => null,
//       );

//       if (coupon == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Coupon not found'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//         return;
//       }

//       if (!isCouponValid(coupon)) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Coupon has expired'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//         return;
//       }

//       final cartProvider = Provider.of<CartProvider>(context, listen: false);
//       final discountPercentage =
//           (coupon['discountPercentage'] as num).toDouble();
//       final discount = (cartProvider.cart.subTotal * discountPercentage / 100);

//       setState(() {
//         appliedCoupon = couponCode;
//         discountAmount = double.parse(discount.toString());
//       });

//       couponController.clear();

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//               'Coupon applied! Discount: ₹${discountAmount.toStringAsFixed(2)}'),
//           duration: const Duration(seconds: 2),
//           backgroundColor: Colors.green,
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error applying coupon: $e'),
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     }
//   }

//   void removeCoupon() {
//     setState(() {
//       appliedCoupon = null;
//       discountAmount = 0.0;
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Coupon removed'),
//         duration: Duration(seconds: 1),
//       ),
//     );
//   }

//   void showCouponsModal() async {
//     if (coupons.isEmpty) {
//       await fetchCoupons();
//     }

//     if (!mounted) return;

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => Container(
//         height: MediaQuery.of(context).size.height * 0.7,
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: Column(
//           children: [
//             Container(
//               margin: const EdgeInsets.only(top: 8),
//               width: 40,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Available Coupons',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.close),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                 ],
//               ),
//             ),
//             const Divider(height: 1),
//             Expanded(
//               child: isLoadingCoupons
//                   ? const Center(child: CircularProgressIndicator())
//                   : coupons.isEmpty
//                       ? const Center(
//                           child: Text(
//                             'No coupons available',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         )
//                       : ListView.builder(
//                           padding: const EdgeInsets.all(16),
//                           itemCount: coupons.length,
//                           itemBuilder: (context, index) {
//                             final coupon = coupons[index];
//                             final isValid = isCouponValid(coupon);
//                             final expiryDate = DateTime.parse(
//                                 coupon['expirationDate'].toString());

//                             return Container(
//                               margin: const EdgeInsets.only(bottom: 12),
//                               decoration: BoxDecoration(
//                                 color: isValid
//                                     ? Colors.white
//                                     : Colors.grey.shade100,
//                                 borderRadius: BorderRadius.circular(12),
//                                 border: Border.all(
//                                   color: isValid
//                                       ? const Color(0xFF5931DD)
//                                       : Colors.grey.shade300,
//                                   width: 1.5,
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.1),
//                                     spreadRadius: 1,
//                                     blurRadius: 4,
//                                     offset: const Offset(0, 2),
//                                   ),
//                                 ],
//                               ),
//                               child: Material(
//                                 color: Colors.transparent,
//                                 child: InkWell(
//                                   borderRadius: BorderRadius.circular(12),
//                                   onTap: isValid
//                                       ? () {
//                                           Navigator.pop(context);
//                                           couponController.text =
//                                               coupon['couponCode'];
//                                           applyCoupon(coupon['couponCode']);
//                                         }
//                                       : null,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(16),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Container(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 12,
//                                                       vertical: 6),
//                                               decoration: BoxDecoration(
//                                                 color: isValid
//                                                     ? const Color(0xFF5931DD)
//                                                     : Colors.grey,
//                                                 borderRadius:
//                                                     BorderRadius.circular(6),
//                                               ),
//                                               child: Text(
//                                                 coupon['couponCode'],
//                                                 style: const TextStyle(
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 16,
//                                                   letterSpacing: 1.2,
//                                                 ),
//                                               ),
//                                             ),
//                                             const Spacer(),
//                                             if (!isValid)
//                                               Container(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 8,
//                                                         vertical: 4),
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.red.shade50,
//                                                   borderRadius:
//                                                       BorderRadius.circular(4),
//                                                 ),
//                                                 child: Text(
//                                                   'EXPIRED',
//                                                   style: TextStyle(
//                                                     color: Colors.red.shade700,
//                                                     fontSize: 10,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 ),
//                                               ),
//                                           ],
//                                         ),
//                                         const SizedBox(height: 12),
//                                         Text(
//                                           '${coupon['discountPercentage']}% OFF',
//                                           style: TextStyle(
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.bold,
//                                             color: isValid
//                                                 ? const Color(0xFF5931DD)
//                                                 : Colors.grey,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 8),
//                                         Row(
//                                           children: [
//                                             Icon(
//                                               Icons.calendar_today,
//                                               size: 14,
//                                               color: Colors.grey.shade600,
//                                             ),
//                                             const SizedBox(width: 4),
//                                             Text(
//                                               'Valid till ${DateFormat('dd MMM yyyy').format(expiryDate)}',
//                                               style: TextStyle(
//                                                 fontSize: 12,
//                                                 color: Colors.grey.shade600,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         if (isValid) ...[
//                                           const SizedBox(height: 12),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.end,
//                                             children: [
//                                               Text(
//                                                 'Tap to apply',
//                                                 style: TextStyle(
//                                                   fontSize: 12,
//                                                   color:
//                                                       const Color(0xFF5931DD),
//                                                   fontWeight: FontWeight.w600,
//                                                 ),
//                                               ),
//                                               const SizedBox(width: 4),
//                                               const Icon(
//                                                 Icons.arrow_forward,
//                                                 size: 16,
//                                                 color: Color(0xFF5931DD),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   double calculateSubtotal(CartProvider cartProvider) {
//     double subtotal = 0.0;
//     for (var item in cartProvider.cart.items) {
//       double itemPrice = item.totalPrice ?? (widget.amount?.toDouble() ?? 0.0);
//       subtotal += itemPrice * item.quantity;
//     }
//     return subtotal;
//   }

//   double calculateTotalPayable(CartProvider cartProvider) {
//     final cart = cartProvider.cart;
//     double subtotal = cart.subTotal;
//     double platformFee = cart.platformFee;
//     double deliveryCharge = cart.deliveryCharge;

//     double totalBeforeDiscount = subtotal + platformFee + deliveryCharge;
//     double afterDiscount = totalBeforeDiscount - discountAmount;

//     return afterDiscount < 0
//         ? 0
//         : double.parse(afterDiscount.toStringAsFixed(2));
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     couponController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: SafeArea(
//         child: Consumer<CartProvider>(
//           builder: (context, cartProvider, child) {
//             // Show loading only on initial load, not on updates
//             if (cartProvider.isLoading && cartProvider.cart.items.isEmpty) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (cartProvider.errorMessage != null) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 16),
//                     Text(
//                       'Please provide your internet connection',
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                   ],
//                 ),
//               );
//             }

//             if (cartProvider.isEmpty) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.shopping_cart_outlined,
//                       size: 64,
//                       color: Colors.grey[400],
//                     ),
//                     const SizedBox(height: 16),
//                     const Text(
//                       'Your cart is empty',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     const Text(
//                       'Add some medicines to get started',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => MainLayout()));
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF5931DD),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: const Text(
//                         'Continue Shopping',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }

//             // Wrap content in FadeTransition for smooth animations
//             return FadeTransition(
//               opacity: _fadeAnimation,
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const SizedBox(height: 10),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 48,
//                                   height: 48,
//                                   decoration: BoxDecoration(
//                                       color: const Color(0XFFEFF3F7),
//                                       borderRadius: BorderRadius.circular(48)),
//                                   child: const Icon(Icons.shopping_cart),
//                                 ),
//                                 const SizedBox(width: 10),
//                                 const AppText(
//                                   "my_cart",
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 const Spacer(),
//                               ],
//                             ),
//                             const SizedBox(height: 34),
//                             _buildMedicationList(cartProvider),
//                             const SizedBox(height: 34),
//                             _buildCouponSection(),
//                             const SizedBox(height: 34),
//                             _buildCheckoutContainer(cartProvider),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   _buildCheckoutButton(cartProvider),
//                   const SizedBox(height: 40),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildMedicationList(CartProvider cartProvider) {
//     final items = cartProvider.cart.items;

//     if (items.isEmpty) {
//       return const Center(
//         child: Text(
//           'No items in cart',
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.grey,
//           ),
//         ),
//       );
//     }

//     return Column(
//       children: List.generate(
//         items.length * 2 - 1,
//         (i) {
//           if (i.isEven) {
//             final item = items[i ~/ 2];
//             return _buildMedicationItem(item, cartProvider);
//           } else {
//             return const Divider(
//               color: Color.fromARGB(255, 221, 221, 221),
//               height: 1,
//               thickness: 1,
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildMedicationItem(CartItem item, CartProvider cartProvider) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       child: Row(
//         children: [
//           Container(
//             width: 60,
//             height: 60,
//             decoration: BoxDecoration(
//               color: Colors.blue.shade100,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: item.images.isNotEmpty
//                 ? ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Image.network(
//                       item.images.first,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return Image.asset(
//                           'assets/tablet.png',
//                           fit: BoxFit.cover,
//                         );
//                       },
//                     ),
//                   )
//                 : Image.asset(
//                     'assets/tablet.png',
//                     fit: BoxFit.cover,
//                   ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   item.name,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                   ),
//                 ),
//                 Text(
//                   'Price: ₹${item.totalPrice}',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey.shade600,
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Row(
//             children: [
//               // Decrease button with animation and loading state
//               _AnimatedQuantityButton(
//                 icon: Icons.remove,
//                 onPressed: (loadingItems[item.medicineId] ?? false) || item.quantity <= 1
//                     ? null
//                     : () async {
//                         setState(() {
//                           loadingItems[item.medicineId] = true;
//                         });
                        
//                         await cartProvider.decreaseQuantity(item.medicineId);
                        
//                         // Add small delay for smoother UX
//                         await Future.delayed(const Duration(milliseconds: 300));
                        
//                         if (mounted) {
//                           setState(() {
//                             loadingItems[item.medicineId] = false;
//                           });
//                         }
//                       },
//                 isDisabled: (loadingItems[item.medicineId] ?? false) || item.quantity <= 1,
//                 backgroundColor: (loadingItems[item.medicineId] ?? false) || item.quantity <= 1
//                     ? Colors.grey.shade300
//                     : const Color.fromARGB(255, 221, 221, 221),
//               ),
//               const SizedBox(width: 8),
//               // Animated quantity display with pulsing animation
//               AnimatedSwitcher(
//                 duration: const Duration(milliseconds: 300),
//                 transitionBuilder: (Widget child, Animation<double> animation) {
//                   return ScaleTransition(
//                     scale: Tween<double>(begin: 0.5, end: 1.0).animate(
//                       CurvedAnimation(
//                         parent: animation,
//                         curve: Curves.elasticOut,
//                       ),
//                     ),
//                     child: FadeTransition(
//                       opacity: animation,
//                       child: child,
//                     ),
//                   );
//                 },
//                 child: (loadingItems[item.medicineId] ?? false)
//                     ? _PulsingLoadingIndicator(
//                         key: ValueKey<String>('loading_${item.medicineId}'),
//                       )
//                     : Container(
//                         key: ValueKey<int>(item.quantity),
//                         padding: const EdgeInsets.symmetric(horizontal: 4),
//                         child: Text(
//                           item.quantity.toString().padLeft(2, '0'),
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//               ),
//               const SizedBox(width: 8),
//               // Increase button with animation and loading state
//               _AnimatedQuantityButton(
//                 icon: Icons.add,
//                 onPressed: (loadingItems[item.medicineId] ?? false)
//                     ? null
//                     : () async {
//                         setState(() {
//                           loadingItems[item.medicineId] = true;
//                         });
                        
//                         await cartProvider.increaseQuantity(item.medicineId);
                        
//                         // Add small delay for smoother UX
//                         await Future.delayed(const Duration(milliseconds: 300));
                        
//                         if (mounted) {
//                           setState(() {
//                             loadingItems[item.medicineId] = false;
//                           });
//                         }
//                       },
//                 isDisabled: loadingItems[item.medicineId] ?? false,
//                 backgroundColor: const Color(0xFF5931DD),
//                 iconColor: Colors.white,
//               ),
//               const SizedBox(width: 25),
//               Container(
//                 width: 24,
//                 height: 24,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                       color: const Color.fromARGB(255, 221, 221, 221)),
//                   color: const Color.fromARGB(255, 255, 255, 255),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: IconButton(
//                   icon: Icon(MdiIcons.trashCanOutline,
//                       color: Colors.red.shade400, size: 20),
//                   onPressed: () async {
//                     final confirm = await showDialog<bool>(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: const Text('Remove Item'),
//                         content: Text('Remove ${item.name} from cart?'),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.pop(context, false),
//                             child: const Text('Cancel'),
//                           ),
//                           TextButton(
//                             onPressed: () => Navigator.pop(context, true),
//                             child: const Text(
//                               'Remove',
//                               style: TextStyle(color: Colors.red),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );

//                     if (confirm == true) {
//                       await cartProvider.removeFromCart(item.medicineId);
//                     }
//                   },
//                   padding: EdgeInsets.zero,
//                   constraints: const BoxConstraints(),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCouponSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (appliedCoupon != null)
//           AnimatedContainer(
//             duration: const Duration(milliseconds: 300),
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.green.shade50,
//               border: Border.all(color: Colors.green.shade300),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               children: [
//                 Icon(Icons.check_circle, color: Colors.green.shade600),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Coupon Applied: $appliedCoupon',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.green.shade700,
//                         ),
//                       ),
//                       Text(
//                         'Discount: -₹${discountAmount.toStringAsFixed(2)}',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.green.shade600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.close),
//                   onPressed: removeCoupon,
//                   constraints: const BoxConstraints(),
//                   padding: EdgeInsets.zero,
//                 )
//               ],
//             ),
//           )
//         else
//           Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade100,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: couponController,
//                         decoration: InputDecoration(
//                           hintText: AppText.translate(context, 'enter_coupon'),
//                           border: InputBorder.none,
//                           enabled: !isLoadingCoupons,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: 48,
//                       width: 48,
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF6C4DFF),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: isLoadingCoupons
//                           ? const Padding(
//                               padding: EdgeInsets.all(12.0),
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2,
//                                 valueColor:
//                                     AlwaysStoppedAnimation<Color>(Colors.white),
//                               ),
//                             )
//                           : IconButton(
//                               icon: const Icon(Icons.arrow_forward,
//                                   color: Colors.white),
//                               onPressed: () {
//                                 if (couponController.text.isEmpty) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content:
//                                           Text('Please enter a coupon code'),
//                                       duration: Duration(seconds: 2),
//                                     ),
//                                   );
//                                   return;
//                                 }

//                                 if (coupons.isEmpty) {
//                                   fetchCoupons().then((_) {
//                                     if (coupons.isNotEmpty) {
//                                       applyCoupon(couponController.text.trim());
//                                     }
//                                   });
//                                 } else {
//                                   applyCoupon(couponController.text.trim());
//                                 }
//                               },
//                             ),
//                     )
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton.icon(
//                   onPressed: showCouponsModal,
//                   icon: const Icon(
//                     Icons.local_offer,
//                     size: 18,
//                     color: Color(0xFF5931DD),
//                   ),
//                   label: const Text(
//                     'View All Coupons',
//                     style: TextStyle(
//                       color: Color(0xFF5931DD),
//                       fontWeight: FontWeight.w600,
//                       fontSize: 14,
//                     ),
//                   ),
//                   style: TextButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 8,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//       ],
//     );
//   }

//   Widget _buildCheckoutButton(CartProvider cartProvider) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: SizedBox(
//         width: double.infinity,
//         height: 50,
//         child: ElevatedButton(
//           onPressed: cartProvider.isEmpty
//               ? null
//               : () {
//                   final totalAmount = calculateTotalPayable(cartProvider);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => PaymentScreen(
//                               amount: totalAmount.toString(),
//                               coupouncode: appliedCoupon,
//                             )),
//                   );
//                 },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFF5931DD),
//             disabledBackgroundColor: Colors.grey,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//           child: const AppText(
//             'checkout',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCheckoutContainer(CartProvider cartProvider) {
//     final cart = cartProvider.cart;
//     final totalAmount = calculateTotalPayable(cartProvider);

//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//       width: 343,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: const Color(0xFFEFF3F7),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildPriceRow(
//               'total_items', '${cart.totalItems.toString().padLeft(2, '0')}'),
//           const SizedBox(height: 8),
//           _buildPriceRow('sub_total', '₹${cart.subTotal}'),
//           const SizedBox(height: 8),
//           _buildPriceRow(
//               'platform_fee', '₹${cart.platformFee.toStringAsFixed(2)}'),
//           const SizedBox(height: 8),
//           if (discountAmount > 0) ...[
//             const SizedBox(height: 8),
//             _buildPriceRow(
//               'discount',
//               '-₹${discountAmount.toStringAsFixed(2)}',
//               isDiscount: true,
//             ),
//           ],
//           const SizedBox(height: 8),
//           _buildPriceRow(
//               'delivery_charge', '₹${cart.deliveryCharge.toStringAsFixed(2)}'),
//           const Divider(height: 24, thickness: 1),
//           _buildPriceRow(
//             'total_payable',
//             '₹${totalAmount.toString()}',
//             isTotal: true,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPriceRow(String label, String value,
//       {bool isTotal = false, bool isDiscount = false}) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           AppText(
//             label,
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//               color: isDiscount
//                   ? Colors.green.shade600
//                   : isTotal
//                       ? const Color(0xFF5931DD)
//                       : Colors.black.withOpacity(0.5),
//             ),
//           ),
//           AnimatedSwitcher(
//             duration: const Duration(milliseconds: 300),
//             transitionBuilder: (Widget child, Animation<double> animation) {
//               return FadeTransition(
//                 opacity: animation,
//                 child: SlideTransition(
//                   position: Tween<Offset>(
//                     begin: const Offset(0.3, 0),
//                     end: Offset.zero,
//                   ).animate(animation),
//                   child: child,
//                 ),
//               );
//             },
//             child: Text(
//               value,
//               key: ValueKey<String>(value),
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: isTotal ? FontWeight.bold : FontWeight.bold,
//                 color: isDiscount
//                     ? Colors.green.shade600
//                     : isTotal
//                         ? const Color(0xFF5931DD)
//                         : Colors.black,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Custom animated button widget for quantity controls
// class _AnimatedQuantityButton extends StatefulWidget {
//   final IconData icon;
//   final VoidCallback? onPressed;
//   final Color backgroundColor;
//   final Color? iconColor;
//   final bool isDisabled;

//   const _AnimatedQuantityButton({
//     required this.icon,
//     required this.onPressed,
//     required this.backgroundColor,
//     this.iconColor,
//     this.isDisabled = false,
//   });

//   @override
//   State<_AnimatedQuantityButton> createState() =>
//       _AnimatedQuantityButtonState();
// }

// class _AnimatedQuantityButtonState extends State<_AnimatedQuantityButton>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 150),
//       vsync: this,
//     );
//     _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _onTapDown(TapDownDetails details) {
//     if (!widget.isDisabled) {
//       _controller.forward();
//     }
//   }

//   void _onTapUp(TapUpDetails details) {
//     if (!widget.isDisabled) {
//       _controller.reverse();
//     }
//   }

//   void _onTapCancel() {
//     if (!widget.isDisabled) {
//       _controller.reverse();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: _onTapDown,
//       onTapUp: _onTapUp,
//       onTapCancel: _onTapCancel,
//       child: ScaleTransition(
//         scale: _scaleAnimation,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           width: 24,
//           height: 24,
//           decoration: BoxDecoration(
//             color: widget.backgroundColor,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: widget.isDisabled
//                 ? []
//                 : [
//                     BoxShadow(
//                       color: widget.backgroundColor.withOpacity(0.3),
//                       blurRadius: 4,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//           ),
//           child: Material(
//             color: Colors.transparent,
//             child: InkWell(
//               borderRadius: BorderRadius.circular(12),
//               onTap: widget.onPressed,
//               child: Icon(
//                 widget.icon,
//                 size: widget.icon == Icons.add ? 16 : 20,
//                 color: widget.iconColor ??
//                     (widget.isDisabled ? Colors.grey : Colors.black),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Pulsing loading indicator widget
// class _PulsingLoadingIndicator extends StatefulWidget {
//   const _PulsingLoadingIndicator({Key? key}) : super(key: key);

//   @override
//   State<_PulsingLoadingIndicator> createState() => _PulsingLoadingIndicatorState();
// }

// class _PulsingLoadingIndicatorState extends State<_PulsingLoadingIndicator>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _opacityAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     )..repeat(reverse: true);

//     _scaleAnimation = Tween<double>(begin: 0.7, end: 1.2).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );

//     _opacityAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
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
//         return Opacity(
//           opacity: _opacityAnimation.value,
//           child: Transform.scale(
//             scale: _scaleAnimation.value,
//             child: Container(
//               width: 24,
//               height: 24,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: const Color(0xFF5931DD).withOpacity(0.3),
//                 border: Border.all(
//                   color: const Color(0xFF5931DD),
//                   width: 2,
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }











///////// New cart screen for fixed the amount mismatch issue////////////////////////




import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_user_app/providers/language_provider.dart';
import 'package:medical_user_app/providers/cart_provider.dart';
import 'package:medical_user_app/models/cart_model.dart';
import 'package:medical_user_app/view/main_layout.dart';
import 'package:medical_user_app/view/payment_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartScreen extends StatefulWidget {
  final double? amount;
  const CartScreen({super.key, this.amount});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with SingleTickerProviderStateMixin {
  bool isWeeklySelected = true;
  int selectedDateIndex = 0;

  TextEditingController couponController = TextEditingController();
  List<dynamic> coupons = [];
  bool isLoadingCoupons = false;
  String? appliedCoupon;
  double discountAmount = 0.0;

  // Track loading state for each item
  Map<String, bool> loadingItems = {};

  // Animation controller for smooth transitions
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CartProvider>(context, listen: false).initializeCart();
    });
  }

  Future<void> fetchCoupons() async {
    setState(() {
      isLoadingCoupons = true;
    });

    try {
      final response = await http.get(
        Uri.parse('http://31.97.206.144:7021/api/admin/getcoupons'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          coupons = data['coupons'] ?? [];
        });

        if (coupons.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No coupons available'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to fetch coupons'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          duration: const Duration(seconds: 2),
        ),
      );
    } finally {
      setState(() {
        isLoadingCoupons = false;
      });
    }
  }

  bool isCouponValid(dynamic coupon) {
    final expirationDate = DateTime.parse(coupon['expirationDate'].toString());
    return expirationDate.isAfter(DateTime.now());
  }

  void applyCoupon(String couponCode) {
    try {
      final coupon = coupons.firstWhere(
        (c) =>
            c['couponCode'].toString().toLowerCase() ==
            couponCode.toLowerCase(),
        orElse: () => null,
      );

      if (coupon == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Coupon not found'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      if (!isCouponValid(coupon)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Coupon has expired'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      final discountPercentage =
          (coupon['discountPercentage'] as num).toDouble();
      final discount = (cartProvider.cart.subTotal * discountPercentage / 100);

      setState(() {
        appliedCoupon = couponCode;
        discountAmount = double.parse(discount.toString());
      });

      couponController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Coupon applied! Discount: ₹${discountAmount.toStringAsFixed(2)}'),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error applying coupon: $e'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void removeCoupon() {
    setState(() {
      appliedCoupon = null;
      discountAmount = 0.0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Coupon removed'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void showCouponsModal() async {
    if (coupons.isEmpty) {
      await fetchCoupons();
    }

    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
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
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Available Coupons',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: isLoadingCoupons
                  ? const Center(child: CircularProgressIndicator())
                  : coupons.isEmpty
                      ? const Center(
                          child: Text(
                            'No coupons available',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: coupons.length,
                          itemBuilder: (context, index) {
                            final coupon = coupons[index];
                            final isValid = isCouponValid(coupon);
                            final expiryDate = DateTime.parse(
                                coupon['expirationDate'].toString());

                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: isValid
                                    ? Colors.white
                                    : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isValid
                                      ? const Color(0xFF5931DD)
                                      : Colors.grey.shade300,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: isValid
                                      ? () {
                                          Navigator.pop(context);
                                          couponController.text =
                                              coupon['couponCode'];
                                          applyCoupon(coupon['couponCode']);
                                        }
                                      : null,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 6),
                                              decoration: BoxDecoration(
                                                color: isValid
                                                    ? const Color(0xFF5931DD)
                                                    : Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                coupon['couponCode'],
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  letterSpacing: 1.2,
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            if (!isValid)
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: Colors.red.shade50,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  'EXPIRED',
                                                  style: TextStyle(
                                                    color: Colors.red.shade700,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          '${coupon['discountPercentage']}% OFF',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: isValid
                                                ? const Color(0xFF5931DD)
                                                : Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today,
                                              size: 14,
                                              color: Colors.grey.shade600,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              'Valid till ${DateFormat('dd MMM yyyy').format(expiryDate)}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (isValid) ...[
                                          const SizedBox(height: 12),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Tap to apply',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      const Color(0xFF5931DD),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              const Icon(
                                                Icons.arrow_forward,
                                                size: 16,
                                                color: Color(0xFF5931DD),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  double calculateSubtotal(CartProvider cartProvider) {
    double subtotal = 0.0;
    for (var item in cartProvider.cart.items) {
      double itemPrice = item.totalPrice ?? (widget.amount?.toDouble() ?? 0.0);
      subtotal += itemPrice * item.quantity;
    }
    return subtotal;
  }

  double calculateTotalPayable(CartProvider cartProvider) {
    final cart = cartProvider.cart;
    double subtotal = cart.subTotal;
    double platformFee = cart.platformFee;
    double deliveryCharge = cart.deliveryCharge;

    double totalBeforeDiscount = subtotal + platformFee + deliveryCharge;
    double afterDiscount = totalBeforeDiscount - discountAmount;

    return afterDiscount < 0
        ? 0
        : double.parse(afterDiscount.toStringAsFixed(2));
  }

  /// Returns true if any cart item is currently being updated
  bool get _isAnyItemLoading => loadingItems.values.any((v) => v == true);

  @override
  void dispose() {
    _animationController.dispose();
    couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            if (cartProvider.isLoading && cartProvider.cart.items.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (cartProvider.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      'Please provide your internet connection',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            }

            if (cartProvider.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Your cart is empty',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Add some medicines to get started',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainLayout()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5931DD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Continue Shopping',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            }

            return FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                      color: const Color(0XFFEFF3F7),
                                      borderRadius: BorderRadius.circular(48)),
                                  child: const Icon(Icons.shopping_cart),
                                ),
                                const SizedBox(width: 10),
                                const AppText(
                                  "my_cart",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                              ],
                            ),
                            const SizedBox(height: 34),
                            _buildMedicationList(cartProvider),
                            const SizedBox(height: 34),
                            _buildCouponSection(),
                            const SizedBox(height: 34),
                            _buildCheckoutContainer(cartProvider),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _buildCheckoutButton(cartProvider),
                  const SizedBox(height: 40),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMedicationList(CartProvider cartProvider) {
    final items = cartProvider.cart.items;

    if (items.isEmpty) {
      return const Center(
        child: Text(
          'No items in cart',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return Column(
      children: List.generate(
        items.length * 2 - 1,
        (i) {
          if (i.isEven) {
            final item = items[i ~/ 2];
            return _buildMedicationItem(item, cartProvider);
          } else {
            return const Divider(
              color: Color.fromARGB(255, 221, 221, 221),
              height: 1,
              thickness: 1,
            );
          }
        },
      ),
    );
  }

  Widget _buildMedicationItem(CartItem item, CartProvider cartProvider) {
    final bool isItemLoading = loadingItems[item.medicineId] ?? false;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          // ── Product image ──────────────────────────────────────────────
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: item.images.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item.images.first,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/tablet.png',
                            fit: BoxFit.cover);
                      },
                    ),
                  )
                : Image.asset('assets/tablet.png', fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),

          // ── Name + price ───────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                // FIX: hide price while updating to avoid showing stale value
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: isItemLoading
                      ? Text(
                          'Updating...',
                          key: const ValueKey('updating'),
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade400),
                        )
                      : Text(
                          'Price: ₹${item.totalPrice}',
                          key: ValueKey('price_${item.totalPrice}'),
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600),
                        ),
                ),
              ],
            ),
          ),

          // ── Quantity controls ──────────────────────────────────────────
          Row(
            children: [
              // Decrease button
              _AnimatedQuantityButton(
                icon: Icons.remove,
                onPressed: isItemLoading || item.quantity <= 1
                    ? null
                    : () async {
                        setState(() => loadingItems[item.medicineId] = true);
                        await cartProvider.decreaseQuantity(item.medicineId);
                        // FIX: removed artificial Future.delayed — clear flag
                        // immediately after the provider finishes so the UI
                        // shows the correct updated value right away.
                        if (mounted) {
                          setState(
                              () => loadingItems[item.medicineId] = false);
                        }
                      },
                isDisabled: isItemLoading || item.quantity <= 1,
                backgroundColor: isItemLoading || item.quantity <= 1
                    ? Colors.grey.shade300
                    : const Color.fromARGB(255, 221, 221, 221),
              ),
              const SizedBox(width: 8),

              // Quantity display / pulsing loader
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(
                    scale: Tween<double>(begin: 0.5, end: 1.0).animate(
                      CurvedAnimation(
                          parent: animation, curve: Curves.elasticOut),
                    ),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: isItemLoading
                    ? _PulsingLoadingIndicator(
                        key: ValueKey<String>('loading_${item.medicineId}'),
                      )
                    : Container(
                        key: ValueKey<int>(item.quantity),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          item.quantity.toString().padLeft(2, '0'),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
              ),
              const SizedBox(width: 8),

              // Increase button
              _AnimatedQuantityButton(
                icon: Icons.add,
                onPressed: isItemLoading
                    ? null
                    : () async {
                        setState(() => loadingItems[item.medicineId] = true);
                        await cartProvider.increaseQuantity(item.medicineId);
                        // FIX: removed artificial Future.delayed
                        if (mounted) {
                          setState(
                              () => loadingItems[item.medicineId] = false);
                        }
                      },
                isDisabled: isItemLoading,
                backgroundColor: const Color(0xFF5931DD),
                iconColor: Colors.white,
              ),
              const SizedBox(width: 25),

              // Delete button
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 221, 221, 221)),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: Icon(MdiIcons.trashCanOutline,
                      color: Colors.red.shade400, size: 20),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Remove Item'),
                        content: Text('Remove ${item.name} from cart?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Remove',
                                style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      await cartProvider.removeFromCart(item.medicineId);
                    }
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCouponSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (appliedCoupon != null)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              border: Border.all(color: Colors.green.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green.shade600),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Coupon Applied: $appliedCoupon',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700),
                      ),
                      Text(
                        'Discount: -₹${discountAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 12, color: Colors.green.shade600),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: removeCoupon,
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                )
              ],
            ),
          )
        else
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: couponController,
                        decoration: InputDecoration(
                          hintText: AppText.translate(context, 'enter_coupon'),
                          border: InputBorder.none,
                          enabled: !isLoadingCoupons,
                        ),
                      ),
                    ),
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C4DFF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: isLoadingCoupons
                          ? const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              ),
                            )
                          : IconButton(
                              icon: const Icon(Icons.arrow_forward,
                                  color: Colors.white),
                              onPressed: () {
                                if (couponController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Please enter a coupon code'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                  return;
                                }
                                if (coupons.isEmpty) {
                                  fetchCoupons().then((_) {
                                    if (coupons.isNotEmpty) {
                                      applyCoupon(
                                          couponController.text.trim());
                                    }
                                  });
                                } else {
                                  applyCoupon(couponController.text.trim());
                                }
                              },
                            ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: showCouponsModal,
                  icon: const Icon(Icons.local_offer,
                      size: 18, color: Color(0xFF5931DD)),
                  label: const Text(
                    'View All Coupons',
                    style: TextStyle(
                        color: Color(0xFF5931DD),
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildCheckoutButton(CartProvider cartProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: cartProvider.isEmpty
              ? null
              : () {
                  final totalAmount = calculateTotalPayable(cartProvider);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentScreen(
                              amount: totalAmount.toString(),
                              coupouncode: appliedCoupon,
                            )),
                  );
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5931DD),
            disabledBackgroundColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const AppText(
            'checkout',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckoutContainer(CartProvider cartProvider) {
    final cart = cartProvider.cart;
    final totalAmount = calculateTotalPayable(cartProvider);

    // FIX: dim the entire summary box while any item quantity is updating
    // so users never see an inconsistent subtotal/total during the async gap.
    return AnimatedOpacity(
      opacity: _isAnyItemLoading ? 0.45 : 1.0,
      duration: const Duration(milliseconds: 200),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 343,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF3F7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPriceRow(
                'total_items', '${cart.totalItems.toString().padLeft(2, '0')}'),
            const SizedBox(height: 8),
            _buildPriceRow('sub_total', '₹${cart.subTotal}'),
            const SizedBox(height: 8),
            _buildPriceRow(
                'platform_fee', '₹${cart.platformFee.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            if (discountAmount > 0) ...[
              const SizedBox(height: 8),
              _buildPriceRow(
                'discount',
                '-₹${discountAmount.toStringAsFixed(2)}',
                isDiscount: true,
              ),
            ],
            const SizedBox(height: 8),
            _buildPriceRow('delivery_charge',
                '₹${cart.deliveryCharge.toStringAsFixed(2)}'),
            const Divider(height: 24, thickness: 1),
            _buildPriceRow(
              'total_payable',
              '₹${totalAmount.toString()}',
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value,
      {bool isTotal = false, bool isDiscount = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isDiscount
                  ? Colors.green.shade600
                  : isTotal
                      ? const Color(0xFF5931DD)
                      : Colors.black.withOpacity(0.5),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.3, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: Text(
              value,
              key: ValueKey<String>(value),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isDiscount
                    ? Colors.green.shade600
                    : isTotal
                        ? const Color(0xFF5931DD)
                        : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Custom animated quantity button ──────────────────────────────────────────

class _AnimatedQuantityButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color? iconColor;
  final bool isDisabled;

  const _AnimatedQuantityButton({
    required this.icon,
    required this.onPressed,
    required this.backgroundColor,
    this.iconColor,
    this.isDisabled = false,
  });

  @override
  State<_AnimatedQuantityButton> createState() =>
      _AnimatedQuantityButtonState();
}

class _AnimatedQuantityButtonState extends State<_AnimatedQuantityButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (!widget.isDisabled) _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    if (!widget.isDisabled) _controller.reverse();
  }

  void _onTapCancel() {
    if (!widget.isDisabled) _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: widget.isDisabled
                ? []
                : [
                    BoxShadow(
                      color: widget.backgroundColor.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: widget.onPressed,
              child: Icon(
                widget.icon,
                size: widget.icon == Icons.add ? 16 : 20,
                color: widget.iconColor ??
                    (widget.isDisabled ? Colors.grey : Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Pulsing loading indicator ─────────────────────────────────────────────────

class _PulsingLoadingIndicator extends StatefulWidget {
  const _PulsingLoadingIndicator({Key? key}) : super(key: key);

  @override
  State<_PulsingLoadingIndicator> createState() =>
      _PulsingLoadingIndicatorState();
}

class _PulsingLoadingIndicatorState extends State<_PulsingLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
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
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF5931DD).withOpacity(0.3),
                border: Border.all(color: const Color(0xFF5931DD), width: 2),
              ),
            ),
          ),
        );
      },
    );
  }
}