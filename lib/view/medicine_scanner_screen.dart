// // // // // // // // import 'package:flutter/material.dart';
// // // // // // // // import 'package:mobile_scanner/mobile_scanner.dart';
// // // // // // // // import 'package:image_picker/image_picker.dart';
// // // // // // // // import 'dart:ui';
// // // // // // // // import 'dart:io';

// // // // // // // // class MedicineScannerScreen extends StatefulWidget {
// // // // // // // //   const MedicineScannerScreen({super.key});

// // // // // // // //   @override
// // // // // // // //   State<MedicineScannerScreen> createState() => _MedicineScannerScreenState();
// // // // // // // // }

// // // // // // // // class _MedicineScannerScreenState extends State<MedicineScannerScreen>
// // // // // // // //     with SingleTickerProviderStateMixin {
// // // // // // // //   late MobileScannerController scannerController;
// // // // // // // //   bool _isScanning = true;
// // // // // // // //   String? _scannedResult;
// // // // // // // //   File? _selectedImage;
// // // // // // // //   final ImagePicker _imagePicker = ImagePicker();

// // // // // // // //   // Animation controller for the scanning line
// // // // // // // //   late AnimationController _animationController;
// // // // // // // //   late Animation<double> _animation;

// // // // // // // //   @override
// // // // // // // //   void initState() {
// // // // // // // //     super.initState();
// // // // // // // //     scannerController = MobileScannerController(
// // // // // // // //       detectionSpeed: DetectionSpeed.normal,
// // // // // // // //       facing: CameraFacing.back,
// // // // // // // //     );

// // // // // // // //     // Initialize animation controller
// // // // // // // //     _animationController = AnimationController(
// // // // // // // //       duration: const Duration(seconds: 2),
// // // // // // // //       vsync: this,
// // // // // // // //     )..repeat(reverse: true); // Makes the animation go back and forth

// // // // // // // //     // Create animation that moves from top (0.0) to bottom (1.0) of container
// // // // // // // //     _animation =
// // // // // // // //         Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
// // // // // // // //   }

// // // // // // // //   @override
// // // // // // // //   void dispose() {
// // // // // // // //     _animationController.dispose();
// // // // // // // //     scannerController.dispose();
// // // // // // // //     super.dispose();
// // // // // // // //   }

// // // // // // // //   void _onBarcodeDetected(BarcodeCapture capture) {
// // // // // // // //     final List<Barcode> barcodes = capture.barcodes;
// // // // // // // //     if (barcodes.isNotEmpty && _isScanning) {
// // // // // // // //       setState(() {
// // // // // // // //         _isScanning = false; // Stop multiple triggers
// // // // // // // //         _scannedResult = barcodes.first.rawValue ?? 'Unknown';
// // // // // // // //       });

// // // // // // // //       // Resume scanning after short delay (optional)
// // // // // // // //       Future.delayed(const Duration(seconds: 2), () {
// // // // // // // //         setState(() {
// // // // // // // //           _isScanning = true;
// // // // // // // //         });
// // // // // // // //       });
// // // // // // // //     }
// // // // // // // //   }

// // // // // // // //   // Method to pick image from gallery
// // // // // // // //   Future<void> _pickImageFromGallery() async {
// // // // // // // //     try {
// // // // // // // //       final XFile? pickedFile = await _imagePicker.pickImage(
// // // // // // // //         source: ImageSource.gallery,
// // // // // // // //         imageQuality: 80, // Compress image to 80% quality
// // // // // // // //       );

// // // // // // // //       if (pickedFile != null) {
// // // // // // // //         setState(() {
// // // // // // // //           _selectedImage = File(pickedFile.path);
// // // // // // // //         });

// // // // // // // //         // Show success message
// // // // // // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // // // // // //           const SnackBar(
// // // // // // // //             content: Text('Image selected successfully!'),
// // // // // // // //             backgroundColor: Colors.green,
// // // // // // // //             duration: Duration(seconds: 2),
// // // // // // // //           ),
// // // // // // // //         );

// // // // // // // //         _processSelectedImage();
// // // // // // // //       }
// // // // // // // //     } catch (e) {
// // // // // // // //       // Handle any errors
// // // // // // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // // // // // //         SnackBar(
// // // // // // // //           content: Text('Error picking image: $e'),
// // // // // // // //           backgroundColor: Colors.red,
// // // // // // // //           duration: const Duration(seconds: 2),
// // // // // // // //         ),
// // // // // // // //       );
// // // // // // // //     }
// // // // // // // //   }

// // // // // // // //   void _processSelectedImage() {

// // // // // // // //     print('Processing selected image: ${_selectedImage?.path}');
// // // // // // // //   }

// // // // // // // //   @override
// // // // // // // //   Widget build(BuildContext context) {
// // // // // // // //     return Scaffold(
// // // // // // // //       body: Stack(
// // // // // // // //         children: [
// // // // // // // //           Positioned.fill(
// // // // // // // //             child: Image.asset(
// // // // // // // //               'assets/background_image.png',
// // // // // // // //               fit: BoxFit.cover,
// // // // // // // //             ),
// // // // // // // //           ),

// // // // // // // //           // Blur effect on top of image
// // // // // // // //           Positioned.fill(
// // // // // // // //             child: BackdropFilter(
// // // // // // // //               filter:
// // // // // // // //                   ImageFilter.blur(sigmaX: 83.6, sigmaY: 83.6), // heavy blur
// // // // // // // //               child: Container(
// // // // // // // //                 color: Colors.black
// // // // // // // //                     .withOpacity(0), // Required for BackdropFilter to work
// // // // // // // //               ),
// // // // // // // //             ),
// // // // // // // //           ),
// // // // // // // //           SafeArea(
// // // // // // // //             child: Column(
// // // // // // // //               children: [
// // // // // // // //                 // Top toolbar
// // // // // // // //                 const SizedBox(
// // // // // // // //                   height: 30,
// // // // // // // //                 ),
// // // // // // // //                 Padding(
// // // // // // // //                   padding: const EdgeInsets.symmetric(
// // // // // // // //                       horizontal: 18.0, vertical: 12.0),
// // // // // // // //                   child: Container(
// // // // // // // //                     height: 44,
// // // // // // // //                     width: 343,
// // // // // // // //                     decoration: BoxDecoration(
// // // // // // // //                       color: Colors.white,
// // // // // // // //                       borderRadius: BorderRadius.circular(10),
// // // // // // // //                     ),
// // // // // // // //                     child: Row(
// // // // // // // //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // // // // //                       children: [
// // // // // // // //                         IconButton(
// // // // // // // //                           icon: const Icon(Icons.flash_on, color: Colors.blue),
// // // // // // // //                           onPressed: () {
// // // // // // // //                             scannerController.toggleTorch();
// // // // // // // //                           },
// // // // // // // //                         ),
// // // // // // // //                         IconButton(
// // // // // // // //                           icon: const Icon(Icons.photo_library, color: Colors.purple),
// // // // // // // //                           onPressed: _pickImageFromGallery, // Added gallery picker function
// // // // // // // //                         ),
// // // // // // // //                         const IconButton(
// // // // // // // //                           icon: Icon(Icons.sync, color: Colors.black54),
// // // // // // // //                           onPressed: null, // You can add sync functionality here
// // // // // // // //                         ),
// // // // // // // //                       ],
// // // // // // // //                     ),
// // // // // // // //                   ),
// // // // // // // //                 ),

// // // // // // // //                 const SizedBox(height: 10.0),

// // // // // // // //                 const Text(
// // // // // // // //                   'Scan the Medicine',
// // // // // // // //                   style: TextStyle(
// // // // // // // //                     fontSize: 22.0,
// // // // // // // //                     fontWeight: FontWeight.bold,
// // // // // // // //                     color: Colors.black87,
// // // // // // // //                   ),
// // // // // // // //                 ),

// // // // // // // //                 const SizedBox(height: 20.0),

// // // // // // // //                 // Scanner View Area
// // // // // // // //                 Padding(
// // // // // // // //                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
// // // // // // // //                   child: Container(
// // // // // // // //                     height: 320,
// // // // // // // //                     width: double.infinity,
// // // // // // // //                     decoration: BoxDecoration(
// // // // // // // //                       color: Colors.white,
// // // // // // // //                       borderRadius: BorderRadius.circular(20.0),
// // // // // // // //                     ),
// // // // // // // //                     child: Stack(
// // // // // // // //                       alignment: Alignment.center,
// // // // // // // //                       children: [
// // // // // // // //                         ClipRRect(
// // // // // // // //                           borderRadius: BorderRadius.circular(20.0),
// // // // // // // //                           child: _selectedImage != null
// // // // // // // //                               ? Image.file(
// // // // // // // //                                   _selectedImage!,
// // // // // // // //                                   fit: BoxFit.cover,
// // // // // // // //                                   width: double.infinity,
// // // // // // // //                                   height: double.infinity,
// // // // // // // //                                 )
// // // // // // // //                               : MobileScanner(
// // // // // // // //                                   controller: scannerController,
// // // // // // // //                                   onDetect: _onBarcodeDetected,
// // // // // // // //                                 ),
// // // // // // // //                         ),

// // // // // // // //                         // Show scanning line only when camera is active
// // // // // // // //                         if (_selectedImage == null)
// // // // // // // //                           AnimatedBuilder(
// // // // // // // //                             animation: _animation,
// // // // // // // //                             builder: (context, child) {
// // // // // // // //                               return Positioned(
// // // // // // // //                                 top: _animation.value * 270,
// // // // // // // //                                 child: Container(
// // // // // // // //                                   width: 280,
// // // // // // // //                                   height: 5,
// // // // // // // //                                   decoration: BoxDecoration(
// // // // // // // //                                     gradient: LinearGradient(
// // // // // // // //                                       colors: [
// // // // // // // //                                         Colors.greenAccent.withOpacity(0.7),
// // // // // // // //                                         Colors.green.withOpacity(0.7)
// // // // // // // //                                       ],
// // // // // // // //                                     ),
// // // // // // // //                                     boxShadow: [
// // // // // // // //                                       BoxShadow(
// // // // // // // //                                         color:
// // // // // // // //                                             Colors.greenAccent.withOpacity(0.5),
// // // // // // // //                                         blurRadius: 12,
// // // // // // // //                                         spreadRadius: 2,
// // // // // // // //                                       ),
// // // // // // // //                                     ],
// // // // // // // //                                   ),
// // // // // // // //                                 ),
// // // // // // // //                               );
// // // // // // // //                             },
// // // // // // // //                           ),

// // // // // // // //                         // Scanner corners
// // // // // // // //                         _buildCorner(Alignment.topLeft),
// // // // // // // //                         _buildCorner(Alignment.topRight),
// // // // // // // //                         _buildCorner(Alignment.bottomLeft),
// // // // // // // //                         _buildCorner(Alignment.bottomRight),

// // // // // // // //                         // Show overlay for selected image
// // // // // // // //                         if (_selectedImage != null)
// // // // // // // //                           Positioned(
// // // // // // // //                             bottom: 16,
// // // // // // // //                             right: 16,
// // // // // // // //                             child: Container(
// // // // // // // //                               padding: const EdgeInsets.all(8),
// // // // // // // //                               decoration: BoxDecoration(
// // // // // // // //                                 color: Colors.black.withOpacity(0.7),
// // // // // // // //                                 borderRadius: BorderRadius.circular(8),
// // // // // // // //                               ),
// // // // // // // //                               child: const Text(
// // // // // // // //                                 'Image Selected',
// // // // // // // //                                 style: TextStyle(
// // // // // // // //                                   color: Colors.white,
// // // // // // // //                                   fontSize: 12,
// // // // // // // //                                   fontWeight: FontWeight.w500,
// // // // // // // //                                 ),
// // // // // // // //                               ),
// // // // // // // //                             ),
// // // // // // // //                           ),
// // // // // // // //                       ],
// // // // // // // //                     ),
// // // // // // // //                   ),
// // // // // // // //                 ),

// // // // // // // //                 const SizedBox(height: 20.0),

// // // // // // // //                 Row(
// // // // // // // //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // // // // // // //                   children: [
// // // // // // // //                     SizedBox(
// // // // // // // //                       height: 36,
// // // // // // // //                       width: 160,
// // // // // // // //                       child: ElevatedButton(
// // // // // // // //                         onPressed: () {
// // // // // // // //                           Navigator.pop(context);
// // // // // // // //                         },
// // // // // // // //                         style: ElevatedButton.styleFrom(
// // // // // // // //                           backgroundColor: Colors.white,
// // // // // // // //                           foregroundColor: Colors.black87,
// // // // // // // //                           shape: RoundedRectangleBorder(
// // // // // // // //                             borderRadius: BorderRadius.circular(5),
// // // // // // // //                           ),
// // // // // // // //                         ),
// // // // // // // //                         child: const Text(
// // // // // // // //                           'Cancel Scanning',
// // // // // // // //                           style:
// // // // // // // //                               TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
// // // // // // // //                         ),
// // // // // // // //                       ),
// // // // // // // //                     ),

// // // // // // // //                     // Add button to switch back to camera if image is selected
// // // // // // // //                     if (_selectedImage != null)
// // // // // // // //                       SizedBox(
// // // // // // // //                         height: 36,
// // // // // // // //                         width: 120,
// // // // // // // //                         child: ElevatedButton(
// // // // // // // //                           onPressed: () {
// // // // // // // //                             setState(() {
// // // // // // // //                               _selectedImage = null;
// // // // // // // //                             });
// // // // // // // //                           },
// // // // // // // //                           style: ElevatedButton.styleFrom(
// // // // // // // //                             backgroundColor: Colors.blue,
// // // // // // // //                             foregroundColor: Colors.white,
// // // // // // // //                             shape: RoundedRectangleBorder(
// // // // // // // //                               borderRadius: BorderRadius.circular(5),
// // // // // // // //                             ),
// // // // // // // //                           ),
// // // // // // // //                           child: const Text(
// // // // // // // //                             'Use Camera',
// // // // // // // //                             style: TextStyle(
// // // // // // // //                                 fontSize: 14, fontWeight: FontWeight.w500),
// // // // // // // //                           ),
// // // // // // // //                         ),
// // // // // // // //                       ),
// // // // // // // //                   ],
// // // // // // // //                 ),

// // // // // // // //                 const SizedBox(height: 20),

// // // // // // // //                 // Display scan result if available
// // // // // // // //                 if (_scannedResult != null)
// // // // // // // //                   Container(
// // // // // // // //                     margin: const EdgeInsets.symmetric(
// // // // // // // //                         horizontal: 24.0, vertical: 10.0),
// // // // // // // //                     padding: const EdgeInsets.all(16.0),
// // // // // // // //                     decoration: BoxDecoration(
// // // // // // // //                       color: Colors.white,
// // // // // // // //                       borderRadius: BorderRadius.circular(15.0),
// // // // // // // //                       boxShadow: [
// // // // // // // //                         BoxShadow(
// // // // // // // //                           color: Colors.black.withOpacity(0.1),
// // // // // // // //                           blurRadius: 8,
// // // // // // // //                           spreadRadius: 1,
// // // // // // // //                         ),
// // // // // // // //                       ],
// // // // // // // //                     ),
// // // // // // // //                     child: Row(
// // // // // // // //                       children: [
// // // // // // // //                         Container(
// // // // // // // //                           width: 80,
// // // // // // // //                           height: 80,
// // // // // // // //                           padding: const EdgeInsets.all(10),
// // // // // // // //                           decoration: BoxDecoration(
// // // // // // // //                             borderRadius: BorderRadius.circular(10),
// // // // // // // //                             image: const DecorationImage(
// // // // // // // //                               image: AssetImage('assets/tablet.png'),
// // // // // // // //                               fit: BoxFit.cover,
// // // // // // // //                             ),
// // // // // // // //                           ),
// // // // // // // //                           child: const Icon(
// // // // // // // //                             Icons.medication_outlined,
// // // // // // // //                             color: Colors.blue,
// // // // // // // //                             size: 30,
// // // // // // // //                           ),
// // // // // // // //                         ),
// // // // // // // //                         const SizedBox(width: 16),
// // // // // // // //                      const   Expanded(
// // // // // // // //                           child: Column(
// // // // // // // //                             crossAxisAlignment: CrossAxisAlignment.start,
// // // // // // // //                             children: [
// // // // // // // //                                Text(
// // // // // // // //                                 'DOLO 500\nparacetamol',
// // // // // // // //                                 style: TextStyle(
// // // // // // // //                                   fontSize: 16,
// // // // // // // //                                   fontWeight: FontWeight.bold,
// // // // // // // //                                 ),
// // // // // // // //                               ),
// // // // // // // //                                SizedBox(height: 4),
// // // // // // // //                                Row(
// // // // // // // //                                 children: [
// // // // // // // //                                   Icon(
// // // // // // // //                                     Icons.location_on_outlined,
// // // // // // // //                                     color: Colors.deepPurple,
// // // // // // // //                                   ),
// // // // // // // //                                   Text("Kakinada")
// // // // // // // //                                 ],
// // // // // // // //                               )
// // // // // // // //                             ],
// // // // // // // //                           ),
// // // // // // // //                         ),
// // // // // // // //                         IconButton(
// // // // // // // //                           icon: const Icon(Icons.arrow_forward_ios, size: 16),
// // // // // // // //                           onPressed: () {
// // // // // // // //                             // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ScannedMedicineScreen()));
// // // // // // // //                           },
// // // // // // // //                         ),
// // // // // // // //                       ],
// // // // // // // //                     ),
// // // // // // // //                   ),

// // // // // // // //                 const Spacer(),
// // // // // // // //               ],
// // // // // // // //             ),
// // // // // // // //           ),
// // // // // // // //         ],
// // // // // // // //       ),
// // // // // // // //     );
// // // // // // // //   }

// // // // // // // //   // Helper method to create corners
// // // // // // // //   Widget _buildCorner(Alignment alignment) {
// // // // // // // //     return Align(
// // // // // // // //       alignment: alignment,
// // // // // // // //       child: Container(
// // // // // // // //         width: 30,
// // // // // // // //         height: 30,
// // // // // // // //         decoration: BoxDecoration(
// // // // // // // //           border: Border(
// // // // // // // //             top: (alignment == Alignment.topLeft ||
// // // // // // // //                     alignment == Alignment.topRight)
// // // // // // // //                 ? const BorderSide(color: Colors.black, width: 3)
// // // // // // // //                 : BorderSide.none,
// // // // // // // //             bottom: (alignment == Alignment.bottomLeft ||
// // // // // // // //                     alignment == Alignment.bottomRight)
// // // // // // // //                 ? const BorderSide(color: Colors.black, width: 3)
// // // // // // // //                 : BorderSide.none,
// // // // // // // //             left: (alignment == Alignment.topLeft ||
// // // // // // // //                     alignment == Alignment.bottomLeft)
// // // // // // // //                 ? const BorderSide(color: Colors.black, width: 3)
// // // // // // // //                 : BorderSide.none,
// // // // // // // //             right: (alignment == Alignment.topRight ||
// // // // // // // //                     alignment == Alignment.bottomRight)
// // // // // // // //                 ? const BorderSide(color: Colors.black, width: 3)
// // // // // // // //                 : BorderSide.none,
// // // // // // // //           ),
// // // // // // // //         ),
// // // // // // // //       ),
// // // // // // // //     );
// // // // // // // //   }
// // // // // // // // }

// // // // // // // import 'package:flutter/material.dart';
// // // // // // // import 'package:mobile_scanner/mobile_scanner.dart';
// // // // // // // import 'package:image_picker/image_picker.dart';
// // // // // // // import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// // // // // // // import 'package:http/http.dart' as http;
// // // // // // // import 'dart:convert';
// // // // // // // import 'dart:ui';
// // // // // // // import 'dart:io';

// // // // // // // class MedicineScannerScreen extends StatefulWidget {
// // // // // // //   const MedicineScannerScreen({super.key});

// // // // // // //   @override
// // // // // // //   State<MedicineScannerScreen> createState() => _MedicineScannerScreenState();
// // // // // // // }

// // // // // // // class _MedicineScannerScreenState extends State<MedicineScannerScreen>
// // // // // // //     with SingleTickerProviderStateMixin {
// // // // // // //   late MobileScannerController scannerController;
// // // // // // //   bool _isScanning = true;
// // // // // // //   String? _scannedResult;
// // // // // // //   File? _selectedImage;
// // // // // // //   final ImagePicker _imagePicker = ImagePicker();
// // // // // // //   final TextRecognizer _textRecognizer = TextRecognizer();

// // // // // // //   bool _isProcessing = false;
// // // // // // //   List<dynamic> _medicines = [];
// // // // // // //   String? _extractedText;

// // // // // // //   // Animation controller for the scanning line
// // // // // // //   late AnimationController _animationController;
// // // // // // //   late Animation<double> _animation;

// // // // // // //   @override
// // // // // // //   void initState() {
// // // // // // //     super.initState();
// // // // // // //     scannerController = MobileScannerController(
// // // // // // //       detectionSpeed: DetectionSpeed.normal,
// // // // // // //       facing: CameraFacing.back,
// // // // // // //     );

// // // // // // //     // Initialize animation controller
// // // // // // //     _animationController = AnimationController(
// // // // // // //       duration: const Duration(seconds: 2),
// // // // // // //       vsync: this,
// // // // // // //     )..repeat(reverse: true); // Makes the animation go back and forth

// // // // // // //     // Create animation that moves from top (0.0) to bottom (1.0) of container
// // // // // // //     _animation =
// // // // // // //         Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
// // // // // // //   }

// // // // // // //   @override
// // // // // // //   void dispose() {
// // // // // // //     _animationController.dispose();
// // // // // // //     scannerController.dispose();
// // // // // // //     _textRecognizer.close();
// // // // // // //     super.dispose();
// // // // // // //   }

// // // // // // //   void _onBarcodeDetected(BarcodeCapture capture) {
// // // // // // //     final List<Barcode> barcodes = capture.barcodes;
// // // // // // //     if (barcodes.isNotEmpty && _isScanning) {
// // // // // // //       setState(() {
// // // // // // //         _isScanning = false; // Stop multiple triggers
// // // // // // //         _scannedResult = barcodes.first.rawValue ?? 'Unknown';
// // // // // // //       });

// // // // // // //       // Resume scanning after short delay (optional)
// // // // // // //       Future.delayed(const Duration(seconds: 2), () {
// // // // // // //         setState(() {
// // // // // // //           _isScanning = true;
// // // // // // //         });
// // // // // // //       });
// // // // // // //     }
// // // // // // //   }

// // // // // // //   // Method to pick image from gallery
// // // // // // //   Future<void> _pickImageFromGallery() async {
// // // // // // //     try {
// // // // // // //       final XFile? pickedFile = await _imagePicker.pickImage(
// // // // // // //         source: ImageSource.gallery,
// // // // // // //         imageQuality: 80, // Compress image to 80% quality
// // // // // // //       );

// // // // // // //       if (pickedFile != null) {
// // // // // // //         setState(() {
// // // // // // //           _selectedImage = File(pickedFile.path);
// // // // // // //           _medicines = []; // Clear previous results
// // // // // // //           _extractedText = null;
// // // // // // //         });

// // // // // // //         // Show success message
// // // // // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // // // // //           const SnackBar(
// // // // // // //             content: Text('Image selected successfully!'),
// // // // // // //             backgroundColor: Colors.green,
// // // // // // //             duration: Duration(seconds: 2),
// // // // // // //           ),
// // // // // // //         );

// // // // // // //         _processSelectedImage();
// // // // // // //       }
// // // // // // //     } catch (e) {
// // // // // // //       // Handle any errors
// // // // // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // // // // //         SnackBar(
// // // // // // //           content: Text('Error picking image: $e'),
// // // // // // //           backgroundColor: Colors.red,
// // // // // // //           duration: const Duration(seconds: 2),
// // // // // // //         ),
// // // // // // //       );
// // // // // // //     }
// // // // // // //   }

// // // // // // //   // Method to take photo from camera
// // // // // // //   Future<void> _takePhotoFromCamera() async {
// // // // // // //     try {
// // // // // // //       final XFile? pickedFile = await _imagePicker.pickImage(
// // // // // // //         source: ImageSource.camera,
// // // // // // //         imageQuality: 80,
// // // // // // //       );

// // // // // // //       if (pickedFile != null) {
// // // // // // //         setState(() {
// // // // // // //           _selectedImage = File(pickedFile.path);
// // // // // // //           _medicines = []; // Clear previous results
// // // // // // //           _extractedText = null;
// // // // // // //         });

// // // // // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // // // // //           const SnackBar(
// // // // // // //             content: Text('Photo captured successfully!'),
// // // // // // //             backgroundColor: Colors.green,
// // // // // // //             duration: Duration(seconds: 2),
// // // // // // //           ),
// // // // // // //         );

// // // // // // //         _processSelectedImage();
// // // // // // //       }
// // // // // // //     } catch (e) {
// // // // // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // // // // //         SnackBar(
// // // // // // //           content: Text('Error taking photo: $e'),
// // // // // // //           backgroundColor: Colors.red,
// // // // // // //           duration: const Duration(seconds: 2),
// // // // // // //         ),
// // // // // // //       );
// // // // // // //     }
// // // // // // //   }

// // // // // // //   // Extract text from image using ML Kit
// // // // // // //   Future<void> _processSelectedImage() async {
// // // // // // //     if (_selectedImage == null) return;

// // // // // // //     setState(() {
// // // // // // //       _isProcessing = true;
// // // // // // //     });

// // // // // // //     try {
// // // // // // //       // Perform text recognition
// // // // // // //       final inputImage = InputImage.fromFile(_selectedImage!);
// // // // // // //       final recognizedText = await _textRecognizer.processImage(inputImage);

// // // // // // //       String extractedText = recognizedText.text;

// // // // // // //       setState(() {
// // // // // // //         _extractedText = extractedText;
// // // // // // //       });

// // // // // // //       if (extractedText.isNotEmpty) {
// // // // // // //         // Extract potential medicine names from the text
// // // // // // //         String medicineName = _extractMedicineName(extractedText);

// // // // // // //         if (medicineName.isNotEmpty) {
// // // // // // //           // Search for medicines using the extracted name
// // // // // // //           await _searchMedicines(medicineName);
// // // // // // //         } else {
// // // // // // //           _showError('No medicine name found in the image. Please try a clearer photo.');
// // // // // // //         }
// // // // // // //       } else {
// // // // // // //         _showError('No text found in image. Please upload a clear photo of the medicine.');
// // // // // // //       }
// // // // // // //     } catch (e) {
// // // // // // //       _showError('Error processing image: $e');
// // // // // // //     } finally {
// // // // // // //       setState(() {
// // // // // // //         _isProcessing = false;
// // // // // // //       });
// // // // // // //     }
// // // // // // //   }

// // // // // // //   // Extract medicine name from recognized text
// // // // // // //   String _extractMedicineName(String text) {
// // // // // // //     // Clean up the text
// // // // // // //     String cleanText = text.trim();

// // // // // // //     // Split into lines and words
// // // // // // //     List<String> lines = cleanText.split('\n');
// // // // // // //     List<String> words = cleanText.split(' ');

// // // // // // //     // Common medicine-related keywords to look for
// // // // // // //     List<String> medicineKeywords = [
// // // // // // //       'tablet', 'capsule', 'syrup', 'injection', 'cream', 'ointment',
// // // // // // //       'mg', 'ml', 'gm', 'strip', 'dose', 'medicine', 'drug'
// // // // // // //     ];

// // // // // // //     // Common non-medicine words to filter out
// // // // // // //     List<String> excludeWords = [
// // // // // // //       'mfg', 'exp', 'manufactured', 'expires', 'batch', 'lot',
// // // // // // //       'price', 'mrp', 'date', 'pack', 'size', 'contents'
// // // // // // //     ];

// // // // // // //     // Try to find medicine name - usually one of the first few prominent words
// // // // // // //     for (String line in lines) {
// // // // // // //       String cleanLine = line.trim();
// // // // // // //       if (cleanLine.length > 2 && cleanLine.length < 50) {
// // // // // // //         // Check if line contains medicine-related keywords or appears to be a medicine name
// // // // // // //         String lowerLine = cleanLine.toLowerCase();

// // // // // // //         // Skip lines with exclude words
// // // // // // //         bool hasExcludeWord = excludeWords.any((word) => lowerLine.contains(word));
// // // // // // //         if (hasExcludeWord) continue;

// // // // // // //         // If line has medicine keywords or is a potential medicine name
// // // // // // //         bool hasMedicineKeyword = medicineKeywords.any((word) => lowerLine.contains(word));

// // // // // // //         // If it looks like a medicine name (has letters, might have numbers)
// // // // // // //         if (RegExp(r'^[A-Za-z][A-Za-z0-9\s-]{2,}').hasMatch(cleanLine)) {
// // // // // // //           // Remove numbers and common suffixes to get base medicine name
// // // // // // //           String medicineName = cleanLine
// // // // // // //               .replaceAll(RegExp(r'\d+\s*(mg|ml|gm|mcg)'), '') // Remove dosage
// // // // // // //               .replaceAll(RegExp(r'\d+'), '') // Remove other numbers
// // // // // // //               .replaceAll(RegExp(r'\s+'), ' ') // Normalize spaces
// // // // // // //               .trim();

// // // // // // //           if (medicineName.length > 2) {
// // // // // // //             return medicineName;
// // // // // // //           }
// // // // // // //         }
// // // // // // //       }
// // // // // // //     }

// // // // // // //     // If no good candidate found, return first non-empty line that looks like text
// // // // // // //     for (String line in lines) {
// // // // // // //       String cleanLine = line.trim();
// // // // // // //       if (cleanLine.length > 2 && cleanLine.length < 30 &&
// // // // // // //           RegExp(r'^[A-Za-z][A-Za-z\s-]*$').hasMatch(cleanLine)) {
// // // // // // //         return cleanLine;
// // // // // // //       }
// // // // // // //     }

// // // // // // //     return '';
// // // // // // //   }

// // // // // // //   // Search medicines using the API
// // // // // // //   Future<void> _searchMedicines(String medicineName) async {
// // // // // // //     try {
// // // // // // //       final url = Uri.parse('https://api.simcurarx.com/api/pharmacy/allmedicine?name=$medicineName');
// // // // // // //       final response = await http.get(url);

// // // // // // //       if (response.statusCode == 200) {
// // // // // // //         final data = json.decode(response.body);

// // // // // // //         setState(() {
// // // // // // //           _medicines = data['medicines'] ?? [];
// // // // // // //         });

// // // // // // //         if (_medicines.isEmpty) {
// // // // // // //           // Try with partial search or alternative names
// // // // // // //           await _tryAlternativeSearch(medicineName);
// // // // // // //         }
// // // // // // //       } else {
// // // // // // //         _showError('Failed to fetch medicines. Please try again.');
// // // // // // //       }
// // // // // // //     } catch (e) {
// // // // // // //       _showError('Network error: Please check your internet connection.');
// // // // // // //     }
// // // // // // //   }

// // // // // // //   // Try alternative search strategies
// // // // // // //   Future<void> _tryAlternativeSearch(String originalName) async {
// // // // // // //     // Try searching with just the first word
// // // // // // //     List<String> words = originalName.split(' ');
// // // // // // //     if (words.isNotEmpty) {
// // // // // // //       String firstWord = words.first;
// // // // // // //       if (firstWord.length > 3) {
// // // // // // //         await _searchMedicines(firstWord);
// // // // // // //       }
// // // // // // //     }

// // // // // // //     // If still no results, show message
// // // // // // //     if (_medicines.isEmpty) {
// // // // // // //       _showError('No medicines found for "$originalName". Try taking a clearer photo or search manually.');
// // // // // // //     }
// // // // // // //   }

// // // // // // //   void _showError(String message) {
// // // // // // //     ScaffoldMessenger.of(context).showSnackBar(
// // // // // // //       SnackBar(
// // // // // // //         content: Text(message),
// // // // // // //         backgroundColor: Colors.orange,
// // // // // // //         duration: const Duration(seconds: 4),
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }

// // // // // // //   // Show options to take photo or pick from gallery
// // // // // // //   void _showImagePickerOptions() {
// // // // // // //     showModalBottomSheet(
// // // // // // //       context: context,
// // // // // // //       builder: (context) => SafeArea(
// // // // // // //         child: Column(
// // // // // // //           mainAxisSize: MainAxisSize.min,
// // // // // // //           children: [
// // // // // // //             const Padding(
// // // // // // //               padding: EdgeInsets.all(16),
// // // // // // //               child: Text(
// // // // // // //                 'Select Medicine Image',
// // // // // // //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
// // // // // // //               ),
// // // // // // //             ),
// // // // // // //             ListTile(
// // // // // // //               leading: const Icon(Icons.camera_alt),
// // // // // // //               title: const Text('Take Photo'),
// // // // // // //               subtitle: const Text('Capture medicine package/bottle'),
// // // // // // //               onTap: () {
// // // // // // //                 Navigator.pop(context);
// // // // // // //                 _takePhotoFromCamera();
// // // // // // //               },
// // // // // // //             ),
// // // // // // //             ListTile(
// // // // // // //               leading: const Icon(Icons.photo_library),
// // // // // // //               title: const Text('Choose from Gallery'),
// // // // // // //               subtitle: const Text('Select existing photo'),
// // // // // // //               onTap: () {
// // // // // // //                 Navigator.pop(context);
// // // // // // //                 _pickImageFromGallery();
// // // // // // //               },
// // // // // // //             ),
// // // // // // //             const SizedBox(height: 16),
// // // // // // //           ],
// // // // // // //         ),
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }

// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     return Scaffold(
// // // // // // //       body: Stack(
// // // // // // //         children: [
// // // // // // //           Positioned.fill(
// // // // // // //             child: Image.asset(
// // // // // // //               'assets/background_image.png',
// // // // // // //               fit: BoxFit.cover,
// // // // // // //             ),
// // // // // // //           ),

// // // // // // //           // Blur effect on top of image
// // // // // // //           Positioned.fill(
// // // // // // //             child: BackdropFilter(
// // // // // // //               filter:
// // // // // // //                   ImageFilter.blur(sigmaX: 83.6, sigmaY: 83.6), // heavy blur
// // // // // // //               child: Container(
// // // // // // //                 color: Colors.black
// // // // // // //                     .withOpacity(0), // Required for BackdropFilter to work
// // // // // // //               ),
// // // // // // //             ),
// // // // // // //           ),
// // // // // // //           SafeArea(
// // // // // // //             child: Column(
// // // // // // //               children: [
// // // // // // //                 // Top toolbar
// // // // // // //                 const SizedBox(height: 30),
// // // // // // //                 Padding(
// // // // // // //                   padding: const EdgeInsets.symmetric(
// // // // // // //                       horizontal: 18.0, vertical: 12.0),
// // // // // // //                   child: Container(
// // // // // // //                     height: 44,
// // // // // // //                     width: 343,
// // // // // // //                     decoration: BoxDecoration(
// // // // // // //                       color: Colors.white,
// // // // // // //                       borderRadius: BorderRadius.circular(10),
// // // // // // //                     ),
// // // // // // //                     child: Row(
// // // // // // //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // // // //                       children: [
// // // // // // //                         IconButton(
// // // // // // //                           icon: const Icon(Icons.flash_on, color: Colors.blue),
// // // // // // //                           onPressed: () {
// // // // // // //                             scannerController.toggleTorch();
// // // // // // //                           },
// // // // // // //                         ),
// // // // // // //                         IconButton(
// // // // // // //                           icon: const Icon(Icons.photo_library, color: Colors.purple),
// // // // // // //                           onPressed: _showImagePickerOptions,
// // // // // // //                         ),
// // // // // // //                         const IconButton(
// // // // // // //                           icon: Icon(Icons.sync, color: Colors.black54),
// // // // // // //                           onPressed: null, // You can add sync functionality here
// // // // // // //                         ),
// // // // // // //                       ],
// // // // // // //                     ),
// // // // // // //                   ),
// // // // // // //                 ),

// // // // // // //                 const SizedBox(height: 10.0),

// // // // // // //                 const Text(
// // // // // // //                   'Scan the Medicine',
// // // // // // //                   style: TextStyle(
// // // // // // //                     fontSize: 22.0,
// // // // // // //                     fontWeight: FontWeight.bold,
// // // // // // //                     color: Colors.black87,
// // // // // // //                   ),
// // // // // // //                 ),

// // // // // // //                 const SizedBox(height: 20.0),

// // // // // // //                 // Scanner View Area
// // // // // // //                 Padding(
// // // // // // //                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
// // // // // // //                   child: Container(
// // // // // // //                     height: 320,
// // // // // // //                     width: double.infinity,
// // // // // // //                     decoration: BoxDecoration(
// // // // // // //                       color: Colors.white,
// // // // // // //                       borderRadius: BorderRadius.circular(20.0),
// // // // // // //                     ),
// // // // // // //                     child: Stack(
// // // // // // //                       alignment: Alignment.center,
// // // // // // //                       children: [
// // // // // // //                         ClipRRect(
// // // // // // //                           borderRadius: BorderRadius.circular(20.0),
// // // // // // //                           child: _selectedImage != null
// // // // // // //                               ? Image.file(
// // // // // // //                                   _selectedImage!,
// // // // // // //                                   fit: BoxFit.cover,
// // // // // // //                                   width: double.infinity,
// // // // // // //                                   height: double.infinity,
// // // // // // //                                 )
// // // // // // //                               : MobileScanner(
// // // // // // //                                   controller: scannerController,
// // // // // // //                                   onDetect: _onBarcodeDetected,
// // // // // // //                                 ),
// // // // // // //                         ),

// // // // // // //                         // Show scanning line only when camera is active
// // // // // // //                         if (_selectedImage == null)
// // // // // // //                           AnimatedBuilder(
// // // // // // //                             animation: _animation,
// // // // // // //                             builder: (context, child) {
// // // // // // //                               return Positioned(
// // // // // // //                                 top: _animation.value * 270,
// // // // // // //                                 child: Container(
// // // // // // //                                   width: 280,
// // // // // // //                                   height: 5,
// // // // // // //                                   decoration: BoxDecoration(
// // // // // // //                                     gradient: LinearGradient(
// // // // // // //                                       colors: [
// // // // // // //                                         Colors.greenAccent.withOpacity(0.7),
// // // // // // //                                         Colors.green.withOpacity(0.7)
// // // // // // //                                       ],
// // // // // // //                                     ),
// // // // // // //                                     boxShadow: [
// // // // // // //                                       BoxShadow(
// // // // // // //                                         color:
// // // // // // //                                             Colors.greenAccent.withOpacity(0.5),
// // // // // // //                                         blurRadius: 12,
// // // // // // //                                         spreadRadius: 2,
// // // // // // //                                       ),
// // // // // // //                                     ],
// // // // // // //                                   ),
// // // // // // //                                 ),
// // // // // // //                               );
// // // // // // //                             },
// // // // // // //                           ),

// // // // // // //                         // Scanner corners
// // // // // // //                         _buildCorner(Alignment.topLeft),
// // // // // // //                         _buildCorner(Alignment.topRight),
// // // // // // //                         _buildCorner(Alignment.bottomLeft),
// // // // // // //                         _buildCorner(Alignment.bottomRight),

// // // // // // //                         // Show processing indicator
// // // // // // //                         if (_isProcessing)
// // // // // // //                           Container(
// // // // // // //                             color: Colors.black.withOpacity(0.7),
// // // // // // //                             child: const Center(
// // // // // // //                               child: Column(
// // // // // // //                                 mainAxisSize: MainAxisSize.min,
// // // // // // //                                 children: [
// // // // // // //                                   CircularProgressIndicator(color: Colors.white),
// // // // // // //                                   SizedBox(height: 16),
// // // // // // //                                   Text(
// // // // // // //                                     'Processing image...',
// // // // // // //                                     style: TextStyle(
// // // // // // //                                       color: Colors.white,
// // // // // // //                                       fontSize: 16,
// // // // // // //                                       fontWeight: FontWeight.w500,
// // // // // // //                                     ),
// // // // // // //                                   ),
// // // // // // //                                 ],
// // // // // // //                               ),
// // // // // // //                             ),
// // // // // // //                           ),

// // // // // // //                         // Show overlay for selected image
// // // // // // //                         if (_selectedImage != null && !_isProcessing)
// // // // // // //                           Positioned(
// // // // // // //                             bottom: 16,
// // // // // // //                             right: 16,
// // // // // // //                             child: Container(
// // // // // // //                               padding: const EdgeInsets.all(8),
// // // // // // //                               decoration: BoxDecoration(
// // // // // // //                                 color: Colors.black.withOpacity(0.7),
// // // // // // //                                 borderRadius: BorderRadius.circular(8),
// // // // // // //                               ),
// // // // // // //                               child: const Text(
// // // // // // //                                 'Image Selected',
// // // // // // //                                 style: TextStyle(
// // // // // // //                                   color: Colors.white,
// // // // // // //                                   fontSize: 12,
// // // // // // //                                   fontWeight: FontWeight.w500,
// // // // // // //                                 ),
// // // // // // //                               ),
// // // // // // //                             ),
// // // // // // //                           ),
// // // // // // //                       ],
// // // // // // //                     ),
// // // // // // //                   ),
// // // // // // //                 ),

// // // // // // //                 const SizedBox(height: 20.0),

// // // // // // //                 Row(
// // // // // // //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // // // // // //                   children: [
// // // // // // //                     SizedBox(
// // // // // // //                       height: 36,
// // // // // // //                       width: 160,
// // // // // // //                       child: ElevatedButton(
// // // // // // //                         onPressed: () {
// // // // // // //                           Navigator.pop(context);
// // // // // // //                         },
// // // // // // //                         style: ElevatedButton.styleFrom(
// // // // // // //                           backgroundColor: Colors.white,
// // // // // // //                           foregroundColor: Colors.black87,
// // // // // // //                           shape: RoundedRectangleBorder(
// // // // // // //                             borderRadius: BorderRadius.circular(5),
// // // // // // //                           ),
// // // // // // //                         ),
// // // // // // //                         child: const Text(
// // // // // // //                           'Cancel Scanning',
// // // // // // //                           style:
// // // // // // //                               TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
// // // // // // //                         ),
// // // // // // //                       ),
// // // // // // //                     ),

// // // // // // //                     // Add button to switch back to camera if image is selected
// // // // // // //                     if (_selectedImage != null)
// // // // // // //                       SizedBox(
// // // // // // //                         height: 36,
// // // // // // //                         width: 120,
// // // // // // //                         child: ElevatedButton(
// // // // // // //                           onPressed: () {
// // // // // // //                             setState(() {
// // // // // // //                               _selectedImage = null;
// // // // // // //                               _medicines = [];
// // // // // // //                               _extractedText = null;
// // // // // // //                             });
// // // // // // //                           },
// // // // // // //                           style: ElevatedButton.styleFrom(
// // // // // // //                             backgroundColor: Colors.blue,
// // // // // // //                             foregroundColor: Colors.white,
// // // // // // //                             shape: RoundedRectangleBorder(
// // // // // // //                               borderRadius: BorderRadius.circular(5),
// // // // // // //                             ),
// // // // // // //                           ),
// // // // // // //                           child: const Text(
// // // // // // //                             'Use Camera',
// // // // // // //                             style: TextStyle(
// // // // // // //                                 fontSize: 14, fontWeight: FontWeight.w500),
// // // // // // //                           ),
// // // // // // //                         ),
// // // // // // //                       ),
// // // // // // //                   ],
// // // // // // //                 ),

// // // // // // //                 const SizedBox(height: 20),

// // // // // // //                 // Display extracted text for debugging (optional)
// // // // // // //                 if (_extractedText != null && _extractedText!.isNotEmpty)
// // // // // // //                   Container(
// // // // // // //                     margin: const EdgeInsets.symmetric(horizontal: 24.0),
// // // // // // //                     padding: const EdgeInsets.all(12.0),
// // // // // // //                     decoration: BoxDecoration(
// // // // // // //                       color: Colors.blue.withOpacity(0.1),
// // // // // // //                       borderRadius: BorderRadius.circular(8.0),
// // // // // // //                       border: Border.all(color: Colors.blue.withOpacity(0.3)),
// // // // // // //                     ),
// // // // // // //                     child: Text(
// // // // // // //                       'Extracted: ${_extractedText!.split('\n').take(3).join(' ')}',
// // // // // // //                       style: const TextStyle(fontSize: 12),
// // // // // // //                       maxLines: 2,
// // // // // // //                       overflow: TextOverflow.ellipsis,
// // // // // // //                     ),
// // // // // // //                   ),

// // // // // // //                 // Display medicine results
// // // // // // //                 Expanded(
// // // // // // //                   child: _medicines.isNotEmpty
// // // // // // //                       ? ListView.builder(
// // // // // // //                           padding: const EdgeInsets.symmetric(horizontal: 24.0),
// // // // // // //                           itemCount: _medicines.length,
// // // // // // //                           itemBuilder: (context, index) {
// // // // // // //                             final medicine = _medicines[index];
// // // // // // //                             return Container(
// // // // // // //                               margin: const EdgeInsets.only(bottom: 12.0),
// // // // // // //                               padding: const EdgeInsets.all(16.0),
// // // // // // //                               decoration: BoxDecoration(
// // // // // // //                                 color: Colors.white,
// // // // // // //                                 borderRadius: BorderRadius.circular(15.0),
// // // // // // //                                 boxShadow: [
// // // // // // //                                   BoxShadow(
// // // // // // //                                     color: Colors.black.withOpacity(0.1),
// // // // // // //                                     blurRadius: 8,
// // // // // // //                                     spreadRadius: 1,
// // // // // // //                                   ),
// // // // // // //                                 ],
// // // // // // //                               ),
// // // // // // //                               child: Row(
// // // // // // //                                 children: [
// // // // // // //                                   Container(
// // // // // // //                                     width: 80,
// // // // // // //                                     height: 80,
// // // // // // //                                     decoration: BoxDecoration(
// // // // // // //                                       borderRadius: BorderRadius.circular(10),
// // // // // // //                                       color: Colors.grey.shade100,
// // // // // // //                                     ),
// // // // // // //                                     child: medicine['images'] != null &&
// // // // // // //                                            medicine['images'].isNotEmpty
// // // // // // //                                         ? ClipRRect(
// // // // // // //                                             borderRadius: BorderRadius.circular(10),
// // // // // // //                                             child: Image.network(
// // // // // // //                                               medicine['images'][0],
// // // // // // //                                               fit: BoxFit.cover,
// // // // // // //                                               errorBuilder: (context, error, stackTrace) =>
// // // // // // //                                                   const Icon(
// // // // // // //                                                     Icons.medication_outlined,
// // // // // // //                                                     color: Colors.blue,
// // // // // // //                                                     size: 30,
// // // // // // //                                                   ),
// // // // // // //                                             ),
// // // // // // //                                           )
// // // // // // //                                         : const Icon(
// // // // // // //                                             Icons.medication_outlined,
// // // // // // //                                             color: Colors.blue,
// // // // // // //                                             size: 30,
// // // // // // //                                           ),
// // // // // // //                                   ),
// // // // // // //                                   const SizedBox(width: 16),
// // // // // // //                                   Expanded(
// // // // // // //                                     child: Column(
// // // // // // //                                       crossAxisAlignment: CrossAxisAlignment.start,
// // // // // // //                                       children: [
// // // // // // //                                         Text(
// // // // // // //                                           medicine['name'] ?? 'Unknown Medicine',
// // // // // // //                                           style: const TextStyle(
// // // // // // //                                             fontSize: 16,
// // // // // // //                                             fontWeight: FontWeight.bold,
// // // // // // //                                           ),
// // // // // // //                                         ),
// // // // // // //                                         const SizedBox(height: 4),
// // // // // // //                                         Text(
// // // // // // //                                           'Rs. ${medicine['price'] ?? 'N/A'} (MRP: Rs. ${medicine['mrp'] ?? 'N/A'})',
// // // // // // //                                           style: TextStyle(
// // // // // // //                                             fontSize: 14,
// // // // // // //                                             color: Colors.green.shade700,
// // // // // // //                                             fontWeight: FontWeight.w600,
// // // // // // //                                           ),
// // // // // // //                                         ),
// // // // // // //                                         const SizedBox(height: 4),
// // // // // // //                                         Row(
// // // // // // //                                           children: [
// // // // // // //                                             const Icon(
// // // // // // //                                               Icons.location_on_outlined,
// // // // // // //                                               color: Colors.deepPurple,
// // // // // // //                                               size: 16,
// // // // // // //                                             ),
// // // // // // //                                             Text(
// // // // // // //                                               medicine['pharmacy']?['name'] ?? 'Unknown Pharmacy',
// // // // // // //                                               style: const TextStyle(fontSize: 12),
// // // // // // //                                             ),
// // // // // // //                                           ],
// // // // // // //                                         ),
// // // // // // //                                       ],
// // // // // // //                                     ),
// // // // // // //                                   ),
// // // // // // //                                   IconButton(
// // // // // // //                                     icon: const Icon(Icons.arrow_forward_ios, size: 16),
// // // // // // //                                     onPressed: () {
// // // // // // //                                       // Navigate to medicine details
// // // // // // //                                       // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ScannedMedicineScreen()));
// // // // // // //                                     },
// // // // // // //                                   ),
// // // // // // //                                 ],
// // // // // // //                               ),
// // // // // // //                             );
// // // // // // //                           },
// // // // // // //                         )
// // // // // // //                       : _selectedImage != null && !_isProcessing
// // // // // // //                           ? const Center(
// // // // // // //                               child: Text(
// // // // // // //                                 'No medicines found.\nTry a clearer image.',
// // // // // // //                                 textAlign: TextAlign.center,
// // // // // // //                                 style: TextStyle(
// // // // // // //                                   color: Colors.grey,
// // // // // // //                                   fontSize: 16,
// // // // // // //                                 ),
// // // // // // //                               ),
// // // // // // //                             )
// // // // // // //                           : const SizedBox(),
// // // // // // //                 ),

// // // // // // //                 // Display scan result if available (QR code result)
// // // // // // //                 if (_scannedResult != null)
// // // // // // //                   Container(
// // // // // // //                     margin: const EdgeInsets.symmetric(
// // // // // // //                         horizontal: 24.0, vertical: 10.0),
// // // // // // //                     padding: const EdgeInsets.all(16.0),
// // // // // // //                     decoration: BoxDecoration(
// // // // // // //                       color: Colors.white,
// // // // // // //                       borderRadius: BorderRadius.circular(15.0),
// // // // // // //                       boxShadow: [
// // // // // // //                         BoxShadow(
// // // // // // //                           color: Colors.black.withOpacity(0.1),
// // // // // // //                           blurRadius: 8,
// // // // // // //                           spreadRadius: 1,
// // // // // // //                         ),
// // // // // // //                       ],
// // // // // // //                     ),
// // // // // // //                     child: Row(
// // // // // // //                       children: [
// // // // // // //                         Container(
// // // // // // //                           width: 80,
// // // // // // //                           height: 80,
// // // // // // //                           padding: const EdgeInsets.all(10),
// // // // // // //                           decoration: BoxDecoration(
// // // // // // //                             borderRadius: BorderRadius.circular(10),
// // // // // // //                             color: Colors.grey.shade100,
// // // // // // //                           ),
// // // // // // //                           child: const Icon(
// // // // // // //                             Icons.qr_code,
// // // // // // //                             color: Colors.blue,
// // // // // // //                             size: 30,
// // // // // // //                           ),
// // // // // // //                         ),
// // // // // // //                         const SizedBox(width: 16),
// // // // // // //                         Expanded(
// // // // // // //                           child: Column(
// // // // // // //                             crossAxisAlignment: CrossAxisAlignment.start,
// // // // // // //                             children: [
// // // // // // //                               const Text(
// // // // // // //                                 'QR Code Scanned',
// // // // // // //                                 style: TextStyle(
// // // // // // //                                   fontSize: 16,
// // // // // // //                                   fontWeight: FontWeight.bold,
// // // // // // //                                 ),
// // // // // // //                               ),
// // // // // // //                               const SizedBox(height: 4),
// // // // // // //                               Text(
// // // // // // //                                 _scannedResult!,
// // // // // // //                                 style: const TextStyle(fontSize: 12),
// // // // // // //                                 maxLines: 2,
// // // // // // //                                 overflow: TextOverflow.ellipsis,
// // // // // // //                               ),
// // // // // // //                             ],
// // // // // // //                           ),
// // // // // // //                         ),
// // // // // // //                         IconButton(
// // // // // // //                           icon: const Icon(Icons.arrow_forward_ios, size: 16),
// // // // // // //                           onPressed: () {
// // // // // // //                             // Handle QR code result
// // // // // // //                           },
// // // // // // //                         ),
// // // // // // //                       ],
// // // // // // //                     ),
// // // // // // //                   ),

// // // // // // //                 const SizedBox(height: 20),
// // // // // // //               ],
// // // // // // //             ),
// // // // // // //           ),
// // // // // // //         ],
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }

// // // // // // //   // Helper method to create corners
// // // // // // //   Widget _buildCorner(Alignment alignment) {
// // // // // // //     return Align(
// // // // // // //       alignment: alignment,
// // // // // // //       child: Container(
// // // // // // //         width: 30,
// // // // // // //         height: 30,
// // // // // // //         decoration: BoxDecoration(
// // // // // // //           border: Border(
// // // // // // //             top: (alignment == Alignment.topLeft ||
// // // // // // //                     alignment == Alignment.topRight)
// // // // // // //                 ? const BorderSide(color: Colors.black, width: 3)
// // // // // // //                 : BorderSide.none,
// // // // // // //             bottom: (alignment == Alignment.bottomLeft ||
// // // // // // //                     alignment == Alignment.bottomRight)
// // // // // // //                 ? const BorderSide(color: Colors.black, width: 3)
// // // // // // //                 : BorderSide.none,
// // // // // // //             left: (alignment == Alignment.topLeft ||
// // // // // // //                     alignment == Alignment.bottomLeft)
// // // // // // //                 ? const BorderSide(color: Colors.black, width: 3)
// // // // // // //                 : BorderSide.none,
// // // // // // //             right: (alignment == Alignment.topRight ||
// // // // // // //                     alignment == Alignment.bottomRight)
// // // // // // //                 ? const BorderSide(color: Colors.black, width: 3)
// // // // // // //                 : BorderSide.none,
// // // // // // //           ),
// // // // // // //         ),
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }
// // // // // // // }

// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:image_picker/image_picker.dart';
// // // // // // import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// // // // // // import 'package:http/http.dart' as http;
// // // // // // import 'dart:convert';
// // // // // // import 'dart:ui';
// // // // // // import 'dart:io';

// // // // // // class MedicineScannerScreen extends StatefulWidget {
// // // // // //   const MedicineScannerScreen({super.key});

// // // // // //   @override
// // // // // //   State<MedicineScannerScreen> createState() => _MedicineScannerScreenState();
// // // // // // }

// // // // // // class _MedicineScannerScreenState extends State<MedicineScannerScreen>
// // // // // //     with SingleTickerProviderStateMixin {
// // // // // //   File? _selectedImage;
// // // // // //   final ImagePicker _imagePicker = ImagePicker();
// // // // // //   final TextRecognizer _textRecognizer = TextRecognizer();

// // // // // //   bool _isProcessing = false;
// // // // // //   List<dynamic> _medicines = [];
// // // // // //   String? _extractedText;

// // // // // //   // Animation controller for the scanning line
// // // // // //   late AnimationController _animationController;
// // // // // //   late Animation<double> _animation;

// // // // // //   @override
// // // // // //   void initState() {
// // // // // //     super.initState();

// // // // // //     // Initialize animation controller
// // // // // //     _animationController = AnimationController(
// // // // // //       duration: const Duration(seconds: 2),
// // // // // //       vsync: this,
// // // // // //     )..repeat(reverse: true); // Makes the animation go back and forth

// // // // // //     // Create animation that moves from top (0.0) to bottom (1.0) of container
// // // // // //     _animation =
// // // // // //         Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
// // // // // //   }

// // // // // //   @override
// // // // // //   void dispose() {
// // // // // //     _animationController.dispose();
// // // // // //     _textRecognizer.close();
// // // // // //     super.dispose();
// // // // // //   }

// // // // // //   // Method to pick image from gallery
// // // // // //   Future<void> _pickImageFromGallery() async {
// // // // // //     try {
// // // // // //       final XFile? pickedFile = await _imagePicker.pickImage(
// // // // // //         source: ImageSource.gallery,
// // // // // //         imageQuality: 85,
// // // // // //         maxWidth: 1920,
// // // // // //         maxHeight: 1080,
// // // // // //       );

// // // // // //       if (pickedFile != null) {
// // // // // //         setState(() {
// // // // // //           _selectedImage = File(pickedFile.path);
// // // // // //           _medicines = []; // Clear previous results
// // // // // //           _extractedText = null;
// // // // // //         });

// // // // // //         // Show success message
// // // // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // // // //           const SnackBar(
// // // // // //             content: Text('Image selected successfully!'),
// // // // // //             backgroundColor: Colors.green,
// // // // // //             duration: Duration(seconds: 2),
// // // // // //           ),
// // // // // //         );

// // // // // //         _processSelectedImage();
// // // // // //       }
// // // // // //     } catch (e) {
// // // // // //       // Handle any errors
// // // // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // // // //         SnackBar(
// // // // // //           content: Text('Error picking image: $e'),
// // // // // //           backgroundColor: Colors.red,
// // // // // //           duration: const Duration(seconds: 2),
// // // // // //         ),
// // // // // //       );
// // // // // //     }
// // // // // //   }

// // // // // //   // Method to take photo from camera
// // // // // //   Future<void> _takePhotoFromCamera() async {
// // // // // //     try {
// // // // // //       final XFile? pickedFile = await _imagePicker.pickImage(
// // // // // //         source: ImageSource.camera,
// // // // // //         imageQuality: 85,
// // // // // //         maxWidth: 1920,
// // // // // //         maxHeight: 1080,
// // // // // //         preferredCameraDevice: CameraDevice.rear,
// // // // // //       );

// // // // // //       if (pickedFile != null) {
// // // // // //         setState(() {
// // // // // //           _selectedImage = File(pickedFile.path);
// // // // // //           _medicines = []; // Clear previous results
// // // // // //           _extractedText = null;
// // // // // //         });

// // // // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // // // //           const SnackBar(
// // // // // //             content: Text('Photo captured successfully!'),
// // // // // //             backgroundColor: Colors.green,
// // // // // //             duration: Duration(seconds: 2),
// // // // // //           ),
// // // // // //         );

// // // // // //         _processSelectedImage();
// // // // // //       }
// // // // // //     } catch (e) {
// // // // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // // // //         SnackBar(
// // // // // //           content: Text('Error taking photo: $e'),
// // // // // //           backgroundColor: Colors.red,
// // // // // //           duration: const Duration(seconds: 2),
// // // // // //         ),
// // // // // //       );
// // // // // //     }
// // // // // //   }

// // // // // //   // Extract text from image using ML Kit
// // // // // //   Future<void> _processSelectedImage() async {
// // // // // //     if (_selectedImage == null) return;

// // // // // //     setState(() {
// // // // // //       _isProcessing = true;
// // // // // //     });

// // // // // //     try {
// // // // // //       // Perform text recognition
// // // // // //       final inputImage = InputImage.fromFile(_selectedImage!);
// // // // // //       final recognizedText = await _textRecognizer.processImage(inputImage);

// // // // // //       String extractedText = recognizedText.text;

// // // // // //       setState(() {
// // // // // //         _extractedText = extractedText;
// // // // // //       });

// // // // // //       if (extractedText.isNotEmpty) {
// // // // // //         // Extract potential medicine names from the text
// // // // // //         String medicineName = _extractMedicineName(extractedText);

// // // // // //         if (medicineName.isNotEmpty) {
// // // // // //           // Search for medicines using the extracted name
// // // // // //           await _searchMedicines(medicineName);
// // // // // //         } else {
// // // // // //           _showError('No medicine name found in the image. Please try a clearer photo.');
// // // // // //         }
// // // // // //       } else {
// // // // // //         _showError('No text found in image. Please upload a clear photo of the medicine.');
// // // // // //       }
// // // // // //     } catch (e) {
// // // // // //       _showError('Error processing image: $e');
// // // // // //     } finally {
// // // // // //       setState(() {
// // // // // //         _isProcessing = false;
// // // // // //       });
// // // // // //     }
// // // // // //   }

// // // // // //   // Extract medicine name from recognized text
// // // // // //   String _extractMedicineName(String text) {
// // // // // //     // Clean up the text
// // // // // //     String cleanText = text.trim();

// // // // // //     // Split into lines and words
// // // // // //     List<String> lines = cleanText.split('\n');

// // // // // //     // Common medicine-related keywords to look for
// // // // // //     List<String> medicineKeywords = [
// // // // // //       'tablet', 'capsule', 'syrup', 'injection', 'cream', 'ointment',
// // // // // //       'mg', 'ml', 'gm', 'strip', 'dose', 'medicine', 'drug'
// // // // // //     ];

// // // // // //     // Common non-medicine words to filter out
// // // // // //     List<String> excludeWords = [
// // // // // //       'mfg', 'exp', 'manufactured', 'expires', 'batch', 'lot',
// // // // // //       'price', 'mrp', 'date', 'pack', 'size', 'contents'
// // // // // //     ];

// // // // // //     // Try to find medicine name - usually one of the first few prominent words
// // // // // //     for (String line in lines) {
// // // // // //       String cleanLine = line.trim();
// // // // // //       if (cleanLine.length > 2 && cleanLine.length < 50) {
// // // // // //         // Check if line contains medicine-related keywords or appears to be a medicine name
// // // // // //         String lowerLine = cleanLine.toLowerCase();

// // // // // //         // Skip lines with exclude words
// // // // // //         bool hasExcludeWord = excludeWords.any((word) => lowerLine.contains(word));
// // // // // //         if (hasExcludeWord) continue;

// // // // // //         // If it looks like a medicine name (has letters, might have numbers)
// // // // // //         if (RegExp(r'^[A-Za-z][A-Za-z0-9\s-]{2,}').hasMatch(cleanLine)) {
// // // // // //           // Remove numbers and common suffixes to get base medicine name
// // // // // //           String medicineName = cleanLine
// // // // // //               .replaceAll(RegExp(r'\d+\s*(mg|ml|gm|mcg)'), '') // Remove dosage
// // // // // //               .replaceAll(RegExp(r'\d+'), '') // Remove other numbers
// // // // // //               .replaceAll(RegExp(r'\s+'), ' ') // Normalize spaces
// // // // // //               .trim();

// // // // // //           if (medicineName.length > 2) {
// // // // // //             return medicineName;
// // // // // //           }
// // // // // //         }
// // // // // //       }
// // // // // //     }

// // // // // //     // If no good candidate found, return first non-empty line that looks like text
// // // // // //     for (String line in lines) {
// // // // // //       String cleanLine = line.trim();
// // // // // //       if (cleanLine.length > 2 && cleanLine.length < 30 &&
// // // // // //           RegExp(r'^[A-Za-z][A-Za-z\s-]*$').hasMatch(cleanLine)) {
// // // // // //         return cleanLine;
// // // // // //       }
// // // // // //     }

// // // // // //     return '';
// // // // // //   }

// // // // // //   // Search medicines using the API
// // // // // //   Future<void> _searchMedicines(String medicineName) async {
// // // // // //     try {
// // // // // //       final url = Uri.parse('https://api.simcurarx.com/api/pharmacy/allmedicine?name=$medicineName');
// // // // // //       final response = await http.get(url);

// // // // // //       if (response.statusCode == 200) {
// // // // // //         final data = json.decode(response.body);

// // // // // //         setState(() {
// // // // // //           _medicines = data['medicines'] ?? [];
// // // // // //         });

// // // // // //         if (_medicines.isEmpty) {
// // // // // //           // Try with partial search or alternative names
// // // // // //           await _tryAlternativeSearch(medicineName);
// // // // // //         }
// // // // // //       } else {
// // // // // //         _showError('Failed to fetch medicines. Please try again.');
// // // // // //       }
// // // // // //     } catch (e) {
// // // // // //       _showError('Network error: Please check your internet connection.');
// // // // // //     }
// // // // // //   }

// // // // // //   // Try alternative search strategies
// // // // // //   Future<void> _tryAlternativeSearch(String originalName) async {
// // // // // //     // Try searching with just the first word
// // // // // //     List<String> words = originalName.split(' ');
// // // // // //     if (words.isNotEmpty) {
// // // // // //       String firstWord = words.first;
// // // // // //       if (firstWord.length > 3) {
// // // // // //         await _searchMedicines(firstWord);
// // // // // //       }
// // // // // //     }

// // // // // //     // If still no results, show message
// // // // // //     if (_medicines.isEmpty) {
// // // // // //       _showError('No medicines found for "$originalName". Try taking a clearer photo or search manually.');
// // // // // //     }
// // // // // //   }

// // // // // //   void _showError(String message) {
// // // // // //     ScaffoldMessenger.of(context).showSnackBar(
// // // // // //       SnackBar(
// // // // // //         content: Text(message),
// // // // // //         backgroundColor: Colors.orange,
// // // // // //         duration: const Duration(seconds: 4),
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   // Show options to take photo or pick from gallery
// // // // // //   void _showImagePickerOptions() {
// // // // // //     showModalBottomSheet(
// // // // // //       context: context,
// // // // // //       builder: (context) => SafeArea(
// // // // // //         child: Column(
// // // // // //           mainAxisSize: MainAxisSize.min,
// // // // // //           children: [
// // // // // //             const Padding(
// // // // // //               padding: EdgeInsets.all(16),
// // // // // //               child: Text(
// // // // // //                 'Select Medicine Image',
// // // // // //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
// // // // // //               ),
// // // // // //             ),
// // // // // //             ListTile(
// // // // // //               leading: const Icon(Icons.camera_alt),
// // // // // //               title: const Text('Take Photo'),
// // // // // //               subtitle: const Text('Capture medicine package/bottle'),
// // // // // //               onTap: () {
// // // // // //                 Navigator.pop(context);
// // // // // //                 _takePhotoFromCamera();
// // // // // //               },
// // // // // //             ),
// // // // // //             ListTile(
// // // // // //               leading: const Icon(Icons.photo_library),
// // // // // //               title: const Text('Choose from Gallery'),
// // // // // //               subtitle: const Text('Select existing photo'),
// // // // // //               onTap: () {
// // // // // //                 Navigator.pop(context);
// // // // // //                 _pickImageFromGallery();
// // // // // //               },
// // // // // //             ),
// // // // // //             const SizedBox(height: 16),
// // // // // //           ],
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Scaffold(
// // // // // //       body: Stack(
// // // // // //         children: [
// // // // // //           Positioned.fill(
// // // // // //             child: Image.asset(
// // // // // //               'assets/background_image.png',
// // // // // //               fit: BoxFit.cover,
// // // // // //             ),
// // // // // //           ),

// // // // // //           // Blur effect on top of image
// // // // // //           Positioned.fill(
// // // // // //             child: BackdropFilter(
// // // // // //               filter:
// // // // // //                   ImageFilter.blur(sigmaX: 83.6, sigmaY: 83.6), // heavy blur
// // // // // //               child: Container(
// // // // // //                 color: Colors.black
// // // // // //                     .withOpacity(0), // Required for BackdropFilter to work
// // // // // //               ),
// // // // // //             ),
// // // // // //           ),
// // // // // //           SafeArea(
// // // // // //             child: Column(
// // // // // //               children: [
// // // // // //                 // Top toolbar
// // // // // //                 const SizedBox(height: 30),
// // // // // //                 Padding(
// // // // // //                   padding: const EdgeInsets.symmetric(
// // // // // //                       horizontal: 18.0, vertical: 12.0),
// // // // // //                   child: Container(
// // // // // //                     height: 44,
// // // // // //                     width: 343,
// // // // // //                     decoration: BoxDecoration(
// // // // // //                       color: Colors.white,
// // // // // //                       borderRadius: BorderRadius.circular(10),
// // // // // //                     ),
// // // // // //                     child: Row(
// // // // // //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // // //                       children: [
// // // // // //                         IconButton(
// // // // // //                           icon: const Icon(Icons.camera_alt, color: Colors.blue),
// // // // // //                           onPressed: _takePhotoFromCamera,
// // // // // //                         ),
// // // // // //                         IconButton(
// // // // // //                           icon: const Icon(Icons.photo_library, color: Colors.purple),
// // // // // //                           onPressed: _pickImageFromGallery,
// // // // // //                         ),
// // // // // //                         IconButton(
// // // // // //                           icon: const Icon(Icons.add_a_photo, color: Colors.green),
// // // // // //                           onPressed: _showImagePickerOptions,
// // // // // //                         ),
// // // // // //                       ],
// // // // // //                     ),
// // // // // //                   ),
// // // // // //                 ),

// // // // // //                 const SizedBox(height: 10.0),

// // // // // //                 const Text(
// // // // // //                   'Scan the Medicine',
// // // // // //                   style: TextStyle(
// // // // // //                     fontSize: 22.0,
// // // // // //                     fontWeight: FontWeight.bold,
// // // // // //                     color: Colors.black87,
// // // // // //                   ),
// // // // // //                 ),

// // // // // //                 const SizedBox(height: 20.0),

// // // // // //                 // Image View Area
// // // // // //                 Padding(
// // // // // //                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
// // // // // //                   child: GestureDetector(
// // // // // //                     onTap: _selectedImage == null ? _showImagePickerOptions : null,
// // // // // //                     child: Container(
// // // // // //                       height: 320,
// // // // // //                       width: double.infinity,
// // // // // //                       decoration: BoxDecoration(
// // // // // //                         color: Colors.white,
// // // // // //                         borderRadius: BorderRadius.circular(20.0),
// // // // // //                         border: Border.all(
// // // // // //                           color: _selectedImage != null
// // // // // //                               ? Colors.green.shade300
// // // // // //                               : Colors.grey.shade300,
// // // // // //                           width: 2,
// // // // // //                         ),
// // // // // //                       ),
// // // // // //                       child: Stack(
// // // // // //                         alignment: Alignment.center,
// // // // // //                         children: [
// // // // // //                           if (_selectedImage != null)
// // // // // //                             ClipRRect(
// // // // // //                               borderRadius: BorderRadius.circular(18.0),
// // // // // //                               child: Image.file(
// // // // // //                                 _selectedImage!,
// // // // // //                                 fit: BoxFit.cover,
// // // // // //                                 width: double.infinity,
// // // // // //                                 height: double.infinity,
// // // // // //                               ),
// // // // // //                             )
// // // // // //                           else
// // // // // //                             Column(
// // // // // //                               mainAxisAlignment: MainAxisAlignment.center,
// // // // // //                               children: [
// // // // // //                                 // Animated scanning line effect even without camera
// // // // // //                                 AnimatedBuilder(
// // // // // //                                   animation: _animation,
// // // // // //                                   builder: (context, child) {
// // // // // //                                     return Container(
// // // // // //                                       width: 280,
// // // // // //                                       height: 5,
// // // // // //                                       margin: EdgeInsets.only(top: _animation.value * 50),
// // // // // //                                       decoration: BoxDecoration(
// // // // // //                                         gradient: LinearGradient(
// // // // // //                                           colors: [
// // // // // //                                             Colors.greenAccent.withOpacity(0.7),
// // // // // //                                             Colors.green.withOpacity(0.7)
// // // // // //                                           ],
// // // // // //                                         ),
// // // // // //                                         boxShadow: [
// // // // // //                                           BoxShadow(
// // // // // //                                             color: Colors.greenAccent.withOpacity(0.5),
// // // // // //                                             blurRadius: 12,
// // // // // //                                             spreadRadius: 2,
// // // // // //                                           ),
// // // // // //                                         ],
// // // // // //                                       ),
// // // // // //                                     );
// // // // // //                                   },
// // // // // //                                 ),
// // // // // //                                 const SizedBox(height: 40),
// // // // // //                                 Icon(
// // // // // //                                   Icons.camera_alt,
// // // // // //                                   size: 60,
// // // // // //                                   color: Colors.grey.shade400,
// // // // // //                                 ),
// // // // // //                                 const SizedBox(height: 16),
// // // // // //                                 Text(
// // // // // //                                   'Tap to take a photo of medicine',
// // // // // //                                   style: TextStyle(
// // // // // //                                     color: Colors.grey.shade600,
// // // // // //                                     fontSize: 16,
// // // // // //                                   ),
// // // // // //                                 ),
// // // // // //                                 const SizedBox(height: 8),
// // // // // //                                 Text(
// // // // // //                                   'Point camera at medicine package or bottle',
// // // // // //                                   style: TextStyle(
// // // // // //                                     color: Colors.grey.shade500,
// // // // // //                                     fontSize: 12,
// // // // // //                                   ),
// // // // // //                                 ),
// // // // // //                               ],
// // // // // //                             ),

// // // // // //                           // Scanner corners (decorative)
// // // // // //                           _buildCorner(Alignment.topLeft),
// // // // // //                           _buildCorner(Alignment.topRight),
// // // // // //                           _buildCorner(Alignment.bottomLeft),
// // // // // //                           _buildCorner(Alignment.bottomRight),

// // // // // //                           // Show processing indicator
// // // // // //                           if (_isProcessing)
// // // // // //                             Container(
// // // // // //                               color: Colors.black.withOpacity(0.7),
// // // // // //                               child: const Center(
// // // // // //                                 child: Column(
// // // // // //                                   mainAxisSize: MainAxisSize.min,
// // // // // //                                   children: [
// // // // // //                                     CircularProgressIndicator(color: Colors.white),
// // // // // //                                     SizedBox(height: 16),
// // // // // //                                     Text(
// // // // // //                                       'Processing image...',
// // // // // //                                       style: TextStyle(
// // // // // //                                         color: Colors.white,
// // // // // //                                         fontSize: 16,
// // // // // //                                         fontWeight: FontWeight.w500,
// // // // // //                                       ),
// // // // // //                                     ),
// // // // // //                                   ],
// // // // // //                                 ),
// // // // // //                               ),
// // // // // //                             ),

// // // // // //                           // Show overlay for selected image
// // // // // //                           if (_selectedImage != null && !_isProcessing)
// // // // // //                             Positioned(
// // // // // //                               bottom: 16,
// // // // // //                               right: 16,
// // // // // //                               child: Container(
// // // // // //                                 padding: const EdgeInsets.all(8),
// // // // // //                                 decoration: BoxDecoration(
// // // // // //                                   color: Colors.black.withOpacity(0.7),
// // // // // //                                   borderRadius: BorderRadius.circular(8),
// // // // // //                                 ),
// // // // // //                                 child: const Text(
// // // // // //                                   'Image Selected',
// // // // // //                                   style: TextStyle(
// // // // // //                                     color: Colors.white,
// // // // // //                                     fontSize: 12,
// // // // // //                                     fontWeight: FontWeight.w500,
// // // // // //                                   ),
// // // // // //                                 ),
// // // // // //                               ),
// // // // // //                             ),
// // // // // //                         ],
// // // // // //                       ),
// // // // // //                     ),
// // // // // //                   ),
// // // // // //                 ),

// // // // // //                 const SizedBox(height: 20.0),

// // // // // //                 // Action buttons
// // // // // //                 Row(
// // // // // //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // // // // //                   children: [
// // // // // //                     SizedBox(
// // // // // //                       height: 36,
// // // // // //                       width: 160,
// // // // // //                       child: ElevatedButton(
// // // // // //                         onPressed: () {
// // // // // //                           Navigator.pop(context);
// // // // // //                         },
// // // // // //                         style: ElevatedButton.styleFrom(
// // // // // //                           backgroundColor: Colors.white,
// // // // // //                           foregroundColor: Colors.black87,
// // // // // //                           shape: RoundedRectangleBorder(
// // // // // //                             borderRadius: BorderRadius.circular(5),
// // // // // //                           ),
// // // // // //                         ),
// // // // // //                         child: const Text(
// // // // // //                           'Cancel',
// // // // // //                           style:
// // // // // //                               TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
// // // // // //                         ),
// // // // // //                       ),
// // // // // //                     ),

// // // // // //                     // Add button to retake photo if image is selected
// // // // // //                     if (_selectedImage != null)
// // // // // //                       SizedBox(
// // // // // //                         height: 36,
// // // // // //                         width: 120,
// // // // // //                         child: ElevatedButton(
// // // // // //                           onPressed: () {
// // // // // //                             setState(() {
// // // // // //                               _selectedImage = null;
// // // // // //                               _medicines = [];
// // // // // //                               _extractedText = null;
// // // // // //                             });
// // // // // //                           },
// // // // // //                           style: ElevatedButton.styleFrom(
// // // // // //                             backgroundColor: Colors.blue,
// // // // // //                             foregroundColor: Colors.white,
// // // // // //                             shape: RoundedRectangleBorder(
// // // // // //                               borderRadius: BorderRadius.circular(5),
// // // // // //                             ),
// // // // // //                           ),
// // // // // //                           child: const Text(
// // // // // //                             'Retake Photo',
// // // // // //                             style: TextStyle(
// // // // // //                                 fontSize: 14, fontWeight: FontWeight.w500),
// // // // // //                           ),
// // // // // //                         ),
// // // // // //                       ),
// // // // // //                   ],
// // // // // //                 ),

// // // // // //                 const SizedBox(height: 20),

// // // // // //                 // Display extracted text for debugging (optional)
// // // // // //                 if (_extractedText != null && _extractedText!.isNotEmpty)
// // // // // //                   Container(
// // // // // //                     margin: const EdgeInsets.symmetric(horizontal: 24.0),
// // // // // //                     padding: const EdgeInsets.all(12.0),
// // // // // //                     decoration: BoxDecoration(
// // // // // //                       color: Colors.blue.withOpacity(0.1),
// // // // // //                       borderRadius: BorderRadius.circular(8.0),
// // // // // //                       border: Border.all(color: Colors.blue.withOpacity(0.3)),
// // // // // //                     ),
// // // // // //                     child: Text(
// // // // // //                       'Extracted: ${_extractedText!.split('\n').take(3).join(' ')}',
// // // // // //                       style: const TextStyle(fontSize: 12),
// // // // // //                       maxLines: 2,
// // // // // //                       overflow: TextOverflow.ellipsis,
// // // // // //                     ),
// // // // // //                   ),

// // // // // //                 // Display medicine results
// // // // // //                 Expanded(
// // // // // //                   child: _medicines.isNotEmpty
// // // // // //                       ? ListView.builder(
// // // // // //                           padding: const EdgeInsets.symmetric(horizontal: 24.0),
// // // // // //                           itemCount: _medicines.length,
// // // // // //                           itemBuilder: (context, index) {
// // // // // //                             final medicine = _medicines[index];
// // // // // //                             return Container(
// // // // // //                               margin: const EdgeInsets.only(bottom: 12.0),
// // // // // //                               padding: const EdgeInsets.all(16.0),
// // // // // //                               decoration: BoxDecoration(
// // // // // //                                 color: Colors.white,
// // // // // //                                 borderRadius: BorderRadius.circular(15.0),
// // // // // //                                 boxShadow: [
// // // // // //                                   BoxShadow(
// // // // // //                                     color: Colors.black.withOpacity(0.1),
// // // // // //                                     blurRadius: 8,
// // // // // //                                     spreadRadius: 1,
// // // // // //                                   ),
// // // // // //                                 ],
// // // // // //                               ),
// // // // // //                               child: Row(
// // // // // //                                 children: [
// // // // // //                                   Container(
// // // // // //                                     width: 80,
// // // // // //                                     height: 80,
// // // // // //                                     decoration: BoxDecoration(
// // // // // //                                       borderRadius: BorderRadius.circular(10),
// // // // // //                                       color: Colors.grey.shade100,
// // // // // //                                     ),
// // // // // //                                     child: medicine['images'] != null &&
// // // // // //                                            medicine['images'].isNotEmpty
// // // // // //                                         ? ClipRRect(
// // // // // //                                             borderRadius: BorderRadius.circular(10),
// // // // // //                                             child: Image.network(
// // // // // //                                               medicine['images'][0],
// // // // // //                                               fit: BoxFit.cover,
// // // // // //                                               errorBuilder: (context, error, stackTrace) =>
// // // // // //                                                   const Icon(
// // // // // //                                                     Icons.medication_outlined,
// // // // // //                                                     color: Colors.blue,
// // // // // //                                                     size: 30,
// // // // // //                                                   ),
// // // // // //                                             ),
// // // // // //                                           )
// // // // // //                                         : const Icon(
// // // // // //                                             Icons.medication_outlined,
// // // // // //                                             color: Colors.blue,
// // // // // //                                             size: 30,
// // // // // //                                           ),
// // // // // //                                   ),
// // // // // //                                   const SizedBox(width: 16),
// // // // // //                                   Expanded(
// // // // // //                                     child: Column(
// // // // // //                                       crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //                                       children: [
// // // // // //                                         Text(
// // // // // //                                           medicine['name'] ?? 'Unknown Medicine',
// // // // // //                                           style: const TextStyle(
// // // // // //                                             fontSize: 16,
// // // // // //                                             fontWeight: FontWeight.bold,
// // // // // //                                           ),
// // // // // //                                         ),
// // // // // //                                         const SizedBox(height: 4),
// // // // // //                                         Text(
// // // // // //                                           'Rs. ${medicine['price'] ?? 'N/A'} (MRP: Rs. ${medicine['mrp'] ?? 'N/A'})',
// // // // // //                                           style: TextStyle(
// // // // // //                                             fontSize: 14,
// // // // // //                                             color: Colors.green.shade700,
// // // // // //                                             fontWeight: FontWeight.w600,
// // // // // //                                           ),
// // // // // //                                         ),
// // // // // //                                         const SizedBox(height: 4),
// // // // // //                                         Row(
// // // // // //                                           children: [
// // // // // //                                             const Icon(
// // // // // //                                               Icons.location_on_outlined,
// // // // // //                                               color: Colors.deepPurple,
// // // // // //                                               size: 16,
// // // // // //                                             ),
// // // // // //                                             Expanded(
// // // // // //                                               child: Text(
// // // // // //                                                 medicine['pharmacy']?['name'] ?? 'Unknown Pharmacy',
// // // // // //                                                 style: const TextStyle(fontSize: 12),
// // // // // //                                                 overflow: TextOverflow.ellipsis,
// // // // // //                                               ),
// // // // // //                                             ),
// // // // // //                                           ],
// // // // // //                                         ),
// // // // // //                                       ],
// // // // // //                                     ),
// // // // // //                                   ),
// // // // // //                                   IconButton(
// // // // // //                                     icon: const Icon(Icons.arrow_forward_ios, size: 16),
// // // // // //                                     onPressed: () {
// // // // // //                                       // Navigate to medicine details
// // // // // //                                       // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ScannedMedicineScreen()));
// // // // // //                                     },
// // // // // //                                   ),
// // // // // //                                 ],
// // // // // //                               ),
// // // // // //                             );
// // // // // //                           },
// // // // // //                         )
// // // // // //                       : _selectedImage != null && !_isProcessing
// // // // // //                           ? const Center(
// // // // // //                               child: Text(
// // // // // //                                 'No medicines found.\nTry a clearer image.',
// // // // // //                                 textAlign: TextAlign.center,
// // // // // //                                 style: TextStyle(
// // // // // //                                   color: Colors.grey,
// // // // // //                                   fontSize: 16,
// // // // // //                                 ),
// // // // // //                               ),
// // // // // //                             )
// // // // // //                           : const SizedBox(),
// // // // // //                 ),

// // // // // //                 const SizedBox(height: 20),
// // // // // //               ],
// // // // // //             ),
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   // Helper method to create corners
// // // // // //   Widget _buildCorner(Alignment alignment) {
// // // // // //     return Align(
// // // // // //       alignment: alignment,
// // // // // //       child: Container(
// // // // // //         width: 30,
// // // // // //         height: 30,
// // // // // //         decoration: BoxDecoration(
// // // // // //           border: Border(
// // // // // //             top: (alignment == Alignment.topLeft ||
// // // // // //                     alignment == Alignment.topRight)
// // // // // //                 ? const BorderSide(color: Colors.black, width: 3)
// // // // // //                 : BorderSide.none,
// // // // // //             bottom: (alignment == Alignment.bottomLeft ||
// // // // // //                     alignment == Alignment.bottomRight)
// // // // // //                 ? const BorderSide(color: Colors.black, width: 3)
// // // // // //                 : BorderSide.none,
// // // // // //             left: (alignment == Alignment.topLeft ||
// // // // // //                     alignment == Alignment.bottomLeft)
// // // // // //                 ? const BorderSide(color: Colors.black, width: 3)
// // // // // //                 : BorderSide.none,
// // // // // //             right: (alignment == Alignment.topRight ||
// // // // // //                     alignment == Alignment.bottomRight)
// // // // // //                 ? const BorderSide(color: Colors.black, width: 3)
// // // // // //                 : BorderSide.none,
// // // // // //           ),
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // // }

// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:image_picker/image_picker.dart';
// // // // // // import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// // // // // // import 'package:http/http.dart' as http;
// // // // // // import 'dart:convert';
// // // // // // import 'dart:ui';
// // // // // // import 'dart:io';

// // // // // // class MedicineScannerScreen extends StatefulWidget {
// // // // // //   const MedicineScannerScreen({super.key});

// // // // // //   @override
// // // // // //   State<MedicineScannerScreen> createState() => _MedicineScannerScreenState();
// // // // // // }

// // // // // // class _MedicineScannerScreenState extends State<MedicineScannerScreen>
// // // // // //     with SingleTickerProviderStateMixin {
// // // // // //   File? _selectedImage;
// // // // // //   final ImagePicker _imagePicker = ImagePicker();
// // // // // //   TextRecognizer? _textRecognizer;

// // // // // //   bool _isProcessing = false;
// // // // // //   List<dynamic> _medicines = [];
// // // // // //   String? _extractedText;

// // // // // //   // Animation controller for the scanning line
// // // // // //   late AnimationController _animationController;
// // // // // //   late Animation<double> _animation;

// // // // // //   @override
// // // // // //   void initState() {
// // // // // //     super.initState();

// // // // // //     // Initialize text recognizer
// // // // // //     _textRecognizer = TextRecognizer();

// // // // // //     // Initialize animation controller
// // // // // //     _animationController = AnimationController(
// // // // // //       duration: const Duration(seconds: 2),
// // // // // //       vsync: this,
// // // // // //     )..repeat(reverse: true); // Makes the animation go back and forth

// // // // // //     // Create animation that moves from top (0.0) to bottom (1.0) of container
// // // // // //     _animation =
// // // // // //         Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
// // // // // //   }

// // // // // //   @override
// // // // // //   void dispose() {
// // // // // //     _animationController.dispose();
// // // // // //     _textRecognizer?.close();
// // // // // //     super.dispose();
// // // // // //   }

// // // // // //   // Method to pick image from gallery
// // // // // //   Future<void> _pickImageFromGallery() async {
// // // // // //     try {
// // // // // //       final XFile? pickedFile = await _imagePicker.pickImage(
// // // // // //         source: ImageSource.gallery,
// // // // // //         imageQuality: 85,
// // // // // //         maxWidth: 1920,
// // // // // //         maxHeight: 1080,
// // // // // //       );

// // // // // //       if (pickedFile != null) {
// // // // // //         setState(() {
// // // // // //           _selectedImage = File(pickedFile.path);
// // // // // //           _medicines = []; // Clear previous results
// // // // // //           _extractedText = null;
// // // // // //         });

// // // // // //         // Show success message
// // // // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // // // //           const SnackBar(
// // // // // //             content: Text('Image selected successfully!'),
// // // // // //             backgroundColor: Colors.green,
// // // // // //             duration: Duration(seconds: 2),
// // // // // //           ),
// // // // // //         );

// // // // // //         _processSelectedImage();
// // // // // //       }
// // // // // //     } catch (e) {
// // // // // //       // Handle any errors
// // // // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // // // //         SnackBar(
// // // // // //           content: Text('Error picking image: $e'),
// // // // // //           backgroundColor: Colors.red,
// // // // // //           duration: const Duration(seconds: 2),
// // // // // //         ),
// // // // // //       );
// // // // // //     }
// // // // // //   }

// // // // // //   // Method to take photo from camera
// // // // // //   Future<void> _takePhotoFromCamera() async {
// // // // // //     try {
// // // // // //       final XFile? pickedFile = await _imagePicker.pickImage(
// // // // // //         source: ImageSource.camera,
// // // // // //         imageQuality: 85,
// // // // // //         maxWidth: 1920,
// // // // // //         maxHeight: 1080,
// // // // // //         preferredCameraDevice: CameraDevice.rear,
// // // // // //       );

// // // // // //       if (pickedFile != null) {
// // // // // //         setState(() {
// // // // // //           _selectedImage = File(pickedFile.path);
// // // // // //           _medicines = []; // Clear previous results
// // // // // //           _extractedText = null;
// // // // // //         });

// // // // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // // // //           const SnackBar(
// // // // // //             content: Text('Photo captured successfully!'),
// // // // // //             backgroundColor: Colors.green,
// // // // // //             duration: Duration(seconds: 2),
// // // // // //           ),
// // // // // //         );

// // // // // //         _processSelectedImage();
// // // // // //       }
// // // // // //     } catch (e) {
// // // // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // // // //         SnackBar(
// // // // // //           content: Text('Error taking photo: $e'),
// // // // // //           backgroundColor: Colors.red,
// // // // // //           duration: const Duration(seconds: 2),
// // // // // //         ),
// // // // // //       );
// // // // // //     }
// // // // // //   }

// // // // // //   // Extract text from image using ML Kit
// // // // // //   Future<void> _processSelectedImage() async {
// // // // // //     if (_selectedImage == null || _textRecognizer == null) return;

// // // // // //     setState(() {
// // // // // //       _isProcessing = true;
// // // // // //     });

// // // // // //     try {
// // // // // //       // Perform text recognition
// // // // // //       final inputImage = InputImage.fromFile(_selectedImage!);
// // // // // //       final recognizedText = await _textRecognizer!.processImage(inputImage);

// // // // // //       String extractedText = recognizedText.text;

// // // // // //       setState(() {
// // // // // //         _extractedText = extractedText;
// // // // // //       });

// // // // // //       if (extractedText.isNotEmpty) {
// // // // // //         // Extract potential medicine names from the text
// // // // // //         String medicineName = _extractMedicineName(extractedText);

// // // // // //         if (medicineName.isNotEmpty) {
// // // // // //           // Search for medicines using the extracted name
// // // // // //           await _searchMedicines(medicineName);
// // // // // //         } else {
// // // // // //           _showError('No medicine name found in the image. Please try a clearer photo.');
// // // // // //         }
// // // // // //       } else {
// // // // // //         _showError('No text found in image. Please upload a clear photo of the medicine.');
// // // // // //       }
// // // // // //     } catch (e) {
// // // // // //       _showError('Error processing image: $e');
// // // // // //     } finally {
// // // // // //       setState(() {
// // // // // //         _isProcessing = false;
// // // // // //       });
// // // // // //     }
// // // // // //   }

// // // // // //   // Extract medicine name from recognized text
// // // // // //   String _extractMedicineName(String text) {
// // // // // //     // Clean up the text
// // // // // //     String cleanText = text.trim();

// // // // // //     // Split into lines and words
// // // // // //     List<String> lines = cleanText.split('\n');

// // // // // //     // Common medicine-related keywords to look for
// // // // // //     // List<String> medicineKeywords = [
// // // // // //     //   'tablet', 'capsule', 'syrup', 'injection', 'cream', 'ointment',
// // // // // //     //   'mg', 'ml', 'gm', 'strip', 'dose', 'medicine', 'drug'
// // // // // //     // ];

// // // // // //     // Common non-medicine words to filter out
// // // // // //     List<String> excludeWords = [
// // // // // //       'mfg', 'exp', 'manufactured', 'expires', 'batch', 'lot',
// // // // // //       'price', 'mrp', 'date', 'pack', 'size', 'contents'
// // // // // //     ];

// // // // // //     // Try to find medicine name - usually one of the first few prominent words
// // // // // //     for (String line in lines) {
// // // // // //       String cleanLine = line.trim();
// // // // // //       if (cleanLine.length > 2 && cleanLine.length < 50) {
// // // // // //         // Check if line contains medicine-related keywords or appears to be a medicine name
// // // // // //         String lowerLine = cleanLine.toLowerCase();

// // // // // //         // Skip lines with exclude words
// // // // // //         bool hasExcludeWord = excludeWords.any((word) => lowerLine.contains(word));
// // // // // //         if (hasExcludeWord) continue;

// // // // // //         // If it looks like a medicine name (has letters, might have numbers)
// // // // // //         if (RegExp(r'^[A-Za-z][A-Za-z0-9\s-]{2,}').hasMatch(cleanLine)) {
// // // // // //           // Remove numbers and common suffixes to get base medicine name
// // // // // //           String medicineName = cleanLine
// // // // // //               .replaceAll(RegExp(r'\d+\s*(mg|ml|gm|mcg)'), '') // Remove dosage
// // // // // //               .replaceAll(RegExp(r'\d+'), '') // Remove other numbers
// // // // // //               .replaceAll(RegExp(r'\s+'), ' ') // Normalize spaces
// // // // // //               .trim();

// // // // // //           if (medicineName.length > 2) {
// // // // // //             return medicineName;
// // // // // //           }
// // // // // //         }
// // // // // //       }
// // // // // //     }

// // // // // //     // If no good candidate found, return first non-empty line that looks like text
// // // // // //     for (String line in lines) {
// // // // // //       String cleanLine = line.trim();
// // // // // //       if (cleanLine.length > 2 && cleanLine.length < 30 &&
// // // // // //           RegExp(r'^[A-Za-z][A-Za-z\s-]*$').hasMatch(cleanLine)) {
// // // // // //         return cleanLine;
// // // // // //       }
// // // // // //     }

// // // // // //     return '';
// // // // // //   }

// // // // // //   // Search medicines using the API
// // // // // //   Future<void> _searchMedicines(String medicineName) async {
// // // // // //     try {
// // // // // //       final url = Uri.parse('https://api.simcurarx.com/api/pharmacy/allmedicine?name=$medicineName');
// // // // // //       final response = await http.get(url);

// // // // // //       if (response.statusCode == 200) {
// // // // // //         final data = json.decode(response.body);

// // // // // //         setState(() {
// // // // // //           _medicines = data['medicines'] ?? [];
// // // // // //         });

// // // // // //         if (_medicines.isEmpty) {
// // // // // //           // Try with partial search or alternative names
// // // // // //           await _tryAlternativeSearch(medicineName);
// // // // // //         }
// // // // // //       } else {
// // // // // //         _showError('Failed to fetch medicines. Please try again.');
// // // // // //       }
// // // // // //     } catch (e) {
// // // // // //       _showError('Network error: Please check your internet connection.');
// // // // // //     }
// // // // // //   }

// // // // // //   // Try alternative search strategies
// // // // // //   Future<void> _tryAlternativeSearch(String originalName) async {
// // // // // //     // Try searching with just the first word
// // // // // //     List<String> words = originalName.split(' ');
// // // // // //     if (words.isNotEmpty) {
// // // // // //       String firstWord = words.first;
// // // // // //       if (firstWord.length > 3) {
// // // // // //         await _searchMedicines(firstWord);
// // // // // //       }
// // // // // //     }

// // // // // //     // If still no results, show message
// // // // // //     if (_medicines.isEmpty) {
// // // // // //       _showError('No medicines found for "$originalName". Try taking a clearer photo or search manually.');
// // // // // //     }
// // // // // //   }

// // // // // //   void _showError(String message) {
// // // // // //     ScaffoldMessenger.of(context).showSnackBar(
// // // // // //       SnackBar(
// // // // // //         content: Text(message),
// // // // // //         backgroundColor: Colors.orange,
// // // // // //         duration: const Duration(seconds: 4),
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   // Show options to take photo or pick from gallery
// // // // // //   void _showImagePickerOptions() {
// // // // // //     showModalBottomSheet(
// // // // // //       context: context,
// // // // // //       builder: (context) => SafeArea(
// // // // // //         child: Column(
// // // // // //           mainAxisSize: MainAxisSize.min,
// // // // // //           children: [
// // // // // //             const Padding(
// // // // // //               padding: EdgeInsets.all(16),
// // // // // //               child: Text(
// // // // // //                 'Select Medicine Image',
// // // // // //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
// // // // // //               ),
// // // // // //             ),
// // // // // //             ListTile(
// // // // // //               leading: const Icon(Icons.camera_alt),
// // // // // //               title: const Text('Take Photo'),
// // // // // //               subtitle: const Text('Capture medicine package/bottle'),
// // // // // //               onTap: () {
// // // // // //                 Navigator.pop(context);
// // // // // //                 _takePhotoFromCamera();
// // // // // //               },
// // // // // //             ),
// // // // // //             ListTile(
// // // // // //               leading: const Icon(Icons.photo_library),
// // // // // //               title: const Text('Choose from Gallery'),
// // // // // //               subtitle: const Text('Select existing photo'),
// // // // // //               onTap: () {
// // // // // //                 Navigator.pop(context);
// // // // // //                 _pickImageFromGallery();
// // // // // //               },
// // // // // //             ),
// // // // // //             const SizedBox(height: 16),
// // // // // //           ],
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Scaffold(
// // // // // //       body: Stack(
// // // // // //         children: [
// // // // // //           Positioned.fill(
// // // // // //             child: Image.asset(
// // // // // //               'assets/background_image.png',
// // // // // //               fit: BoxFit.cover,
// // // // // //             ),
// // // // // //           ),

// // // // // //           // Blur effect on top of image
// // // // // //           Positioned.fill(
// // // // // //             child: BackdropFilter(
// // // // // //               filter:
// // // // // //                   ImageFilter.blur(sigmaX: 83.6, sigmaY: 83.6), // heavy blur
// // // // // //               child: Container(
// // // // // //                 color: Colors.black
// // // // // //                     .withOpacity(0), // Required for BackdropFilter to work
// // // // // //               ),
// // // // // //             ),
// // // // // //           ),
// // // // // //           SafeArea(
// // // // // //             child: Column(
// // // // // //               children: [
// // // // // //                 // Top toolbar
// // // // // //                 const SizedBox(height: 30),
// // // // // //                 Padding(
// // // // // //                   padding: const EdgeInsets.symmetric(
// // // // // //                       horizontal: 18.0, vertical: 12.0),
// // // // // //                   child: Container(
// // // // // //                     height: 44,
// // // // // //                     width: 343,
// // // // // //                     decoration: BoxDecoration(
// // // // // //                       color: Colors.white,
// // // // // //                       borderRadius: BorderRadius.circular(10),
// // // // // //                     ),
// // // // // //                     child: Row(
// // // // // //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // // //                       children: [
// // // // // //                         IconButton(
// // // // // //                           icon: const Icon(Icons.camera_alt, color: Colors.blue),
// // // // // //                           onPressed: _takePhotoFromCamera,
// // // // // //                         ),
// // // // // //                         IconButton(
// // // // // //                           icon: const Icon(Icons.photo_library, color: Colors.purple),
// // // // // //                           onPressed: _pickImageFromGallery,
// // // // // //                         ),
// // // // // //                         IconButton(
// // // // // //                           icon: const Icon(Icons.add_a_photo, color: Colors.green),
// // // // // //                           onPressed: _showImagePickerOptions,
// // // // // //                         ),
// // // // // //                       ],
// // // // // //                     ),
// // // // // //                   ),
// // // // // //                 ),

// // // // // //                 const SizedBox(height: 10.0),

// // // // // //                 const Text(
// // // // // //                   'Scan the Medicine',
// // // // // //                   style: TextStyle(
// // // // // //                     fontSize: 22.0,
// // // // // //                     fontWeight: FontWeight.bold,
// // // // // //                     color: Colors.black87,
// // // // // //                   ),
// // // // // //                 ),

// // // // // //                 const SizedBox(height: 20.0),

// // // // // //                 // Image View Area
// // // // // //                 Padding(
// // // // // //                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
// // // // // //                   child: GestureDetector(
// // // // // //                     onTap: _selectedImage == null ? _showImagePickerOptions : null,
// // // // // //                     child: Container(
// // // // // //                       height: 320,
// // // // // //                       width: double.infinity,
// // // // // //                       decoration: BoxDecoration(
// // // // // //                         color: Colors.white,
// // // // // //                         borderRadius: BorderRadius.circular(20.0),
// // // // // //                         border: Border.all(
// // // // // //                           color: _selectedImage != null
// // // // // //                               ? Colors.green.shade300
// // // // // //                               : Colors.grey.shade300,
// // // // // //                           width: 2,
// // // // // //                         ),
// // // // // //                       ),
// // // // // //                       child: Stack(
// // // // // //                         alignment: Alignment.center,
// // // // // //                         children: [
// // // // // //                           if (_selectedImage != null)
// // // // // //                             ClipRRect(
// // // // // //                               borderRadius: BorderRadius.circular(18.0),
// // // // // //                               child: Image.file(
// // // // // //                                 _selectedImage!,
// // // // // //                                 fit: BoxFit.cover,
// // // // // //                                 width: double.infinity,
// // // // // //                                 height: double.infinity,
// // // // // //                               ),
// // // // // //                             )
// // // // // //                           else
// // // // // //                             Column(
// // // // // //                               mainAxisAlignment: MainAxisAlignment.center,
// // // // // //                               children: [
// // // // // //                                 // Animated scanning line effect even without camera
// // // // // //                                 AnimatedBuilder(
// // // // // //                                   animation: _animation,
// // // // // //                                   builder: (context, child) {
// // // // // //                                     return Container(
// // // // // //                                       width: 280,
// // // // // //                                       height: 5,
// // // // // //                                       margin: EdgeInsets.only(top: _animation.value * 50),
// // // // // //                                       decoration: BoxDecoration(
// // // // // //                                         gradient: LinearGradient(
// // // // // //                                           colors: [
// // // // // //                                             Colors.greenAccent.withOpacity(0.7),
// // // // // //                                             Colors.green.withOpacity(0.7)
// // // // // //                                           ],
// // // // // //                                         ),
// // // // // //                                         boxShadow: [
// // // // // //                                           BoxShadow(
// // // // // //                                             color: Colors.greenAccent.withOpacity(0.5),
// // // // // //                                             blurRadius: 12,
// // // // // //                                             spreadRadius: 2,
// // // // // //                                           ),
// // // // // //                                         ],
// // // // // //                                       ),
// // // // // //                                     );
// // // // // //                                   },
// // // // // //                                 ),
// // // // // //                                 const SizedBox(height: 40),
// // // // // //                                 Icon(
// // // // // //                                   Icons.camera_alt,
// // // // // //                                   size: 60,
// // // // // //                                   color: Colors.grey.shade400,
// // // // // //                                 ),
// // // // // //                                 const SizedBox(height: 16),
// // // // // //                                 Text(
// // // // // //                                   'Tap to take a photo of medicine',
// // // // // //                                   style: TextStyle(
// // // // // //                                     color: Colors.grey.shade600,
// // // // // //                                     fontSize: 16,
// // // // // //                                   ),
// // // // // //                                 ),
// // // // // //                                 const SizedBox(height: 8),
// // // // // //                                 Text(
// // // // // //                                   'Point camera at medicine package or bottle',
// // // // // //                                   style: TextStyle(
// // // // // //                                     color: Colors.grey.shade500,
// // // // // //                                     fontSize: 12,
// // // // // //                                   ),
// // // // // //                                 ),
// // // // // //                               ],
// // // // // //                             ),

// // // // // //                           // Scanner corners (decorative)
// // // // // //                           _buildCorner(Alignment.topLeft),
// // // // // //                           _buildCorner(Alignment.topRight),
// // // // // //                           _buildCorner(Alignment.bottomLeft),
// // // // // //                           _buildCorner(Alignment.bottomRight),

// // // // // //                           // Show processing indicator
// // // // // //                           if (_isProcessing)
// // // // // //                             Container(
// // // // // //                               color: Colors.black.withOpacity(0.7),
// // // // // //                               child: const Center(
// // // // // //                                 child: Column(
// // // // // //                                   mainAxisSize: MainAxisSize.min,
// // // // // //                                   children: [
// // // // // //                                     CircularProgressIndicator(color: Colors.white),
// // // // // //                                     SizedBox(height: 16),
// // // // // //                                     Text(
// // // // // //                                       'Processing image...',
// // // // // //                                       style: TextStyle(
// // // // // //                                         color: Colors.white,
// // // // // //                                         fontSize: 16,
// // // // // //                                         fontWeight: FontWeight.w500,
// // // // // //                                       ),
// // // // // //                                     ),
// // // // // //                                   ],
// // // // // //                                 ),
// // // // // //                               ),
// // // // // //                             ),

// // // // // //                           // Show overlay for selected image
// // // // // //                           if (_selectedImage != null && !_isProcessing)
// // // // // //                             Positioned(
// // // // // //                               bottom: 16,
// // // // // //                               right: 16,
// // // // // //                               child: Container(
// // // // // //                                 padding: const EdgeInsets.all(8),
// // // // // //                                 decoration: BoxDecoration(
// // // // // //                                   color: Colors.black.withOpacity(0.7),
// // // // // //                                   borderRadius: BorderRadius.circular(8),
// // // // // //                                 ),
// // // // // //                                 child: const Text(
// // // // // //                                   'Image Selected',
// // // // // //                                   style: TextStyle(
// // // // // //                                     color: Colors.white,
// // // // // //                                     fontSize: 12,
// // // // // //                                     fontWeight: FontWeight.w500,
// // // // // //                                   ),
// // // // // //                                 ),
// // // // // //                               ),
// // // // // //                             ),
// // // // // //                         ],
// // // // // //                       ),
// // // // // //                     ),
// // // // // //                   ),
// // // // // //                 ),

// // // // // //                 const SizedBox(height: 20.0),

// // // // // //                 // Action buttons
// // // // // //                 Row(
// // // // // //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // // // // //                   children: [
// // // // // //                     SizedBox(
// // // // // //                       height: 36,
// // // // // //                       width: 160,
// // // // // //                       child: ElevatedButton(
// // // // // //                         onPressed: () {
// // // // // //                           Navigator.pop(context);
// // // // // //                         },
// // // // // //                         style: ElevatedButton.styleFrom(
// // // // // //                           backgroundColor: Colors.white,
// // // // // //                           foregroundColor: Colors.black87,
// // // // // //                           shape: RoundedRectangleBorder(
// // // // // //                             borderRadius: BorderRadius.circular(5),
// // // // // //                           ),
// // // // // //                         ),
// // // // // //                         child: const Text(
// // // // // //                           'Cancel',
// // // // // //                           style:
// // // // // //                               TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
// // // // // //                         ),
// // // // // //                       ),
// // // // // //                     ),

// // // // // //                     // Add button to retake photo if image is selected
// // // // // //                     if (_selectedImage != null)
// // // // // //                       SizedBox(
// // // // // //                         height: 36,
// // // // // //                         width: 120,
// // // // // //                         child: ElevatedButton(
// // // // // //                           onPressed: () {
// // // // // //                             setState(() {
// // // // // //                               _selectedImage = null;
// // // // // //                               _medicines = [];
// // // // // //                               _extractedText = null;
// // // // // //                             });
// // // // // //                           },
// // // // // //                           style: ElevatedButton.styleFrom(
// // // // // //                             backgroundColor: Colors.blue,
// // // // // //                             foregroundColor: Colors.white,
// // // // // //                             shape: RoundedRectangleBorder(
// // // // // //                               borderRadius: BorderRadius.circular(5),
// // // // // //                             ),
// // // // // //                           ),
// // // // // //                           child: const Text(
// // // // // //                             'Retake Photo',
// // // // // //                             style: TextStyle(
// // // // // //                                 fontSize: 14, fontWeight: FontWeight.w500),
// // // // // //                           ),
// // // // // //                         ),
// // // // // //                       ),
// // // // // //                   ],
// // // // // //                 ),

// // // // // //                 const SizedBox(height: 20),

// // // // // //                 // Display extracted text for debugging (optional)
// // // // // //                 if (_extractedText != null && _extractedText!.isNotEmpty)
// // // // // //                   Container(
// // // // // //                     margin: const EdgeInsets.symmetric(horizontal: 24.0),
// // // // // //                     padding: const EdgeInsets.all(12.0),
// // // // // //                     decoration: BoxDecoration(
// // // // // //                       color: Colors.blue.withOpacity(0.1),
// // // // // //                       borderRadius: BorderRadius.circular(8.0),
// // // // // //                       border: Border.all(color: Colors.blue.withOpacity(0.3)),
// // // // // //                     ),
// // // // // //                     child: Text(
// // // // // //                       'Extracted: ${_extractedText!.split('\n').take(3).join(' ')}',
// // // // // //                       style: const TextStyle(fontSize: 12),
// // // // // //                       maxLines: 2,
// // // // // //                       overflow: TextOverflow.ellipsis,
// // // // // //                     ),
// // // // // //                   ),

// // // // // //                 // Display medicine results
// // // // // //                 Expanded(
// // // // // //                   child: _medicines.isNotEmpty
// // // // // //                       ? ListView.builder(
// // // // // //                           padding: const EdgeInsets.symmetric(horizontal: 24.0),
// // // // // //                           itemCount: _medicines.length,
// // // // // //                           itemBuilder: (context, index) {
// // // // // //                             final medicine = _medicines[index];
// // // // // //                             return Container(
// // // // // //                               margin: const EdgeInsets.only(bottom: 12.0),
// // // // // //                               padding: const EdgeInsets.all(16.0),
// // // // // //                               decoration: BoxDecoration(
// // // // // //                                 color: Colors.white,
// // // // // //                                 borderRadius: BorderRadius.circular(15.0),
// // // // // //                                 boxShadow: [
// // // // // //                                   BoxShadow(
// // // // // //                                     color: Colors.black.withOpacity(0.1),
// // // // // //                                     blurRadius: 8,
// // // // // //                                     spreadRadius: 1,
// // // // // //                                   ),
// // // // // //                                 ],
// // // // // //                               ),
// // // // // //                               child: Row(
// // // // // //                                 children: [
// // // // // //                                   Container(
// // // // // //                                     width: 80,
// // // // // //                                     height: 80,
// // // // // //                                     decoration: BoxDecoration(
// // // // // //                                       borderRadius: BorderRadius.circular(10),
// // // // // //                                       color: Colors.grey.shade100,
// // // // // //                                     ),
// // // // // //                                     child: medicine['images'] != null &&
// // // // // //                                            medicine['images'].isNotEmpty
// // // // // //                                         ? ClipRRect(
// // // // // //                                             borderRadius: BorderRadius.circular(10),
// // // // // //                                             child: Image.network(
// // // // // //                                               medicine['images'][0],
// // // // // //                                               fit: BoxFit.cover,
// // // // // //                                               errorBuilder: (context, error, stackTrace) =>
// // // // // //                                                   const Icon(
// // // // // //                                                     Icons.medication_outlined,
// // // // // //                                                     color: Colors.blue,
// // // // // //                                                     size: 30,
// // // // // //                                                   ),
// // // // // //                                             ),
// // // // // //                                           )
// // // // // //                                         : const Icon(
// // // // // //                                             Icons.medication_outlined,
// // // // // //                                             color: Colors.blue,
// // // // // //                                             size: 30,
// // // // // //                                           ),
// // // // // //                                   ),
// // // // // //                                   const SizedBox(width: 16),
// // // // // //                                   Expanded(
// // // // // //                                     child: Column(
// // // // // //                                       crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //                                       children: [
// // // // // //                                         Text(
// // // // // //                                           medicine['name'] ?? 'Unknown Medicine',
// // // // // //                                           style: const TextStyle(
// // // // // //                                             fontSize: 16,
// // // // // //                                             fontWeight: FontWeight.bold,
// // // // // //                                           ),
// // // // // //                                         ),
// // // // // //                                         const SizedBox(height: 4),
// // // // // //                                         Text(
// // // // // //                                           'Rs. ${medicine['price'] ?? 'N/A'} (MRP: Rs. ${medicine['mrp'] ?? 'N/A'})',
// // // // // //                                           style: TextStyle(
// // // // // //                                             fontSize: 14,
// // // // // //                                             color: Colors.green.shade700,
// // // // // //                                             fontWeight: FontWeight.w600,
// // // // // //                                           ),
// // // // // //                                         ),
// // // // // //                                         const SizedBox(height: 4),
// // // // // //                                         Row(
// // // // // //                                           children: [
// // // // // //                                             const Icon(
// // // // // //                                               Icons.location_on_outlined,
// // // // // //                                               color: Colors.deepPurple,
// // // // // //                                               size: 16,
// // // // // //                                             ),
// // // // // //                                             Expanded(
// // // // // //                                               child: Text(
// // // // // //                                                 medicine['pharmacy']?['name'] ?? 'Unknown Pharmacy',
// // // // // //                                                 style: const TextStyle(fontSize: 12),
// // // // // //                                                 overflow: TextOverflow.ellipsis,
// // // // // //                                               ),
// // // // // //                                             ),
// // // // // //                                           ],
// // // // // //                                         ),
// // // // // //                                       ],
// // // // // //                                     ),
// // // // // //                                   ),
// // // // // //                                   IconButton(
// // // // // //                                     icon: const Icon(Icons.arrow_forward_ios, size: 16),
// // // // // //                                     onPressed: () {
// // // // // //                                       // Navigate to medicine details
// // // // // //                                       // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ScannedMedicineScreen()));
// // // // // //                                     },
// // // // // //                                   ),
// // // // // //                                 ],
// // // // // //                               ),
// // // // // //                             );
// // // // // //                           },
// // // // // //                         )
// // // // // //                       : _selectedImage != null && !_isProcessing
// // // // // //                           ? const Center(
// // // // // //                               child: Text(
// // // // // //                                 'No medicines found.\nTry a clearer image.',
// // // // // //                                 textAlign: TextAlign.center,
// // // // // //                                 style: TextStyle(
// // // // // //                                   color: Colors.grey,
// // // // // //                                   fontSize: 16,
// // // // // //                                 ),
// // // // // //                               ),
// // // // // //                             )
// // // // // //                           : const SizedBox(),
// // // // // //                 ),

// // // // // //                 const SizedBox(height: 20),
// // // // // //               ],
// // // // // //             ),
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   // Helper method to create corners
// // // // // //   Widget _buildCorner(Alignment alignment) {
// // // // // //     return Align(
// // // // // //       alignment: alignment,
// // // // // //       child: Container(
// // // // // //         width: 30,
// // // // // //         height: 30,
// // // // // //         decoration: BoxDecoration(
// // // // // //           border: Border(
// // // // // //             top: (alignment == Alignment.topLeft ||
// // // // // //                     alignment == Alignment.topRight)
// // // // // //                 ? const BorderSide(color: Colors.black, width: 3)
// // // // // //                 : BorderSide.none,
// // // // // //             bottom: (alignment == Alignment.bottomLeft ||
// // // // // //                     alignment == Alignment.bottomRight)
// // // // // //                 ? const BorderSide(color: Colors.black, width: 3)
// // // // // //                 : BorderSide.none,
// // // // // //             left: (alignment == Alignment.topLeft ||
// // // // // //                     alignment == Alignment.bottomLeft)
// // // // // //                 ? const BorderSide(color: Colors.black, width: 3)
// // // // // //                 : BorderSide.none,
// // // // // //             right: (alignment == Alignment.topRight ||
// // // // // //                     alignment == Alignment.bottomRight)
// // // // // //                 ? const BorderSide(color: Colors.black, width: 3)
// // // // // //                 : BorderSide.none,
// // // // // //           ),
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // // }

// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:image_picker/image_picker.dart';
// // // // // import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// // // // // import 'package:http/http.dart' as http;
// // // // // import 'package:medical_user_app/view/near_pharmacy_screen.dart';
// // // // // import 'dart:convert';
// // // // // import 'dart:ui';
// // // // // import 'dart:io';

// // // // // class MedicineScannerScreen extends StatefulWidget {
// // // // //   const MedicineScannerScreen({super.key});

// // // // //   @override
// // // // //   State<MedicineScannerScreen> createState() => _MedicineScannerScreenState();
// // // // // }

// // // // // class _MedicineScannerScreenState extends State<MedicineScannerScreen>
// // // // //     with SingleTickerProviderStateMixin {
// // // // //   File? _selectedImage;
// // // // //   final ImagePicker _imagePicker = ImagePicker();
// // // // //   TextRecognizer? _textRecognizer;

// // // // //   bool _isProcessing = false;
// // // // //   List<dynamic> _medicines = [];
// // // // //   String? _extractedText;

// // // // //   // Animation controller for the scanning line
// // // // //   late AnimationController _animationController;
// // // // //   late Animation<double> _animation;

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();

// // // // //     // Initialize text recognizer
// // // // //     _textRecognizer = TextRecognizer();

// // // // //     // Initialize animation controller
// // // // //     _animationController = AnimationController(
// // // // //       duration: const Duration(seconds: 2),
// // // // //       vsync: this,
// // // // //     )..repeat(reverse: true); // Makes the animation go back and forth

// // // // //     // Create animation that moves from top (0.0) to bottom (1.0) of container
// // // // //     _animation =
// // // // //         Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
// // // // //   }

// // // // //   @override
// // // // //   void dispose() {
// // // // //     _animationController.dispose();
// // // // //     _textRecognizer?.close();
// // // // //     super.dispose();
// // // // //   }

// // // // //   // Method to pick image from gallery
// // // // //   Future<void> _pickImageFromGallery() async {
// // // // //     try {
// // // // //       final XFile? pickedFile = await _imagePicker.pickImage(
// // // // //         source: ImageSource.gallery,
// // // // //         imageQuality: 85,
// // // // //         maxWidth: 1920,
// // // // //         maxHeight: 1080,
// // // // //       );

// // // // //       if (pickedFile != null) {
// // // // //         setState(() {
// // // // //           _selectedImage = File(pickedFile.path);
// // // // //           _medicines = []; // Clear previous results
// // // // //           _extractedText = null;
// // // // //         });

// // // // //         // Show success message
// // // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // // //           const SnackBar(
// // // // //             content: Text('Image selected successfully!'),
// // // // //             backgroundColor: Colors.green,
// // // // //             duration: Duration(seconds: 2),
// // // // //           ),
// // // // //         );

// // // // //         _processSelectedImage();
// // // // //       }
// // // // //     } catch (e) {
// // // // //       // Handle any errors
// // // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // // //         SnackBar(
// // // // //           content: Text('Error picking image: $e'),
// // // // //           backgroundColor: Colors.red,
// // // // //           duration: const Duration(seconds: 2),
// // // // //         ),
// // // // //       );
// // // // //     }
// // // // //   }

// // // // //   // Method to take photo from camera
// // // // //   Future<void> _takePhotoFromCamera() async {
// // // // //     try {
// // // // //       final XFile? pickedFile = await _imagePicker.pickImage(
// // // // //         source: ImageSource.camera,
// // // // //         imageQuality: 85,
// // // // //         maxWidth: 1920,
// // // // //         maxHeight: 1080,
// // // // //         preferredCameraDevice: CameraDevice.rear,
// // // // //       );

// // // // //       if (pickedFile != null) {
// // // // //         setState(() {
// // // // //           _selectedImage = File(pickedFile.path);
// // // // //           _medicines = []; // Clear previous results
// // // // //           _extractedText = null;
// // // // //         });

// // // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // // //           const SnackBar(
// // // // //             content: Text('Photo captured successfully!'),
// // // // //             backgroundColor: Colors.green,
// // // // //             duration: Duration(seconds: 2),
// // // // //           ),
// // // // //         );

// // // // //         _processSelectedImage();
// // // // //       }
// // // // //     } catch (e) {
// // // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // // //         SnackBar(
// // // // //           content: Text('Error taking photo: $e'),
// // // // //           backgroundColor: Colors.red,
// // // // //           duration: const Duration(seconds: 2),
// // // // //         ),
// // // // //       );
// // // // //     }
// // // // //   }

// // // // //   // Extract text from image using ML Kit
// // // // //   Future<void> _processSelectedImage() async {
// // // // //     if (_selectedImage == null || _textRecognizer == null) return;

// // // // //     setState(() {
// // // // //       _isProcessing = true;
// // // // //     });

// // // // //     try {
// // // // //       // Perform text recognition
// // // // //       final inputImage = InputImage.fromFile(_selectedImage!);
// // // // //       final recognizedText = await _textRecognizer!.processImage(inputImage);

// // // // //       print("Reccccccccccccccccccccccccccccccc$recognizedText");

// // // // //       String extractedText = recognizedText.text;

// // // // //       print("Extracted Text$extractedText");

// // // // //       setState(() {
// // // // //         _extractedText = extractedText;
// // // // //       });

// // // // //       if (extractedText.isNotEmpty) {
// // // // //         // Extract potential medicine names from the text
// // // // //         String medicineName = _extractMedicineName(extractedText);

// // // // //         print("oooooooooooooooooopppppppppppppppppp$medicineName");

// // // // //         // Validate the extracted name
// // // // //         String validatedName = _validateMedicineName(medicineName);

// // // // //         if (validatedName.isNotEmpty) {
// // // // //           print('Extracted medicine name: $validatedName'); // Debug print
// // // // //           // Search for medicines using the validated name
// // // // //           await _searchMedicines(validatedName);
// // // // //         } else {
// // // // //           _showError(
// // // // //               'Could not identify medicine name from the image. Please ensure the medicine name is clearly visible.');
// // // // //         }
// // // // //       } else {
// // // // //         _showError(
// // // // //             'No text found in image. Please upload a clear photo of the medicine package.');
// // // // //       }
// // // // //     } catch (e) {
// // // // //       _showError('Error processing image: $e');
// // // // //     } finally {
// // // // //       setState(() {
// // // // //         _isProcessing = false;
// // // // //       });
// // // // //     }
// // // // //   }

// // // // //   // Enhanced medicine name extraction method
// // // // //   String _extractMedicineName(String text) {
// // // // //     if (text.isEmpty) return '';

// // // // //     // Clean up the text
// // // // //     String cleanText = text.trim();

// // // // //     // Split into lines and words
// // // // //     List<String> lines = cleanText.split('\n');

// // // // //     // Common medicine suffixes to remove
// // // // //     List<String> medicineSuffixes = [
// // // // //       'tablets',
// // // // //       'tablet',
// // // // //       'caps',
// // // // //       'capsule',
// // // // //       'capsules',
// // // // //       'syrup',
// // // // //       'injection',
// // // // //       'cream',
// // // // //       'ointment',
// // // // //       'drops',
// // // // //       'suspension',
// // // // //       'solution',
// // // // //       'gel',
// // // // //       'lotion'
// // // // //     ];

// // // // //     // Common dosage patterns to remove
// // // // //     List<RegExp> dosagePatterns = [
// // // // //       RegExp(r'\d+\s*(mg|ml|gm|mcg|g|l)', caseSensitive: false),
// // // // //       RegExp(r'\d+\s*mg', caseSensitive: false),
// // // // //       RegExp(r'\d+mg', caseSensitive: false),
// // // // //       RegExp(r'IP\s*\d+\s*(mg|ml|gm|mcg)', caseSensitive: false),
// // // // //       RegExp(r'IP', caseSensitive: false),
// // // // //     ];

// // // // //     // Words/patterns to exclude
// // // // //     List<String> excludeWords = [
// // // // //       'mfg',
// // // // //       'exp',
// // // // //       'manufactured',
// // // // //       'expires',
// // // // //       'expiry',
// // // // //       'batch',
// // // // //       'lot',
// // // // //       'price',
// // // // //       'mrp',
// // // // //       'date',
// // // // //       'pack',
// // // // //       'size',
// // // // //       'contents',
// // // // //       'strip',
// // // // //       'each',
// // // // //       'uncoated',
// // // // //       'contains',
// // // // //       'store',
// // // // //       'dosage',
// // // // //       'physician',
// // // // //       'temperature',
// // // // //       'exceeding',
// // // // //       'lic',
// // // // //       'no',
// // // // //       'made',
// // // // //       'india',
// // // // //       'limited',
// // // // //       'ltd',
// // // // //       'pvt',
// // // // //       'pharmaceuticals',
// // // // //       'pharma',
// // // // //       'healthcare',
// // // // //       'drugs',
// // // // //       'sector',
// // // // //       'road',
// // // // //       'plot',
// // // // //       'micro',
// // // // //       'labs'
// // // // //     ];

// // // // //     List<String> potentialMedicineNames = [];

// // // // //     // Process each line
// // // // //     for (String line in lines) {
// // // // //       String cleanLine = line.trim();
// // // // //       if (cleanLine.length < 3 || cleanLine.length > 50) continue;

// // // // //       String lowerLine = cleanLine.toLowerCase();

// // // // //       // Skip lines with exclude words
// // // // //       bool hasExcludeWord =
// // // // //           excludeWords.any((word) => lowerLine.contains(word.toLowerCase()));
// // // // //       if (hasExcludeWord) continue;

// // // // //       // Skip lines that are mostly numbers or special characters
// // // // //       if (RegExp(r'^[0-9\s\-\.\,\:\;\(\)]+$').hasMatch(cleanLine)) continue;

// // // // //       // Remove dosage information
// // // // //       String processedLine = cleanLine;
// // // // //       for (RegExp pattern in dosagePatterns) {
// // // // //         processedLine = processedLine.replaceAll(pattern, '').trim();
// // // // //       }

// // // // //       // Remove medicine suffixes
// // // // //       for (String suffix in medicineSuffixes) {
// // // // //         RegExp suffixPattern =
// // // // //             RegExp(r'\b' + suffix + r'\b', caseSensitive: false);
// // // // //         processedLine = processedLine.replaceAll(suffixPattern, '').trim();
// // // // //       }

// // // // //       // Clean up extra spaces and special characters
// // // // //       processedLine = processedLine
// // // // //           .replaceAll(
// // // // //               RegExp(r'[^\w\s\-]'), ' ') // Remove special chars except hyphen
// // // // //           .replaceAll(RegExp(r'\s+'), ' ') // Normalize spaces
// // // // //           .trim();

// // // // //       // If still has meaningful text, consider it
// // // // //       if (processedLine.length >= 3 && processedLine.length <= 30) {
// // // // //         // Check if it looks like a medicine name (starts with letter, contains letters)
// // // // //         if (RegExp(r'^[A-Za-z][A-Za-z0-9\s\-]*[A-Za-z]')
// // // // //             .hasMatch(processedLine)) {
// // // // //           potentialMedicineNames.add(processedLine);
// // // // //         }
// // // // //       }
// // // // //     }

// // // // //     // If we found potential names, return the best one
// // // // //     if (potentialMedicineNames.isNotEmpty) {
// // // // //       // Sort by length and alphabetical content ratio
// // // // //       potentialMedicineNames.sort((a, b) {
// // // // //         // Prefer shorter names (more likely to be the core medicine name)
// // // // //         int lengthCompare = a.length.compareTo(b.length);
// // // // //         if (lengthCompare != 0) return lengthCompare;

// // // // //         // Prefer names with more alphabetical characters
// // // // //         int aAlphaCount = a.replaceAll(RegExp(r'[^A-Za-z]'), '').length;
// // // // //         int bAlphaCount = b.replaceAll(RegExp(r'[^A-Za-z]'), '').length;
// // // // //         return bAlphaCount.compareTo(aAlphaCount);
// // // // //       });

// // // // //       String bestName = potentialMedicineNames.first;

// // // // //       // For compound names like "Dolo-650", extract just "Dolo"
// // // // //       if (bestName.contains('-')) {
// // // // //         List<String> parts = bestName.split('-');
// // // // //         String firstPart = parts.first.trim();
// // // // //         if (firstPart.length >= 3) {
// // // // //           return firstPart;
// // // // //         }
// // // // //       }

// // // // //       // For names with numbers, try to extract the alphabetical part
// // // // //       if (RegExp(r'\d').hasMatch(bestName)) {
// // // // //         String alphabeticalPart =
// // // // //             bestName.replaceAll(RegExp(r'\d+'), '').trim();
// // // // //         if (alphabeticalPart.length >= 3) {
// // // // //           return alphabeticalPart;
// // // // //         }
// // // // //       }

// // // // //       return bestName;
// // // // //     }

// // // // //     // Fallback: Look for any prominent words in the first few lines
// // // // //     for (int i = 0; i < lines.length && i < 5; i++) {
// // // // //       String line = lines[i].trim();
// // // // //       if (line.length >= 4 && line.length <= 20) {
// // // // //         // Check if it's mostly alphabetical
// // // // //         String alphaOnly = line.replaceAll(RegExp(r'[^A-Za-z]'), '');
// // // // //         if (alphaOnly.length >= 3 && alphaOnly.length >= line.length * 0.6) {
// // // // //           return alphaOnly;
// // // // //         }
// // // // //       }
// // // // //     }

// // // // //     return '';
// // // // //   }

// // // // //   // Additional method to validate and clean medicine name before API call
// // // // //   String _validateMedicineName(String name) {
// // // // //     if (name.isEmpty) return '';

// // // // //     // Remove any remaining unwanted characters
// // // // //     String cleaned = name
// // // // //         .replaceAll(
// // // // //             RegExp(r'[^\w\s\-]'), '') // Keep only word chars, spaces, hyphens
// // // // //         .replaceAll(RegExp(r'\s+'), ' ') // Normalize spaces
// // // // //         .trim();

// // // // //     // Must be at least 3 characters and mostly alphabetical
// // // // //     if (cleaned.length < 3) return '';

// // // // //     String alphaOnly = cleaned.replaceAll(RegExp(r'[^A-Za-z]'), '');
// // // // //     if (alphaOnly.length < 2) return '';

// // // // //     return cleaned;
// // // // //   }

// // // // //   // Search medicines using the API
// // // // //   Future<void> _searchMedicines(String medicineName) async {
// // // // //     try {
// // // // //       print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh$medicineName");
// // // // //       final url = Uri.parse(
// // // // //           'https://api.simcurarx.com/api/pharmacy/allmedicine?name=$medicineName');
// // // // //       final response = await http.get(url);

// // // // //       print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh${response.body}");

// // // // //       if (response.statusCode == 200) {
// // // // //         final data = json.decode(response.body);

// // // // //         setState(() {
// // // // //           _medicines = data['medicines'] ?? [];
// // // // //         });

// // // // //         if (_medicines.isEmpty) {
// // // // //           // Try with partial search or alternative names
// // // // //           await _tryAlternativeSearch(medicineName);
// // // // //         }
// // // // //       } else {
// // // // //         _showError('Failed to fetch medicines. Please try again.');
// // // // //       }
// // // // //     } catch (e) {
// // // // //       _showError('Network error: Please check your internet connection.');
// // // // //     }
// // // // //   }

// // // // //   // Enhanced alternative search method
// // // // //   Future<void> _tryAlternativeSearch(String originalName) async {
// // // // //     List<String> searchVariations = [];

// // // // //     // Add the original name
// // // // //     searchVariations.add(originalName);

// // // // //     // Try with first word only
// // // // //     List<String> words = originalName.split(' ');
// // // // //     if (words.isNotEmpty && words.first.length > 2) {
// // // // //       searchVariations.add(words.first);
// // // // //     }

// // // // //     // Try with last word if it's longer
// // // // //     if (words.length > 1 && words.last.length > 3) {
// // // // //       searchVariations.add(words.last);
// // // // //     }

// // // // //     // Try removing common prefixes/suffixes
// // // // //     String withoutCommon = originalName
// // // // //         .replaceAll(RegExp(r'^(dr|mr|mrs)\.?\s*', caseSensitive: false), '')
// // // // //         .replaceAll(
// // // // //             RegExp(r'\s*(plus|forte|xl|sr|er)$', caseSensitive: false), '');

// // // // //     if (withoutCommon != originalName && withoutCommon.length > 2) {
// // // // //       searchVariations.add(withoutCommon);
// // // // //     }

// // // // //     // Try each variation
// // // // //     for (String variation in searchVariations) {
// // // // //       if (variation.length >= 3) {
// // // // //         print('Trying search with: $variation'); // Debug print
// // // // //         await _searchMedicines(variation);
// // // // //         if (_medicines.isNotEmpty) {
// // // // //           break; // Stop if we found results
// // // // //         }

// // // // //         // Add a small delay between requests
// // // // //         await Future.delayed(const Duration(milliseconds: 500));
// // // // //       }
// // // // //     }

// // // // //     // If still no results, show message
// // // // //     if (_medicines.isEmpty) {
// // // // //       _showError(
// // // // //           'No medicines found for "$originalName". Please try taking a clearer photo focusing on the medicine name.');
// // // // //     }
// // // // //   }

// // // // //   void _showError(String message) {
// // // // //     ScaffoldMessenger.of(context).showSnackBar(
// // // // //       SnackBar(
// // // // //         content: Text(message),
// // // // //         backgroundColor: Colors.orange,
// // // // //         duration: const Duration(seconds: 4),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   // Show options to take photo or pick from gallery
// // // // //   void _showImagePickerOptions() {
// // // // //     showModalBottomSheet(
// // // // //       context: context,
// // // // //       builder: (context) => SafeArea(
// // // // //         child: Column(
// // // // //           mainAxisSize: MainAxisSize.min,
// // // // //           children: [
// // // // //             const Padding(
// // // // //               padding: EdgeInsets.all(16),
// // // // //               child: Text(
// // // // //                 'Select Medicine Image',
// // // // //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
// // // // //               ),
// // // // //             ),
// // // // //             ListTile(
// // // // //               leading: const Icon(Icons.camera_alt),
// // // // //               title: const Text('Take Photo'),
// // // // //               subtitle: const Text('Capture medicine package/bottle'),
// // // // //               onTap: () {
// // // // //                 Navigator.pop(context);
// // // // //                 _takePhotoFromCamera();
// // // // //               },
// // // // //             ),
// // // // //             ListTile(
// // // // //               leading: const Icon(Icons.photo_library),
// // // // //               title: const Text('Choose from Gallery'),
// // // // //               subtitle: const Text('Select existing photo'),
// // // // //               onTap: () {
// // // // //                 Navigator.pop(context);
// // // // //                 _pickImageFromGallery();
// // // // //               },
// // // // //             ),
// // // // //             const SizedBox(height: 16),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       body: Stack(
// // // // //         children: [
// // // // //           Positioned.fill(
// // // // //             child: Image.asset(
// // // // //               'assets/background_image.png',
// // // // //               fit: BoxFit.cover,
// // // // //             ),
// // // // //           ),

// // // // //           // Blur effect on top of image
// // // // //           Positioned.fill(
// // // // //             child: BackdropFilter(
// // // // //               filter:
// // // // //                   ImageFilter.blur(sigmaX: 83.6, sigmaY: 83.6), // heavy blur
// // // // //               child: Container(
// // // // //                 color: Colors.black
// // // // //                     .withOpacity(0), // Required for BackdropFilter to work
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //           SafeArea(
// // // // //             child: Column(
// // // // //               children: [
// // // // //                 // Top toolbar
// // // // //                 const SizedBox(height: 30),
// // // // //                 Padding(
// // // // //                   padding: const EdgeInsets.symmetric(
// // // // //                       horizontal: 18.0, vertical: 12.0),
// // // // //                   child: Container(
// // // // //                     height: 44,
// // // // //                     width: 343,
// // // // //                     decoration: BoxDecoration(
// // // // //                       color: Colors.white,
// // // // //                       borderRadius: BorderRadius.circular(10),
// // // // //                     ),
// // // // //                     child: Row(
// // // // //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // // // //                       children: [
// // // // //                         IconButton(
// // // // //                           icon:
// // // // //                               const Icon(Icons.camera_alt, color: Colors.blue),
// // // // //                           onPressed: _takePhotoFromCamera,
// // // // //                           tooltip: 'Take Photo',
// // // // //                         ),
// // // // //                         IconButton(
// // // // //                           icon: const Icon(Icons.photo_library,
// // // // //                               color: Colors.purple),
// // // // //                           onPressed: _pickImageFromGallery,
// // // // //                           tooltip: 'Choose from Gallery',
// // // // //                         ),
// // // // //                         IconButton(
// // // // //                           icon: const Icon(Icons.add_a_photo,
// // // // //                               color: Colors.green),
// // // // //                           onPressed: _showImagePickerOptions,
// // // // //                           tooltip: 'Select Image',
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),

// // // // //                 const SizedBox(height: 10.0),

// // // // //                 const Text(
// // // // //                   'Scan the Medicine',
// // // // //                   style: TextStyle(
// // // // //                     fontSize: 22.0,
// // // // //                     fontWeight: FontWeight.bold,
// // // // //                     color: Colors.black87,
// // // // //                   ),
// // // // //                 ),

// // // // //                 const SizedBox(height: 20.0),

// // // // //                 // Image View Area
// // // // //                 Padding(
// // // // //                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
// // // // //                   child: GestureDetector(
// // // // //                     onTap:
// // // // //                         _selectedImage == null ? _showImagePickerOptions : null,
// // // // //                     child: Container(
// // // // //                       height: 320,
// // // // //                       width: double.infinity,
// // // // //                       decoration: BoxDecoration(
// // // // //                         color: Colors.white,
// // // // //                         borderRadius: BorderRadius.circular(20.0),
// // // // //                         border: Border.all(
// // // // //                           color: _selectedImage != null
// // // // //                               ? Colors.green.shade300
// // // // //                               : Colors.grey.shade300,
// // // // //                           width: 2,
// // // // //                         ),
// // // // //                       ),
// // // // //                       child: Stack(
// // // // //                         alignment: Alignment.center,
// // // // //                         children: [
// // // // //                           if (_selectedImage != null)
// // // // //                             ClipRRect(
// // // // //                               borderRadius: BorderRadius.circular(18.0),
// // // // //                               child: Image.file(
// // // // //                                 _selectedImage!,
// // // // //                                 fit: BoxFit.cover,
// // // // //                                 width: double.infinity,
// // // // //                                 height: double.infinity,
// // // // //                               ),
// // // // //                             )
// // // // //                           else
// // // // //                             Column(
// // // // //                               mainAxisAlignment: MainAxisAlignment.center,
// // // // //                               children: [
// // // // //                                 // Animated scanning line effect even without camera
// // // // //                                 AnimatedBuilder(
// // // // //                                   animation: _animation,
// // // // //                                   builder: (context, child) {
// // // // //                                     return Container(
// // // // //                                       width: 280,
// // // // //                                       height: 5,
// // // // //                                       margin: EdgeInsets.only(
// // // // //                                           top: _animation.value * 50),
// // // // //                                       decoration: BoxDecoration(
// // // // //                                         gradient: LinearGradient(
// // // // //                                           colors: [
// // // // //                                             Colors.greenAccent.withOpacity(0.7),
// // // // //                                             Colors.green.withOpacity(0.7)
// // // // //                                           ],
// // // // //                                         ),
// // // // //                                         boxShadow: [
// // // // //                                           BoxShadow(
// // // // //                                             color: Colors.greenAccent
// // // // //                                                 .withOpacity(0.5),
// // // // //                                             blurRadius: 12,
// // // // //                                             spreadRadius: 2,
// // // // //                                           ),
// // // // //                                         ],
// // // // //                                       ),
// // // // //                                     );
// // // // //                                   },
// // // // //                                 ),
// // // // //                                 const SizedBox(height: 40),
// // // // //                                 Icon(
// // // // //                                   Icons.camera_alt,
// // // // //                                   size: 60,
// // // // //                                   color: Colors.grey.shade400,
// // // // //                                 ),
// // // // //                                 const SizedBox(height: 16),
// // // // //                                 Text(
// // // // //                                   'Tap to take a photo of medicine',
// // // // //                                   style: TextStyle(
// // // // //                                     color: Colors.grey.shade600,
// // // // //                                     fontSize: 16,
// // // // //                                   ),
// // // // //                                 ),
// // // // //                                 const SizedBox(height: 8),
// // // // //                                 Text(
// // // // //                                   'Point camera at medicine package or bottle',
// // // // //                                   style: TextStyle(
// // // // //                                     color: Colors.grey.shade500,
// // // // //                                     fontSize: 12,
// // // // //                                   ),
// // // // //                                 ),
// // // // //                               ],
// // // // //                             ),

// // // // //                           // Scanner corners (decorative)
// // // // //                           _buildCorner(Alignment.topLeft),
// // // // //                           _buildCorner(Alignment.topRight),
// // // // //                           _buildCorner(Alignment.bottomLeft),
// // // // //                           _buildCorner(Alignment.bottomRight),

// // // // //                           // Show processing indicator
// // // // //                           if (_isProcessing)
// // // // //                             Container(
// // // // //                               color: Colors.black.withOpacity(0.7),
// // // // //                               child: const Center(
// // // // //                                 child: Column(
// // // // //                                   mainAxisSize: MainAxisSize.min,
// // // // //                                   children: [
// // // // //                                     CircularProgressIndicator(
// // // // //                                         color: Colors.white),
// // // // //                                     SizedBox(height: 16),
// // // // //                                     Text(
// // // // //                                       'Processing image...',
// // // // //                                       style: TextStyle(
// // // // //                                         color: Colors.white,
// // // // //                                         fontSize: 16,
// // // // //                                         fontWeight: FontWeight.w500,
// // // // //                                       ),
// // // // //                                     ),
// // // // //                                   ],
// // // // //                                 ),
// // // // //                               ),
// // // // //                             ),

// // // // //                           // Show overlay for selected image
// // // // //                           if (_selectedImage != null && !_isProcessing)
// // // // //                             Positioned(
// // // // //                               bottom: 16,
// // // // //                               right: 16,
// // // // //                               child: Container(
// // // // //                                 padding: const EdgeInsets.all(8),
// // // // //                                 decoration: BoxDecoration(
// // // // //                                   color: Colors.black.withOpacity(0.7),
// // // // //                                   borderRadius: BorderRadius.circular(8),
// // // // //                                 ),
// // // // //                                 child: const Text(
// // // // //                                   'Image Selected',
// // // // //                                   style: TextStyle(
// // // // //                                     color: Colors.white,
// // // // //                                     fontSize: 12,
// // // // //                                     fontWeight: FontWeight.w500,
// // // // //                                   ),
// // // // //                                 ),
// // // // //                               ),
// // // // //                             ),
// // // // //                         ],
// // // // //                       ),
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),

// // // // //                 const SizedBox(height: 20.0),

// // // // //                 // Action buttons
// // // // //                 Row(
// // // // //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // // // //                   children: [
// // // // //                     SizedBox(
// // // // //                       height: 36,
// // // // //                       width: 160,
// // // // //                       child: ElevatedButton(
// // // // //                         onPressed: () {
// // // // //                           Navigator.pop(context);
// // // // //                         },
// // // // //                         style: ElevatedButton.styleFrom(
// // // // //                           backgroundColor: Colors.white,
// // // // //                           foregroundColor: Colors.black87,
// // // // //                           shape: RoundedRectangleBorder(
// // // // //                             borderRadius: BorderRadius.circular(5),
// // // // //                           ),
// // // // //                         ),
// // // // //                         child: const Text(
// // // // //                           'Cancel',
// // // // //                           style: TextStyle(
// // // // //                               fontSize: 14, fontWeight: FontWeight.w500),
// // // // //                         ),
// // // // //                       ),
// // // // //                     ),
// // // // //                     if (_selectedImage != null)
// // // // //                       SizedBox(
// // // // //                         height: 36,
// // // // //                         width: 120,
// // // // //                         child: ElevatedButton(
// // // // //                           onPressed: () {
// // // // //                             setState(() {
// // // // //                               _selectedImage = null;
// // // // //                               _medicines = [];
// // // // //                               _extractedText = null;
// // // // //                             });
// // // // //                           },
// // // // //                           style: ElevatedButton.styleFrom(
// // // // //                             backgroundColor: Colors.blue,
// // // // //                             foregroundColor: Colors.white,
// // // // //                             shape: RoundedRectangleBorder(
// // // // //                               borderRadius: BorderRadius.circular(5),
// // // // //                             ),
// // // // //                           ),
// // // // //                           child: const Text(
// // // // //                             'Retake Photo',
// // // // //                             style: TextStyle(
// // // // //                                 fontSize: 14, fontWeight: FontWeight.w500),
// // // // //                           ),
// // // // //                         ),
// // // // //                       ),
// // // // //                   ],
// // // // //                 ),

// // // // //                 const SizedBox(height: 20),
// // // // //                 if (_extractedText != null && _extractedText!.isNotEmpty)
// // // // //                   Container(
// // // // //                     margin: const EdgeInsets.symmetric(horizontal: 24.0),
// // // // //                     padding: const EdgeInsets.all(12.0),
// // // // //                     decoration: BoxDecoration(
// // // // //                       color: Colors.blue.withOpacity(0.1),
// // // // //                       borderRadius: BorderRadius.circular(8.0),
// // // // //                       border: Border.all(color: Colors.blue.withOpacity(0.3)),
// // // // //                     ),
// // // // //                     child: Text(
// // // // //                       'Extracted: ${_extractedText!.split('\n').take(3).join(' ')}',
// // // // //                       style: const TextStyle(fontSize: 12),
// // // // //                       maxLines: 2,
// // // // //                       overflow: TextOverflow.ellipsis,
// // // // //                     ),
// // // // //                   ),

// // // // //                 // Display medicine results
// // // // //                 Expanded(
// // // // //                   child: _medicines.isNotEmpty
// // // // //                       ? ListView.builder(
// // // // //                           padding: const EdgeInsets.symmetric(horizontal: 24.0),
// // // // //                           itemCount: _medicines.length,
// // // // //                           itemBuilder: (context, index) {
// // // // //                             final medicine = _medicines[index];
// // // // //                             return GestureDetector(
// // // // //                               onTap: () {
// // // // //                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>NearPharmacyScreen()));
// // // // //                               },
// // // // //                               child: Container(
// // // // //                                 margin: const EdgeInsets.only(bottom: 12.0),
// // // // //                                 padding: const EdgeInsets.all(16.0),
// // // // //                                 decoration: BoxDecoration(
// // // // //                                   color: Colors.white,
// // // // //                                   borderRadius: BorderRadius.circular(15.0),
// // // // //                                   boxShadow: [
// // // // //                                     BoxShadow(
// // // // //                                       color: Colors.black.withOpacity(0.1),
// // // // //                                       blurRadius: 8,
// // // // //                                       spreadRadius: 1,
// // // // //                                     ),
// // // // //                                   ],
// // // // //                                 ),
// // // // //                                 child: Row(
// // // // //                                   children: [
// // // // //                                     Container(
// // // // //                                       width: 80,
// // // // //                                       height: 80,
// // // // //                                       decoration: BoxDecoration(
// // // // //                                         borderRadius: BorderRadius.circular(10),
// // // // //                                         color: Colors.grey.shade100,
// // // // //                                       ),
// // // // //                                       child: medicine['images'] != null &&
// // // // //                                               medicine['images'].isNotEmpty
// // // // //                                           ? ClipRRect(
// // // // //                                               borderRadius:
// // // // //                                                   BorderRadius.circular(10),
// // // // //                                               child: Image.network(
// // // // //                                                 medicine['images'][0],
// // // // //                                                 fit: BoxFit.cover,
// // // // //                                                 errorBuilder: (context, error,
// // // // //                                                         stackTrace) =>
// // // // //                                                     const Icon(
// // // // //                                                   Icons.medication_outlined,
// // // // //                                                   color: Colors.blue,
// // // // //                                                   size: 30,
// // // // //                                                 ),
// // // // //                                               ),
// // // // //                                             )
// // // // //                                           : const Icon(
// // // // //                                               Icons.medication_outlined,
// // // // //                                               color: Colors.blue,
// // // // //                                               size: 30,
// // // // //                                             ),
// // // // //                                     ),
// // // // //                                     const SizedBox(width: 16),
// // // // //                                     Expanded(
// // // // //                                       child: Column(
// // // // //                                         crossAxisAlignment:
// // // // //                                             CrossAxisAlignment.start,
// // // // //                                         children: [
// // // // //                                           Text(
// // // // //                                             medicine['name'] ??
// // // // //                                                 'Unknown Medicine',
// // // // //                                             style: const TextStyle(
// // // // //                                               fontSize: 16,
// // // // //                                               fontWeight: FontWeight.bold,
// // // // //                                             ),
// // // // //                                           ),
// // // // //                                           const SizedBox(height: 4),
// // // // //                                           Text(
// // // // //                                             'Rs. ${medicine['price'] ?? 'N/A'} (MRP: Rs. ${medicine['mrp'] ?? 'N/A'})',
// // // // //                                             style: TextStyle(
// // // // //                                               fontSize: 14,
// // // // //                                               color: Colors.green.shade700,
// // // // //                                               fontWeight: FontWeight.w600,
// // // // //                                             ),
// // // // //                                           ),
// // // // //                                           const SizedBox(height: 4),
// // // // //                                           Row(
// // // // //                                             children: [
// // // // //                                               const Icon(
// // // // //                                                 Icons.location_on_outlined,
// // // // //                                                 color: Colors.deepPurple,
// // // // //                                                 size: 16,
// // // // //                                               ),
// // // // //                                               Expanded(
// // // // //                                                 child: Text(
// // // // //                                                   medicine['pharmacy']?['name'] ??
// // // // //                                                       'Unknown Pharmacy',
// // // // //                                                   style: const TextStyle(
// // // // //                                                       fontSize: 12),
// // // // //                                                   overflow: TextOverflow.ellipsis,
// // // // //                                                 ),
// // // // //                                               ),
// // // // //                                             ],
// // // // //                                           ),
// // // // //                                         ],
// // // // //                                       ),
// // // // //                                     ),
// // // // //                                     IconButton(
// // // // //                                       icon: const Icon(Icons.arrow_forward_ios,
// // // // //                                           size: 16),
// // // // //                                       onPressed: () {
// // // // //                                         // Navigate to medicine details
// // // // //                                         // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ScannedMedicineScreen()));
// // // // //                                       },
// // // // //                                     ),
// // // // //                                   ],
// // // // //                                 ),
// // // // //                               ),
// // // // //                             );
// // // // //                           },
// // // // //                         )
// // // // //                       : _selectedImage != null && !_isProcessing
// // // // //                           ? const Center(
// // // // //                               child: Text(
// // // // //                                 'No medicines found.\nTry a clearer image.',
// // // // //                                 textAlign: TextAlign.center,
// // // // //                                 style: TextStyle(
// // // // //                                   color: Colors.grey,
// // // // //                                   fontSize: 16,
// // // // //                                 ),
// // // // //                               ),
// // // // //                             )
// // // // //                           : const SizedBox(),
// // // // //                 ),

// // // // //                 const SizedBox(height: 20),
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   // Helper method to create corners
// // // // //   Widget _buildCorner(Alignment alignment) {
// // // // //     return Align(
// // // // //       alignment: alignment,
// // // // //       child: Container(
// // // // //         width: 30,
// // // // //         height: 30,
// // // // //         decoration: BoxDecoration(
// // // // //           border: Border(
// // // // //             top: (alignment == Alignment.topLeft ||
// // // // //                     alignment == Alignment.topRight)
// // // // //                 ? const BorderSide(color: Colors.black, width: 3)
// // // // //                 : BorderSide.none,
// // // // //             bottom: (alignment == Alignment.bottomLeft ||
// // // // //                     alignment == Alignment.bottomRight)
// // // // //                 ? const BorderSide(color: Colors.black, width: 3)
// // // // //                 : BorderSide.none,
// // // // //             left: (alignment == Alignment.topLeft ||
// // // // //                     alignment == Alignment.bottomLeft)
// // // // //                 ? const BorderSide(color: Colors.black, width: 3)
// // // // //                 : BorderSide.none,
// // // // //             right: (alignment == Alignment.topRight ||
// // // // //                     alignment == Alignment.bottomRight)
// // // // //                 ? const BorderSide(color: Colors.black, width: 3)
// // // // //                 : BorderSide.none,
// // // // //           ),
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:image_picker/image_picker.dart';
// // // import 'package:image_cropper/image_cropper.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'package:medical_user_app/utils/shared_preferences_helper.dart';
// // // import 'dart:convert';
// // // import 'dart:ui';
// // // import 'dart:io';

// // // class PrescriptionUploadScreen extends StatefulWidget {
// // //   const PrescriptionUploadScreen({super.key});

// // //   @override
// // //   State<PrescriptionUploadScreen> createState() => _PrescriptionUploadScreenState();
// // // }

// // // class _PrescriptionUploadScreenState extends State<PrescriptionUploadScreen>
// // //     with SingleTickerProviderStateMixin {
// // //   File? _selectedImage;
// // //   File? _croppedImage;
// // //   final ImagePicker _imagePicker = ImagePicker();

// // //   bool _isProcessing = false;
// // //   bool _isUploading = false;

// // //   // Animation controller for the scanning line
// // //   late AnimationController _animationController;
// // //   late Animation<double> _animation;

// // //   @override
// // //   void initState() {
// // //     super.initState();

// // //     // Initialize animation controller
// // //     _animationController = AnimationController(
// // //       duration: const Duration(seconds: 2),
// // //       vsync: this,
// // //     )..repeat(reverse: true);

// // //     // Create animation that moves from top (0.0) to bottom (1.0) of container
// // //     _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _animationController.dispose();
// // //     super.dispose();
// // //   }

// // //   // Method to pick image from gallery
// // //   Future<void> _pickImageFromGallery() async {
// // //     try {
// // //       final XFile? pickedFile = await _imagePicker.pickImage(
// // //         source: ImageSource.gallery,
// // //         imageQuality: 90,
// // //         maxWidth: 2000,
// // //         maxHeight: 2000,
// // //       );

// // //       if (pickedFile != null) {
// // //         setState(() {
// // //           _selectedImage = File(pickedFile.path);
// // //           _croppedImage = null; // Reset cropped image
// // //         });

// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(
// // //             content: Text('Image selected successfully!'),
// // //             backgroundColor: Colors.green,
// // //             duration: Duration(seconds: 2),
// // //           ),
// // //         );

// // //         // Automatically open crop editor
// // //         await _cropImage();
// // //       }
// // //     } catch (e) {
// // //       _showError('Error picking image: $e');
// // //     }
// // //   }

// // //   // Method to take photo from camera
// // //   Future<void> _takePhotoFromCamera() async {
// // //     try {
// // //       final XFile? pickedFile = await _imagePicker.pickImage(
// // //         source: ImageSource.camera,
// // //         imageQuality: 90,
// // //         maxWidth: 2000,
// // //         maxHeight: 2000,
// // //         preferredCameraDevice: CameraDevice.rear,
// // //       );

// // //       if (pickedFile != null) {
// // //         setState(() {
// // //           _selectedImage = File(pickedFile.path);
// // //           _croppedImage = null; // Reset cropped image
// // //         });

// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(
// // //             content: Text('Photo captured successfully!'),
// // //             backgroundColor: Colors.green,
// // //             duration: Duration(seconds: 2),
// // //           ),
// // //         );

// // //         // Automatically open crop editor
// // //         await _cropImage();
// // //       }
// // //     } catch (e) {
// // //       _showError('Error taking photo: $e');
// // //     }
// // //   }

// // //   // Method to crop the selected image
// // //   Future<void> _cropImage() async {
// // //     if (_selectedImage == null) return;

// // //     try {
// // //       setState(() {
// // //         _isProcessing = true;
// // //       });

// // //       CroppedFile? croppedFile = await ImageCropper().cropImage(
// // //         sourcePath: _selectedImage!.path,
// // //         compressFormat: ImageCompressFormat.jpg,
// // //         compressQuality: 90,
// // //         uiSettings: [
// // //           AndroidUiSettings(
// // //             toolbarTitle: 'Crop Prescription',
// // //             toolbarColor: Colors.blue,
// // //             toolbarWidgetColor: Colors.white,
// // //             initAspectRatio: CropAspectRatioPreset.original,
// // //             lockAspectRatio: false,
// // //             aspectRatioPresets: [
// // //               CropAspectRatioPreset.original,
// // //               CropAspectRatioPreset.square,
// // //               CropAspectRatioPreset.ratio3x2,
// // //               CropAspectRatioPreset.ratio4x3,
// // //               CropAspectRatioPreset.ratio16x9
// // //             ],
// // //           ),
// // //           IOSUiSettings(
// // //             title: 'Crop Prescription',
// // //             doneButtonTitle: 'Done',
// // //             cancelButtonTitle: 'Cancel',
// // //             aspectRatioPresets: [
// // //               CropAspectRatioPreset.original,
// // //               CropAspectRatioPreset.square,
// // //               CropAspectRatioPreset.ratio3x2,
// // //               CropAspectRatioPreset.ratio4x3,
// // //               CropAspectRatioPreset.ratio16x9
// // //             ],
// // //           ),
// // //         ],
// // //       );

// // //       if (croppedFile != null) {
// // //         setState(() {
// // //           _croppedImage = File(croppedFile.path);
// // //         });

// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(
// // //             content: Text('Image cropped successfully!'),
// // //             backgroundColor: Colors.green,
// // //             duration: Duration(seconds: 2),
// // //           ),
// // //         );
// // //       }
// // //     } catch (e) {
// // //       _showError('Error cropping image: $e');
// // //     } finally {
// // //       setState(() {
// // //         _isProcessing = false;
// // //       });
// // //     }
// // //   }

// // //   // Method to upload prescription to API
// // //   Future<void> _uploadPrescription() async {
// // //     if (_croppedImage == null && _selectedImage == null) {
// // //       _showError('Please select and crop an image first');
// // //       return;
// // //     }

// // //     try {
// // //       setState(() {
// // //         _isUploading = true;
// // //       });

// // //       // Get user data from SharedPreferences
// // //       final user = await SharedPreferencesHelper.getUser();
// // //       if (user == null || user.id.isEmpty) {
// // //         _showError('User not found. Please login again.');
// // //         return;
// // //       }

// // //       // Use cropped image if available, otherwise use selected image
// // //       File imageToUpload = _croppedImage ?? _selectedImage!;

// // //       // Create multipart request
// // //       final uri = Uri.parse('https://api.simcurarx.com/api/users/sendprescription/${user.id}');
// // //       final request = http.MultipartRequest('POST', uri);

// // //       // Add the image file
// // //       final imageFile = await http.MultipartFile.fromPath(
// // //         'prescriptionFile',
// // //         imageToUpload.path,
// // //         filename: 'prescription_${DateTime.now().millisecondsSinceEpoch}.jpg',
// // //       );
// // //       request.files.add(imageFile);

// // //       // Add auth token if available
// // //       final token = await SharedPreferencesHelper.getToken();
// // //       if (token != null && token.isNotEmpty) {
// // //         request.headers['Authorization'] = 'Bearer $token';
// // //       }

// // //       print('Uploading prescription for user: ${user.id}');
// // //       print('Image path: ${imageToUpload.path}');
// // //       print('API URL: $uri');

// // //       // Send the request
// // //       final streamedResponse = await request.send();
// // //       final response = await http.Response.fromStream(streamedResponse);

// // //       print('Response status: ${response.statusCode}');
// // //       print('Response body: ${response.body}');

// // //       if (response.statusCode == 200 || response.statusCode == 201) {
// // //         // Success
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(
// // //             content: Text('Prescription uploaded successfully!'),
// // //             backgroundColor: Colors.green,
// // //             duration: Duration(seconds: 3),
// // //           ),
// // //         );

// // //         // Clear the images and go back or navigate to success page
// // //         setState(() {
// // //           _selectedImage = null;
// // //           _croppedImage = null;
// // //         });

// // //         // You can navigate to a success page or back to previous screen
// // //         Navigator.pop(context);
// // //       } else {
// // //         // Handle API error
// // //         try {
// // //           final errorData = json.decode(response.body);
// // //           _showError(errorData['message'] ?? 'Failed to upload prescription');
// // //         } catch (e) {
// // //           _showError('Failed to upload prescription. Status: ${response.statusCode}');
// // //         }
// // //       }
// // //     } catch (e) {
// // //       _showError('Network error: $e');
// // //       print('Upload error: $e');
// // //     } finally {
// // //       setState(() {
// // //         _isUploading = false;
// // //       });
// // //     }
// // //   }

// // //   void _showError(String message) {
// // //     ScaffoldMessenger.of(context).showSnackBar(
// // //       SnackBar(
// // //         content: Text(message),
// // //         backgroundColor: Colors.red,
// // //         duration: const Duration(seconds: 4),
// // //       ),
// // //     );
// // //   }

// // //   // Show options to take photo or pick from gallery
// // //   void _showImagePickerOptions() {
// // //     showModalBottomSheet(
// // //       context: context,
// // //       builder: (context) => SafeArea(
// // //         child: Column(
// // //           mainAxisSize: MainAxisSize.min,
// // //           children: [
// // //             const Padding(
// // //               padding: EdgeInsets.all(16),
// // //               child: Text(
// // //                 'Select Prescription Image',
// // //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
// // //               ),
// // //             ),
// // //             ListTile(
// // //               leading: const Icon(Icons.camera_alt),
// // //               title: const Text('Take Photo'),
// // //               subtitle: const Text('Capture prescription with camera'),
// // //               onTap: () {
// // //                 Navigator.pop(context);
// // //                 _takePhotoFromCamera();
// // //               },
// // //             ),
// // //             ListTile(
// // //               leading: const Icon(Icons.photo_library),
// // //               title: const Text('Choose from Gallery'),
// // //               subtitle: const Text('Select existing photo'),
// // //               onTap: () {
// // //                 Navigator.pop(context);
// // //                 _pickImageFromGallery();
// // //               },
// // //             ),
// // //             const SizedBox(height: 16),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: Stack(
// // //         children: [
// // //           // Background image
// // //           Positioned.fill(
// // //             child: Image.asset(
// // //               'assets/background_image.png',
// // //               fit: BoxFit.cover,
// // //             ),
// // //           ),

// // //           // Blur effect
// // //           Positioned.fill(
// // //             child: BackdropFilter(
// // //               filter: ImageFilter.blur(sigmaX: 83.6, sigmaY: 83.6),
// // //               child: Container(
// // //                 color: Colors.black.withOpacity(0),
// // //               ),
// // //             ),
// // //           ),

// // //           SafeArea(
// // //             child: Column(
// // //               children: [
// // //                 // Top toolbar
// // //                 const SizedBox(height: 30),
// // //                 Padding(
// // //                   padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
// // //                   child: Container(
// // //                     height: 44,
// // //                     width: 343,
// // //                     decoration: BoxDecoration(
// // //                       color: Colors.white,
// // //                       borderRadius: BorderRadius.circular(10),
// // //                     ),
// // //                     child: Row(
// // //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // //                       children: [
// // //                         IconButton(
// // //                           icon: const Icon(Icons.camera_alt, color: Colors.blue),
// // //                           onPressed: _takePhotoFromCamera,
// // //                           tooltip: 'Take Photo',
// // //                         ),
// // //                         IconButton(
// // //                           icon: const Icon(Icons.photo_library, color: Colors.purple),
// // //                           onPressed: _pickImageFromGallery,
// // //                           tooltip: 'Choose from Gallery',
// // //                         ),
// // //                         IconButton(
// // //                           icon: const Icon(Icons.crop, color: Colors.orange),
// // //                           onPressed: (_selectedImage != null || _croppedImage != null) ? _cropImage : null,
// // //                           tooltip: 'Crop Image',
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                 ),

// // //                 const SizedBox(height: 10.0),

// // //                 const Text(
// // //                   'Upload Prescription',
// // //                   style: TextStyle(
// // //                     fontSize: 22.0,
// // //                     fontWeight: FontWeight.bold,
// // //                     color: Colors.black87,
// // //                   ),
// // //                 ),

// // //                 const SizedBox(height: 20.0),

// // //                 // Image View Area
// // //                 Expanded(
// // //                   child: Padding(
// // //                     padding: const EdgeInsets.symmetric(horizontal: 24.0),
// // //                     child: GestureDetector(
// // //                       onTap: (_croppedImage == null && _selectedImage == null) ? _showImagePickerOptions : null,
// // //                       child: Container(
// // //                         width: double.infinity,
// // //                         decoration: BoxDecoration(
// // //                           color: Colors.white,
// // //                           borderRadius: BorderRadius.circular(20.0),
// // //                           border: Border.all(
// // //                             color: (_croppedImage != null || _selectedImage != null)
// // //                                 ? Colors.green.shade300
// // //                                 : Colors.grey.shade300,
// // //                             width: 2,
// // //                           ),
// // //                         ),
// // //                         child: Stack(
// // //                           alignment: Alignment.center,
// // //                           children: [
// // //                             // Display image if available
// // //                             if (_croppedImage != null || _selectedImage != null)
// // //                               ClipRRect(
// // //                                 borderRadius: BorderRadius.circular(18.0),
// // //                                 child: Image.file(
// // //                                   _croppedImage ?? _selectedImage!,
// // //                                   fit: BoxFit.contain,
// // //                                   width: double.infinity,
// // //                                   height: double.infinity,
// // //                                 ),
// // //                               )
// // //                             else
// // //                               Column(
// // //                                 mainAxisAlignment: MainAxisAlignment.center,
// // //                                 children: [
// // //                                   // Animated scanning line effect
// // //                                   AnimatedBuilder(
// // //                                     animation: _animation,
// // //                                     builder: (context, child) {
// // //                                       return Container(
// // //                                         width: 280,
// // //                                         height: 5,
// // //                                         margin: EdgeInsets.only(top: _animation.value * 50),
// // //                                         decoration: BoxDecoration(
// // //                                           gradient: LinearGradient(
// // //                                             colors: [
// // //                                               Colors.blueAccent.withOpacity(0.7),
// // //                                               Colors.blue.withOpacity(0.7)
// // //                                             ],
// // //                                           ),
// // //                                           boxShadow: [
// // //                                             BoxShadow(
// // //                                               color: Colors.blueAccent.withOpacity(0.5),
// // //                                               blurRadius: 12,
// // //                                               spreadRadius: 2,
// // //                                             ),
// // //                                           ],
// // //                                         ),
// // //                                       );
// // //                                     },
// // //                                   ),
// // //                                   const SizedBox(height: 40),
// // //                                   Icon(
// // //                                     Icons.description_outlined,
// // //                                     size: 60,
// // //                                     color: Colors.grey.shade400,
// // //                                   ),
// // //                                   const SizedBox(height: 16),
// // //                                   Text(
// // //                                     'Tap to capture prescription',
// // //                                     style: TextStyle(
// // //                                       color: Colors.grey.shade600,
// // //                                       fontSize: 16,
// // //                                     ),
// // //                                   ),
// // //                                   const SizedBox(height: 8),
// // //                                   Text(
// // //                                     'Take a clear photo of your prescription',
// // //                                     style: TextStyle(
// // //                                       color: Colors.grey.shade500,
// // //                                       fontSize: 12,
// // //                                     ),
// // //                                   ),
// // //                                 ],
// // //                               ),

// // //                             // Scanner corners (decorative)
// // //                             _buildCorner(Alignment.topLeft),
// // //                             _buildCorner(Alignment.topRight),
// // //                             _buildCorner(Alignment.bottomLeft),
// // //                             _buildCorner(Alignment.bottomRight),

// // //                             // Show processing indicator
// // //                             if (_isProcessing)
// // //                               Container(
// // //                                 color: Colors.black.withOpacity(0.7),
// // //                                 child: const Center(
// // //                                   child: Column(
// // //                                     mainAxisSize: MainAxisSize.min,
// // //                                     children: [
// // //                                       CircularProgressIndicator(color: Colors.white),
// // //                                       SizedBox(height: 16),
// // //                                       Text(
// // //                                         'Processing image...',
// // //                                         style: TextStyle(
// // //                                           color: Colors.white,
// // //                                           fontSize: 16,
// // //                                           fontWeight: FontWeight.w500,
// // //                                         ),
// // //                                       ),
// // //                                     ],
// // //                                   ),
// // //                                 ),
// // //                               ),

// // //                             // Show cropped indicator
// // //                             if (_croppedImage != null)
// // //                               Positioned(
// // //                                 top: 16,
// // //                                 right: 16,
// // //                                 child: Container(
// // //                                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// // //                                   decoration: BoxDecoration(
// // //                                     color: Colors.green.withOpacity(0.8),
// // //                                     borderRadius: BorderRadius.circular(12),
// // //                                   ),
// // //                                   child: const Row(
// // //                                     mainAxisSize: MainAxisSize.min,
// // //                                     children: [
// // //                                       Icon(Icons.crop, color: Colors.white, size: 16),
// // //                                       SizedBox(width: 4),
// // //                                       Text(
// // //                                         'Cropped',
// // //                                         style: TextStyle(
// // //                                           color: Colors.white,
// // //                                           fontSize: 12,
// // //                                           fontWeight: FontWeight.w500,
// // //                                         ),
// // //                                       ),
// // //                                     ],
// // //                                   ),
// // //                                 ),
// // //                               ),
// // //                           ],
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ),

// // //                 const SizedBox(height: 20.0),

// // //                 // Action buttons
// // //                 Padding(
// // //                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
// // //                   child: Row(
// // //                     children: [
// // //                       // Cancel button
// // //                       Expanded(
// // //                         child: SizedBox(
// // //                           height: 48,
// // //                           child: ElevatedButton(
// // //                             onPressed: () {
// // //                               Navigator.pop(context);
// // //                             },
// // //                             style: ElevatedButton.styleFrom(
// // //                               backgroundColor: Colors.white,
// // //                               foregroundColor: Colors.black87,
// // //                               shape: RoundedRectangleBorder(
// // //                                 borderRadius: BorderRadius.circular(8),
// // //                                 side: BorderSide(color: Colors.grey.shade300),
// // //                               ),
// // //                             ),
// // //                             child: const Text(
// // //                               'Cancel',
// // //                               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// // //                             ),
// // //                           ),
// // //                         ),
// // //                       ),

// // //                       const SizedBox(width: 16),

// // //                       // Submit button
// // //                       Expanded(
// // //                         flex: 2,
// // //                         child: SizedBox(
// // //                           height: 48,
// // //                           child: ElevatedButton(
// // //                             onPressed: (_croppedImage != null || _selectedImage != null) && !_isUploading
// // //                                 ? _uploadPrescription
// // //                                 : null,
// // //                             style: ElevatedButton.styleFrom(
// // //                               backgroundColor: Colors.blue,
// // //                               foregroundColor: Colors.white,
// // //                               shape: RoundedRectangleBorder(
// // //                                 borderRadius: BorderRadius.circular(8),
// // //                               ),
// // //                               disabledBackgroundColor: Colors.grey.shade300,
// // //                             ),
// // //                             child: _isUploading
// // //                                 ? const Row(
// // //                                     mainAxisAlignment: MainAxisAlignment.center,
// // //                                     children: [
// // //                                       SizedBox(
// // //                                         width: 20,
// // //                                         height: 20,
// // //                                         child: CircularProgressIndicator(
// // //                                           strokeWidth: 2,
// // //                                           valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
// // //                                         ),
// // //                                       ),
// // //                                       SizedBox(width: 8),
// // //                                       Text('Uploading...'),
// // //                                     ],
// // //                                   )
// // //                                 : const Text(
// // //                                     'Submit Prescription',
// // //                                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
// // //                                   ),
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),

// // //                 const SizedBox(height: 30),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   // Helper method to create corners
// // //   Widget _buildCorner(Alignment alignment) {
// // //     return Align(
// // //       alignment: alignment,
// // //       child: Container(
// // //         width: 30,
// // //         height: 30,
// // //         decoration: BoxDecoration(
// // //           border: Border(
// // //             top: (alignment == Alignment.topLeft || alignment == Alignment.topRight)
// // //                 ? const BorderSide(color: Colors.blue, width: 3)
// // //                 : BorderSide.none,
// // //             bottom: (alignment == Alignment.bottomLeft || alignment == Alignment.bottomRight)
// // //                 ? const BorderSide(color: Colors.blue, width: 3)
// // //                 : BorderSide.none,
// // //             left: (alignment == Alignment.topLeft || alignment == Alignment.bottomLeft)
// // //                 ? const BorderSide(color: Colors.blue, width: 3)
// // //                 : BorderSide.none,
// // //             right: (alignment == Alignment.topRight || alignment == Alignment.bottomRight)
// // //                 ? const BorderSide(color: Colors.blue, width: 3)
// // //                 : BorderSide.none,
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:medical_user_app/utils/shared_preferences_helper.dart';
// // import 'package:image/image.dart' as img;
// // import 'dart:convert';
// // import 'dart:ui';
// // import 'dart:io';

// // class PrescriptionUploadScreen extends StatefulWidget {
// //   const PrescriptionUploadScreen({super.key});

// //   @override
// //   State<PrescriptionUploadScreen> createState() => _PrescriptionUploadScreenState();
// // }

// // class _PrescriptionUploadScreenState extends State<PrescriptionUploadScreen>
// //     with SingleTickerProviderStateMixin {
// //   File? _selectedImage;
// //   File? _croppedImage;
// //   final ImagePicker _imagePicker = ImagePicker();

// //   bool _isProcessing = false;
// //   bool _isUploading = false;

// //   // Animation controller for the scanning line
// //   late AnimationController _animationController;
// //   late Animation<double> _animation;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _animationController = AnimationController(
// //       duration: const Duration(seconds: 2),
// //       vsync: this,
// //     )..repeat(reverse: true);
// //     _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
// //   }

// //   @override
// //   void dispose() {
// //     _animationController.dispose();
// //     super.dispose();
// //   }

// //   // Simple crop function using image package
// //   Future<File?> _cropImageToSquare(File imageFile) async {
// //     try {
// //       final bytes = await imageFile.readAsBytes();
// //       img.Image? originalImage = img.decodeImage(bytes);

// //       if (originalImage == null) return null;

// //       // Get the smaller dimension to make a square
// //       int size = originalImage.width < originalImage.height
// //           ? originalImage.width
// //           : originalImage.height;

// //       // Calculate center crop coordinates
// //       int x = (originalImage.width - size) ~/ 2;
// //       int y = (originalImage.height - size) ~/ 2;

// //       // Crop to square
// //       img.Image croppedImage = img.copyCrop(
// //         originalImage,
// //         x: x,
// //         y: y,
// //         width: size,
// //         height: size,
// //       );

// //       // Save the cropped image
// //       final tempDir = Directory.systemTemp;
// //       final croppedFile = File('${tempDir.path}/cropped_${DateTime.now().millisecondsSinceEpoch}.jpg');

// //       await croppedFile.writeAsBytes(img.encodeJpg(croppedImage, quality: 85));

// //       return croppedFile;
// //     } catch (e) {
// //       print('Error cropping image: $e');
// //       return null;
// //     }
// //   }

// //   // Alternative: Crop to document aspect ratio (4:3)
// //   Future<File?> _cropImageToDocument(File imageFile) async {
// //     try {
// //       final bytes = await imageFile.readAsBytes();
// //       img.Image? originalImage = img.decodeImage(bytes);

// //       if (originalImage == null) return null;

// //       const double aspectRatio = 4.0 / 3.0; // Document ratio
// //       int cropWidth, cropHeight;

// //       if (originalImage.width / originalImage.height > aspectRatio) {
// //         cropHeight = originalImage.height;
// //         cropWidth = (cropHeight * aspectRatio).round();
// //       } else {
// //         cropWidth = originalImage.width;
// //         cropHeight = (cropWidth / aspectRatio).round();
// //       }

// //       int x = (originalImage.width - cropWidth) ~/ 2;
// //       int y = (originalImage.height - cropHeight) ~/ 2;

// //       img.Image croppedImage = img.copyCrop(
// //         originalImage,
// //         x: x,
// //         y: y,
// //         width: cropWidth,
// //         height: cropHeight,
// //       );

// //       final tempDir = Directory.systemTemp;
// //       final croppedFile = File('${tempDir.path}/cropped_doc_${DateTime.now().millisecondsSinceEpoch}.jpg');

// //       await croppedFile.writeAsBytes(img.encodeJpg(croppedImage, quality: 85));

// //       return croppedFile;
// //     } catch (e) {
// //       print('Error cropping image: $e');
// //       return null;
// //     }
// //   }

// //   Future<void> _pickImageFromGallery() async {
// //     try {
// //       final XFile? pickedFile = await _imagePicker.pickImage(
// //         source: ImageSource.gallery,
// //         imageQuality: 90,
// //         maxWidth: 2000,
// //         maxHeight: 2000,
// //       );

// //       if (pickedFile != null && mounted) {
// //         setState(() {
// //           _selectedImage = File(pickedFile.path);
// //           _croppedImage = null;
// //         });

// //         if (mounted) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(
// //               content: Text('Image selected successfully!'),
// //               backgroundColor: Colors.green,
// //               duration: Duration(seconds: 2),
// //             ),
// //           );
// //         }
// //       }
// //     } catch (e) {
// //       if (mounted) {
// //         _showError('Error picking image: $e');
// //       }
// //     }
// //   }

// //   Future<void> _takePhotoFromCamera() async {
// //     try {
// //       final XFile? pickedFile = await _imagePicker.pickImage(
// //         source: ImageSource.camera,
// //         imageQuality: 90,
// //         maxWidth: 2000,
// //         maxHeight: 2000,
// //         preferredCameraDevice: CameraDevice.rear,
// //       );

// //       if (pickedFile != null && mounted) {
// //         setState(() {
// //           _selectedImage = File(pickedFile.path);
// //           _croppedImage = null;
// //         });

// //         if (mounted) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(
// //               content: Text('Photo captured successfully!'),
// //               backgroundColor: Colors.green,
// //               duration: Duration(seconds: 2),
// //             ),
// //           );
// //         }
// //       }
// //     } catch (e) {
// //       if (mounted) {
// //         _showError('Error taking photo: $e');
// //       }
// //     }
// //   }

// //   // Show crop options
// //   void _showCropOptions() {
// //     if (_selectedImage == null) return;

// //     showModalBottomSheet(
// //       context: context,
// //       builder: (context) => SafeArea(
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             const Padding(
// //               padding: EdgeInsets.all(16),
// //               child: Text(
// //                 'Crop Options',
// //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
// //               ),
// //             ),
// //             ListTile(
// //               leading: const Icon(Icons.crop_square),
// //               title: const Text('Square Crop'),
// //               subtitle: const Text('Crop to square shape'),
// //               onTap: () {
// //                 Navigator.pop(context);
// //                 _applyCrop(CropType.square);
// //               },
// //             ),
// //             ListTile(
// //               leading: const Icon(Icons.crop_landscape),
// //               title: const Text('Document Crop'),
// //               subtitle: const Text('Crop to document ratio (4:3)'),
// //               onTap: () {
// //                 Navigator.pop(context);
// //                 _applyCrop(CropType.document);
// //               },
// //             ),
// //             const SizedBox(height: 16),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Future<void> _applyCrop(CropType cropType) async {
// //     if (_selectedImage == null) return;

// //     setState(() {
// //       _isProcessing = true;
// //     });

// //     try {
// //       File? croppedFile;

// //       switch (cropType) {
// //         case CropType.square:
// //           croppedFile = await _cropImageToSquare(_selectedImage!);
// //           break;
// //         case CropType.document:
// //           croppedFile = await _cropImageToDocument(_selectedImage!);
// //           break;
// //       }

// //       if (croppedFile != null && mounted) {
// //         setState(() {
// //           _croppedImage = croppedFile;
// //         });

// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(
// //             content: Text('Image cropped successfully!'),
// //             backgroundColor: Colors.green,
// //             duration: Duration(seconds: 2),
// //           ),
// //         );
// //       } else if (mounted) {
// //         _showError('Failed to crop image');
// //       }
// //     } catch (e) {
// //       if (mounted) {
// //         _showError('Error cropping image: $e');
// //       }
// //     } finally {
// //       if (mounted) {
// //         setState(() {
// //           _isProcessing = false;
// //         });
// //       }
// //     }
// //   }

// //   Future<void> _uploadPrescription() async {
// //     if (_croppedImage == null && _selectedImage == null) {
// //       _showError('Please select an image first');
// //       return;
// //     }

// //     if (_isUploading) return;

// //     try {
// //       setState(() {
// //         _isUploading = true;
// //       });

// //       final user = await SharedPreferencesHelper.getUser();
// //       if (user == null || user.id.isEmpty) {
// //         _showError('User not found. Please login again.');
// //         return;
// //       }

// //       File imageToUpload = _croppedImage ?? _selectedImage!;

// //       final uri = Uri.parse('https://api.simcurarx.com/api/users/sendprescription/${user.id}');
// //       final request = http.MultipartRequest('POST', uri);

// //       final imageFile = await http.MultipartFile.fromPath(
// //         'prescriptionFile',
// //         imageToUpload.path,
// //         filename: 'prescription_${DateTime.now().millisecondsSinceEpoch}.jpg',
// //       );
// //       request.files.add(imageFile);

// //       final token = await SharedPreferencesHelper.getToken();
// //       if (token != null && token.isNotEmpty) {
// //         request.headers['Authorization'] = 'Bearer $token';
// //       }

// //       final streamedResponse = await request.send().timeout(
// //         const Duration(seconds: 30),
// //         onTimeout: () {
// //           throw Exception('Upload timeout. Please check your internet connection.');
// //         },
// //       );
// //       final response = await http.Response.fromStream(streamedResponse);

// //       if (mounted) {
// //         if (response.statusCode == 200 || response.statusCode == 201) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(
// //               content: Text('Prescription uploaded successfully!'),
// //               backgroundColor: Colors.green,
// //               duration: Duration(seconds: 3),
// //             ),
// //           );

// //           setState(() {
// //             _selectedImage = null;
// //             _croppedImage = null;
// //           });

// //           Navigator.pop(context);
// //         } else {
// //           try {
// //             final errorData = json.decode(response.body);
// //             _showError(errorData['message'] ?? 'Failed to upload prescription');
// //           } catch (e) {
// //             _showError('Failed to upload prescription. Status: ${response.statusCode}');
// //           }
// //         }
// //       }
// //     } catch (e) {
// //       if (mounted) {
// //         _showError('Network error: $e');
// //       }
// //     } finally {
// //       if (mounted) {
// //         setState(() {
// //           _isUploading = false;
// //         });
// //       }
// //     }
// //   }

// //   void _showError(String message) {
// //     if (mounted) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text(message),
// //           backgroundColor: Colors.red,
// //           duration: const Duration(seconds: 4),
// //         ),
// //       );
// //     }
// //   }

// //   void _showImagePickerOptions() {
// //     showModalBottomSheet(
// //       context: context,
// //       builder: (context) => SafeArea(
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             const Padding(
// //               padding: EdgeInsets.all(16),
// //               child: Text(
// //                 'Select Prescription Image',
// //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
// //               ),
// //             ),
// //             ListTile(
// //               leading: const Icon(Icons.camera_alt),
// //               title: const Text('Take Photo'),
// //               subtitle: const Text('Capture prescription with camera'),
// //               onTap: () {
// //                 Navigator.pop(context);
// //                 _takePhotoFromCamera();
// //               },
// //             ),
// //             ListTile(
// //               leading: const Icon(Icons.photo_library),
// //               title: const Text('Choose from Gallery'),
// //               subtitle: const Text('Select existing photo'),
// //               onTap: () {
// //                 Navigator.pop(context);
// //                 _pickImageFromGallery();
// //               },
// //             ),
// //             const SizedBox(height: 16),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildCorner(Alignment alignment) {
// //     return Positioned(
// //       top: alignment.y < 0 ? 20 : null,
// //       bottom: alignment.y > 0 ? 20 : null,
// //       left: alignment.x < 0 ? 20 : null,
// //       right: alignment.x > 0 ? 20 : null,
// //       child: Container(
// //         width: 25,
// //         height: 25,
// //         decoration: BoxDecoration(
// //           border: Border(
// //             top: alignment.y <= 0
// //                 ? BorderSide(color: Colors.blue.shade600, width: 3)
// //                 : BorderSide.none,
// //             bottom: alignment.y >= 0
// //                 ? BorderSide(color: Colors.blue.shade600, width: 3)
// //                 : BorderSide.none,
// //             left: alignment.x <= 0
// //                 ? BorderSide(color: Colors.blue.shade600, width: 3)
// //                 : BorderSide.none,
// //             right: alignment.x >= 0
// //                 ? BorderSide(color: Colors.blue.shade600, width: 3)
// //                 : BorderSide.none,
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Stack(
// //         children: [
// //           Positioned.fill(
// //             child: Image.asset(
// //               'assets/background_image.png',
// //               fit: BoxFit.cover,
// //             ),
// //           ),
// //           Positioned.fill(
// //             child: BackdropFilter(
// //               filter: ImageFilter.blur(sigmaX: 83.6, sigmaY: 83.6),
// //               child: Container(
// //                 color: Colors.black.withOpacity(0),
// //               ),
// //             ),
// //           ),
// //           SafeArea(
// //             child: Column(
// //               children: [
// //                 const SizedBox(height: 30),
// //                 Padding(
// //                   padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
// //                   child: Container(
// //                     height: 44,
// //                     width: 343,
// //                     decoration: BoxDecoration(
// //                       color: Colors.white,
// //                       borderRadius: BorderRadius.circular(10),
// //                     ),
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                       children: [
// //                         IconButton(
// //                           icon: const Icon(Icons.camera_alt, color: Colors.blue),
// //                           onPressed: _takePhotoFromCamera,
// //                           tooltip: 'Take Photo',
// //                         ),
// //                         IconButton(
// //                           icon: const Icon(Icons.photo_library, color: Colors.purple),
// //                           onPressed: _pickImageFromGallery,
// //                           tooltip: 'Choose from Gallery',
// //                         ),
// //                         IconButton(
// //                           icon: const Icon(Icons.crop, color: Colors.orange),
// //                           onPressed: (_selectedImage != null && !_isProcessing) ? _showCropOptions : null,
// //                           tooltip: 'Crop Image',
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(height: 10.0),
// //                 const Text(
// //                   'Upload Prescription',
// //                   style: TextStyle(
// //                     fontSize: 22.0,
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.black87,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 20.0),
// //                 Expanded(
// //                   child: Padding(
// //                     padding: const EdgeInsets.symmetric(horizontal: 24.0),
// //                     child: GestureDetector(
// //                       onTap: (_croppedImage == null && _selectedImage == null && !_isProcessing)
// //                           ? _showImagePickerOptions : null,
// //                       child: Container(
// //                         width: double.infinity,
// //                         decoration: BoxDecoration(
// //                           color: Colors.white,
// //                           borderRadius: BorderRadius.circular(20.0),
// //                           border: Border.all(
// //                             color: (_croppedImage != null || _selectedImage != null)
// //                                 ? Colors.green.shade300
// //                                 : Colors.grey.shade300,
// //                             width: 2,
// //                           ),
// //                         ),
// //                         child: Stack(
// //                           alignment: Alignment.center,
// //                           children: [
// //                             if (_croppedImage != null || _selectedImage != null)
// //                               ClipRRect(
// //                                 borderRadius: BorderRadius.circular(18.0),
// //                                 child: Image.file(
// //                                   _croppedImage ?? _selectedImage!,
// //                                   fit: BoxFit.contain,
// //                                   width: double.infinity,
// //                                   height: double.infinity,
// //                                 ),
// //                               )
// //                             else
// //                               Column(
// //                                 mainAxisAlignment: MainAxisAlignment.center,
// //                                 children: [
// //                                   AnimatedBuilder(
// //                                     animation: _animation,
// //                                     builder: (context, child) {
// //                                       return Container(
// //                                         width: 280,
// //                                         height: 5,
// //                                         margin: EdgeInsets.only(top: _animation.value * 50),
// //                                         decoration: BoxDecoration(
// //                                           gradient: LinearGradient(
// //                                             colors: [
// //                                               Colors.blueAccent.withOpacity(0.7),
// //                                               Colors.blue.withOpacity(0.7)
// //                                             ],
// //                                           ),
// //                                           boxShadow: [
// //                                             BoxShadow(
// //                                               color: Colors.blueAccent.withOpacity(0.5),
// //                                               blurRadius: 12,
// //                                               spreadRadius: 2,
// //                                             ),
// //                                           ],
// //                                         ),
// //                                       );
// //                                     },
// //                                   ),
// //                                   const SizedBox(height: 40),
// //                                   Icon(
// //                                     Icons.description_outlined,
// //                                     size: 60,
// //                                     color: Colors.grey.shade400,
// //                                   ),
// //                                   const SizedBox(height: 16),
// //                                   Text(
// //                                     'Tap to capture prescription',
// //                                     style: TextStyle(
// //                                       color: Colors.grey.shade600,
// //                                       fontSize: 16,
// //                                     ),
// //                                   ),
// //                                   const SizedBox(height: 8),
// //                                   Text(
// //                                     'Take a clear photo of your prescription',
// //                                     style: TextStyle(
// //                                       color: Colors.grey.shade500,
// //                                       fontSize: 12,
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),

// //                             _buildCorner(Alignment.topLeft),
// //                             _buildCorner(Alignment.topRight),
// //                             _buildCorner(Alignment.bottomLeft),
// //                             _buildCorner(Alignment.bottomRight),

// //                             if (_isProcessing)
// //                               Container(
// //                                 color: Colors.black.withOpacity(0.7),
// //                                 child: const Center(
// //                                   child: Column(
// //                                     mainAxisSize: MainAxisSize.min,
// //                                     children: [
// //                                       CircularProgressIndicator(color: Colors.white),
// //                                       SizedBox(height: 16),
// //                                       Text(
// //                                         'Processing image...',
// //                                         style: TextStyle(
// //                                           color: Colors.white,
// //                                           fontSize: 16,
// //                                           fontWeight: FontWeight.w500,
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ),

// //                             if (_croppedImage != null)
// //                               Positioned(
// //                                 top: 16,
// //                                 right: 16,
// //                                 child: Container(
// //                                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //                                   decoration: BoxDecoration(
// //                                     color: Colors.green.withOpacity(0.8),
// //                                     borderRadius: BorderRadius.circular(12),
// //                                   ),
// //                                   child: const Row(
// //                                     mainAxisSize: MainAxisSize.min,
// //                                     children: [
// //                                       Icon(Icons.crop, color: Colors.white, size: 16),
// //                                       SizedBox(width: 4),
// //                                       Text(
// //                                         'Cropped',
// //                                         style: TextStyle(
// //                                           color: Colors.white,
// //                                           fontSize: 12,
// //                                           fontWeight: FontWeight.w500,
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(height: 20.0),
// //                 Padding(
// //                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
// //                   child: Row(
// //                     children: [
// //                       Expanded(
// //                         child: SizedBox(
// //                           height: 48,
// //                           child: ElevatedButton(
// //                             onPressed: () {
// //                               Navigator.pop(context);
// //                             },
// //                             style: ElevatedButton.styleFrom(
// //                               backgroundColor: Colors.white,
// //                               foregroundColor: Colors.black87,
// //                               shape: RoundedRectangleBorder(
// //                                 borderRadius: BorderRadius.circular(8),
// //                                 side: BorderSide(color: Colors.grey.shade300),
// //                               ),
// //                             ),
// //                             child: const Text(
// //                               'Cancel',
// //                               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                       const SizedBox(width: 16),
// //                       Expanded(
// //                         child: SizedBox(
// //                           height: 48,
// //                           child: ElevatedButton(
// //                             onPressed: (_croppedImage != null || _selectedImage != null) && !_isUploading
// //                                 ? _uploadPrescription
// //                                 : null,
// //                             style: ElevatedButton.styleFrom(
// //                               backgroundColor: Colors.blue.shade600,
// //                               foregroundColor: Colors.white,
// //                               shape: RoundedRectangleBorder(
// //                                 borderRadius: BorderRadius.circular(8),
// //                               ),
// //                               disabledBackgroundColor: Colors.grey.shade300,
// //                             ),
// //                             child: _isUploading
// //                                 ? const SizedBox(
// //                                     width: 20,
// //                                     height: 20,
// //                                     child: CircularProgressIndicator(
// //                                       color: Colors.white,
// //                                       strokeWidth: 2,
// //                                     ),
// //                                   )
// //                                 : const Text(
// //                                     'Upload',
// //                                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //                                   ),
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 const SizedBox(height: 30),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // enum CropType { square, document }

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:medical_user_app/utils/shared_preferences_helper.dart';
// import 'package:medical_user_app/widgets/cropper_image_widget.dart';
// import 'dart:convert';
// import 'dart:ui';
// import 'dart:io';
// // import 'cropper_screen.dart'; // Import the new cropper screen

// class PrescriptionUploadScreen extends StatefulWidget {
//   const PrescriptionUploadScreen({super.key});

//   @override
//   State<PrescriptionUploadScreen> createState() => _PrescriptionUploadScreenState();
// }

// class _PrescriptionUploadScreenState extends State<PrescriptionUploadScreen>
//     with SingleTickerProviderStateMixin {
//   File? _selectedImage;
//   final ImagePicker _imagePicker = ImagePicker();

//   bool _isUploading = false;

//   // Animation controller for the scanning line
//   late AnimationController _animationController;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     )..repeat(reverse: true);
//     _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickImageFromGallery() async {
//     try {
//       final XFile? pickedFile = await _imagePicker.pickImage(
//         source: ImageSource.gallery,
//         imageQuality: 90,
//         maxWidth: 2000,
//         maxHeight: 2000,
//       );

//       if (pickedFile != null && mounted) {
//         _navigateToCropper(File(pickedFile.path));
//       }
//     } catch (e) {
//       if (mounted) {
//         _showError('Error picking image: $e');
//       }
//     }
//   }

//   Future<void> _takePhotoFromCamera() async {
//     try {
//       final XFile? pickedFile = await _imagePicker.pickImage(
//         source: ImageSource.camera,
//         imageQuality: 90,
//         maxWidth: 2000,
//         maxHeight: 2000,
//         preferredCameraDevice: CameraDevice.rear,
//       );

//       if (pickedFile != null && mounted) {
//         _navigateToCropper(File(pickedFile.path));
//       }
//     } catch (e) {
//       if (mounted) {
//         _showError('Error taking photo: $e');
//       }
//     }
//   }

//   void _navigateToCropper(File imageFile) async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => CropperScreen(imageFile: imageFile),
//       ),
//     );

//     // If a cropped image is returned, use it
//     if (result != null && result is File) {
//       setState(() {
//         _selectedImage = result;
//       });

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Image processed successfully!'),
//             backgroundColor: Colors.green,
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//     }
//   }

//   Future<void> _uploadPrescription() async {
//     if (_selectedImage == null) {
//       _showError('Please select an image first');
//       return;
//     }

//     if (_isUploading) return;

//     try {
//       setState(() {
//         _isUploading = true;
//       });

//       final user = await SharedPreferencesHelper.getUser();
//       if (user == null || user.id.isEmpty) {
//         _showError('User not found. Please login again.');
//         return;
//       }

//       final uri = Uri.parse('https://api.simcurarx.com/api/users/sendprescription/${user.id}');
//       final request = http.MultipartRequest('POST', uri);

//       final imageFile = await http.MultipartFile.fromPath(
//         'prescriptionFile',
//         _selectedImage!.path,
//         filename: 'prescription_${DateTime.now().millisecondsSinceEpoch}.jpg',
//       );
//       request.files.add(imageFile);

//       final token = await SharedPreferencesHelper.getToken();
//       if (token != null && token.isNotEmpty) {
//         request.headers['Authorization'] = 'Bearer $token';
//       }

//       final streamedResponse = await request.send().timeout(
//         const Duration(seconds: 30),
//         onTimeout: () {
//           throw Exception('Upload timeout. Please check your internet connection.');
//         },
//       );
//       final response = await http.Response.fromStream(streamedResponse);

//       if (mounted) {
//         if (response.statusCode == 200 || response.statusCode == 201) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Prescription uploaded successfully!'),
//               backgroundColor: Colors.green,
//               duration: Duration(seconds: 3),
//             ),
//           );

//           setState(() {
//             _selectedImage = null;
//           });

//           Navigator.pop(context);
//         } else {
//           try {
//             final errorData = json.decode(response.body);
//             _showError(errorData['message'] ?? 'Failed to upload prescription');
//           } catch (e) {
//             _showError('Failed to upload prescription. Status: ${response.statusCode}');
//           }
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         _showError('Network error: $e');
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isUploading = false;
//         });
//       }
//     }
//   }

//   void _showError(String message) {
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(message),
//           backgroundColor: Colors.red,
//           duration: const Duration(seconds: 4),
//         ),
//       );
//     }
//   }

//   void _showImagePickerOptions() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Padding(
//               padding: EdgeInsets.all(16),
//               child: Text(
//                 'Select Prescription Image',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.camera_alt),
//               title: const Text('Take Photo'),
//               subtitle: const Text('Capture prescription with camera'),
//               onTap: () {
//                 Navigator.pop(context);
//                 _takePhotoFromCamera();
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.photo_library),
//               title: const Text('Choose from Gallery'),
//               subtitle: const Text('Select existing photo'),
//               onTap: () {
//                 Navigator.pop(context);
//                 _pickImageFromGallery();
//               },
//             ),
//             const SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCorner(Alignment alignment) {
//     return Positioned(
//       top: alignment.y < 0 ? 20 : null,
//       bottom: alignment.y > 0 ? 20 : null,
//       left: alignment.x < 0 ? 20 : null,
//       right: alignment.x > 0 ? 20 : null,
//       child: Container(
//         width: 25,
//         height: 25,
//         decoration: BoxDecoration(
//           border: Border(
//             top: alignment.y <= 0
//                 ? BorderSide(color: Colors.blue.shade600, width: 3)
//                 : BorderSide.none,
//             bottom: alignment.y >= 0
//                 ? BorderSide(color: Colors.blue.shade600, width: 3)
//                 : BorderSide.none,
//             left: alignment.x <= 0
//                 ? BorderSide(color: Colors.blue.shade600, width: 3)
//                 : BorderSide.none,
//             right: alignment.x >= 0
//                 ? BorderSide(color: Colors.blue.shade600, width: 3)
//                 : BorderSide.none,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Image.asset(
//               'assets/background_image.png',
//               fit: BoxFit.cover,
//             ),
//           ),
//           Positioned.fill(
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 83.6, sigmaY: 83.6),
//               child: Container(
//                 color: Colors.black.withOpacity(0),
//               ),
//             ),
//           ),
//           SafeArea(
//             child: Column(
//               children: [
//                 const SizedBox(height: 30),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
//                   child: Container(
//                     height: 44,
//                     width: 343,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.camera_alt, color: Colors.blue),
//                           onPressed: _takePhotoFromCamera,
//                           tooltip: 'Take Photo',
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.photo_library, color: Colors.purple),
//                           onPressed: _pickImageFromGallery,
//                           tooltip: 'Choose from Gallery',
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.crop, color: Colors.orange),
//                           onPressed: _selectedImage != null
//                               ? () => _navigateToCropper(_selectedImage!)
//                               : null,
//                           tooltip: 'Crop Image',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10.0),
//                 const Text(
//                   'Upload Prescription',
//                   style: TextStyle(
//                     fontSize: 22.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 20.0),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                     child: GestureDetector(
//                       onTap: _selectedImage == null ? _showImagePickerOptions : null,
//                       child: Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20.0),
//                           border: Border.all(
//                             color: _selectedImage != null
//                                 ? Colors.green.shade300
//                                 : Colors.grey.shade300,
//                             width: 2,
//                           ),
//                         ),
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             if (_selectedImage != null)
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(18.0),
//                                 child: Image.file(
//                                   _selectedImage!,
//                                   fit: BoxFit.contain,
//                                   width: double.infinity,
//                                   height: double.infinity,
//                                 ),
//                               )
//                             else
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   AnimatedBuilder(
//                                     animation: _animation,
//                                     builder: (context, child) {
//                                       return Container(
//                                         width: 280,
//                                         height: 5,
//                                         margin: EdgeInsets.only(top: _animation.value * 50),
//                                         decoration: BoxDecoration(
//                                           gradient: LinearGradient(
//                                             colors: [
//                                               Colors.blueAccent.withOpacity(0.7),
//                                               Colors.blue.withOpacity(0.7)
//                                             ],
//                                           ),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: Colors.blueAccent.withOpacity(0.5),
//                                               blurRadius: 12,
//                                               spreadRadius: 2,
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                   const SizedBox(height: 40),
//                                   Icon(
//                                     Icons.description_outlined,
//                                     size: 60,
//                                     color: Colors.grey.shade400,
//                                   ),
//                                   const SizedBox(height: 16),
//                                   Text(
//                                     'Tap to capture prescription',
//                                     style: TextStyle(
//                                       color: Colors.grey.shade600,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 8),
//                                   Text(
//                                     'Take a clear photo of your prescription',
//                                     style: TextStyle(
//                                       color: Colors.grey.shade500,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 ],
//                               ),

//                             _buildCorner(Alignment.topLeft),
//                             _buildCorner(Alignment.topRight),
//                             _buildCorner(Alignment.bottomLeft),
//                             _buildCorner(Alignment.bottomRight),

//                             if (_selectedImage != null)
//                               Positioned(
//                                 top: 16,
//                                 right: 16,
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                                   decoration: BoxDecoration(
//                                     color: Colors.green.withOpacity(0.8),
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   child: const Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Icon(Icons.check_circle, color: Colors.white, size: 16),
//                                       SizedBox(width: 4),
//                                       Text(
//                                         'Ready',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20.0),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: SizedBox(
//                           height: 48,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.white,
//                               foregroundColor: Colors.black87,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                                 side: BorderSide(color: Colors.grey.shade300),
//                               ),
//                             ),
//                             child: const Text(
//                               'Cancel',
//                               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: SizedBox(
//                           height: 48,
//                           child: ElevatedButton(
//                             onPressed: _selectedImage != null && !_isUploading
//                                 ? _uploadPrescription
//                                 : null,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.blue.shade600,
//                               foregroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               disabledBackgroundColor: Colors.grey.shade300,
//                             ),
//                             child: _isUploading
//                                 ? const SizedBox(
//                                     width: 20,
//                                     height: 20,
//                                     child: CircularProgressIndicator(
//                                       color: Colors.white,
//                                       strokeWidth: 2,
//                                     ),
//                                   )
//                                 : const Text(
//                                     'Upload',
//                                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                                   ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/utils/shared_preferences_helper.dart';
import 'package:medical_user_app/widgets/cropper_image_widget.dart';
import 'dart:convert';
import 'dart:ui';
import 'dart:io';

class PrescriptionUploadScreen extends StatefulWidget {
  const PrescriptionUploadScreen({super.key});

  @override
  State<PrescriptionUploadScreen> createState() =>
      _PrescriptionUploadScreenState();
}

class _PrescriptionUploadScreenState extends State<PrescriptionUploadScreen>
    with SingleTickerProviderStateMixin {
  File? _selectedImage;
  final ImagePicker _imagePicker = ImagePicker();
  final TextEditingController _notesController = TextEditingController();

  bool _isUploading = false;

  // Animation controller for the scanning line
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
        maxWidth: 2000,
        maxHeight: 2000,
      );

      if (pickedFile != null && mounted) {
        _navigateToCropper(File(pickedFile.path));
      }
    } catch (e) {
      if (mounted) {
        _showError('Error picking image: $e');
      }
    }
  }

  Future<void> _takePhotoFromCamera() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 90,
        maxWidth: 2000,
        maxHeight: 2000,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (pickedFile != null && mounted) {
        _navigateToCropper(File(pickedFile.path));
      }
    } catch (e) {
      if (mounted) {
        _showError('Error taking photo: $e');
      }
    }
  }

  void _navigateToCropper(File imageFile) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CropperScreen(imageFile: imageFile),
      ),
    );

    // If a cropped image is returned, use it
    if (result != null && result is File) {
      setState(() {
        _selectedImage = result;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image processed successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> _uploadPrescription() async {
    if (_selectedImage == null) {
      _showError('Please select an image first');
      return;
    }

    if (_isUploading) return;

    try {
      setState(() {
        _isUploading = true;
      });

      final user = await SharedPreferencesHelper.getUser();
      if (user == null || user.id.isEmpty) {
        _showError('User not found. Please login again.');
        return;
      }

      final uri = Uri.parse(
          'https://api.simcurarx.com/api/users/sendprescription/${user.id}');
      final request = http.MultipartRequest('POST', uri);

      final imageFile = await http.MultipartFile.fromPath(
        'prescriptionFile',
        _selectedImage!.path,
        filename: 'prescription_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      request.files.add(imageFile);

      // Add notes field if there's any text
      if (_notesController.text.isNotEmpty) {
        request.fields['notes'] = _notesController.text.trim();
      }

      final token = await SharedPreferencesHelper.getToken();
      if (token != null && token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception(
              'Upload timeout. Please check your internet connection.');
        },
      );
      final response = await http.Response.fromStream(streamedResponse);

      if (mounted) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Prescription uploaded successfully!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            ),
          );

          setState(() {
            _selectedImage = null;
            _notesController.clear();
          });

          Navigator.pop(context);
        } else {
          try {
            final errorData = json.decode(response.body);
            _showError(errorData['message'] ?? 'Failed to upload prescription');
          } catch (e) {
            _showError(
                'Failed to upload prescription. Status: ${response.statusCode}');
          }
        }
      }
    } catch (e) {
      if (mounted) {
        _showError('Network error: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Select Prescription Image',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              subtitle: const Text('Capture prescription with camera'),
              onTap: () {
                Navigator.pop(context);
                _takePhotoFromCamera();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              subtitle: const Text('Select existing photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromGallery();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildCorner(Alignment alignment) {
    return Positioned(
      top: alignment.y < 0 ? 20 : null,
      bottom: alignment.y > 0 ? 20 : null,
      left: alignment.x < 0 ? 20 : null,
      right: alignment.x > 0 ? 20 : null,
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          border: Border(
            top: alignment.y <= 0
                ? BorderSide(color: Colors.blue.shade600, width: 3)
                : BorderSide.none,
            bottom: alignment.y >= 0
                ? BorderSide(color: Colors.blue.shade600, width: 3)
                : BorderSide.none,
            left: alignment.x <= 0
                ? BorderSide(color: Colors.blue.shade600, width: 3)
                : BorderSide.none,
            right: alignment.x >= 0
                ? BorderSide(color: Colors.blue.shade600, width: 3)
                : BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background_image.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 83.6, sigmaY: 83.6),
              child: Container(
                color: Colors.black.withOpacity(0),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 12.0),
                  child: Container(
                    height: 44,
                    width: 343,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.camera_alt, color: Colors.blue),
                          onPressed: _takePhotoFromCamera,
                          tooltip: 'Take Photo',
                        ),
                        IconButton(
                          icon: const Icon(Icons.photo_library,
                              color: Colors.purple),
                          onPressed: _pickImageFromGallery,
                          tooltip: 'Choose from Gallery',
                        ),
                        IconButton(
                          icon: const Icon(Icons.crop, color: Colors.orange),
                          onPressed: _selectedImage != null
                              ? () => _navigateToCropper(_selectedImage!)
                              : null,
                          tooltip: 'Crop Image',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Upload Prescription',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: GestureDetector(
                      onTap: _selectedImage == null
                          ? _showImagePickerOptions
                          : null,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: _selectedImage != null
                                ? Colors.green.shade300
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            if (_selectedImage != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(18.0),
                                child: Image.file(
                                  _selectedImage!,
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              )
                            else
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedBuilder(
                                    animation: _animation,
                                    builder: (context, child) {
                                      return Container(
                                        width: 280,
                                        height: 5,
                                        margin: EdgeInsets.only(
                                            top: _animation.value * 50),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.blueAccent
                                                  .withOpacity(0.7),
                                              Colors.blue.withOpacity(0.7)
                                            ],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.blueAccent
                                                  .withOpacity(0.5),
                                              blurRadius: 12,
                                              spreadRadius: 2,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 40),
                                  Icon(
                                    Icons.description_outlined,
                                    size: 60,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Tap to capture prescription',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Take a clear photo of your prescription',
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            _buildCorner(Alignment.topLeft),
                            _buildCorner(Alignment.topRight),
                            _buildCorner(Alignment.bottomLeft),
                            _buildCorner(Alignment.bottomRight),
                            if (_selectedImage != null)
                              Positioned(
                                top: 16,
                                right: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.check_circle,
                                          color: Colors.white, size: 16),
                                      SizedBox(width: 4),
                                      Text(
                                        'Ready',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                // Notes TextField
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextField(
                    controller: _notesController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Add notes (optional)',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Colors.blue.shade600, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black87,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _selectedImage != null && !_isUploading
                                ? _uploadPrescription
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade600,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              disabledBackgroundColor: Colors.grey.shade300,
                            ),
                            child: _isUploading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'Upload',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
