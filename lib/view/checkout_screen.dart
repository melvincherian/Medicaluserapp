// // // // import 'package:flutter/material.dart';
// // // // import 'package:intl/intl.dart';
// // // // import 'package:medical_user_app/providers/language_provider.dart';
// // // // import 'package:medical_user_app/view/near_pharmacy_screen.dart';
// // // // import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// // // // class CheckoutScreen extends StatefulWidget {
// // // //   final String? pharmacyName;
// // // //   final String? pharmacyImage;
// // // //   final String? medicineName;
// // // //   final String? medicinePrice;

// // // //   const CheckoutScreen({
// // // //     super.key,
// // // //     this.pharmacyName,
// // // //     this.pharmacyImage,
// // // //     this.medicineName,
// // // //     this.medicinePrice,
// // // //   });

// // // //   @override
// // // //   State<CheckoutScreen> createState() => _CheckoutScreenState();
// // // // }

// // // // class _CheckoutScreenState extends State<CheckoutScreen> {
// // // //   bool isWeeklySelected = true;
// // // //   late List<Map<String, dynamic>> medications;
// // // //   int selectedDateIndex = 0; // Track selected date
// // // //   DateTime selectedDeliveryDate =
// // // //       DateTime.now(); // Track selected delivery date

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     // Initialize medications with passed data or default values
// // // //     medications = [
// // // //       {
// // // //         "name": widget.medicineName ?? "DOLO 500",
// // // //         "quantity": "1 Strip",
// // // //         "count": 1,
// // // //         "pharmacyName": widget.pharmacyName ?? "Unknown Pharmacy",
// // // //         "pharmacyImage": widget.pharmacyImage ?? "assets/tablet.png",
// // // //         "price": widget.medicinePrice ?? ""
// // // //       },
// // // //     ];
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       backgroundColor: Colors.grey[50],
// // // //       body: SafeArea(
// // // //         child: Column(
// // // //           children: [
// // // //             Expanded(
// // // //               child: SingleChildScrollView(
// // // //                 child: Padding(
// // // //                   padding: const EdgeInsets.all(16.0),
// // // //                   child: Column(
// // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // //                     children: [
// // // //                       const SizedBox(height: 20),
// // // //                       _buildFrequencyToggle(),
// // // //                       const SizedBox(height: 34),
// // // //                       _buildMedicationList(),
// // // //                       const SizedBox(height: 24),
// // // //                       const Text(
// // // //                         "Select Date For Meds Delivery",
// // // //                         style: TextStyle(
// // // //                           fontSize: 18,
// // // //                           fontWeight: FontWeight.bold,
// // // //                         ),
// // // //                       ),
// // // //                       const SizedBox(height: 24),
// // // //                       Row(
// // // //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //                         children: List.generate(5, (index) {
// // // //                           DateTime today = DateTime.now();
// // // //                           DateTime date =
// // // //                               DateTime.now().add(Duration(days: index));

// // // //                           String day = DateFormat('d').format(date);
// // // //                           String month = DateFormat('MMM').format(date);

// // // //                           // Check if this card's date is today
// // // //                           bool isToday = date.day == today.day &&
// // // //                               date.month == today.month &&
// // // //                               date.year == today.year;

// // // //                           // Check if this date is selected
// // // //                           bool isSelected = selectedDateIndex == index;

// // // //                           // Calendar icon
// // // //                           if (index == 4) {
// // // //                             return GestureDetector(
// // // //                               onTap: () =>
// // // //                                   _selectFromCalendar(isStartDate: true),
// // // //                               child: Stack(
// // // //                                 alignment: Alignment.topCenter,
// // // //                                 children: [
// // // //                                   Positioned(
// // // //                                     top: 0,
// // // //                                     child: Container(
// // // //                                       height: 6,
// // // //                                       width: 50,
// // // //                                       decoration: BoxDecoration(
// // // //                                         color: Colors.black,
// // // //                                         borderRadius: BorderRadius.circular(30),
// // // //                                       ),
// // // //                                     ),
// // // //                                   ),
// // // //                                   Container(
// // // //                                     margin: const EdgeInsets.only(top: 4),
// // // //                                     height: 80,
// // // //                                     width: 55,
// // // //                                     padding: const EdgeInsets.symmetric(
// // // //                                         vertical: 12),
// // // //                                     decoration: BoxDecoration(
// // // //                                       color: Colors.white,
// // // //                                       borderRadius: BorderRadius.circular(8),
// // // //                                       border: Border.all(color: Colors.black12),
// // // //                                     ),
// // // //                                     child:
// // // //                                         const Icon(Icons.calendar_month_sharp),
// // // //                                   ),
// // // //                                 ],
// // // //                               ),
// // // //                             );
// // // //                           }

// // // //                           return GestureDetector(
// // // //                             onTap: () {
// // // //                               setState(() {
// // // //                                 selectedDateIndex = index;
// // // //                                 selectedDeliveryDate = date;
// // // //                               });
// // // //                             },
// // // //                             child: Stack(
// // // //                               alignment: Alignment.topCenter,
// // // //                               children: [
// // // //                                 Positioned(
// // // //                                   top: 0,
// // // //                                   child: Container(
// // // //                                     height: 6,
// // // //                                     width: 50,
// // // //                                     decoration: BoxDecoration(
// // // //                                       color: isSelected
// // // //                                           ? const Color(0XFF120698)
// // // //                                           : Colors.black,
// // // //                                       borderRadius: BorderRadius.circular(30),
// // // //                                     ),
// // // //                                   ),
// // // //                                 ),
// // // //                                 Container(
// // // //                                   margin: const EdgeInsets.only(top: 4),
// // // //                                   height: 80,
// // // //                                   width: 60,
// // // //                                   padding:
// // // //                                       const EdgeInsets.symmetric(vertical: 12),
// // // //                                   decoration: BoxDecoration(
// // // //                                     color: isSelected
// // // //                                         ? const Color(0XFF5931DD)
// // // //                                         : Colors.white,
// // // //                                     borderRadius: BorderRadius.circular(8),
// // // //                                     border: Border.all(
// // // //                                       color: isSelected
// // // //                                           ? const Color(0XFF5931DD)
// // // //                                           : Colors.black12,
// // // //                                     ),
// // // //                                   ),
// // // //                                   child: Column(
// // // //                                     children: [
// // // //                                       Text(
// // // //                                         day,
// // // //                                         style: TextStyle(
// // // //                                           color: isSelected
// // // //                                               ? Colors.white
// // // //                                               : Colors.black,
// // // //                                           fontWeight: FontWeight.bold,
// // // //                                           fontSize: 16,
// // // //                                         ),
// // // //                                       ),
// // // //                                       const SizedBox(height: 4),
// // // //                                       Text(
// // // //                                         month,
// // // //                                         style: TextStyle(
// // // //                                           color: isSelected
// // // //                                               ? Colors.white
// // // //                                               : Colors.black,
// // // //                                           fontSize: 14,
// // // //                                           fontWeight: FontWeight.bold,
// // // //                                         ),
// // // //                                       ),
// // // //                                     ],
// // // //                                   ),
// // // //                                 ),
// // // //                               ],
// // // //                             ),
// // // //                           );
// // // //                         }),
// // // //                       ),
// // // //                       const SizedBox(height: 34),
// // // //                       _buildDeliveryNote(),
// // // //                     ],
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //             _buildCheckoutButton(),
// // // //             const SizedBox(height: 40),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Future<void> _selectFromCalendar({required bool isStartDate}) async {
// // // //     final DateTime today = DateTime.now();
// // // //     final DateTime? picked = await showDatePicker(
// // // //       context: context,
// // // //       initialDate: selectedDeliveryDate,
// // // //       firstDate: today,
// // // //       lastDate: DateTime(today.year + 1),
// // // //     );

// // // //     if (picked != null) {
// // // //       setState(() {
// // // //         selectedDeliveryDate = picked;
// // // //         selectedDateIndex = -1; // Set to -1 to indicate custom date selected
// // // //       });
// // // //     }
// // // //   }

// // // //   Widget _buildFrequencyToggle() {
// // // //     return Container(
// // // //       decoration: const BoxDecoration(
// // // //         color: Color.fromARGB(255, 237, 234, 245),
// // // //         borderRadius: BorderRadius.horizontal(
// // // //           left: Radius.circular(24),
// // // //           right: Radius.circular(24),
// // // //         ),
// // // //       ),
// // // //       width: double.infinity,
// // // //       child: Row(
// // // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //         children: [
// // // //           InkWell(
// // // //             onTap: () {
// // // //               setState(() {
// // // //                 isWeeklySelected = true;
// // // //               });
// // // //             },
// // // //             child: Container(
// // // //               height: 48,
// // // //               width: 166,
// // // //               decoration: BoxDecoration(
// // // //                 color: isWeeklySelected
// // // //                     ? const Color(0xFF5931DD)
// // // //                     : Colors.transparent,
// // // //                 borderRadius: const BorderRadius.horizontal(
// // // //                   left: Radius.circular(24),
// // // //                   right: Radius.circular(24),
// // // //                 ),
// // // //                 border: Border.all(
// // // //                   color: const Color(0xFF5931DD),
// // // //                   width: 1,
// // // //                 ),
// // // //               ),
// // // //               alignment: Alignment.center,
// // // //               child: Text(
// // // //                 'Weekly',
// // // //                 style: TextStyle(
// // // //                   color: isWeeklySelected ? Colors.white : Colors.black,
// // // //                   fontWeight: FontWeight.w500,
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //           ),
// // // //           InkWell(
// // // //             onTap: () {
// // // //               setState(() {
// // // //                 isWeeklySelected = false;
// // // //               });
// // // //             },
// // // //             child: Container(
// // // //               height: 48,
// // // //               width: 160,
// // // //               decoration: BoxDecoration(
// // // //                 color: !isWeeklySelected
// // // //                     ? const Color(0xFF5931DD)
// // // //                     : Colors.transparent,
// // // //                 borderRadius: const BorderRadius.horizontal(
// // // //                   left: Radius.circular(24),
// // // //                   right: Radius.circular(24),
// // // //                 ),
// // // //                 border: Border.all(
// // // //                   color: const Color(0xFF5931DD),
// // // //                   width: 1,
// // // //                 ),
// // // //               ),
// // // //               alignment: Alignment.center,
// // // //               child: Text(
// // // //                 'Monthly',
// // // //                 style: TextStyle(
// // // //                   color: !isWeeklySelected ? Colors.white : Colors.black,
// // // //                   fontWeight: FontWeight.w500,
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildMedicationList() {
// // // //     return Column(
// // // //       children: List.generate(
// // // //         medications.length * 2 - 1,
// // // //         (i) {
// // // //           if (i.isEven) {
// // // //             final med = medications[i ~/ 2];
// // // //             return _buildMedicationItem(med);
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

// // // //   Widget _buildMedicationItem(Map<String, dynamic> medication) {
// // // //     // Get pharmacy image - use network image if it starts with http, otherwise use asset
// // // //     Widget medicationImage;
// // // //     String pharmacyImage = medication["pharmacyImage"] ?? "assets/tablet.png";

// // // //     if (pharmacyImage.startsWith('http://') ||
// // // //         pharmacyImage.startsWith('https://')) {
// // // //       medicationImage = ClipRRect(
// // // //         borderRadius: BorderRadius.circular(8),
// // // //         child: Image.network(
// // // //           pharmacyImage,
// // // //           width: 60,
// // // //           height: 60,
// // // //           fit: BoxFit.cover,
// // // //           errorBuilder: (context, error, stackTrace) {
// // // //             return Container(
// // // //               width: 60,
// // // //               height: 60,
// // // //               decoration: BoxDecoration(
// // // //                 color: Colors.blue.shade100,
// // // //                 borderRadius: BorderRadius.circular(8),
// // // //               ),
// // // //               child: const Icon(
// // // //                 Icons.local_pharmacy,
// // // //                 size: 30,
// // // //                 color: Colors.grey,
// // // //               ),
// // // //             );
// // // //           },
// // // //           loadingBuilder: (context, child, loadingProgress) {
// // // //             if (loadingProgress == null) return child;
// // // //             return Container(
// // // //               width: 60,
// // // //               height: 60,
// // // //               decoration: BoxDecoration(
// // // //                 color: Colors.blue.shade100,
// // // //                 borderRadius: BorderRadius.circular(8),
// // // //               ),
// // // //               child: const Center(
// // // //                 child: CircularProgressIndicator(strokeWidth: 2),
// // // //               ),
// // // //             );
// // // //           },
// // // //         ),
// // // //       );
// // // //     } else {
// // // //       medicationImage = Container(
// // // //         width: 60,
// // // //         height: 60,
// // // //         decoration: BoxDecoration(
// // // //           color: Colors.blue.shade100,
// // // //           borderRadius: BorderRadius.circular(8),
// // // //           image: DecorationImage(
// // // //             image: AssetImage(pharmacyImage),
// // // //             fit: BoxFit.cover,
// // // //           ),
// // // //         ),
// // // //       );
// // // //     }

// // // //     return Container(
// // // //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// // // //       child: Row(
// // // //         children: [
// // // //           medicationImage,
// // // //           const SizedBox(width: 12),
// // // //           Expanded(
// // // //             child: Column(
// // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // //               children: [
// // // //                 Text(
// // // //                   medication["name"],
// // // //                   style: const TextStyle(
// // // //                     fontWeight: FontWeight.bold,
// // // //                     fontSize: 14,
// // // //                   ),
// // // //                 ),
// // // //                 Text(
// // // //                   'Qty: ${medication["quantity"]}',
// // // //                   style: TextStyle(
// // // //                     fontSize: 12,
// // // //                     color: Colors.grey.shade600,
// // // //                   ),
// // // //                 ),
// // // //                 // Show pharmacy name
// // // //                 if (medication["pharmacyName"] != null &&
// // // //                     medication["pharmacyName"] != "Unknown Pharmacy")
// // // //                   // Text(
// // // //                   //   'From: ${medication["pharmacyName"]}',
// // // //                   //   style: TextStyle(
// // // //                   //     fontSize: 11,
// // // //                   //     color: Colors.purple.shade600,
// // // //                   //     fontWeight: FontWeight.w500,
// // // //                   //   ),
// // // //                   // ),
// // // //                   // Show price if available
// // // //                   if (medication["price"] != null &&
// // // //                       medication["price"].toString().isNotEmpty)
// // // //                     Text(
// // // //                       '₹${medication["price"]}',
// // // //                       style: const TextStyle(
// // // //                         fontSize: 12,
// // // //                         color: Colors.green,
// // // //                         fontWeight: FontWeight.bold,
// // // //                       ),
// // // //                     ),
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
// // // //                   onPressed: () {
// // // //                     if (medication["count"] > 1) {
// // // //                       setState(() {
// // // //                         medication["count"]--;
// // // //                       });
// // // //                     }
// // // //                   },
// // // //                   padding: EdgeInsets.zero,
// // // //                   constraints: const BoxConstraints(),
// // // //                 ),
// // // //               ),
// // // //               const SizedBox(width: 8),
// // // //               Text(
// // // //                 '0${medication["count"]}',
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
// // // //                   onPressed: () {
// // // //                     setState(() {
// // // //                       medication["count"]++;
// // // //                     });
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
// // // //                   onPressed: () {
// // // //                     setState(() {
// // // //                       medications.remove(medication);
// // // //                     });
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

// // // //   Widget _buildDeliveryNote() {
// // // //     String formattedDate =
// // // //         DateFormat('dd/MM/yyyy').format(selectedDeliveryDate);

// // // //     return SizedBox(
// // // //       width: double.infinity,
// // // //       child: Container(
// // // //         padding: const EdgeInsets.all(12),
// // // //         decoration: BoxDecoration(
// // // //           border: Border.all(color: Colors.grey.shade300),
// // // //           borderRadius: BorderRadius.circular(8),
// // // //         ),
// // // //         child: Column(
// // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // //           children: [
// // // //             RichText(
// // // //               text: TextSpan(
// // // //                 style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
// // // //                 children: const [
// // // //                   TextSpan(
// // // //                     text: 'Note: ',
// // // //                     style: TextStyle(fontWeight: FontWeight.bold),
// // // //                   ),
// // // //                   TextSpan(
// // // //                     text: 'Your Medicines Will be Delivery on',
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //             const SizedBox(height: 4),
// // // //             Text(
// // // //               formattedDate,
// // // //               style: TextStyle(
// // // //                 color: Colors.grey.shade600,
// // // //                 fontSize: 14,
// // // //                 fontWeight: FontWeight.w600,
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildCheckoutButton() {
// // // //     return Padding(
// // // //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // // //       child: SizedBox(
// // // //         width: double.infinity,
// // // //         height: 50,
// // // //         child: ElevatedButton(
// // // //           onPressed: () {
// // // //             Navigator.push(context,
// // // //                 MaterialPageRoute(builder: (context) => NearPharmacyScreen()));
// // // //           },
// // // //           style: ElevatedButton.styleFrom(
// // // //             backgroundColor: const Color(0xFF5931DD),
// // // //             shape: RoundedRectangleBorder(
// // // //               borderRadius: BorderRadius.circular(8),
// // // //             ),
// // // //           ),
// // // //           child: const AppText(
// // // //             'checkout',
// // // //             style: TextStyle(
// // // //               fontSize: 16,
// // // //               fontWeight: FontWeight.bold,
// // // //               color: Colors.white,
// // // //             ),
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:intl/intl.dart';
// // // import 'package:provider/provider.dart';
// // // import 'package:medical_user_app/providers/language_provider.dart';
// // // import 'package:medical_user_app/providers/periodic_plan_provider.dart';
// // // import 'package:medical_user_app/view/near_pharmacy_screen.dart';
// // // import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// // // class CheckoutScreen extends StatefulWidget {
// // //   final String? pharmacyName;
// // //   final String? pharmacyImage;
// // //   final String? medicineName;
// // //   final String? medicinePrice;
// // //   final String? medicineId;
// // //   final List<Map<String, dynamic>>? medicationsList;

// // //   const CheckoutScreen({
// // //     super.key,
// // //     this.pharmacyName,
// // //     this.pharmacyImage,
// // //     this.medicineName,
// // //     this.medicinePrice,
// // //     this.medicineId,
// // //     this.medicationsList,
// // //   });

// // //   @override
// // //   State<CheckoutScreen> createState() => _CheckoutScreenState();
// // // }

// // // class _CheckoutScreenState extends State<CheckoutScreen> {
// // //   bool isWeeklySelected = true;
// // //   late List<Map<String, dynamic>> medications;
// // //   int selectedDateIndex = 0;
// // //   DateTime selectedDeliveryDate = DateTime.now();
// // //   final TextEditingController _notesController = TextEditingController();

// // //   @override
// // //   void initState() {
// // //     super.initState();

// // //     // Initialize medications with passed data or default values
// // //     if (widget.medicationsList != null && widget.medicationsList!.isNotEmpty) {
// // //       medications = List<Map<String, dynamic>>.from(widget.medicationsList!);
// // //     } else {
// // //       medications = [
// // //         {
// // //           "medicineId": widget.medicineId ?? "mock_medicine_id",
// // //           "name": widget.medicineName ?? "DOLO 500",
// // //           "quantity": "1 Strip",
// // //           "count": 1,
// // //           "pharmacyName": widget.pharmacyName ?? "Unknown Pharmacy",
// // //           "pharmacyImage": widget.pharmacyImage ?? "assets/tablet.png",
// // //           "price": widget.medicinePrice ?? ""
// // //         },
// // //       ];
// // //     }

// // //     // Load existing periodic plans when screen initializes
// // //     WidgetsBinding.instance.addPostFrameCallback((_) {
// // //       context.read<PeriodicPlanProvider>().getUserPeriodicPlans();
// // //     });
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _notesController.dispose();
// // //     super.dispose();
// // //   }

// // //   Future<void> _createPeriodicPlan() async {
// // //     final provider = context.read<PeriodicPlanProvider>();

// // //     // Validate medications data
// // //     if (!provider.validateMedicationData(medications)) {
// // //       _showErrorDialog(provider.error ?? 'Invalid medication data');
// // //       return;
// // //     }

// // //     // Validate delivery date
// // //     if (!provider.validateDeliveryDates([selectedDeliveryDate])) {
// // //       _showErrorDialog(provider.error ?? 'Invalid delivery date');
// // //       return;
// // //     }

// // //     // Show loading dialog
// // //     _showLoadingDialog();

// // //     try {
// // //       final success = await provider.createPeriodicPlan(
// // //         planType: isWeeklySelected ? 'Weekly' : 'Monthly',
// // //         medications: medications,
// // //         deliveryDates: [selectedDeliveryDate],
// // //         notes: _notesController.text.trim(),
// // //       );

// // //       // Hide loading dialog
// // //       Navigator.of(context).pop();

// // //       if (success) {
// // //         _showSuccessDialog();
// // //       } else {
// // //         _showErrorDialog(provider.error ?? 'Failed to create periodic plan');
// // //       }
// // //     } catch (e) {
// // //       // Hide loading dialog
// // //       Navigator.of(context).pop();
// // //       _showErrorDialog('An unexpected error occurred: ${e.toString()}');
// // //     }
// // //   }

// // //   void _showLoadingDialog() {
// // //     showDialog(
// // //       context: context,
// // //       barrierDismissible: false,
// // //       builder: (BuildContext context) {
// // //         return const AlertDialog(
// // //           content: Row(
// // //             mainAxisSize: MainAxisSize.min,
// // //             children: [
// // //               CircularProgressIndicator(),
// // //               SizedBox(width: 16),
// // //               Text('Creating periodic plan...'),
// // //             ],
// // //           ),
// // //         );
// // //       },
// // //     );
// // //   }

// // //   void _showSuccessDialog() {
// // //     showDialog(
// // //       context: context,
// // //       builder: (BuildContext context) {
// // //         return AlertDialog(
// // //           title: const Text('Success'),
// // //           content: Text(
// // //             'Your ${isWeeklySelected ? 'weekly' : 'monthly'} periodic plan has been created successfully!',
// // //           ),
// // //           actions: [
// // //             TextButton(
// // //               onPressed: () {
// // //                 Navigator.of(context).pop(); // Close dialog
// // //                 Navigator.push(
// // //                   context,
// // //                   MaterialPageRoute(
// // //                     builder: (context) => NearPharmacyScreen(),
// // //                   ),
// // //                 );
// // //               },
// // //               child: const Text('OK'),
// // //             ),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }

// // //   void _showErrorDialog(String message) {
// // //     showDialog(
// // //       context: context,
// // //       builder: (BuildContext context) {
// // //         return AlertDialog(
// // //           title: const Text('Error'),
// // //           content: Text(message),
// // //           actions: [
// // //             TextButton(
// // //               onPressed: () => Navigator.of(context).pop(),
// // //               child: const Text('OK'),
// // //             ),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.grey[50],
// // //       body: SafeArea(
// // //         child: Column(
// // //           children: [
// // //             Expanded(
// // //               child: SingleChildScrollView(
// // //                 child: Padding(
// // //                   padding: const EdgeInsets.all(16.0),
// // //                   child: Column(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       const SizedBox(height: 20),
// // //                       _buildFrequencyToggle(),
// // //                       const SizedBox(height: 34),
// // //                       _buildMedicationList(),
// // //                       const SizedBox(height: 24),
// // //                       const Text(
// // //                         "Select Date For Meds Delivery",
// // //                         style: TextStyle(
// // //                           fontSize: 18,
// // //                           fontWeight: FontWeight.bold,
// // //                         ),
// // //                       ),
// // //                       const SizedBox(height: 24),
// // //                       _buildDateSelector(),
// // //                       const SizedBox(height: 34),
// // //                       _buildDeliveryNote(),
// // //                       const SizedBox(height: 24),
// // //                       _buildNotesSection(),
// // //                     ],
// // //                   ),
// // //                 ),
// // //               ),
// // //             ),
// // //             Consumer<PeriodicPlanProvider>(
// // //               builder: (context, provider, child) {
// // //                 return _buildCheckoutButton(provider);
// // //               },
// // //             ),
// // //             const SizedBox(height: 40),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildNotesSection() {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         const Text(
// // //           "Additional Notes (Optional)",
// // //           style: TextStyle(
// // //             fontSize: 16,
// // //             fontWeight: FontWeight.bold,
// // //           ),
// // //         ),
// // //         const SizedBox(height: 12),
// // //         TextField(
// // //           controller: _notesController,
// // //           maxLines: 3,
// // //           decoration: InputDecoration(
// // //             hintText: 'Add any special instructions for delivery...',
// // //             border: OutlineInputBorder(
// // //               borderRadius: BorderRadius.circular(8),
// // //             ),
// // //             filled: true,
// // //             fillColor: Colors.white,
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   Widget _buildDateSelector() {
// // //     return Row(
// // //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //       children: List.generate(5, (index) {
// // //         DateTime today = DateTime.now();
// // //         DateTime date = DateTime.now().add(Duration(days: index));

// // //         String day = DateFormat('d').format(date);
// // //         String month = DateFormat('MMM').format(date);

// // //         bool isToday = date.day == today.day &&
// // //             date.month == today.month &&
// // //             date.year == today.year;

// // //         bool isSelected = selectedDateIndex == index;

// // //         // Calendar icon
// // //         if (index == 4) {
// // //           return GestureDetector(
// // //             onTap: () => _selectFromCalendar(isStartDate: true),
// // //             child: Stack(
// // //               alignment: Alignment.topCenter,
// // //               children: [
// // //                 Positioned(
// // //                   top: 0,
// // //                   child: Container(
// // //                     height: 6,
// // //                     width: 50,
// // //                     decoration: BoxDecoration(
// // //                       color: Colors.black,
// // //                       borderRadius: BorderRadius.circular(30),
// // //                     ),
// // //                   ),
// // //                 ),
// // //                 Container(
// // //                   margin: const EdgeInsets.only(top: 4),
// // //                   height: 80,
// // //                   width: 55,
// // //                   padding: const EdgeInsets.symmetric(vertical: 12),
// // //                   decoration: BoxDecoration(
// // //                     color: Colors.white,
// // //                     borderRadius: BorderRadius.circular(8),
// // //                     border: Border.all(color: Colors.black12),
// // //                   ),
// // //                   child: const Icon(Icons.calendar_month_sharp),
// // //                 ),
// // //               ],
// // //             ),
// // //           );
// // //         }

// // //         return GestureDetector(
// // //           onTap: () {
// // //             setState(() {
// // //               selectedDateIndex = index;
// // //               selectedDeliveryDate = date;
// // //             });
// // //           },
// // //           child: Stack(
// // //             alignment: Alignment.topCenter,
// // //             children: [
// // //               Positioned(
// // //                 top: 0,
// // //                 child: Container(
// // //                   height: 6,
// // //                   width: 50,
// // //                   decoration: BoxDecoration(
// // //                     color: isSelected
// // //                         ? const Color(0XFF120698)
// // //                         : Colors.black,
// // //                     borderRadius: BorderRadius.circular(30),
// // //                   ),
// // //                 ),
// // //               ),
// // //               Container(
// // //                 margin: const EdgeInsets.only(top: 4),
// // //                 height: 80,
// // //                 width: 60,
// // //                 padding: const EdgeInsets.symmetric(vertical: 12),
// // //                 decoration: BoxDecoration(
// // //                   color: isSelected
// // //                       ? const Color(0XFF5931DD)
// // //                       : Colors.white,
// // //                   borderRadius: BorderRadius.circular(8),
// // //                   border: Border.all(
// // //                     color: isSelected
// // //                         ? const Color(0XFF5931DD)
// // //                         : Colors.black12,
// // //                   ),
// // //                 ),
// // //                 child: Column(
// // //                   children: [
// // //                     Text(
// // //                       day,
// // //                       style: TextStyle(
// // //                         color: isSelected ? Colors.white : Colors.black,
// // //                         fontWeight: FontWeight.bold,
// // //                         fontSize: 16,
// // //                       ),
// // //                     ),
// // //                     const SizedBox(height: 4),
// // //                     Text(
// // //                       month,
// // //                       style: TextStyle(
// // //                         color: isSelected ? Colors.white : Colors.black,
// // //                         fontSize: 14,
// // //                         fontWeight: FontWeight.bold,
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         );
// // //       }),
// // //     );
// // //   }

// // //   Future<void> _selectFromCalendar({required bool isStartDate}) async {
// // //     final DateTime today = DateTime.now();
// // //     final DateTime? picked = await showDatePicker(
// // //       context: context,
// // //       initialDate: selectedDeliveryDate,
// // //       firstDate: today,
// // //       lastDate: DateTime(today.year + 1),
// // //     );

// // //     if (picked != null) {
// // //       setState(() {
// // //         selectedDeliveryDate = picked;
// // //         selectedDateIndex = -1; // Set to -1 to indicate custom date selected
// // //       });
// // //     }
// // //   }

// // //   Widget _buildFrequencyToggle() {
// // //     return Container(
// // //       decoration: const BoxDecoration(
// // //         color: Color.fromARGB(255, 237, 234, 245),
// // //         borderRadius: BorderRadius.horizontal(
// // //           left: Radius.circular(24),
// // //           right: Radius.circular(24),
// // //         ),
// // //       ),
// // //       width: double.infinity,
// // //       child: Row(
// // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //         children: [
// // //           InkWell(
// // //             onTap: () {
// // //               setState(() {
// // //                 isWeeklySelected = true;
// // //               });
// // //             },
// // //             child: Container(
// // //               height: 48,
// // //               width: 166,
// // //               decoration: BoxDecoration(
// // //                 color: isWeeklySelected
// // //                     ? const Color(0xFF5931DD)
// // //                     : Colors.transparent,
// // //                 borderRadius: const BorderRadius.horizontal(
// // //                   left: Radius.circular(24),
// // //                   right: Radius.circular(24),
// // //                 ),
// // //                 border: Border.all(
// // //                   color: const Color(0xFF5931DD),
// // //                   width: 1,
// // //                 ),
// // //               ),
// // //               alignment: Alignment.center,
// // //               child: Text(
// // //                 'Weekly',
// // //                 style: TextStyle(
// // //                   color: isWeeklySelected ? Colors.white : Colors.black,
// // //                   fontWeight: FontWeight.w500,
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //           InkWell(
// // //             onTap: () {
// // //               setState(() {
// // //                 isWeeklySelected = false;
// // //               });
// // //             },
// // //             child: Container(
// // //               height: 48,
// // //               width: 160,
// // //               decoration: BoxDecoration(
// // //                 color: !isWeeklySelected
// // //                     ? const Color(0xFF5931DD)
// // //                     : Colors.transparent,
// // //                 borderRadius: const BorderRadius.horizontal(
// // //                   left: Radius.circular(24),
// // //                   right: Radius.circular(24),
// // //                 ),
// // //                 border: Border.all(
// // //                   color: const Color(0xFF5931DD),
// // //                   width: 1,
// // //                 ),
// // //               ),
// // //               alignment: Alignment.center,
// // //               child: Text(
// // //                 'Monthly',
// // //                 style: TextStyle(
// // //                   color: !isWeeklySelected ? Colors.white : Colors.black,
// // //                   fontWeight: FontWeight.w500,
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildMedicationList() {
// // //     return Column(
// // //       children: List.generate(
// // //         medications.length * 2 - 1,
// // //         (i) {
// // //           if (i.isEven) {
// // //             final med = medications[i ~/ 2];
// // //             return _buildMedicationItem(med);
// // //           } else {
// // //             return const Divider(
// // //               color: Color.fromARGB(255, 221, 221, 221),
// // //               height: 1,
// // //               thickness: 1,
// // //             );
// // //           }
// // //         },
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildMedicationItem(Map<String, dynamic> medication) {
// // //     Widget medicationImage;
// // //     String pharmacyImage = medication["pharmacyImage"] ?? "assets/tablet.png";

// // //     if (pharmacyImage.startsWith('http://') ||
// // //         pharmacyImage.startsWith('https://')) {
// // //       medicationImage = ClipRRect(
// // //         borderRadius: BorderRadius.circular(8),
// // //         child: Image.network(
// // //           pharmacyImage,
// // //           width: 60,
// // //           height: 60,
// // //           fit: BoxFit.cover,
// // //           errorBuilder: (context, error, stackTrace) {
// // //             return Container(
// // //               width: 60,
// // //               height: 60,
// // //               decoration: BoxDecoration(
// // //                 color: Colors.blue.shade100,
// // //                 borderRadius: BorderRadius.circular(8),
// // //               ),
// // //               child: const Icon(
// // //                 Icons.local_pharmacy,
// // //                 size: 30,
// // //                 color: Colors.grey,
// // //               ),
// // //             );
// // //           },
// // //           loadingBuilder: (context, child, loadingProgress) {
// // //             if (loadingProgress == null) return child;
// // //             return Container(
// // //               width: 60,
// // //               height: 60,
// // //               decoration: BoxDecoration(
// // //                 color: Colors.blue.shade100,
// // //                 borderRadius: BorderRadius.circular(8),
// // //               ),
// // //               child: const Center(
// // //                 child: CircularProgressIndicator(strokeWidth: 2),
// // //               ),
// // //             );
// // //           },
// // //         ),
// // //       );
// // //     } else {
// // //       medicationImage = Container(
// // //         width: 60,
// // //         height: 60,
// // //         decoration: BoxDecoration(
// // //           color: Colors.blue.shade100,
// // //           borderRadius: BorderRadius.circular(8),
// // //           image: DecorationImage(
// // //             image: AssetImage(pharmacyImage),
// // //             fit: BoxFit.cover,
// // //           ),
// // //         ),
// // //       );
// // //     }

// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// // //       child: Row(
// // //         children: [
// // //           medicationImage,
// // //           const SizedBox(width: 12),
// // //           Expanded(
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 Text(
// // //                   medication["name"],
// // //                   style: const TextStyle(
// // //                     fontWeight: FontWeight.bold,
// // //                     fontSize: 14,
// // //                   ),
// // //                 ),
// // //                 Text(
// // //                   'Qty: ${medication["quantity"]}',
// // //                   style: TextStyle(
// // //                     fontSize: 12,
// // //                     color: Colors.grey.shade600,
// // //                   ),
// // //                 ),
// // //                 if (medication["pharmacyName"] != null &&
// // //                     medication["pharmacyName"] != "Unknown Pharmacy")
// // //                   Text(
// // //                     'From: ${medication["pharmacyName"]}',
// // //                     style: TextStyle(
// // //                       fontSize: 11,
// // //                       color: Colors.purple.shade600,
// // //                       fontWeight: FontWeight.w500,
// // //                     ),
// // //                   ),
// // //                 if (medication["price"] != null &&
// // //                     medication["price"].toString().isNotEmpty)
// // //                   Text(
// // //                     '₹${medication["price"]}',
// // //                     style: const TextStyle(
// // //                       fontSize: 12,
// // //                       color: Colors.green,
// // //                       fontWeight: FontWeight.bold,
// // //                     ),
// // //                   ),
// // //               ],
// // //             ),
// // //           ),
// // //           Row(
// // //             children: [
// // //               Container(
// // //                 width: 24,
// // //                 height: 24,
// // //                 decoration: BoxDecoration(
// // //                   color: const Color.fromARGB(255, 221, 221, 221),
// // //                   borderRadius: BorderRadius.circular(12),
// // //                 ),
// // //                 child: IconButton(
// // //                   icon: const Icon(Icons.remove, size: 20),
// // //                   onPressed: () {
// // //                     if (medication["count"] > 1) {
// // //                       setState(() {
// // //                         medication["count"]--;
// // //                       });
// // //                     }
// // //                   },
// // //                   padding: EdgeInsets.zero,
// // //                   constraints: const BoxConstraints(),
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 8),
// // //               Text(
// // //                 '0${medication["count"]}',
// // //                 style: const TextStyle(fontWeight: FontWeight.bold),
// // //               ),
// // //               const SizedBox(width: 8),
// // //               Container(
// // //                 width: 24,
// // //                 height: 24,
// // //                 decoration: BoxDecoration(
// // //                   color: const Color(0xFF5931DD),
// // //                   borderRadius: BorderRadius.circular(12),
// // //                 ),
// // //                 child: IconButton(
// // //                   icon: const Icon(Icons.add, size: 16, color: Colors.white),
// // //                   onPressed: () {
// // //                     setState(() {
// // //                       medication["count"]++;
// // //                     });
// // //                   },
// // //                   padding: EdgeInsets.zero,
// // //                   constraints: const BoxConstraints(),
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 25),
// // //               Container(
// // //                 width: 24,
// // //                 height: 24,
// // //                 decoration: BoxDecoration(
// // //                   border: Border.all(
// // //                       color: const Color.fromARGB(255, 221, 221, 221)),
// // //                   color: const Color.fromARGB(255, 255, 255, 255),
// // //                   borderRadius: BorderRadius.circular(12),
// // //                 ),
// // //                 child: IconButton(
// // //                   icon: Icon(MdiIcons.trashCanOutline,
// // //                       color: Colors.red.shade400, size: 20),
// // //                   onPressed: () {
// // //                     setState(() {
// // //                       medications.remove(medication);
// // //                     });
// // //                   },
// // //                   padding: EdgeInsets.zero,
// // //                   constraints: const BoxConstraints(),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildDeliveryNote() {
// // //     String formattedDate =
// // //         DateFormat('dd/MM/yyyy').format(selectedDeliveryDate);

// // //     return SizedBox(
// // //       width: double.infinity,
// // //       child: Container(
// // //         padding: const EdgeInsets.all(12),
// // //         decoration: BoxDecoration(
// // //           border: Border.all(color: Colors.grey.shade300),
// // //           borderRadius: BorderRadius.circular(8),
// // //         ),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             RichText(
// // //               text: TextSpan(
// // //                 style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
// // //                 children: const [
// // //                   TextSpan(
// // //                     text: 'Note: ',
// // //                     style: TextStyle(fontWeight: FontWeight.bold),
// // //                   ),
// // //                   TextSpan(
// // //                     text: 'Your Medicines Will be Delivered on',
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //             const SizedBox(height: 4),
// // //             Text(
// // //               formattedDate,
// // //               style: TextStyle(
// // //                 color: Colors.grey.shade600,
// // //                 fontSize: 14,
// // //                 fontWeight: FontWeight.w600,
// // //               ),
// // //             ),
// // //             const SizedBox(height: 8),
// // //             Text(
// // //               'Plan Type: ${isWeeklySelected ? 'Weekly' : 'Monthly'} recurring delivery',
// // //               style: TextStyle(
// // //                 color: const Color(0xFF5931DD),
// // //                 fontSize: 12,
// // //                 fontWeight: FontWeight.w600,
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildCheckoutButton(PeriodicPlanProvider provider) {
// // //     return Padding(
// // //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // //       child: SizedBox(
// // //         width: double.infinity,
// // //         height: 50,
// // //         child: ElevatedButton(
// // //           onPressed: provider.isLoading
// // //               ? null
// // //               : () async {
// // //                   // Clear any previous errors
// // //                   provider.clearError();

// // //                   // Create the periodic plan
// // //                   await _createPeriodicPlan();
// // //                 },
// // //           style: ElevatedButton.styleFrom(
// // //             backgroundColor: const Color(0xFF5931DD),
// // //             disabledBackgroundColor: Colors.grey,
// // //             shape: RoundedRectangleBorder(
// // //               borderRadius: BorderRadius.circular(8),
// // //             ),
// // //           ),
// // //           child: provider.isLoading
// // //               ? const Row(
// // //                   mainAxisAlignment: MainAxisAlignment.center,
// // //                   children: [
// // //                     SizedBox(
// // //                       width: 20,
// // //                       height: 20,
// // //                       child: CircularProgressIndicator(
// // //                         color: Colors.white,
// // //                         strokeWidth: 2,
// // //                       ),
// // //                     ),
// // //                     SizedBox(width: 8),
// // //                     Text(
// // //                       'Creating Plan...',
// // //                       style: TextStyle(
// // //                         fontSize: 16,
// // //                         fontWeight: FontWeight.bold,
// // //                         color: Colors.white,
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 )
// // //               : const AppText(
// // //                   'Create Periodic Plan',
// // //                   style: TextStyle(
// // //                     fontSize: 16,
// // //                     fontWeight: FontWeight.bold,
// // //                     color: Colors.white,
// // //                   ),
// // //                 ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';
// // import 'package:medical_user_app/view/change_address_screen.dart';
// // import 'package:medical_user_app/view/main_layout.dart';
// // import 'package:medical_user_app/widgets/periodic_plans.dart';
// // import 'package:provider/provider.dart';
// // import 'package:medical_user_app/providers/language_provider.dart';
// // import 'package:medical_user_app/providers/periodic_plan_provider.dart';
// // import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// // class CheckoutScreen extends StatefulWidget {
// //   final String? pharmacyName;
// //   final String? pharmacyImage;
// //   final String? medicineName;
// //   final String? medicinePrice;
// //   final String? medicineId;
// //   final List<Map<String, dynamic>>? medicationsList;

// //   const CheckoutScreen({
// //     super.key,
// //     this.pharmacyName,
// //     this.pharmacyImage,
// //     this.medicineName,
// //     this.medicinePrice,
// //     this.medicineId,
// //     this.medicationsList,
// //   });

// //   @override
// //   State<CheckoutScreen> createState() => _CheckoutScreenState();
// // }

// // class _CheckoutScreenState extends State<CheckoutScreen> {
// //   bool isWeeklySelected = true;
// //   late List<Map<String, dynamic>> medications;
// //   int selectedDateIndex = 0;
// //   DateTime selectedDeliveryDate = DateTime.now();
// //   final TextEditingController _notesController = TextEditingController();

// //   @override
// //   void initState() {
// //     super.initState();

// //     // Initialize medications with passed data or default values
// //     if (widget.medicationsList != null && widget.medicationsList!.isNotEmpty) {
// //       medications = List<Map<String, dynamic>>.from(widget.medicationsList!);
// //     } else {
// //       medications = [
// //         {
// //           "medicineId": widget.medicineId ?? "mock_medicine_id",
// //           "name": widget.medicineName ?? "DOLO 500",
// //           "quantity": "1 Strip",
// //           "count": 1,
// //           "pharmacyName": widget.pharmacyName ?? "Unknown Pharmacy",
// //           "pharmacyImage": widget.pharmacyImage ?? "assets/tablet.png",
// //           "price": widget.medicinePrice ?? ""
// //         },
// //       ];
// //     }

// //     // Load existing periodic plans when screen initializes
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       context.read<PeriodicPlanProvider>();
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     _notesController.dispose();
// //     super.dispose();
// //   }

// //   Future<void> _createPeriodicPlan() async {
// //     final provider = context.read<PeriodicPlanProvider>();

// //     // Validate medications data
// //     if (!provider.validateMedicationData(medications)) {
// //       _showErrorDialog(provider.error ?? 'Invalid medication data');
// //       return;
// //     }

// //     // Validate delivery date
// //     if (!provider.validateDeliveryDates([selectedDeliveryDate])) {
// //       _showErrorDialog(provider.error ?? 'Invalid delivery date');
// //       return;
// //     }

// //     // Show loading dialog
// //     _showLoadingDialog();

// //     print('fgrfffffffffffffffffffffffffffffffff$selectedDeliveryDate');
// //     print('selectttttttttttttttttttttttttttttttttttttttttt$isWeeklySelected');

// //     try {
// //       final success = await provider.createPeriodicPlan(
// //         planType: isWeeklySelected ? 'Weekly' : 'Monthly',
// //         medications: medications,
// //         deliveryDates: [selectedDeliveryDate],
// //         notes: _notesController.text.trim(),
// //       );

// //       // Hide loading dialog
// //       Navigator.of(context).pop();

// //       if (success) {
// //         _showSuccessDialog();
// //       } else {
// //         _showErrorDialog(provider.error ?? 'Failed to create periodic plan');
// //       }
// //     } catch (e) {
// //       // Hide loading dialog
// //       Navigator.of(context).pop();
// //       _showErrorDialog('An unexpected error occurred: ${e.toString()}');
// //     }
// //   }

// //   void _showLoadingDialog() {
// //     showDialog(
// //       context: context,
// //       barrierDismissible: false,
// //       builder: (BuildContext context) {
// //         return const AlertDialog(
// //           content: Row(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               CircularProgressIndicator(),
// //               SizedBox(width: 16),
// //               Text('Creating periodic plan...'),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   void _showSuccessDialog() {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: const Text('Success'),
// //           content: Text(
// //             'Your ${isWeeklySelected ? 'weekly' : 'monthly'} periodic plan has been created successfully!',
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.of(context).pop(); // Close dialog
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                     builder: (context) =>const MainLayout(),
// //                   ),
// //                 );
// //               },
// //               child: const Text('OK'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   void _showErrorDialog(String message) {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: const Text('Error'),
// //           content: Text(message),
// //           actions: [
// //             TextButton(
// //               onPressed: () => Navigator.of(context).pop(),
// //               child: const Text('OK'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   void _navigateBackToMedicineSelection(BuildContext context) {
// //   Navigator.of(context).pop();

// //   // Show the medicine selection modal after popping
// //   WidgetsBinding.instance.addPostFrameCallback((_) {
// //     showModalBottomSheet(
// //       context: context,
// //       isScrollControlled: true,
// //       backgroundColor: Colors.transparent,
// //       builder: (context) =>const MedicineDetailsModalWithSearch(
// //         showAfterActivation: false,
// //       ),
// //     );
// //   });
// // }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         leading: IconButton(onPressed: (){
// //           _navigateBackToMedicineSelection(context);
// //         }, icon: Icon(Icons.arrow_back_ios)),
// //       ),
// //       backgroundColor: Colors.grey[50],
// //       body: SafeArea(
// //         child: Column(
// //           children: [
// //             Expanded(
// //               child: SingleChildScrollView(
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(16.0),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       const SizedBox(height: 20),
// //                       _buildFrequencyToggle(),
// //                       const SizedBox(height: 34),
// //                       _buildMedicationList(),
// //                       const SizedBox(height: 24),
// //                       const Text(
// //                         "Select Date For Meds Delivery",
// //                         style: TextStyle(
// //                           fontSize: 18,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 24),
// //                       _buildDateSelector(),
// //                       const SizedBox(height: 34),
// //                       _buildDeliveryNote(),
// //                       const SizedBox(height: 24),
// //                       _buildNotesSection(),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             Consumer<PeriodicPlanProvider>(
// //               builder: (context, provider, child) {
// //                 return _buildCheckoutButton(provider);
// //               },
// //             ),
// //             const SizedBox(height: 40),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildNotesSection() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [

// //       TextButton(onPressed: (){
// //         Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangeAddressScreen()));
// //       }, child: Text('Add Address(Mandatory)')),

// //         const Text(
// //           "Additional Notes (Optional)",
// //           style: TextStyle(
// //             fontSize: 16,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         const SizedBox(height: 12),
// //         TextField(
// //           controller: _notesController,
// //           maxLines: 3,
// //           decoration: InputDecoration(
// //             hintText: 'Add any special instructions for delivery...',
// //             border: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(8),
// //             ),
// //             filled: true,
// //             fillColor: Colors.white,
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildDateSelector() {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       children: List.generate(5, (index) {
// //         DateTime today = DateTime.now();
// //         DateTime date = DateTime.now().add(Duration(days: index));

// //         String day = DateFormat('d').format(date);
// //         String month = DateFormat('MMM').format(date);

// //         bool isToday = date.day == today.day &&
// //             date.month == today.month &&
// //             date.year == today.year;

// //         bool isSelected = selectedDateIndex == index;

// //         // Calendar icon
// //         if (index == 4) {
// //           return GestureDetector(
// //             onTap: () => _selectFromCalendar(isStartDate: true),
// //             child: Stack(
// //               alignment: Alignment.topCenter,
// //               children: [
// //                 Positioned(
// //                   top: 0,
// //                   child: Container(
// //                     height: 6,
// //                     width: 50,
// //                     decoration: BoxDecoration(
// //                       color: Colors.black,
// //                       borderRadius: BorderRadius.circular(30),
// //                     ),
// //                   ),
// //                 ),
// //                 Container(
// //                   margin: const EdgeInsets.only(top: 4),
// //                   height: 80,
// //                   width: 55,
// //                   padding: const EdgeInsets.symmetric(vertical: 12),
// //                   decoration: BoxDecoration(
// //                     color: Colors.white,
// //                     borderRadius: BorderRadius.circular(8),
// //                     border: Border.all(color: Colors.black12),
// //                   ),
// //                   child: const Icon(Icons.calendar_month_sharp),
// //                 ),
// //               ],
// //             ),
// //           );
// //         }

// //         return GestureDetector(
// //           onTap: () {
// //             setState(() {
// //               selectedDateIndex = index;
// //               selectedDeliveryDate = date;
// //             });
// //           },
// //           child: Stack(
// //             alignment: Alignment.topCenter,
// //             children: [
// //               Positioned(
// //                 top: 0,
// //                 child: Container(
// //                   height: 6,
// //                   width: 50,
// //                   decoration: BoxDecoration(
// //                     color: isSelected
// //                         ? const Color(0XFF120698)
// //                         : Colors.black,
// //                     borderRadius: BorderRadius.circular(30),
// //                   ),
// //                 ),
// //               ),
// //               Container(
// //                 margin: const EdgeInsets.only(top: 4),
// //                 height: 80,
// //                 width: 60,
// //                 padding: const EdgeInsets.symmetric(vertical: 12),
// //                 decoration: BoxDecoration(
// //                   color: isSelected
// //                       ? const Color(0XFF5931DD)
// //                       : Colors.white,
// //                   borderRadius: BorderRadius.circular(8),
// //                   border: Border.all(
// //                     color: isSelected
// //                         ? const Color(0XFF5931DD)
// //                         : Colors.black12,
// //                   ),
// //                 ),
// //                 child: Column(
// //                   children: [
// //                     Text(
// //                       day,
// //                       style: TextStyle(
// //                         color: isSelected ? Colors.white : Colors.black,
// //                         fontWeight: FontWeight.bold,
// //                         fontSize: 16,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 4),
// //                     Text(
// //                       month,
// //                       style: TextStyle(
// //                         color: isSelected ? Colors.white : Colors.black,
// //                         fontSize: 14,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         );
// //       }),
// //     );
// //   }

// //   Future<void> _selectFromCalendar({required bool isStartDate}) async {
// //     final DateTime today = DateTime.now();
// //     final DateTime? picked = await showDatePicker(
// //       context: context,
// //       initialDate: selectedDeliveryDate,
// //       firstDate: today,
// //       lastDate: DateTime(today.year + 1),
// //     );

// //     if (picked != null) {
// //       setState(() {
// //         selectedDeliveryDate = picked;
// //         selectedDateIndex = -1; // Set to -1 to indicate custom date selected
// //       });
// //     }
// //   }

// //   Widget _buildFrequencyToggle() {
// //     return Container(
// //       decoration: const BoxDecoration(
// //         color: Color.fromARGB(255, 237, 234, 245),
// //         borderRadius: BorderRadius.horizontal(
// //           left: Radius.circular(24),
// //           right: Radius.circular(24),
// //         ),
// //       ),
// //       width: double.infinity,
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           InkWell(
// //             onTap: () {
// //               setState(() {
// //                 isWeeklySelected = true;
// //               });
// //             },
// //             child: Container(
// //               height: 48,
// //               width: 166,
// //               decoration: BoxDecoration(
// //                 color: isWeeklySelected
// //                     ? const Color(0xFF5931DD)
// //                     : Colors.transparent,
// //                 borderRadius: const BorderRadius.horizontal(
// //                   left: Radius.circular(24),
// //                   right: Radius.circular(24),
// //                 ),
// //                 border: Border.all(
// //                   color: const Color(0xFF5931DD),
// //                   width: 1,
// //                 ),
// //               ),
// //               alignment: Alignment.center,
// //               child: Text(
// //                 'Weekly',
// //                 style: TextStyle(
// //                   color: isWeeklySelected ? Colors.white : Colors.black,
// //                   fontWeight: FontWeight.w500,
// //                 ),
// //               ),
// //             ),
// //           ),
// //           InkWell(
// //             onTap: () {
// //               setState(() {
// //                 isWeeklySelected = false;
// //               });
// //             },
// //             child: Container(
// //               height: 48,
// //               width: 160,
// //               decoration: BoxDecoration(
// //                 color: !isWeeklySelected
// //                     ? const Color(0xFF5931DD)
// //                     : Colors.transparent,
// //                 borderRadius: const BorderRadius.horizontal(
// //                   left: Radius.circular(24),
// //                   right: Radius.circular(24),
// //                 ),
// //                 border: Border.all(
// //                   color: const Color(0xFF5931DD),
// //                   width: 1,
// //                 ),
// //               ),
// //               alignment: Alignment.center,
// //               child: Text(
// //                 'Monthly',
// //                 style: TextStyle(
// //                   color: !isWeeklySelected ? Colors.white : Colors.black,
// //                   fontWeight: FontWeight.w500,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildMedicationList() {
// //     return Column(
// //       children: List.generate(
// //         medications.length * 2 - 1,
// //         (i) {
// //           if (i.isEven) {
// //             final med = medications[i ~/ 2];
// //             return _buildMedicationItem(med);
// //           } else {
// //             return const Divider(
// //               color: Color.fromARGB(255, 221, 221, 221),
// //               height: 1,
// //               thickness: 1,
// //             );
// //           }
// //         },
// //       ),
// //     );
// //   }

// //   Widget _buildMedicationItem(Map<String, dynamic> medication) {
// //     Widget medicationImage;
// //     String pharmacyImage = medication["pharmacyImage"] ?? "assets/tablet.png";

// //     if (pharmacyImage.startsWith('http://') ||
// //         pharmacyImage.startsWith('https://')) {
// //       medicationImage = ClipRRect(
// //         borderRadius: BorderRadius.circular(8),
// //         child: Image.network(
// //           pharmacyImage,
// //           width: 60,
// //           height: 60,
// //           fit: BoxFit.cover,
// //           errorBuilder: (context, error, stackTrace) {
// //             return Container(
// //               width: 60,
// //               height: 60,
// //               decoration: BoxDecoration(
// //                 color: Colors.blue.shade100,
// //                 borderRadius: BorderRadius.circular(8),
// //               ),
// //               child: const Icon(
// //                 Icons.local_pharmacy,
// //                 size: 30,
// //                 color: Colors.grey,
// //               ),
// //             );
// //           },
// //           loadingBuilder: (context, child, loadingProgress) {
// //             if (loadingProgress == null) return child;
// //             return Container(
// //               width: 60,
// //               height: 60,
// //               decoration: BoxDecoration(
// //                 color: Colors.blue.shade100,
// //                 borderRadius: BorderRadius.circular(8),
// //               ),
// //               child: const Center(
// //                 child: CircularProgressIndicator(strokeWidth: 2),
// //               ),
// //             );
// //           },
// //         ),
// //       );
// //     } else {
// //       medicationImage = Container(
// //         width: 60,
// //         height: 60,
// //         decoration: BoxDecoration(
// //           color: Colors.blue.shade100,
// //           borderRadius: BorderRadius.circular(8),
// //           image: DecorationImage(
// //             image: AssetImage(pharmacyImage),
// //             fit: BoxFit.cover,
// //           ),
// //         ),
// //       );
// //     }

// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// //       child: Row(
// //         children: [
// //           medicationImage,
// //           const SizedBox(width: 12),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   medication["name"],
// //                   style: const TextStyle(
// //                     fontWeight: FontWeight.bold,
// //                     fontSize: 14,
// //                   ),
// //                 ),
// //                 Text(
// //                   'Qty: ${medication["quantity"]}',
// //                   style: TextStyle(
// //                     fontSize: 12,
// //                     color: Colors.grey.shade600,
// //                   ),
// //                 ),
// //                 if (medication["pharmacyName"] != null &&
// //                     medication["pharmacyName"] != "Unknown Pharmacy")
// //                   Text(
// //                     'From: ${medication["pharmacyName"]}',
// //                     style: TextStyle(
// //                       fontSize: 11,
// //                       color: Colors.purple.shade600,
// //                       fontWeight: FontWeight.w500,
// //                     ),
// //                   ),
// //                 if (medication["price"] != null &&
// //                     medication["price"].toString().isNotEmpty)
// //                   Text(
// //                     '₹${medication["price"]}',
// //                     style: const TextStyle(
// //                       fontSize: 12,
// //                       color: Colors.green,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //               ],
// //             ),
// //           ),
// //           Row(
// //             children: [
// //               Container(
// //                 width: 24,
// //                 height: 24,
// //                 decoration: BoxDecoration(
// //                   color: const Color.fromARGB(255, 221, 221, 221),
// //                   borderRadius: BorderRadius.circular(12),
// //                 ),
// //                 child: IconButton(
// //                   icon: const Icon(Icons.remove, size: 20),
// //                   onPressed: () {
// //                     if (medication["count"] > 1) {
// //                       setState(() {
// //                         medication["count"]--;
// //                       });
// //                     }
// //                   },
// //                   padding: EdgeInsets.zero,
// //                   constraints: const BoxConstraints(),
// //                 ),
// //               ),
// //               const SizedBox(width: 8),
// //               Text(
// //                 '0${medication["count"]}',
// //                 style: const TextStyle(fontWeight: FontWeight.bold),
// //               ),
// //               const SizedBox(width: 8),
// //               Container(
// //                 width: 24,
// //                 height: 24,
// //                 decoration: BoxDecoration(
// //                   color: const Color(0xFF5931DD),
// //                   borderRadius: BorderRadius.circular(12),
// //                 ),
// //                 child: IconButton(
// //                   icon: const Icon(Icons.add, size: 16, color: Colors.white),
// //                   onPressed: () {
// //                     setState(() {
// //                       medication["count"]++;
// //                     });
// //                   },
// //                   padding: EdgeInsets.zero,
// //                   constraints: const BoxConstraints(),
// //                 ),
// //               ),
// //               const SizedBox(width: 25),
// //               Container(
// //                 width: 24,
// //                 height: 24,
// //                 decoration: BoxDecoration(
// //                   border: Border.all(
// //                       color: const Color.fromARGB(255, 221, 221, 221)),
// //                   color: const Color.fromARGB(255, 255, 255, 255),
// //                   borderRadius: BorderRadius.circular(12),
// //                 ),
// //                 child: IconButton(
// //                   icon: Icon(MdiIcons.trashCanOutline,
// //                       color: Colors.red.shade400, size: 20),
// //                   onPressed: () {
// //                     setState(() {
// //                       medications.remove(medication);
// //                     });
// //                   },
// //                   padding: EdgeInsets.zero,
// //                   constraints: const BoxConstraints(),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildDeliveryNote() {
// //     String formattedDate =
// //         DateFormat('dd/MM/yyyy').format(selectedDeliveryDate);

// //     return SizedBox(
// //       width: double.infinity,
// //       child: Container(
// //         padding: const EdgeInsets.all(12),
// //         decoration: BoxDecoration(
// //           border: Border.all(color: Colors.grey.shade300),
// //           borderRadius: BorderRadius.circular(8),
// //         ),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             RichText(
// //               text: TextSpan(
// //                 style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
// //                 children: const [
// //                   TextSpan(
// //                     text: 'Note: ',
// //                     style: TextStyle(fontWeight: FontWeight.bold),
// //                   ),
// //                   TextSpan(
// //                     text: 'Your Medicines Will be Delivered on',
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(height: 4),
// //             Text(
// //               formattedDate,
// //               style: TextStyle(
// //                 color: Colors.grey.shade600,
// //                 fontSize: 14,
// //                 fontWeight: FontWeight.w600,
// //               ),
// //             ),
// //             const SizedBox(height: 8),
// //             Text(
// //               'Plan Type: ${isWeeklySelected ? 'Weekly' : 'Monthly'} recurring delivery',
// //               style: TextStyle(
// //                 color: const Color(0xFF5931DD),
// //                 fontSize: 12,
// //                 fontWeight: FontWeight.w600,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildCheckoutButton(PeriodicPlanProvider provider) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //       child: SizedBox(
// //         width: double.infinity,
// //         height: 50,
// //         child: ElevatedButton(
// //           onPressed: provider.isLoading
// //               ? null
// //               : () async {
// //                   // Clear any previous errors
// //                   provider.clearError();

// //                   // Create the periodic plan
// //                   await _createPeriodicPlan();
// //                 },
// //           style: ElevatedButton.styleFrom(
// //             backgroundColor: const Color(0xFF5931DD),
// //             disabledBackgroundColor: Colors.grey,
// //             shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(8),
// //             ),
// //           ),
// //           child: provider.isLoading
// //               ? const Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     SizedBox(
// //                       width: 20,
// //                       height: 20,
// //                       child: CircularProgressIndicator(
// //                         color: Colors.white,
// //                         strokeWidth: 2,
// //                       ),
// //                     ),
// //                     SizedBox(width: 8),
// //                     Text(
// //                       'Creating Plan...',
// //                       style: TextStyle(
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.bold,
// //                         color: Colors.white,
// //                       ),
// //                     ),
// //                   ],
// //                 )
// //               : const AppText(
// //                   'Create Periodic Plan',
// //                   style: TextStyle(
// //                     fontSize: 16,
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.white,
// //                   ),
// //                 ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:medical_user_app/view/change_address_screen.dart';
// import 'package:medical_user_app/view/main_layout.dart';
// import 'package:medical_user_app/widgets/periodic_plans.dart';
// import 'package:provider/provider.dart';
// import 'package:medical_user_app/providers/language_provider.dart';
// import 'package:medical_user_app/providers/periodic_plan_provider.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// class CheckoutScreen extends StatefulWidget {
//   final String? pharmacyName;
//   final String? pharmacyImage;
//   final String? medicineName;
//   final String? medicinePrice;
//   final String? medicineId;
//   final String? mrp;
//   final List<Map<String, dynamic>>? medicationsList;
//   final List<Medicine>? selectedMedicines;

//   const CheckoutScreen({
//     super.key,
//     this.pharmacyName,
//     this.pharmacyImage,
//     this.medicineName,
//     this.medicinePrice,
//     this.medicineId,
//     this.medicationsList,
//     this.mrp,
//     this.selectedMedicines,
//   });

//   @override
//   State<CheckoutScreen> createState() => _CheckoutScreenState();
// }

// class _CheckoutScreenState extends State<CheckoutScreen> {
//   bool isWeeklySelected = true;
//   late List<Map<String, dynamic>> medications;
//   int selectedDateIndex = 0;
//   DateTime selectedDeliveryDate = DateTime.now();
//   final TextEditingController _notesController = TextEditingController();

//   // Add this variable to track selected address
//   Map<String, dynamic>? selectedAddress;

//   @override
//   void initState() {
//     super.initState();

//     // Initialize medications with passed data or default values
//     if (widget.medicationsList != null && widget.medicationsList!.isNotEmpty) {
//       medications = List<Map<String, dynamic>>.from(widget.medicationsList!);
//     } else {
//       medications = [
//         {
//           "medicineId": widget.medicineId ?? "mock_medicine_id",
//           "name": widget.medicineName ?? "DOLO 500",
//           "quantity": "1 Strip",
//           "count": 1,
//           "pharmacyName": widget.pharmacyName ?? "Unknown Pharmacy",
//           "pharmacyImage": widget.pharmacyImage ?? "assets/tablet.png",
//           "price": widget.medicinePrice ?? ""
//         },
//       ];
//     }

//     // Load existing periodic plans when screen initializes
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<PeriodicPlanProvider>();
//     });
//   }

//   @override
//   void dispose() {
//     _notesController.dispose();
//     super.dispose();
//   }

//   Future<void> _createPeriodicPlan() async {
//     // Check if address is selected
//     if (selectedAddress == null) {
//       _showErrorDialog(
//           'Please select a delivery address before creating the plan');
//       return;
//     }

//     final provider = context.read<PeriodicPlanProvider>();

//     // Validate medications data
//     if (!provider.validateMedicationData(medications)) {
//       _showErrorDialog(provider.error ?? 'Invalid medication data');
//       return;
//     }

//     // Validate delivery date
//     if (!provider.validateDeliveryDates([selectedDeliveryDate])) {
//       _showErrorDialog(provider.error ?? 'Invalid delivery date');
//       return;
//     }

//     // Show loading dialog
//     _showLoadingDialog();

//     print('Selected delivery date: $selectedDeliveryDate');
//     print('Plan type: ${isWeeklySelected ? 'Weekly' : 'Monthly'}');
//     print('Selected address: $selectedAddress');

//     try {
//       final success = await provider.createPeriodicPlan(
//         planType: isWeeklySelected ? 'Weekly' : 'Monthly',
//         medications: medications,
//         deliveryDates: [selectedDeliveryDate],
//         notes: _notesController.text.trim(),
//         // You can add the selectedAddress to the provider call if needed
//       );

//       // Hide loading dialog
//       Navigator.of(context).pop();

//       if (success) {
//         _showSuccessDialog();
//       } else {
//         _showErrorDialog(provider.error ?? 'Failed to create periodic plan');
//       }
//     } catch (e) {
//       // Hide loading dialog
//       Navigator.of(context).pop();
//       _showErrorDialog('An unexpected error occurred: ${e.toString()}');
//     }
//   }

//   void _showLoadingDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return const AlertDialog(
//           content: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               CircularProgressIndicator(),
//               SizedBox(width: 16),
//               Text('Creating periodic plan...'),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _showSuccessDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Success'),
//           content: Text(
//             'Your ${isWeeklySelected ? 'weekly' : 'monthly'} periodic plan has been created successfully!',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close dialog
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const MainLayout(),
//                   ),
//                 );
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Error'),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _navigateBackToMedicineSelection(BuildContext context) {
//     Navigator.of(context).pop();

//     // Show the medicine selection modal after popping
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         backgroundColor: Colors.transparent,
//         builder: (context) => MedicineDetailsModalWithSearch(
//           showAfterActivation: false,
//           previouslySelectedMedicines: widget.selectedMedicines,
//         ),
//       );
//     });
//   }

//   // Add this method to navigate to address selection
//   Future<void> _navigateToAddressSelection() async {
//     final selectedAddressResult = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const ChangeAddressScreen(),
//       ),
//     );

//     if (selectedAddressResult != null) {
//       setState(() {
//         selectedAddress = selectedAddressResult;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               _navigateBackToMedicineSelection(context);
//             },
//             icon: const Icon(Icons.arrow_back_ios)),
//       ),
//       backgroundColor: Colors.grey[50],
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 20),
//                       _buildFrequencyToggle(),
//                       const SizedBox(height: 34),
//                       _buildMedicationList(),
//                       const SizedBox(height: 24),
//                       const Text(
//                         "Select Date For Meds Delivery",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 24),
//                       _buildDateSelector(),
//                       const SizedBox(height: 34),
//                       _buildDeliveryNote(),
//                       const SizedBox(height: 24),
//                       _buildNotesSection(),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Consumer<PeriodicPlanProvider>(
//               builder: (context, provider, child) {
//                 return _buildCheckoutButton(provider);
//               },
//             ),
//             const SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNotesSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Modified address section
//         Container(
//           width: double.infinity,
//           margin: const EdgeInsets.only(bottom: 16),
//           child: selectedAddress == null
//               ? TextButton(
//                   onPressed: _navigateToAddressSelection,
//                   style: TextButton.styleFrom(
//                     padding: const EdgeInsets.all(16),
//                     backgroundColor: Colors.red.shade50,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       side: BorderSide(color: Colors.red.shade300),
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(Icons.add_location_alt, color: Colors.red.shade600),
//                       const SizedBox(width: 8),
//                       Text(
//                         'Add Address (Mandatory)',
//                         style: TextStyle(
//                           color: Colors.red.shade600,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               : Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.green.shade50,
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: Colors.green.shade300),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Icon(Icons.location_on, color: Colors.green.shade600),
//                           const SizedBox(width: 8),
//                           const Expanded(
//                             child: Text(
//                               'Delivery Address',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: _navigateToAddressSelection,
//                             child: Text(
//                               'Change',
//                               style: TextStyle(
//                                 color: Colors.blue.shade600,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         _buildFullAddressString(selectedAddress!),
//                         style: TextStyle(
//                           color: Colors.grey[700],
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//         ),

//         const Text(
//           "Additional Notes (Optional)",
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),
//         TextField(
//           controller: _notesController,
//           maxLines: 3,
//           decoration: InputDecoration(
//             hintText: 'Add any special instructions for delivery...',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//             filled: true,
//             fillColor: Colors.white,
//           ),
//         ),
//       ],
//     );
//   }

//   // Helper method to build address string
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

//   Widget _buildDateSelector() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: List.generate(5, (index) {
//         DateTime today = DateTime.now();
//         DateTime date = DateTime.now().add(Duration(days: index));

//         String day = DateFormat('d').format(date);
//         String month = DateFormat('MMM').format(date);

//         bool isToday = date.day == today.day &&
//             date.month == today.month &&
//             date.year == today.year;

//         bool isSelected = selectedDateIndex == index;

//         // Calendar icon
//         if (index == 4) {
//           return GestureDetector(
//             onTap: () => _selectFromCalendar(isStartDate: true),
//             child: Stack(
//               alignment: Alignment.topCenter,
//               children: [
//                 Positioned(
//                   top: 0,
//                   child: Container(
//                     height: 6,
//                     width: 50,
//                     decoration: BoxDecoration(
//                       color: Colors.black,
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(top: 4),
//                   height: 80,
//                   width: 55,
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: Colors.black12),
//                   ),
//                   child: const Icon(Icons.calendar_month_sharp),
//                 ),
//               ],
//             ),
//           );
//         }

//         return GestureDetector(
//           onTap: () {
//             setState(() {
//               selectedDateIndex = index;
//               selectedDeliveryDate = date;
//             });
//           },
//           child: Stack(
//             alignment: Alignment.topCenter,
//             children: [
//               Positioned(
//                 top: 0,
//                 child: Container(
//                   height: 6,
//                   width: 50,
//                   decoration: BoxDecoration(
//                     color: isSelected ? const Color(0XFF120698) : Colors.black,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(top: 4),
//                 height: 80,
//                 width: 60,
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//                 decoration: BoxDecoration(
//                   color: isSelected ? const Color(0XFF5931DD) : Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(
//                     color:
//                         isSelected ? const Color(0XFF5931DD) : Colors.black12,
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Text(
//                       day,
//                       style: TextStyle(
//                         color: isSelected ? Colors.white : Colors.black,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       month,
//                       style: TextStyle(
//                         color: isSelected ? Colors.white : Colors.black,
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }

//   Future<void> _selectFromCalendar({required bool isStartDate}) async {
//     final DateTime today = DateTime.now();
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDeliveryDate,
//       firstDate: today,
//       lastDate: DateTime(today.year + 1),
//     );

//     if (picked != null) {
//       setState(() {
//         selectedDeliveryDate = picked;
//         selectedDateIndex = -1; // Set to -1 to indicate custom date selected
//       });
//     }
//   }

//   Widget _buildFrequencyToggle() {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Color.fromARGB(255, 237, 234, 245),
//         borderRadius: BorderRadius.horizontal(
//           left: Radius.circular(24),
//           right: Radius.circular(24),
//         ),
//       ),
//       width: double.infinity,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           InkWell(
//             onTap: () {
//               setState(() {
//                 isWeeklySelected = true;
//               });
//             },
//             child: Container(
//               height: 48,
//               width: 166,
//               decoration: BoxDecoration(
//                 color: isWeeklySelected
//                     ? const Color(0xFF5931DD)
//                     : Colors.transparent,
//                 borderRadius: const BorderRadius.horizontal(
//                   left: Radius.circular(24),
//                   right: Radius.circular(24),
//                 ),
//                 border: Border.all(
//                   color: const Color(0xFF5931DD),
//                   width: 1,
//                 ),
//               ),
//               alignment: Alignment.center,
//               child: Text(
//                 'Weekly',
//                 style: TextStyle(
//                   color: isWeeklySelected ? Colors.white : Colors.black,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ),
//           InkWell(
//             onTap: () {
//               setState(() {
//                 isWeeklySelected = false;
//               });
//             },
//             child: Container(
//               height: 48,
//               width: 160,
//               decoration: BoxDecoration(
//                 color: !isWeeklySelected
//                     ? const Color(0xFF5931DD)
//                     : Colors.transparent,
//                 borderRadius: const BorderRadius.horizontal(
//                   left: Radius.circular(24),
//                   right: Radius.circular(24),
//                 ),
//                 border: Border.all(
//                   color: const Color(0xFF5931DD),
//                   width: 1,
//                 ),
//               ),
//               alignment: Alignment.center,
//               child: Text(
//                 'Monthly',
//                 style: TextStyle(
//                   color: !isWeeklySelected ? Colors.white : Colors.black,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMedicationList() {
//     return Column(
//       children: List.generate(
//         medications.length * 2 - 1,
//         (i) {
//           if (i.isEven) {
//             final med = medications[i ~/ 2];
//             return _buildMedicationItem(med);
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

//   Widget _buildMedicationItem(Map<String, dynamic> medication) {
//     Widget medicationImage;
//     String pharmacyImage = medication["pharmacyImage"] ?? "assets/tablet.png";

//     if (pharmacyImage.startsWith('http://') ||
//         pharmacyImage.startsWith('https://')) {
//       medicationImage = ClipRRect(
//         borderRadius: BorderRadius.circular(8),
//         child: Image.network(
//           pharmacyImage,
//           width: 60,
//           height: 60,
//           fit: BoxFit.cover,
//           errorBuilder: (context, error, stackTrace) {
//             return Container(
//               width: 60,
//               height: 60,
//               decoration: BoxDecoration(
//                 color: Colors.blue.shade100,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Icon(
//                 Icons.local_pharmacy,
//                 size: 30,
//                 color: Colors.grey,
//               ),
//             );
//           },
//           loadingBuilder: (context, child, loadingProgress) {
//             if (loadingProgress == null) return child;
//             return Container(
//               width: 60,
//               height: 60,
//               decoration: BoxDecoration(
//                 color: Colors.blue.shade100,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Center(
//                 child: CircularProgressIndicator(strokeWidth: 2),
//               ),
//             );
//           },
//         ),
//       );
//     } else {
//       medicationImage = Container(
//         width: 60,
//         height: 60,
//         decoration: BoxDecoration(
//           color: Colors.blue.shade100,
//           borderRadius: BorderRadius.circular(8),
//           image: DecorationImage(
//             image: AssetImage(pharmacyImage),
//             fit: BoxFit.cover,
//           ),
//         ),
//       );
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       child: Row(
//         children: [
//           medicationImage,
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   medication["name"],
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                   ),
//                 ),
//                 Text(
//                   'Qty: ${medication["quantity"]}',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//                 if (medication["pharmacyName"] != null &&
//                     medication["pharmacyName"] != "Unknown Pharmacy")
//                   Text(
//                     'From: ${medication["pharmacyName"]}',
//                     style: TextStyle(
//                       fontSize: 11,
//                       color: Colors.purple.shade600,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 if (medication["price"] != null &&
//                     medication["price"].toString().isNotEmpty)
//                   Text(
//                     '₹${medication["mrp"]}',
//                     style: const TextStyle(
//                       fontSize: 12,
//                       color: Colors.green,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           Row(
//             children: [
//               Container(
//                 width: 24,
//                 height: 24,
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 221, 221, 221),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: IconButton(
//                   icon: const Icon(Icons.remove, size: 20),
//                   onPressed: () {
//                     if (medication["count"] > 1) {
//                       setState(() {
//                         medication["count"]--;
//                       });
//                     }
//                   },
//                   padding: EdgeInsets.zero,
//                   constraints: const BoxConstraints(),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 '0${medication["count"]}',
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(width: 8),
//               Container(
//                 width: 24,
//                 height: 24,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF5931DD),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: IconButton(
//                   icon: const Icon(Icons.add, size: 16, color: Colors.white),
//                   onPressed: () {
//                     setState(() {
//                       medication["count"]++;
//                     });
//                   },
//                   padding: EdgeInsets.zero,
//                   constraints: const BoxConstraints(),
//                 ),
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
//                   onPressed: () {
//                     setState(() {
//                       medications.remove(medication);
//                     });
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

//   Widget _buildDeliveryNote() {
//     String formattedDate =
//         DateFormat('dd/MM/yyyy').format(selectedDeliveryDate);

//     return SizedBox(
//       width: double.infinity,
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey.shade300),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             RichText(
//               text: TextSpan(
//                 style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
//                 children: const [
//                   TextSpan(
//                     text: 'Note: ',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   TextSpan(
//                     text: 'Your Medicines Will be Delivered on',
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               formattedDate,
//               style: TextStyle(
//                 color: Colors.grey.shade600,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Plan Type: ${isWeeklySelected ? 'Weekly' : 'Monthly'} recurring delivery',
//               style: const TextStyle(
//                 color: Color(0xFF5931DD),
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCheckoutButton(PeriodicPlanProvider provider) {
//     // Check if address is selected to enable/disable button
//     bool isButtonEnabled = selectedAddress != null && !provider.isLoading;

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: SizedBox(
//         width: double.infinity,
//         height: 50,
//         child: ElevatedButton(
//           onPressed: isButtonEnabled
//               ? () async {
//                   // Clear any previous errors
//                   provider.clearError();

//                   // Create the periodic plan
//                   await _createPeriodicPlan();
//                 }
//               : null, // Disabled when address is not selected
//           style: ElevatedButton.styleFrom(
//             backgroundColor: isButtonEnabled
//                 ? const Color(0xFF5931DD)
//                 : Colors.grey.shade400,
//             disabledBackgroundColor: Colors.grey.shade400,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//           child: provider.isLoading
//               ? const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       width: 20,
//                       height: 20,
//                       child: CircularProgressIndicator(
//                         color: Colors.white,
//                         strokeWidth: 2,
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     Text(
//                       'Creating Plan...',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 )
//               : Text(
//                   selectedAddress == null
//                       ? 'Select Address to Continue'
//                       : 'Create Periodic Plan',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: isButtonEnabled ? Colors.white : Colors.white70,
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_user_app/view/change_address_screen.dart';
import 'package:medical_user_app/view/main_layout.dart';
import 'package:medical_user_app/widgets/periodic_plans.dart';
import 'package:provider/provider.dart';
import 'package:medical_user_app/providers/periodic_plan_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CheckoutScreen extends StatefulWidget {
  final String? pharmacyName;
  final String? pharmacyImage;
  final String? medicineName;
  final String? medicinePrice;
  final String? medicineId;
  final String? mrp;
  final List<Map<String, dynamic>>? medicationsList;
  final List<Medicine>? selectedMedicines;

  const CheckoutScreen({
    super.key,
    this.pharmacyName,
    this.pharmacyImage,
    this.medicineName,
    this.medicinePrice,
    this.medicineId,
    this.medicationsList,
    this.mrp,
    this.selectedMedicines,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool isWeeklySelected = true;
  late List<Map<String, dynamic>> medications;
  int selectedDateIndex = 0;
  DateTime selectedDeliveryDate = DateTime.now();
  final TextEditingController _notesController = TextEditingController();

  // Add this variable to track selected address
  Map<String, dynamic>? selectedAddress;

  @override
  void initState() {
    super.initState();

    // Initialize medications with passed data or default values
    if (widget.medicationsList != null && widget.medicationsList!.isNotEmpty) {
      medications = List<Map<String, dynamic>>.from(widget.medicationsList!);
    } else {
      medications = [
        {
          "medicineId": widget.medicineId ?? "mock_medicine_id",
          "name": widget.medicineName ?? "DOLO 500",
          "quantity": "1 Strip",
          "count": 1,
          "pharmacyName": widget.pharmacyName ?? "Unknown Pharmacy",
          "pharmacyImage": widget.pharmacyImage ?? "assets/tablet.png",
          "price": widget.medicinePrice ?? ""
        },
      ];
    }

    // Load existing periodic plans when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PeriodicPlanProvider>();
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _createPeriodicPlan() async {
    // Check if medications list is not empty
    if (medications.isEmpty) {
      _showErrorDialog('Please add at least one medicine to the plan');
      return;
    }

    // Check if address is selected
    if (selectedAddress == null) {
      _showErrorDialog(
          'Please select a delivery address before creating the plan');
      return;
    }

    final provider = context.read<PeriodicPlanProvider>();

    // Validate medications data
    if (!provider.validateMedicationData(medications)) {
      _showErrorDialog(provider.error ?? 'Invalid medication data');
      return;
    }

    // Validate delivery date
    if (!provider.validateDeliveryDates([selectedDeliveryDate])) {
      _showErrorDialog(provider.error ?? 'Invalid delivery date');
      return;
    }

    // Show loading dialog
    _showLoadingDialog();

    print('Selected delivery date: $selectedDeliveryDate');
    print('Plan type: ${isWeeklySelected ? 'Weekly' : 'Monthly'}');
    print('Selected address: $selectedAddress');

    try {
      final success = await provider.createPeriodicPlan(
        planType: isWeeklySelected ? 'Weekly' : 'Monthly',
        medications: medications,
        deliveryDates: [selectedDeliveryDate],
        notes: _notesController.text.trim(),
        // You can add the selectedAddress to the provider call if needed
      );

      // Hide loading dialog
      Navigator.of(context).pop();

      if (success) {
        _showSuccessDialog();
      } else {
        _showErrorDialog(provider.error ?? 'Failed to create periodic plan');
      }
    } catch (e) {
      // Hide loading dialog
      Navigator.of(context).pop();
      _showErrorDialog('An unexpected error occurred: ${e.toString()}');
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text('Creating periodic plan...'),
            ],
          ),
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: Text(
            'Your ${isWeeklySelected ? 'weekly' : 'monthly'} periodic plan has been created successfully!',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainLayout(),
                  ),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _navigateBackToMedicineSelection(BuildContext context) {
    Navigator.of(context).pop();

    // Show the medicine selection modal after popping
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => MedicineDetailsModalWithSearch(
          showAfterActivation: false,
          previouslySelectedMedicines: widget.selectedMedicines,
        ),
      );
    });
  }

  // Add this method to navigate to address selection
  Future<void> _navigateToAddressSelection() async {
    final selectedAddressResult = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChangeAddressScreen(),
      ),
    );

    if (selectedAddressResult != null) {
      setState(() {
        selectedAddress = selectedAddressResult;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              _navigateBackToMedicineSelection(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      _buildFrequencyToggle(),
                      const SizedBox(height: 34),
                      _buildMedicationList(),
                      const SizedBox(height: 24),
                      const Text(
                        "Select Date For Meds Delivery",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildDateSelector(),
                      const SizedBox(height: 34),
                      _buildDeliveryNote(),
                      const SizedBox(height: 24),
                      _buildNotesSection(),
                    ],
                  ),
                ),
              ),
            ),
            Consumer<PeriodicPlanProvider>(
              builder: (context, provider, child) {
                return _buildCheckoutButton(provider);
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Modified address section
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          child: selectedAddress == null
              ? TextButton(
                  onPressed: _navigateToAddressSelection,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.red.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.red.shade300),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.add_location_alt, color: Colors.red.shade600),
                      const SizedBox(width: 8),
                      Text(
                        'Add Address (Mandatory)',
                        style: TextStyle(
                          color: Colors.red.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.green.shade600),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              'Delivery Address',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: _navigateToAddressSelection,
                            child: Text(
                              'Change',
                              style: TextStyle(
                                color: Colors.blue.shade600,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _buildFullAddressString(selectedAddress!),
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
        ),

        const Text(
          "Additional Notes (Optional)",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _notesController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Add any special instructions for delivery...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }

  // Helper method to build address string
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

  Widget _buildDateSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(5, (index) {
        DateTime today = DateTime.now();
        DateTime date = DateTime.now().add(Duration(days: index));

        String day = DateFormat('d').format(date);
        String month = DateFormat('MMM').format(date);

        bool isToday = date.day == today.day &&
            date.month == today.month &&
            date.year == today.year;

        bool isSelected = selectedDateIndex == index;

        // Calendar icon
        if (index == 4) {
          return GestureDetector(
            onTap: () => _selectFromCalendar(isStartDate: true),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  top: 0,
                  child: Container(
                    height: 6,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  height: 80,
                  width: 55,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: const Icon(Icons.calendar_month_sharp),
                ),
              ],
            ),
          );
        }

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedDateIndex = index;
              selectedDeliveryDate = date;
            });
          },
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 0,
                child: Container(
                  height: 6,
                  width: 50,
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0XFF120698) : Colors.black,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                height: 80,
                width: 60,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0XFF5931DD) : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color:
                        isSelected ? const Color(0XFF5931DD) : Colors.black12,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      day,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      month,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Future<void> _selectFromCalendar({required bool isStartDate}) async {
    final DateTime today = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDeliveryDate,
      firstDate: today,
      lastDate: DateTime(today.year + 1),
    );

    if (picked != null) {
      setState(() {
        selectedDeliveryDate = picked;
        selectedDateIndex = -1; // Set to -1 to indicate custom date selected
      });
    }
  }

  Widget _buildFrequencyToggle() {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 237, 234, 245),
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(24),
          right: Radius.circular(24),
        ),
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isWeeklySelected = true;
              });
            },
            child: Container(
              height: 48,
              width: 166,
              decoration: BoxDecoration(
                color: isWeeklySelected
                    ? const Color(0xFF5931DD)
                    : Colors.transparent,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(24),
                  right: Radius.circular(24),
                ),
                border: Border.all(
                  color: const Color(0xFF5931DD),
                  width: 1,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'Weekly',
                style: TextStyle(
                  color: isWeeklySelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                isWeeklySelected = false;
              });
            },
            child: Container(
              height: 48,
              width: 160,
              decoration: BoxDecoration(
                color: !isWeeklySelected
                    ? const Color(0xFF5931DD)
                    : Colors.transparent,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(24),
                  right: Radius.circular(24),
                ),
                border: Border.all(
                  color: const Color(0xFF5931DD),
                  width: 1,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'Monthly',
                style: TextStyle(
                  color: !isWeeklySelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationList() {
    // Check if medications list is empty
    if (medications.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                size: 64,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 16),
              Text(
                'No medicines added',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please add medicines to create a plan',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: List.generate(
        medications.length * 2 - 1,
        (i) {
          if (i.isEven) {
            final med = medications[i ~/ 2];
            return _buildMedicationItem(med);
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

  Widget _buildMedicationItem(Map<String, dynamic> medication) {
    Widget medicationImage;
    String pharmacyImage = medication["pharmacyImage"] ?? "assets/tablet.png";

    if (pharmacyImage.startsWith('http://') ||
        pharmacyImage.startsWith('https://')) {
      medicationImage = ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          pharmacyImage,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.local_pharmacy,
                size: 30,
                color: Colors.grey,
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          },
        ),
      );
    } else {
      medicationImage = Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: AssetImage(pharmacyImage),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          medicationImage,
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medication["name"],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Qty: ${medication["quantity"]}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                if (medication["pharmacyName"] != null &&
                    medication["pharmacyName"] != "Unknown Pharmacy")
                  Text(
                    'From: ${medication["pharmacyName"]}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.purple.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                if (medication["price"] != null &&
                    medication["price"].toString().isNotEmpty)
                  Text(
                    '₹${medication["mrp"]}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 221, 221, 221),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.remove, size: 20),
                  onPressed: () {
                    if (medication["count"] > 1) {
                      setState(() {
                        medication["count"]--;
                      });
                    }
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '0${medication["count"]}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFF5931DD),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, size: 16, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      medication["count"]++;
                    });
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
              const SizedBox(width: 25),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 221, 221, 221)),
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: Icon(MdiIcons.trashCanOutline,
                      color: Colors.red.shade400, size: 20),
                  onPressed: () {
                    setState(() {
                      medications.remove(medication);
                    });
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

  Widget _buildDeliveryNote() {
    String formattedDate =
        DateFormat('dd/MM/yyyy').format(selectedDeliveryDate);

    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
                children: const [
                  TextSpan(
                    text: 'Note: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'Your Medicines Will be Delivered on',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              formattedDate,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Plan Type: ${isWeeklySelected ? 'Weekly' : 'Monthly'} recurring delivery',
              style: const TextStyle(
                color: Color(0xFF5931DD),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutButton(PeriodicPlanProvider provider) {
    // Check if address is selected and medications list is not empty to enable/disable button
    bool isButtonEnabled = selectedAddress != null &&
        !provider.isLoading &&
        medications.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: isButtonEnabled
              ? () async {
                  // Clear any previous errors
                  provider.clearError();

                  // Create the periodic plan
                  await _createPeriodicPlan();
                }
              : null, // Disabled when address is not selected or medications list is empty
          style: ElevatedButton.styleFrom(
            backgroundColor: isButtonEnabled
                ? const Color(0xFF5931DD)
                : Colors.grey.shade400,
            disabledBackgroundColor: Colors.grey.shade400,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: provider.isLoading
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Creating Plan...',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              : Text(
                  medications.isEmpty
                      ? 'Add Medicines to Continue'
                      : selectedAddress == null
                          ? 'Select Address to Continue'
                          : 'Create Periodic Plan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isButtonEnabled ? Colors.white : Colors.white70,
                  ),
                ),
        ),
      ),
    );
  }
}
