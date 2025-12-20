// // // import 'package:flutter/material.dart';
// // // import 'package:medical_user_app/utils/shared_preferences_helper.dart';
// // // import 'package:provider/provider.dart';
// // // import 'package:medical_user_app/providers/address_provider.dart';

// // // class ChangeAddressScreen extends StatefulWidget {
// // //   const ChangeAddressScreen({Key? key}) : super(key: key);

// // //   @override
// // //   State<ChangeAddressScreen> createState() => _ChangeAddressScreenState();
// // // }

// // // class _ChangeAddressScreenState extends State<ChangeAddressScreen> {
// // //   // Text controllers for form fields
// // //   final TextEditingController _countryController = TextEditingController();
// // //   final TextEditingController _stateController = TextEditingController();
// // //   final TextEditingController _cityController = TextEditingController();
// // //   final TextEditingController _pincodeController = TextEditingController();
// // //   final TextEditingController _houseController = TextEditingController();
// // //   final TextEditingController _streetController = TextEditingController();
// // //   final TextEditingController _searchController = TextEditingController();

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     // Fetch addresses when screen loads
// // //     WidgetsBinding.instance.addPostFrameCallback((_) {
// // //       context.read<AddressProvider>().fetchAddresses();
// // //     });
// // //   }

// // //   Future<void> _debugUserData() async {
// // //     try {
// // //       print('=== DEBUG USER DATA IN SCREEN ===');

// // //       final authData = await SharedPreferencesHelper.getAuthData();
// // //       print('Auth Data: $authData');

// // //       final user = authData['user'];
// // //       if (user != null) {
// // //         print('User found in screen:');
// // //         print('- Type: ${user.runtimeType}');
// // //         print('- ID: ${user.id}');
// // //         print('- toString: ${user.toString()}');
// // //       } else {
// // //         print('No user found in screen');
// // //       }

// // //       print('=== END DEBUG SCREEN ===');
// // //     } catch (e) {
// // //       print('Screen debug error: $e');
// // //     }
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _countryController.dispose();
// // //     _stateController.dispose();
// // //     _cityController.dispose();
// // //     _pincodeController.dispose();
// // //     _houseController.dispose();
// // //     _streetController.dispose();
// // //     _searchController.dispose();
// // //     super.dispose();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.white,
// // //       appBar: AppBar(
// // //         backgroundColor: Colors.white,
// // //         elevation: 0,
// // //         centerTitle: true,
// // //         title: const Text(
// // //           'Change Address',
// // //           style: TextStyle(
// // //               color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
// // //         ),
// // //         leading: InkWell(
// // //           onTap: () => Navigator.pop(context),
// // //           child: Container(
// // //             margin: const EdgeInsets.all(8),
// // //             decoration: BoxDecoration(
// // //               color: Colors.white,
// // //               border: Border.all(color: Colors.grey.shade300),
// // //               borderRadius: BorderRadius.circular(8),
// // //             ),
// // //             child: const Icon(Icons.arrow_back_ios_new, size: 18),
// // //           ),
// // //         ),
// // //       ),
// // //       body: Consumer<AddressProvider>(
// // //         builder: (context, addressProvider, child) {
// // //           return Padding(
// // //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // //             child: Column(
// // //               mainAxisAlignment: MainAxisAlignment.start,
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 const SizedBox(height: 30),

// // //                 // Search Bar
// // //                 Container(
// // //                   height: 50,
// // //                   decoration: BoxDecoration(
// // //                     color: Colors.grey[200],
// // //                     borderRadius: BorderRadius.circular(8),
// // //                   ),
// // //                   child: TextField(
// // //                     controller: _searchController,
// // //                     decoration: InputDecoration(
// // //                       border: InputBorder.none,
// // //                       prefixIcon: Icon(
// // //                         Icons.search,
// // //                         color: Colors.grey[600],
// // //                       ),
// // //                       hintText: 'Search your City',
// // //                       hintStyle: TextStyle(
// // //                         color: Colors.grey[600],
// // //                         fontSize: 16,
// // //                       ),
// // //                       contentPadding: const EdgeInsets.symmetric(
// // //                         horizontal: 12,
// // //                         vertical: 15,
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ),
// // //                 const SizedBox(height: 16),

// // //                 // Choose Location on Map Button
// // //                 InkWell(
// // //                   onTap: () {
// // //                     // TODO: Implement map location selection
// // //                     ScaffoldMessenger.of(context).showSnackBar(
// // //                       const SnackBar(
// // //                         content: Text('Map location feature coming soon!'),
// // //                       ),
// // //                     );
// // //                   },
// // //                   child: Container(
// // //                     width: 230,
// // //                     height: 36,
// // //                     padding: const EdgeInsets.all(4),
// // //                     decoration: BoxDecoration(
// // //                       borderRadius: BorderRadius.circular(10),
// // //                       border: Border.all(
// // //                           color: const Color.fromARGB(255, 187, 187, 187)),
// // //                     ),
// // //                     child: const Row(
// // //                       children: [
// // //                         Icon(Icons.my_location, size: 18),
// // //                         SizedBox(width: 16),
// // //                         Text(
// // //                           'Choose Location On Map',
// // //                           style: TextStyle(
// // //                             fontSize: 16,
// // //                             fontWeight: FontWeight.w500,
// // //                           ),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                 ),

// // //                 const SizedBox(height: 20),
// // //                 const Divider(),

// // //                 // Error Message
// // //                 if (addressProvider.errorMessage.isNotEmpty)
// // //                   Container(
// // //                     margin: const EdgeInsets.only(bottom: 16),
// // //                     padding: const EdgeInsets.all(12),
// // //                     decoration: BoxDecoration(
// // //                       color: Colors.red.shade50,
// // //                       borderRadius: BorderRadius.circular(8),
// // //                       border: Border.all(color: Colors.red.shade200),
// // //                     ),
// // //                     child: Row(
// // //                       children: [
// // //                         Icon(Icons.error_outline, color: Colors.red.shade600),
// // //                         const SizedBox(width: 8),
// // //                         Expanded(
// // //                           child: Text(
// // //                             addressProvider.errorMessage,
// // //                             style: TextStyle(
// // //                               color: Colors.red.shade700,
// // //                               fontSize: 14,
// // //                             ),
// // //                           ),
// // //                         ),
// // //                         IconButton(
// // //                           onPressed: () => addressProvider.clearError(),
// // //                           icon: Icon(Icons.close,
// // //                             color: Colors.red.shade600,
// // //                             size: 20,
// // //                           ),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),

// // //                 // Saved Locations List
// // //                 Expanded(
// // //                   child: addressProvider.isLoading
// // //                       ? const Center(
// // //                           child: CircularProgressIndicator(
// // //                             color: Color(0xFF6A3DE8),
// // //                           ),
// // //                         )
// // //                       : addressProvider.addresses.isEmpty
// // //                           ? const Center(
// // //                               child: Column(
// // //                                 mainAxisAlignment: MainAxisAlignment.center,
// // //                                 children: [
// // //                                   Icon(
// // //                                     Icons.location_off,
// // //                                     size: 64,
// // //                                     color: Colors.grey,
// // //                                   ),
// // //                                   SizedBox(height: 16),
// // //                                   Text(
// // //                                     'No addresses found',
// // //                                     style: TextStyle(
// // //                                       fontSize: 16,
// // //                                       color: Colors.grey,
// // //                                     ),
// // //                                   ),
// // //                                   SizedBox(height: 8),
// // //                                   Text(
// // //                                     'Add your first address below',
// // //                                     style: TextStyle(
// // //                                       fontSize: 14,
// // //                                       color: Colors.grey,
// // //                                     ),
// // //                                   ),
// // //                                 ],
// // //                               ),
// // //                             )
// // //                           : RefreshIndicator(
// // //                               onRefresh: () => addressProvider.fetchAddresses(),
// // //                               child: ListView.builder(
// // //                                 itemCount: addressProvider.addresses.length,
// // //                                 itemBuilder: (context, index) {
// // //                                   final address = addressProvider.addresses[index];
// // //                                   return Column(
// // //                                     children: [
// // //                                       ListTile(
// // //                                         contentPadding:
// // //                                             const EdgeInsets.symmetric(vertical: 1),
// // //                                         leading: const Icon(Icons.location_on_outlined,
// // //                                             color: Colors.black),
// // //                                         title: Text(
// // //                                           _buildAddressString(address),
// // //                                           style: const TextStyle(
// // //                                             fontSize: 16,
// // //                                             fontWeight: FontWeight.w500,
// // //                                           ),
// // //                                         ),
// // //                                         subtitle: Text(
// // //                                           _buildFullAddressString(address),
// // //                                           style: TextStyle(
// // //                                             fontSize: 12,
// // //                                             color: Colors.grey[600],
// // //                                           ),
// // //                                         ),
// // //                                         trailing: Icon(
// // //                                           Icons.chevron_right,
// // //                                           color: Colors.grey[400],
// // //                                         ),
// // //                                         onTap: () {
// // //                                           // Handle location selection and return to payment screen
// // //                                           _selectAddress(address);
// // //                                         },
// // //                                       ),
// // //                                       const Divider(),
// // //                                     ],
// // //                                   );
// // //                                 },
// // //                               ),
// // //                             ),
// // //                 ),

// // //                 // Add Address Button
// // //                 Padding(
// // //                   padding: const EdgeInsets.symmetric(vertical: 16.0),
// // //                   child: SizedBox(
// // //                     width: double.infinity,
// // //                     height: 50,
// // //                     child: ElevatedButton(
// // //                       onPressed: addressProvider.isLoading
// // //                           ? null
// // //                           : () => _showAddAddressPopup(context),
// // //                       style: ElevatedButton.styleFrom(
// // //                         backgroundColor: const Color(0xFF6A3DE8),
// // //                         disabledBackgroundColor: Colors.grey.shade300,
// // //                         shape: RoundedRectangleBorder(
// // //                           borderRadius: BorderRadius.circular(8),
// // //                         ),
// // //                       ),
// // //                       child: addressProvider.isLoading
// // //                           ? const SizedBox(
// // //                               height: 20,
// // //                               width: 20,
// // //                               child: CircularProgressIndicator(
// // //                                 strokeWidth: 2,
// // //                                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
// // //                               ),
// // //                             )
// // //                           : const Text(
// // //                               'Add Address',
// // //                               style: TextStyle(
// // //                                 fontSize: 16,
// // //                                 fontWeight: FontWeight.bold,
// // //                                 color: Colors.white,
// // //                               ),
// // //                             ),
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }

// // //   void _selectAddress(Map<String, dynamic> address) {
// // //     // Show confirmation dialog before selecting
// // //     showDialog(
// // //       context: context,
// // //       builder: (BuildContext context) {
// // //         return AlertDialog(
// // //           title: const Text('Select Address'),
// // //           content: Column(
// // //             mainAxisSize: MainAxisSize.min,
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               const Text('Do you want to use this address for delivery?'),
// // //               const SizedBox(height: 12),
// // //               Container(
// // //                 padding: const EdgeInsets.all(12),
// // //                 decoration: BoxDecoration(
// // //                   color: Colors.grey.shade50,
// // //                   borderRadius: BorderRadius.circular(8),
// // //                   border: Border.all(color: Colors.grey.shade300),
// // //                 ),
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     Text(
// // //                       _buildAddressString(address),
// // //                       style: const TextStyle(
// // //                         fontWeight: FontWeight.bold,
// // //                         fontSize: 16,
// // //                       ),
// // //                     ),
// // //                     const SizedBox(height: 4),
// // //                     Text(
// // //                       _buildFullAddressString(address),
// // //                       style: TextStyle(
// // //                         color: Colors.grey[600],
// // //                         fontSize: 14,
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //           actions: [
// // //             TextButton(
// // //               onPressed: () {
// // //                 Navigator.of(context).pop();
// // //               },
// // //               child: const Text('Cancel'),
// // //             ),
// // //             ElevatedButton(
// // //               onPressed: () {
// // //                 Navigator.of(context).pop();
// // //                 // Return the selected address to PaymentScreen
// // //                 Navigator.pop(context, address);
// // //               },
// // //               style: ElevatedButton.styleFrom(
// // //                 backgroundColor: const Color(0xFF6A3DE8),
// // //               ),
// // //               child: const Text(
// // //                 'Use This Address',
// // //                 style: TextStyle(color: Colors.white),
// // //               ),
// // //             ),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }

// // //   String _buildAddressString(Map<String, dynamic> address) {
// // //     final city = address['city'] ?? '';
// // //     final state = address['state'] ?? '';
// // //     return city.isNotEmpty && state.isNotEmpty ? '$city, $state' : 'Unknown Location';
// // //   }

// // //   String _buildFullAddressString(Map<String, dynamic> address) {
// // //     final house = address['house'] ?? '';
// // //     final street = address['street'] ?? '';
// // //     final city = address['city'] ?? '';
// // //     final state = address['state'] ?? '';
// // //     final pincode = address['pincode'] ?? '';

// // //     List<String> parts = [];
// // //     if (house.isNotEmpty) parts.add(house);
// // //     if (street.isNotEmpty) parts.add(street);
// // //     if (city.isNotEmpty) parts.add(city);
// // //     if (state.isNotEmpty) parts.add(state);
// // //     if (pincode.isNotEmpty) parts.add(pincode);

// // //     return parts.join(', ');
// // //   }

// // //   void _showAddAddressPopup(BuildContext context) {
// // //     // Clear controllers
// // //     _clearControllers();

// // //     showModalBottomSheet(
// // //       context: context,
// // //       isScrollControlled: true,
// // //       backgroundColor: Colors.transparent,
// // //       builder: (context) {
// // //         return Consumer<AddressProvider>(
// // //           builder: (context, addressProvider, child) {
// // //             return DraggableScrollableSheet(
// // //               initialChildSize: 0.9,
// // //               maxChildSize: 0.95,
// // //               minChildSize: 0.5,
// // //               expand: false,
// // //               builder: (context, scrollController) {
// // //                 return Container(
// // //                   padding: const EdgeInsets.all(16),
// // //                   decoration: const BoxDecoration(
// // //                     color: Colors.white,
// // //                     borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
// // //                   ),
// // //                   child: SingleChildScrollView(
// // //                     controller: scrollController,
// // //                     child: Column(
// // //                       crossAxisAlignment: CrossAxisAlignment.center,
// // //                       children: [
// // //                         const Text(
// // //                           "Add Address",
// // //                           style: TextStyle(
// // //                             fontSize: 18,
// // //                             fontWeight: FontWeight.bold,
// // //                           ),
// // //                         ),
// // //                         const SizedBox(height: 16),

// // //                         // Error Message in popup
// // //                         if (addressProvider.errorMessage.isNotEmpty)
// // //                           Container(
// // //                             margin: const EdgeInsets.only(bottom: 16),
// // //                             padding: const EdgeInsets.all(12),
// // //                             decoration: BoxDecoration(
// // //                               color: Colors.red.shade50,
// // //                               borderRadius: BorderRadius.circular(8),
// // //                               border: Border.all(color: Colors.red.shade200),
// // //                             ),
// // //                             child: Row(
// // //                               children: [
// // //                                 Icon(Icons.error_outline, color: Colors.red.shade600),
// // //                                 const SizedBox(width: 8),
// // //                                 Expanded(
// // //                                   child: Text(
// // //                                     addressProvider.errorMessage,
// // //                                     style: TextStyle(
// // //                                       color: Colors.red.shade700,
// // //                                       fontSize: 14,
// // //                                     ),
// // //                                   ),
// // //                                 ),
// // //                               ],
// // //                             ),
// // //                           ),

// // //                         // Text fields
// // //                         _buildTextField("Country", "Enter country", _countryController),
// // //                         const SizedBox(height: 10),
// // //                         _buildTextField("State", "Enter state", _stateController),
// // //                         const SizedBox(height: 10),
// // //                         _buildTextField("City", "Enter city", _cityController),
// // //                         const SizedBox(height: 10),
// // //                         _buildTextField("Pincode", "Enter pincode", _pincodeController),
// // //                         const SizedBox(height: 10),
// // //                         _buildTextField("House/Flat No.", "Enter house/flat number", _houseController),
// // //                         const SizedBox(height: 10),
// // //                         _buildTextField("Street", "Enter street name", _streetController),

// // //                         const SizedBox(height: 20),

// // //                         // Save button
// // //                         SizedBox(
// // //                           width: double.infinity,
// // //                           height: 48,
// // //                           child: ElevatedButton(
// // //                             style: ElevatedButton.styleFrom(
// // //                               backgroundColor: const Color(0xFF6A3DE8),
// // //                               disabledBackgroundColor: Colors.grey.shade300,
// // //                               shape: RoundedRectangleBorder(
// // //                                 borderRadius: BorderRadius.circular(8),
// // //                               ),
// // //                             ),
// // //                             onPressed: addressProvider.isLoading
// // //                                 ? null
// // //                                 : () => _saveAddress(context, addressProvider),
// // //                             child: addressProvider.isLoading
// // //                                 ? const SizedBox(
// // //                                     height: 20,
// // //                                     width: 20,
// // //                                     child: CircularProgressIndicator(
// // //                                       strokeWidth: 2,
// // //                                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
// // //                                     ),
// // //                                   )
// // //                                 : const Text(
// // //                                     "Save Address",
// // //                                     style: TextStyle(fontSize: 16, color: Colors.white),
// // //                                   ),
// // //                           ),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                 );
// // //               },
// // //             );
// // //           },
// // //         );
// // //       },
// // //     );
// // //   }

// // //   Widget _buildTextField(String label, String hint, TextEditingController controller) {
// // //     return TextField(
// // //       controller: controller,
// // //       decoration: InputDecoration(
// // //         labelText: label,
// // //         hintText: hint,
// // //         border: OutlineInputBorder(
// // //           borderRadius: BorderRadius.circular(8),
// // //         ),
// // //         isDense: true,
// // //         contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
// // //       ),
// // //     );
// // //   }

// // //   void _clearControllers() {
// // //     _countryController.clear();
// // //     _stateController.clear();
// // //     _cityController.clear();
// // //     _pincodeController.clear();
// // //     _houseController.clear();
// // //     _streetController.clear();
// // //   }

// // //   Future<void> _saveAddress(BuildContext context, AddressProvider addressProvider) async {
// // //     // Validate fields
// // //     if (_countryController.text.trim().isEmpty ||
// // //         _stateController.text.trim().isEmpty ||
// // //         _cityController.text.trim().isEmpty ||
// // //         _pincodeController.text.trim().isEmpty ||
// // //         _houseController.text.trim().isEmpty ||
// // //         _streetController.text.trim().isEmpty) {

// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(
// // //           content: Text('Please fill in all fields'),
// // //           backgroundColor: Colors.red,
// // //         ),
// // //       );
// // //       return;
// // //     }

// // //     // Clear any existing errors
// // //     addressProvider.clearError();

// // //     // Add address
// // //     final success = await addressProvider.addAddress(
// // //       house: _houseController.text.trim(),
// // //       street: _streetController.text.trim(),
// // //       city: _cityController.text.trim(),
// // //       state: _stateController.text.trim(),
// // //       pincode: _pincodeController.text.trim(),
// // //       country: _countryController.text.trim(),
// // //     );

// // //     if (success) {
// // //       Navigator.pop(context); // Close popup
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(
// // //           content: Text('Address added successfully!'),
// // //           backgroundColor: Colors.green,
// // //         ),
// // //       );
// // //       _clearControllers();
// // //     }
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:medical_user_app/utils/shared_preferences_helper.dart';
// // import 'package:medical_user_app/view/maplocation/map_location_screen.dart';
// // import 'package:provider/provider.dart';
// // import 'package:medical_user_app/providers/address_provider.dart';

// // // Import your new map screen
// // // import 'package:medical_user_app/screens/map_location_screen.dart';

// // class ChangeAddressScreen extends StatefulWidget {
// //   const ChangeAddressScreen({Key? key}) : super(key: key);

// //   @override
// //   State<ChangeAddressScreen> createState() => _ChangeAddressScreenState();
// // }

// // class _ChangeAddressScreenState extends State<ChangeAddressScreen> {
// //   // Text controllers for form fields
// //   final TextEditingController _countryController = TextEditingController();
// //   final TextEditingController _stateController = TextEditingController();
// //   final TextEditingController _cityController = TextEditingController();
// //   final TextEditingController _pincodeController = TextEditingController();
// //   final TextEditingController _houseController = TextEditingController();
// //   final TextEditingController _streetController = TextEditingController();
// //   final TextEditingController _searchController = TextEditingController();

// //   @override
// //   void initState() {
// //     super.initState();
// //     // Fetch addresses when screen loads
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       context.read<AddressProvider>().fetchAddresses();
// //     });
// //   }

// //   Future<void> _debugUserData() async {
// //     try {
// //       print('=== DEBUG USER DATA IN SCREEN ===');

// //       final authData = await SharedPreferencesHelper.getAuthData();
// //       print('Auth Data: $authData');

// //       final user = authData['user'];
// //       if (user != null) {
// //         print('User found in screen:');
// //         print('- Type: ${user.runtimeType}');
// //         print('- ID: ${user.id}');
// //         print('- toString: ${user.toString()}');
// //       } else {
// //         print('No user found in screen');
// //       }

// //       print('=== END DEBUG SCREEN ===');
// //     } catch (e) {
// //       print('Screen debug error: $e');
// //     }
// //   }

// //   Future<void> _navigateToMapLocation() async {
// //     try {
// //       // Navigate to map screen and wait for result
// //       final result = await Navigator.push(
// //         context,
// //         MaterialPageRoute(
// //           builder: (context) => const MapLocationScreen(),
// //         ),
// //       );

// //       if (result != null && result is Map<String, dynamic>) {
// //         // Handle the returned location data
// //         final components = result['components'] as Map<String, String>? ?? {};
// //         final address = result['address'] as String? ?? '';

// //         // Pre-fill the form fields with selected location data
// //         setState(() {
// //           _streetController.text = components['street'] ?? '';
// //           _cityController.text = components['city'] ?? '';
// //           _stateController.text = components['state'] ?? '';
// //           _pincodeController.text = components['pincode'] ?? '';
// //           _countryController.text = components['country'] ?? 'India';
// //         });

// //         // Show the add address popup with pre-filled data
// //         _showAddAddressPopup(context);

// //         // Show success message
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text('Location selected: ${address.length > 50 ? address.substring(0, 50) + '...' : address}'),
// //             backgroundColor: Colors.green,
// //             duration: const Duration(seconds: 2),
// //           ),
// //         );
// //       }
// //     } catch (e) {
// //       // Show error message
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('Error opening map: ${e.toString()}'),
// //           backgroundColor: Colors.red,
// //         ),
// //       );
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     _countryController.dispose();
// //     _stateController.dispose();
// //     _cityController.dispose();
// //     _pincodeController.dispose();
// //     _houseController.dispose();
// //     _streetController.dispose();
// //     _searchController.dispose();
// //     super.dispose();
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
// //           'Change Address',
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
// //       ),
// //       body: Consumer<AddressProvider>(
// //         builder: (context, addressProvider, child) {
// //           return Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.start,
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 const SizedBox(height: 30),

// //                 // Search Bar
// //                 Container(
// //                   height: 50,
// //                   decoration: BoxDecoration(
// //                     color: Colors.grey[200],
// //                     borderRadius: BorderRadius.circular(8),
// //                   ),
// //                   child: TextField(
// //                     controller: _searchController,
// //                     decoration: InputDecoration(
// //                       border: InputBorder.none,
// //                       prefixIcon: Icon(
// //                         Icons.search,
// //                         color: Colors.grey[600],
// //                       ),
// //                       hintText: 'Search your City',
// //                       hintStyle: TextStyle(
// //                         color: Colors.grey[600],
// //                         fontSize: 16,
// //                       ),
// //                       contentPadding: const EdgeInsets.symmetric(
// //                         horizontal: 12,
// //                         vertical: 15,
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(height: 16),

// //                 // Choose Location on Map Button - Updated with actual navigation
// //                 InkWell(
// //                   onTap: _navigateToMapLocation,
// //                   child: Container(
// //                     width: 230,
// //                     height: 36,
// //                     padding: const EdgeInsets.all(4),
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(10),
// //                       border: Border.all(
// //                           color: const Color.fromARGB(255, 187, 187, 187)),
// //                     ),
// //                     child: const Row(
// //                       children: [
// //                         Icon(Icons.my_location, size: 18),
// //                         SizedBox(width: 16),
// //                         Text(
// //                           'Choose Location On Map',
// //                           style: TextStyle(
// //                             fontSize: 16,
// //                             fontWeight: FontWeight.w500,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),

// //                 const SizedBox(height: 20),
// //                 const Divider(),

// //                 // Error Message
// //                 if (addressProvider.errorMessage.isNotEmpty)
// //                   Container(
// //                     margin: const EdgeInsets.only(bottom: 16),
// //                     padding: const EdgeInsets.all(12),
// //                     decoration: BoxDecoration(
// //                       color: Colors.red.shade50,
// //                       borderRadius: BorderRadius.circular(8),
// //                       border: Border.all(color: Colors.red.shade200),
// //                     ),
// //                     child: Row(
// //                       children: [
// //                         Icon(Icons.error_outline, color: Colors.red.shade600),
// //                         const SizedBox(width: 8),
// //                         Expanded(
// //                           child: Text(
// //                             addressProvider.errorMessage,
// //                             style: TextStyle(
// //                               color: Colors.red.shade700,
// //                               fontSize: 14,
// //                             ),
// //                           ),
// //                         ),
// //                         IconButton(
// //                           onPressed: () => addressProvider.clearError(),
// //                           icon: Icon(Icons.close,
// //                             color: Colors.red.shade600,
// //                             size: 20,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),

// //                 // Saved Locations List
// //                 Expanded(
// //                   child: addressProvider.isLoading
// //                       ? const Center(
// //                           child: CircularProgressIndicator(
// //                             color: Color(0xFF6A3DE8),
// //                           ),
// //                         )
// //                       : addressProvider.addresses.isEmpty
// //                           ? const Center(
// //                               child: Column(
// //                                 mainAxisAlignment: MainAxisAlignment.center,
// //                                 children: [
// //                                   Icon(
// //                                     Icons.location_off,
// //                                     size: 64,
// //                                     color: Colors.grey,
// //                                   ),
// //                                   SizedBox(height: 16),
// //                                   Text(
// //                                     'No addresses found',
// //                                     style: TextStyle(
// //                                       fontSize: 16,
// //                                       color: Colors.grey,
// //                                     ),
// //                                   ),
// //                                   SizedBox(height: 8),
// //                                   Text(
// //                                     'Add your first address below',
// //                                     style: TextStyle(
// //                                       fontSize: 14,
// //                                       color: Colors.grey,
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                             )
// //                           : RefreshIndicator(
// //                               onRefresh: () => addressProvider.fetchAddresses(),
// //                               child: ListView.builder(
// //                                 itemCount: addressProvider.addresses.length,
// //                                 itemBuilder: (context, index) {
// //                                   final address = addressProvider.addresses[index];
// //                                   return Column(
// //                                     children: [
// //                                       ListTile(
// //                                         contentPadding:
// //                                             const EdgeInsets.symmetric(vertical: 1),
// //                                         leading: const Icon(Icons.location_on_outlined,
// //                                             color: Colors.black),
// //                                         title: Text(
// //                                           _buildAddressString(address),
// //                                           style: const TextStyle(
// //                                             fontSize: 16,
// //                                             fontWeight: FontWeight.w500,
// //                                           ),
// //                                         ),
// //                                         subtitle: Text(
// //                                           _buildFullAddressString(address),
// //                                           style: TextStyle(
// //                                             fontSize: 12,
// //                                             color: Colors.grey[600],
// //                                           ),
// //                                         ),
// //                                         trailing: Icon(
// //                                           Icons.chevron_right,
// //                                           color: Colors.grey[400],
// //                                         ),
// //                                         onTap: () {
// //                                           // Handle location selection and return to payment screen
// //                                           _selectAddress(address);
// //                                         },
// //                                       ),
// //                                       const Divider(),
// //                                     ],
// //                                   );
// //                                 },
// //                               ),
// //                             ),
// //                 ),

// //                 // Add Address Button
// //                 Padding(
// //                   padding: const EdgeInsets.symmetric(vertical: 16.0),
// //                   child: SizedBox(
// //                     width: double.infinity,
// //                     height: 50,
// //                     child: ElevatedButton(
// //                       onPressed: addressProvider.isLoading
// //                           ? null
// //                           : () => _showAddAddressPopup(context),
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: const Color(0xFF6A3DE8),
// //                         disabledBackgroundColor: Colors.grey.shade300,
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(8),
// //                         ),
// //                       ),
// //                       child: addressProvider.isLoading
// //                           ? const SizedBox(
// //                               height: 20,
// //                               width: 20,
// //                               child: CircularProgressIndicator(
// //                                 strokeWidth: 2,
// //                                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
// //                               ),
// //                             )
// //                           : const Text(
// //                               'Add Address',
// //                               style: TextStyle(
// //                                 fontSize: 16,
// //                                 fontWeight: FontWeight.bold,
// //                                 color: Colors.white,
// //                               ),
// //                             ),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   void _selectAddress(Map<String, dynamic> address) {
// //     // Show confirmation dialog before selecting
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: const Text('Select Address'),
// //           content: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               const Text('Do you want to use this address for delivery?'),
// //               const SizedBox(height: 12),
// //               Container(
// //                 padding: const EdgeInsets.all(12),
// //                 decoration: BoxDecoration(
// //                   color: Colors.grey.shade50,
// //                   borderRadius: BorderRadius.circular(8),
// //                   border: Border.all(color: Colors.grey.shade300),
// //                 ),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       _buildAddressString(address),
// //                       style: const TextStyle(
// //                         fontWeight: FontWeight.bold,
// //                         fontSize: 16,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 4),
// //                     Text(
// //                       _buildFullAddressString(address),
// //                       style: TextStyle(
// //                         color: Colors.grey[600],
// //                         fontSize: 14,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //               child: const Text('Cancel'),
// //             ),
// //             ElevatedButton(
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //                 // Return the selected address to PaymentScreen
// //                 Navigator.pop(context, address);
// //               },
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: const Color(0xFF6A3DE8),
// //               ),
// //               child: const Text(
// //                 'Use This Address',
// //                 style: TextStyle(color: Colors.white),
// //               ),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   String _buildAddressString(Map<String, dynamic> address) {
// //     final city = address['city'] ?? '';
// //     final state = address['state'] ?? '';
// //     return city.isNotEmpty && state.isNotEmpty ? '$city, $state' : 'Unknown Location';
// //   }

// //   String _buildFullAddressString(Map<String, dynamic> address) {
// //     final house = address['house'] ?? '';
// //     final street = address['street'] ?? '';
// //     final city = address['city'] ?? '';
// //     final state = address['state'] ?? '';
// //     final pincode = address['pincode'] ?? '';

// //     List<String> parts = [];
// //     if (house.isNotEmpty) parts.add(house);
// //     if (street.isNotEmpty) parts.add(street);
// //     if (city.isNotEmpty) parts.add(city);
// //     if (state.isNotEmpty) parts.add(state);
// //     if (pincode.isNotEmpty) parts.add(pincode);

// //     return parts.join(', ');
// //   }

// //   void _showAddAddressPopup(BuildContext context) {
// //     // Clear controllers
// //     _clearControllers();

// //     showModalBottomSheet(
// //       context: context,
// //       isScrollControlled: true,
// //       backgroundColor: Colors.transparent,
// //       builder: (context) {
// //         return Consumer<AddressProvider>(
// //           builder: (context, addressProvider, child) {
// //             return DraggableScrollableSheet(
// //               initialChildSize: 0.9,
// //               maxChildSize: 0.95,
// //               minChildSize: 0.5,
// //               expand: false,
// //               builder: (context, scrollController) {
// //                 return Container(
// //                   padding: const EdgeInsets.all(16),
// //                   decoration: const BoxDecoration(
// //                     color: Colors.white,
// //                     borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
// //                   ),
// //                   child: SingleChildScrollView(
// //                     controller: scrollController,
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.center,
// //                       children: [
// //                         const Text(
// //                           "Add Address",
// //                           style: TextStyle(
// //                             fontSize: 18,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         const SizedBox(height: 16),

// //                         // Error Message in popup
// //                         if (addressProvider.errorMessage.isNotEmpty)
// //                           Container(
// //                             margin: const EdgeInsets.only(bottom: 16),
// //                             padding: const EdgeInsets.all(12),
// //                             decoration: BoxDecoration(
// //                               color: Colors.red.shade50,
// //                               borderRadius: BorderRadius.circular(8),
// //                               border: Border.all(color: Colors.red.shade200),
// //                             ),
// //                             child: Row(
// //                               children: [
// //                                 Icon(Icons.error_outline, color: Colors.red.shade600),
// //                                 const SizedBox(width: 8),
// //                                 Expanded(
// //                                   child: Text(
// //                                     addressProvider.errorMessage,
// //                                     style: TextStyle(
// //                                       color: Colors.red.shade700,
// //                                       fontSize: 14,
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),

// //                         // Text fields
// //                         _buildTextField("Country", "Enter country", _countryController),
// //                         const SizedBox(height: 10),
// //                         _buildTextField("State", "Enter state", _stateController),
// //                         const SizedBox(height: 10),
// //                         _buildTextField("City", "Enter city", _cityController),
// //                         const SizedBox(height: 10),
// //                         _buildTextField("Pincode", "Enter pincode", _pincodeController),
// //                         const SizedBox(height: 10),
// //                         _buildTextField("House/Flat No.", "Enter house/flat number", _houseController),
// //                         const SizedBox(height: 10),
// //                         _buildTextField("Street", "Enter street name", _streetController),

// //                         const SizedBox(height: 20),

// //                         // Save button
// //                         SizedBox(
// //                           width: double.infinity,
// //                           height: 48,
// //                           child: ElevatedButton(
// //                             style: ElevatedButton.styleFrom(
// //                               backgroundColor: const Color(0xFF6A3DE8),
// //                               disabledBackgroundColor: Colors.grey.shade300,
// //                               shape: RoundedRectangleBorder(
// //                                 borderRadius: BorderRadius.circular(8),
// //                               ),
// //                             ),
// //                             onPressed: addressProvider.isLoading
// //                                 ? null
// //                                 : () => _saveAddress(context, addressProvider),
// //                             child: addressProvider.isLoading
// //                                 ? const SizedBox(
// //                                     height: 20,
// //                                     width: 20,
// //                                     child: CircularProgressIndicator(
// //                                       strokeWidth: 2,
// //                                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
// //                                     ),
// //                                   )
// //                                 : const Text(
// //                                     "Save Address",
// //                                     style: TextStyle(fontSize: 16, color: Colors.white),
// //                                   ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 );
// //               },
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }

// //   Widget _buildTextField(String label, String hint, TextEditingController controller) {
// //     return TextField(
// //       controller: controller,
// //       decoration: InputDecoration(
// //         labelText: label,
// //         hintText: hint,
// //         border: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(8),
// //         ),
// //         isDense: true,
// //         contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
// //       ),
// //     );
// //   }

// //   void _clearControllers() {
// //     _countryController.clear();
// //     _stateController.clear();
// //     _cityController.clear();
// //     _pincodeController.clear();
// //     _houseController.clear();
// //     _streetController.clear();
// //   }

// //   Future<void> _saveAddress(BuildContext context, AddressProvider addressProvider) async {
// //     // Validate fields
// //     if (_countryController.text.trim().isEmpty ||
// //         _stateController.text.trim().isEmpty ||
// //         _cityController.text.trim().isEmpty ||
// //         _pincodeController.text.trim().isEmpty ||
// //         _houseController.text.trim().isEmpty ||
// //         _streetController.text.trim().isEmpty) {

// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(
// //           content: Text('Please fill in all fields'),
// //           backgroundColor: Colors.red,
// //         ),
// //       );
// //       return;
// //     }

// //     // Clear any existing errors
// //     addressProvider.clearError();

// //     // Add address
// //     final success = await addressProvider.addAddress(
// //       house: _houseController.text.trim(),
// //       street: _streetController.text.trim(),
// //       city: _cityController.text.trim(),
// //       state: _stateController.text.trim(),
// //       pincode: _pincodeController.text.trim(),
// //       country: _countryController.text.trim(),
// //     );

// //     if (success) {
// //       Navigator.pop(context); // Close popup
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(
// //           content: Text('Address added successfully!'),
// //           backgroundColor: Colors.green,
// //         ),
// //       );
// //       _clearControllers();
// //     }
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:medical_user_app/utils/shared_preferences_helper.dart';
// import 'package:medical_user_app/view/maplocation/map_location_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:medical_user_app/providers/address_provider.dart';

// class ChangeAddressScreen extends StatefulWidget {
//   const ChangeAddressScreen({Key? key}) : super(key: key);

//   @override
//   State<ChangeAddressScreen> createState() => _ChangeAddressScreenState();
// }

// class _ChangeAddressScreenState extends State<ChangeAddressScreen> {
//   // Text controllers for form fields
//   final TextEditingController _countryController = TextEditingController();
//   final TextEditingController _stateController = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();
//   final TextEditingController _pincodeController = TextEditingController();
//   final TextEditingController _houseController = TextEditingController();
//   final TextEditingController _streetController = TextEditingController();
//   final TextEditingController _searchController = TextEditingController();

//   // Selected location from map
//   Map<String, dynamic>? _selectedMapLocation;

//   @override
//   void initState() {
//     super.initState();
//     // Fetch addresses when screen loads
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<AddressProvider>().fetchAddresses();
//     });
//   }

//   Future<void> _debugUserData() async {
//     try {
//       print('=== DEBUG USER DATA IN SCREEN ===');

//       final authData = await SharedPreferencesHelper.getAuthData();
//       print('Auth Data: $authData');

//       final user = authData['user'];
//       if (user != null) {
//         print('User found in screen:');
//         print('- Type: ${user.runtimeType}');
//         print('- ID: ${user.id}');
//         print('- toString: ${user.toString()}');
//       } else {
//         print('No user found in screen');
//       }

//       print('=== END DEBUG SCREEN ===');
//     } catch (e) {
//       print('Screen debug error: $e');
//     }
//   }

//   Future<void> _navigateToMapLocation() async {
//     try {
//       // Navigate to map screen and wait for result
//       final result = await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const MapLocationScreen(),
//         ),
//       );

//       if (result != null && result is Map<String, dynamic>) {
//         // Store the selected location data
//         setState(() {
//           _selectedMapLocation = result;
//         });

//         // Show success message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Location selected: ${(result['address'] as String).length > 50 ? (result['address'] as String).substring(0, 50) + '...' : result['address']}'),
//             backgroundColor: Colors.green,
//             duration: const Duration(seconds: 2),
//           ),
//         );
//       }
//     } catch (e) {
//       // Show error message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error opening map: ${e.toString()}'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   void _selectMapLocation() {
//     if (_selectedMapLocation != null) {
//       // Show confirmation dialog before selecting the map location
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Use Selected Location'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text('Do you want to use this location for delivery?'),
//                 const SizedBox(height: 12),
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade50,
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: Colors.grey.shade300),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Row(
//                         children: [
//                           Icon(Icons.location_on, color: Color(0xFF6A3DE8), size: 20),
//                           SizedBox(width: 8),
//                           Text(
//                             'Selected from Map',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         _selectedMapLocation!['address'],
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('Cancel'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   // Create address object from map location
//                   final components = _selectedMapLocation!['components'] as Map<String, String>? ?? {};
//                   final mapAddress = {
//                     'house': '', // Map doesn't provide house number
//                     'street': components['street'] ?? '',
//                     'city': components['city'] ?? '',
//                     'state': components['state'] ?? '',
//                     'pincode': components['pincode'] ?? '',
//                     'country': components['country'] ?? 'India',
//                     'latitude': _selectedMapLocation!['latitude'],
//                     'longitude': _selectedMapLocation!['longitude'],
//                     'fullAddress': _selectedMapLocation!['address'],
//                   };
//                   // Return the selected address to PaymentScreen
//                   Navigator.pop(context, mapAddress);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF6A3DE8),
//                 ),
//                 child: const Text(
//                   'Use This Location',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _countryController.dispose();
//     _stateController.dispose();
//     _cityController.dispose();
//     _pincodeController.dispose();
//     _houseController.dispose();
//     _streetController.dispose();
//     _searchController.dispose();
//     super.dispose();
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
//           'Change Address',
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
//       ),
//       body: Consumer<AddressProvider>(
//         builder: (context, addressProvider, child) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 30),

//                 // Search Bar
//                 Container(
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: TextField(
//                     controller: _searchController,
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       prefixIcon: Icon(
//                         Icons.search,
//                         color: Colors.grey[600],
//                       ),
//                       hintText: 'Search your City',
//                       hintStyle: TextStyle(
//                         color: Colors.grey[600],
//                         fontSize: 16,
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 15,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 // Choose Location on Map Button
//                 InkWell(
//                   onTap: _navigateToMapLocation,
//                   child: Container(
//                     width: 230,
//                     height: 36,
//                     padding: const EdgeInsets.all(4),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                           color: const Color.fromARGB(255, 187, 187, 187)),
//                     ),
//                     child: const Row(
//                       children: [
//                         Icon(Icons.my_location, size: 18),
//                         SizedBox(width: 16),
//                         Text(
//                           'Choose Location On Map',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // Display selected map location
//                 if (_selectedMapLocation != null) ...[
//                   const SizedBox(height: 16),
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF6A3DE8).withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(color: const Color(0xFF6A3DE8)),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             const Icon(
//                               Icons.location_on,
//                               color: Color(0xFF6A3DE8),
//                               size: 20,
//                             ),
//                             const SizedBox(width: 8),
//                             const Expanded(
//                               child: Text(
//                                 'Selected from Map',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                   color: Color(0xFF6A3DE8),
//                                 ),
//                               ),
//                             ),
//                             InkWell(
//                               onTap: _selectMapLocation,
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFF6A3DE8),
//                                   borderRadius: BorderRadius.circular(4),
//                                 ),
//                                 child: const Text(
//                                   'Use This',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           _selectedMapLocation!['address'],
//                           style: TextStyle(
//                             color: Colors.grey[700],
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],

//                 const SizedBox(height: 20),
//                 const Divider(),

//                 // Error Message
//                 if (addressProvider.errorMessage.isNotEmpty)
//                   Container(
//                     margin: const EdgeInsets.only(bottom: 16),
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.red.shade50,
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(color: Colors.red.shade200),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(Icons.error_outline, color: Colors.red.shade600),
//                         const SizedBox(width: 8),
//                         Expanded(
//                           child: Text(
//                             addressProvider.errorMessage,
//                             style: TextStyle(
//                               color: Colors.red.shade700,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () => addressProvider.clearError(),
//                           icon: Icon(Icons.close,
//                             color: Colors.red.shade600,
//                             size: 20,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                 // Saved Locations List
//                 Expanded(
//                   child: addressProvider.isLoading
//                       ? const Center(
//                           child: CircularProgressIndicator(
//                             color: Color(0xFF6A3DE8),
//                           ),
//                         )
//                       : addressProvider.addresses.isEmpty
//                           ? const Center(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(
//                                     Icons.location_off,
//                                     size: 64,
//                                     color: Colors.grey,
//                                   ),
//                                   SizedBox(height: 16),
//                                   Text(
//                                     'No addresses found',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                   SizedBox(height: 8),
//                                   Text(
//                                     'Add your first address below',
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           : RefreshIndicator(
//                               onRefresh: () => addressProvider.fetchAddresses(),
//                               child: ListView.builder(
//                                 itemCount: addressProvider.addresses.length,
//                                 itemBuilder: (context, index) {
//                                   final address = addressProvider.addresses[index];
//                                   return Column(
//                                     children: [
//                                       ListTile(
//                                         contentPadding:
//                                             const EdgeInsets.symmetric(vertical: 1),
//                                         leading: const Icon(Icons.location_on_outlined,
//                                             color: Colors.black),
//                                         title: Text(
//                                           _buildAddressString(address),
//                                           style: const TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                         subtitle: Text(
//                                           _buildFullAddressString(address),
//                                           style: TextStyle(
//                                             fontSize: 12,
//                                             color: Colors.grey[600],
//                                           ),
//                                         ),
//                                         trailing: Icon(
//                                           Icons.chevron_right,
//                                           color: Colors.grey[400],
//                                         ),
//                                         onTap: () {
//                                           // Handle location selection and return to payment screen
//                                           _selectAddress(address);
//                                         },
//                                       ),
//                                       const Divider(),
//                                     ],
//                                   );
//                                 },
//                               ),
//                             ),
//                 ),

//                 // Add Address Button
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 16.0),
//                   child: SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: addressProvider.isLoading
//                           ? null
//                           : () => _showAddAddressPopup(context),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF6A3DE8),
//                         disabledBackgroundColor: Colors.grey.shade300,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: addressProvider.isLoading
//                           ? const SizedBox(
//                               height: 20,
//                               width: 20,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2,
//                                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                               ),
//                             )
//                           : const Text(
//                               'Add Address',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   void _selectAddress(Map<String, dynamic> address) {
//     // Show confirmation dialog before selecting
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Select Address'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text('Do you want to use this address for delivery?'),
//               const SizedBox(height: 12),
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade50,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.grey.shade300),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       _buildAddressString(address),
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       _buildFullAddressString(address),
//                       style: TextStyle(
//                         color: Colors.grey[600],
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 // Return the selected address to PaymentScreen
//                 Navigator.pop(context, address);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF6A3DE8),
//               ),
//               child: const Text(
//                 'Use This Address',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   String _buildAddressString(Map<String, dynamic> address) {
//     final city = address['city'] ?? '';
//     final state = address['state'] ?? '';
//     return city.isNotEmpty && state.isNotEmpty ? '$city, $state' : 'Unknown Location';
//   }

//   String _buildFullAddressString(Map<String, dynamic> address) {
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

//     return parts.join(', ');
//   }

//   void _showAddAddressPopup(BuildContext context) {
//     // Clear controllers first
//     _clearControllers();

//     // Pre-fill from map location if available
//     if (_selectedMapLocation != null) {
//       final components = _selectedMapLocation!['components'] as Map<String, String>? ?? {};
//       _streetController.text = components['street'] ?? '';
//       _cityController.text = components['city'] ?? '';
//       _stateController.text = components['state'] ?? '';
//       _pincodeController.text = components['pincode'] ?? '';
//       _countryController.text = components['country'] ?? 'India';
//     }

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) {
//         return Consumer<AddressProvider>(
//           builder: (context, addressProvider, child) {
//             return DraggableScrollableSheet(
//               initialChildSize: 0.9,
//               maxChildSize: 0.95,
//               minChildSize: 0.5,
//               expand: false,
//               builder: (context, scrollController) {
//                 return Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//                   ),
//                   child: SingleChildScrollView(
//                     controller: scrollController,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const Text(
//                           "Add Address",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 16),

//                         // Error Message in popup
//                         if (addressProvider.errorMessage.isNotEmpty)
//                           Container(
//                             margin: const EdgeInsets.only(bottom: 16),
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: Colors.red.shade50,
//                               borderRadius: BorderRadius.circular(8),
//                               border: Border.all(color: Colors.red.shade200),
//                             ),
//                             child: Row(
//                               children: [
//                                 Icon(Icons.error_outline, color: Colors.red.shade600),
//                                 const SizedBox(width: 8),
//                                 Expanded(
//                                   child: Text(
//                                     addressProvider.errorMessage,
//                                     style: TextStyle(
//                                       color: Colors.red.shade700,
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),

//                         // Text fields
//                         _buildTextField("Country", "Enter country", _countryController),
//                         const SizedBox(height: 10),
//                         _buildTextField("State", "Enter state", _stateController),
//                         const SizedBox(height: 10),
//                         _buildTextField("City", "Enter city", _cityController),
//                         const SizedBox(height: 10),
//                         _buildTextField("Pincode", "Enter pincode", _pincodeController),
//                         const SizedBox(height: 10),
//                         _buildTextField("House/Flat No.", "Enter house/flat number", _houseController),
//                         const SizedBox(height: 10),
//                         _buildTextField("Street", "Enter street name", _streetController),

//                         const SizedBox(height: 20),

//                         // Save button
//                         SizedBox(
//                           width: double.infinity,
//                           height: 48,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFF6A3DE8),
//                               disabledBackgroundColor: Colors.grey.shade300,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             onPressed: addressProvider.isLoading
//                                 ? null
//                                 : () => _saveAddress(context, addressProvider),
//                             child: addressProvider.isLoading
//                                 ? const SizedBox(
//                                     height: 20,
//                                     width: 20,
//                                     child: CircularProgressIndicator(
//                                       strokeWidth: 2,
//                                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                                     ),
//                                   )
//                                 : const Text(
//                                     "Save Address",
//                                     style: TextStyle(fontSize: 16, color: Colors.white),
//                                   ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         );
//       },
//     );
//   }

//   Widget _buildTextField(String label, String hint, TextEditingController controller) {
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: label,
//         hintText: hint,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         isDense: true,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//       ),
//     );
//   }

//   void _clearControllers() {
//     _countryController.clear();
//     _stateController.clear();
//     _cityController.clear();
//     _pincodeController.clear();
//     _houseController.clear();
//     _streetController.clear();
//   }

//   Future<void> _saveAddress(BuildContext context, AddressProvider addressProvider) async {
//     // Validate fields
//     if (_countryController.text.trim().isEmpty ||
//         _stateController.text.trim().isEmpty ||
//         _cityController.text.trim().isEmpty ||
//         _pincodeController.text.trim().isEmpty ||
//         _houseController.text.trim().isEmpty ||
//         _streetController.text.trim().isEmpty) {

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please fill in all fields'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     // Clear any existing errors
//     addressProvider.clearError();

//     // Add address
//     final success = await addressProvider.addAddress(
//       house: _houseController.text.trim(),
//       street: _streetController.text.trim(),
//       city: _cityController.text.trim(),
//       state: _stateController.text.trim(),
//       pincode: _pincodeController.text.trim(),
//       country: _countryController.text.trim(),
//     );

//     if (success) {
//       Navigator.pop(context); // Close popup
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Address added successfully!'),
//           backgroundColor: Colors.green,
//         ),
//       );
//       _clearControllers();
//       // Clear selected map location after saving
//       setState(() {
//         _selectedMapLocation = null;
//       });
//     }
//   }
// }









import 'package:flutter/material.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';
import 'package:medical_user_app/view/maplocation/map_location_screen.dart';
import 'package:provider/provider.dart';
import 'package:medical_user_app/providers/address_provider.dart';

class ChangeAddressScreen extends StatefulWidget {
  const ChangeAddressScreen({Key? key}) : super(key: key);

  @override
  State<ChangeAddressScreen> createState() => _ChangeAddressScreenState();
}

class _ChangeAddressScreenState extends State<ChangeAddressScreen> {
  // Text controllers for form fields
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _houseController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  // Selected location from map
  Map<String, dynamic>? _selectedMapLocation;

  // Search functionality
  String _searchQuery = '';
  List<Map<String, dynamic>> _filteredAddresses = [];

  final Map<String, String?> _fieldErrors = {};


  @override
  void initState() {
    super.initState();
    // Fetch addresses when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddressProvider>().fetchAddresses();
    });

    // Listen to search controller changes
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase().trim();
    });
  }

  List<Map<String, dynamic>> _getFilteredAddresses(List<dynamic> addresses) {
    // Convert dynamic list to Map list
    final addressList =
        addresses.map((address) => address as Map<String, dynamic>).toList();

    if (_searchQuery.isEmpty) {
      return addressList;
    }

    return addressList.where((address) {
      final country = (address['country'] ?? '').toString().toLowerCase();
      final state = (address['state'] ?? '').toString().toLowerCase();
      final city = (address['city'] ?? '').toString().toLowerCase();
      final pincode = (address['pincode'] ?? '').toString().toLowerCase();
      final house = (address['house'] ?? '').toString().toLowerCase();
      final street = (address['street'] ?? '').toString().toLowerCase();
      // final house = (address['house'] ?? '').toString().toLowerCase();
      // final street = (address['street'] ?? '').toString().toLowerCase();
      // final city = (address['city'] ?? '').toString().toLowerCase();
      // final state = (address['state'] ?? '').toString().toLowerCase();
      // final pincode = (address['pincode'] ?? '').toString().toLowerCase();
      // final country = (address['country'] ?? '').toString().toLowerCase();

      // Create a combined string of all address fields for comprehensive search
      final combinedAddress = '$house $street $city $state $pincode $country';

      return combinedAddress.contains(_searchQuery) ||
          city.contains(_searchQuery) ||
          state.contains(_searchQuery) ||
          pincode.contains(_searchQuery) ||
          street.contains(_searchQuery) ||
          house.contains(_searchQuery);
    }).toList();
  }

  Future<void> _debugUserData() async {
    try {
      print('=== DEBUG USER DATA IN SCREEN ===');

      final authData = await SharedPreferencesHelper.getAuthData();
      print('Auth Data: $authData');

      final user = authData['user'];
      if (user != null) {
        print('User found in screen:');
        print('- Type: ${user.runtimeType}');
        print('- ID: ${user.id}');
        print('- toString: ${user.toString()}');
      } else {
        print('No user found in screen');
      }

      print('=== END DEBUG SCREEN ===');
    } catch (e) {
      print('Screen debug error: $e');
    }
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchQuery = '';
    });
  }

  Future<void> _navigateToMapLocation() async {
    try {
      // Navigate to map screen and wait for result
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MapLocationScreen(),
        ),
      );

      if (result != null && result is Map<String, dynamic>) {
        // Store the selected location data
        setState(() {
          _selectedMapLocation = result;
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Location selected: ${(result['address'] as String).length > 50 ? (result['address'] as String).substring(0, 50) + '...' : result['address']}'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error opening map: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _selectMapLocation() {
    if (_selectedMapLocation != null) {
      // Show confirmation dialog before selecting the map location
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Use Selected Location'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Do you want to use this location for delivery?'),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.location_on,
                              color: Color(0xFF6A3DE8), size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Selected from Map',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _selectedMapLocation!['address'],
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Create address object from map location
                  final components = _selectedMapLocation!['components']
                          as Map<String, String>? ??
                      {};
                  final mapAddress = {
                    'house': '', // Map doesn't provide house number
                    'street': components['street'] ?? '',
                    'city': components['city'] ?? '',
                    'state': components['state'] ?? '',
                    'pincode': components['pincode'] ?? '',
                    'country': components['country'] ?? 'India',
                    'latitude': _selectedMapLocation!['latitude'],
                    'longitude': _selectedMapLocation!['longitude'],
                    'fullAddress': _selectedMapLocation!['address'],
                  };
                  // Return the selected address to PaymentScreen
                  Navigator.pop(context, mapAddress);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6A3DE8),
                ),
                child: const Text(
                  'Use This Location',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _countryController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
    _houseController.dispose();
    _streetController.dispose();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
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
          'Change Address',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: InkWell(
  onTap: () => Navigator.pop(context),
  child: Padding(
    padding: const EdgeInsets.only(left: 4,), // adjust the value
    child: Container(
      margin: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.arrow_back_ios_new, size: 18),
    ),
  ),
),

      ),
      body: Consumer<AddressProvider>(
        builder: (context, addressProvider, child) {
          // Get filtered addresses based on search query
          final filteredAddresses =
              _getFilteredAddresses(addressProvider.addresses);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),

                // Search Bar with enhanced functionality
                // Container(
                //   height: 50,
                //   decoration: BoxDecoration(
                //     color: Colors.grey[200],
                //     borderRadius: BorderRadius.circular(8),
                //   ),
                //   child: TextField(
                //     controller: _searchController,
                //     decoration: InputDecoration(
                //       border: InputBorder.none,
                //       prefixIcon: Icon(
                //         Icons.search,
                //         color: Colors.grey[600],
                //       ),
                //       suffixIcon: _searchQuery.isNotEmpty
                //           ? IconButton(
                //               icon: Icon(
                //                 Icons.clear,
                //                 color: Colors.grey[600],
                //               ),
                //               onPressed: _clearSearch,
                //             )
                //           : null,
                //       hintText: 'Search saved address...',
                //       hintStyle: TextStyle(
                //         color: Colors.grey[600],
                //         fontSize: 16,
                //       ),
                //       contentPadding: const EdgeInsets.symmetric(
                //         horizontal: 12,
                //         vertical: 15,
                //       ),
                //     ),
                //   ),
                // ),

                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF3F7)
,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: _searchController,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey[600],
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Colors.grey[600],
                              ),
                              onPressed: _clearSearch,
                            )
                          : null,
                      hintText: 'Search saved address...',
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 0, // Reduced for better alignment
                      ),
                    ),
                  ),
                ),

                // Search results counter
                if (_searchQuery.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    '${filteredAddresses.length} address${filteredAddresses.length != 1 ? 'es' : ''} found',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],

                const SizedBox(height: 16),

                // Choose Location on Map Button
                InkWell(
                  onTap: _navigateToMapLocation,
                  child: Container(
                    width: 240,
                    height: 36,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color.fromARGB(255, 187, 187, 187)),
                    ),
                    child: const Row(
                      children: [
                        SizedBox(width:  12,),
                        Icon(Icons.my_location, size: 18),
                        SizedBox(width: 13),
                        Text(
                          'Choose Location On Map',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Display selected map location
                if (_selectedMapLocation != null) ...[
                  const SizedBox(height: 16),

                  // Container(
                  //   width: double.infinity,
                  //   padding: const EdgeInsets.all(12),
                  //   decoration: BoxDecoration(
                  //     color: const Color(0xFF6A3DE8).withOpacity(0.1),
                  //     borderRadius: BorderRadius.circular(8),
                  //     border: Border.all(color: const Color(0xFF6A3DE8)),
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           const Icon(
                  //             Icons.location_on,
                  //             color: Color(0xFF6A3DE8),
                  //             size: 20,
                  //           ),
                  //           const SizedBox(width: 8),
                  //           const Expanded(
                  //             child: Text(
                  //               'Selected from Map',
                  //               style: TextStyle(
                  //                 fontWeight: FontWeight.bold,
                  //                 fontSize: 16,
                  //                 color: Color(0xFF6A3DE8),
                  //               ),
                  //             ),
                  //           ),
                  //           InkWell(
                  //             onTap: _selectMapLocation,
                  //             child: Container(
                  //               padding: const EdgeInsets.symmetric(
                  //                   horizontal: 8, vertical: 4),
                  //               decoration: BoxDecoration(
                  //                 color: const Color(0xFF6A3DE8),
                  //                 borderRadius: BorderRadius.circular(4),
                  //               ),
                  //               child: const Text(
                  //                 'Use This',
                  //                 style: TextStyle(
                  //                   color: Colors.white,
                  //                   fontSize: 12,
                  //                   fontWeight: FontWeight.bold,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       const SizedBox(height: 8),
                  //       Text(
                  //         _selectedMapLocation!['address'],
                  //         style: TextStyle(
                  //           color: Colors.grey[700],
                  //           fontSize: 14,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],

                const SizedBox(height: 20),
                const Divider(),

                // Error Message
                if (addressProvider.errorMessage.isNotEmpty)
                  Row(
                    children: [
                      // Icon(Icons.error_outline, color: Colors.red.shade600),
                      const SizedBox(width: 8),
                      // Expanded(
                      //   child: Text(
                      //     addressProvider.errorMessage,
                      //     style: TextStyle(
                      //       color: Colors.red.shade700,
                      //       fontSize: 14,
                      //     ),
                      //   ),
                      // ),

                      //  Expanded(
                      //   child: Text(
                      //     'Please Provide your internet Connection',
                      //     style: TextStyle(
                      //       color: Colors.red.shade700,
                      //       fontSize: 14,
                      //     ),
                      //   ),
                      // ),
                      // IconButton(
                      //   onPressed: () => addressProvider.clearError(),
                      //   icon: Icon(
                      //     Icons.close,
                      //     color: Colors.red.shade600,
                      //     size: 20,
                      //   ),
                      // ),
                    ],
                  ),

                // Saved Locations List with search functionality
                Expanded(
                  child: addressProvider.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF6A3DE8),
                          ),
                        )
                      : filteredAddresses.isEmpty
                          ? SingleChildScrollView(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _searchQuery.isNotEmpty
                                          ? Icons.search_off
                                          : Icons.location_off,
                                      size: 64,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      _searchQuery.isNotEmpty
                                          ? 'No addresses found for "$_searchQuery"'
                                          : 'No addresses found',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      _searchQuery.isNotEmpty
                                          ? 'Try searching with different keywords'
                                          : 'Add your first address below',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    if (_searchQuery.isNotEmpty) ...[
                                      const SizedBox(height: 12),
                                      TextButton(
                                        onPressed: _clearSearch,
                                        child: const Text(
                                          'Clear Search',
                                          style: TextStyle(
                                            color: Color(0xFF6A3DE8),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: () => addressProvider.fetchAddresses(),
                              child: ListView.builder(
                                itemCount: filteredAddresses.length,
                                itemBuilder: (context, index) {
                                  final address = filteredAddresses[index];
                                  return Column(
                                    children: [
                                      ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 1),
                                        leading: const Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.black),
                                        title: Text(
                                          _buildAddressString(address),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        subtitle: Text(
                                          _buildFullAddressString(address),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        trailing: Icon(
                                          Icons.chevron_right,
                                          color: Colors.grey[400],
                                        ),
                                        onTap: () {
                                          // Handle location selection and return to payment screen
                                          _selectAddress(address);
                                        },
                                      ),
                                      const Divider(),
                                    ],
                                  );
                                },
                              ),
                            ),
                ),

                // Add Address Button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: addressProvider.isLoading
                          ? null
                          : () => _showAddAddressPopup(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6A3DE8),
                        disabledBackgroundColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: addressProvider.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              'Add Address',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _selectAddress(Map<String, dynamic> address) {
    // Show confirmation dialog before selecting
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Address'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Do you want to use this address for delivery?'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _buildAddressString(address),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _buildFullAddressString(address),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Return the selected address to PaymentScreen
                Navigator.pop(context, address);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6A3DE8),
              ),
              child: const Text(
                'Use This Address',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  String _buildAddressString(Map<String, dynamic> address) {
    final city = address['city'] ?? '';
    final state = address['state'] ?? '';
    return city.isNotEmpty && state.isNotEmpty
        ? '$city, $state'
        : 'Unknown Location';
  }

  String _buildFullAddressString(Map<String, dynamic> address) {
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

    return parts.join(', ');
  }

  void _showAddAddressPopup(BuildContext context) {
    // Clear controllers first
    _clearControllers();

    // Pre-fill from map location if available
    if (_selectedMapLocation != null) {
      final components =
          _selectedMapLocation!['components'] as Map<String, String>? ?? {};
      _streetController.text = components['street'] ?? '';
      _cityController.text = components['city'] ?? '';
      _stateController.text = components['state'] ?? '';
      _pincodeController.text = components['pincode'] ?? '';
      _countryController.text = components['country'] ?? 'India';
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Consumer<AddressProvider>(
          builder: (context, addressProvider, child) {
            return DraggableScrollableSheet(
              initialChildSize: 0.9,
              maxChildSize: 0.95,
              minChildSize: 0.5,
              expand: false,
              builder: (context, scrollController) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Add Address",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Error Message in popup
                        if (addressProvider.errorMessage.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.red.shade200),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.error_outline,
                                    color: Colors.red.shade600),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    addressProvider.errorMessage,
                                    style: TextStyle(
                                      color: Colors.red.shade700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        // Text fields
                        _buildTextField(
                            "Country", "Enter country", _countryController),
                        const SizedBox(height: 10),
                        _buildTextField(
                            "State", "Enter state", _stateController),
                        const SizedBox(height: 10),
                        _buildTextField("City", "Enter city", _cityController),
                        const SizedBox(height: 10),
                        _buildTextField(
                            "Pincode", "Enter pincode", _pincodeController),
                        const SizedBox(height: 10),
                        _buildTextField("House/Flat No.",
                            "Enter house/flat number", _houseController),
                        const SizedBox(height: 10),
                        _buildTextField(
                            "Street", "Enter street name", _streetController),

                        const SizedBox(height: 20),

                        // Save button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6A3DE8),
                              disabledBackgroundColor: Colors.grey.shade300,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: addressProvider.isLoading
                                ? null
                                : () => _saveAddress(context, addressProvider),
                            child: addressProvider.isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  )
                                : const Text(
                                    "Save Address",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  // Widget _buildTextField(
  //     String label, String hint, TextEditingController controller) {
  //   return TextField(
  //     controller: controller,
  //     decoration: InputDecoration(
  //       labelText: label,
  //       hintText: hint,
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //       isDense: true,
  //       contentPadding:
  //           const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  //     ),
  //   );
  // }


  Widget _buildTextField(
    String label, String hint, TextEditingController controller) {
  final fieldKey = label.toLowerCase().replaceAll('/', '').replaceAll(' ', '_');
  
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      errorText: _fieldErrors[fieldKey],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: _fieldErrors[fieldKey] != null ? Colors.red : Colors.grey,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: _fieldErrors[fieldKey] != null ? Colors.red : Colors.grey.shade400,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: _fieldErrors[fieldKey] != null ? Colors.red : const Color(0xFF6A3DE8),
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      isDense: true,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ),
    onChanged: (value) {
      // Clear error when user starts typing
      if (_fieldErrors[fieldKey] != null && value.trim().isNotEmpty) {
        setState(() {
          _fieldErrors.remove(fieldKey);
        });
      }
    },
  );
}

  void _clearControllers() {
    _countryController.clear();
    _stateController.clear();
    _cityController.clear();
    _pincodeController.clear();
    _houseController.clear();
    _streetController.clear();
     _fieldErrors.clear();
  }

  // Future<void> _saveAddress(
  //     BuildContext context, AddressProvider addressProvider) async {
  //   // Validate fields
  //   if (_countryController.text.trim().isEmpty ||
  //       _stateController.text.trim().isEmpty ||
  //       _cityController.text.trim().isEmpty ||
  //       _pincodeController.text.trim().isEmpty ||
  //       _houseController.text.trim().isEmpty ||
  //       _streetController.text.trim().isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Please fill in all fields'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return;
  //   }

  //   // Clear any existing errors
  //   addressProvider.clearError();

  //   // Add address
  //   final success = await addressProvider.addAddress(
  //     house: _houseController.text.trim(),
  //     street: _streetController.text.trim(),
  //     city: _cityController.text.trim(),
  //     state: _stateController.text.trim(),
  //     pincode: _pincodeController.text.trim(),
  //     country: _countryController.text.trim(),
  //   );

  //   if (success) {
  //     Navigator.pop(context); // Close popup
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Address added successfully!'),
  //         backgroundColor: Colors.green,
  //       ),
  //     );
  //     _clearControllers();
  //     // Clear selected map location after saving
  //     setState(() {
  //       _selectedMapLocation = null;
  //     });
  //   }
  // }

  Future<void> _saveAddress(
    BuildContext context, AddressProvider addressProvider) async {
  // Clear previous errors
  setState(() {
    _fieldErrors.clear();
  });

  // Validate each field
  bool hasError = false;

  if (_countryController.text.trim().isEmpty) {
    _fieldErrors['country'] = 'Country is required';
    hasError = true;
  }

  if (_stateController.text.trim().isEmpty) {
    _fieldErrors['state'] = 'State is required';
    hasError = true;
  }

  if (_cityController.text.trim().isEmpty) {
    _fieldErrors['city'] = 'City is required';
    hasError = true;
  }

  if (_pincodeController.text.trim().isEmpty) {
    _fieldErrors['pincode'] = 'Pincode is required';
    hasError = true;
  }

  if (_houseController.text.trim().isEmpty) {
    _fieldErrors['houseflat_no'] = 'House/Flat No. is required';
    hasError = true;
  }

  if (_streetController.text.trim().isEmpty) {
    _fieldErrors['street'] = 'Street is required';
    hasError = true;
  }

  if (hasError) {
    setState(() {}); // Trigger rebuild to show errors
    return;
  }

  // Clear any existing errors
  addressProvider.clearError();

  // Add address
  final success = await addressProvider.addAddress(
    house: _houseController.text.trim(),
    street: _streetController.text.trim(),
    city: _cityController.text.trim(),
    state: _stateController.text.trim(),
    pincode: _pincodeController.text.trim(),
    country: _countryController.text.trim(),
  );

  if (success) {
    Navigator.pop(context); // Close popup
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Address added successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    _clearControllers();
    // Clear selected map location after saving
    setState(() {
      _selectedMapLocation = null;
      _fieldErrors.clear(); // Clear errors
    });
  }
}



}
