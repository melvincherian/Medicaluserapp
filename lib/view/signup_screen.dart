
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:medical_user_app/view/otp_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:medical_user_app/providers/auth_provider.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final nameController = TextEditingController();
//   final mobileController = TextEditingController();
//   final invitationController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
  
//   bool _isValidName = false;
//   bool _isValidMobile = false;

//   @override
//   void initState() {
//     super.initState();
//     nameController.addListener(_validateForm);
//     mobileController.addListener(_validateForm);
    
//     // Listen to auth state changes
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final authProvider = Provider.of<AuthProvider>(context, listen: false);
//       // authProvider.addListener(_handleAuthStateChange);
//     });
//   }

//   void _validateForm() {
//     setState(() {
//       _isValidName = nameController.text.trim().length >= 2;
//       _isValidMobile = mobileController.text.length == 10;
//     });
//   }
//   @override
//   void dispose() {
//     nameController.removeListener(_validateForm);
//     mobileController.removeListener(_validateForm);
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     // authProvider.removeListener(_handleAuthStateChange);
//     nameController.dispose();
//     mobileController.dispose();
//     invitationController.dispose();
//     super.dispose();
//   }

//   bool get _isFormValid => _isValidName && _isValidMobile;

// Future<void> _handleSignup() async {
//   if (!_formKey.currentState!.validate()) {
//     return;
//   }

//   final authProvider = Provider.of<AuthProvider>(context, listen: false);

//   try {
//     await authProvider.register(
//       name: nameController.text.trim(),
//       mobile: mobileController.text.trim(),
//     );

//     // Wait a bit for the state to update
//     // await Future.delayed(const Duration(milliseconds: 100));

//     if (mounted) {
//       if (authProvider.status == AuthStatus.authenticated) {
//         _showSuccessSnackBar('Registration successful! OTP sent to your mobile.');
        
//         // Navigate to OTP screen instead of Login screen
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => OtpScreen(phoneNumber: mobileController.text,)),
//         );
        
//       } else if (authProvider.status == AuthStatus.error) {
//         String errorMessage = 'Registration failed. Please try again.';
        
//         // Check for specific error messages
//         if (authProvider.errorMessage?.isNotEmpty == true) {
//           errorMessage = authProvider.errorMessage!;
          
//           // Handle common error cases
//           if (errorMessage.toLowerCase().contains('already') || 
//               errorMessage.toLowerCase().contains('exists')) {
//             errorMessage = 'User already registered with this mobile number.';
//           }
//         }
        
//         _showErrorSnackBar(errorMessage);
        
//         // Debug print for APK debugging
//         print('Registration Error: $errorMessage');
//       } else {
//         // Handle case where status is not clear
//         _showErrorSnackBar('Registration failed. Please check your details and try again.');
//       }
//     }
//   } catch (e) {
//     if (mounted) {
//       String errorMessage = 'An unexpected error occurred. Please try again.';
      
//       // Handle specific exceptions
//       if (e.toString().contains('already') || e.toString().contains('exists')) {
//         errorMessage = 'User already registered with this mobile number.';
//       }
      
//       _showErrorSnackBar(errorMessage);
      
//       // Debug print for APK debugging
//       print('Registration Exception: ${e.toString()}');
//     }
//   }
// }



//   void _showErrorSnackBar(String message) {
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//       const  SnackBar(
//           content: Text('User already Registered'),
//           // content: Text(message),
//           backgroundColor: Colors.red,
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//     }
//   }

//   void _showSuccessSnackBar(String message) {
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(message),
//           backgroundColor: Colors.green,
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//     }
//   }

//   void _showComingSoonDialog(String feature) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(feature),
//           content: Text('$feature is coming soon!'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text(
//                 'OK',
//                 style: TextStyle(color: Color(0xFF5E35B1)),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Back',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 16,
//             fontWeight: FontWeight.normal,
//           ),
//         ),
//         titleSpacing: -10,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 20),

//                 // Center the image using Align
//                 Align(
//                   alignment: Alignment.center,
//                   child: SizedBox(
//                     width: 150,
//                     height: 173.5,
//                     child: Image.asset("assets/mainlogo.jpg"),
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 // Title (aligned left)
//                 const Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Signup Account',
//                     style: TextStyle(
//                       fontSize: 36,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8),

//                 // Subtitle (aligned left)
//                 const Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Hello! Let\'s Join with Us',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black54,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // Name Field
//                 _buildInputField(
//                   label: 'Name',
//                   hint: 'Enter your Name',
//                   controller: nameController,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Name is required';
//                     }
//                     if (value.trim().length < 2) {
//                       return 'Name must be at least 2 characters';
//                     }
//                     return null;
//                   },
//                   isValid: _isValidName,
//                 ),
//                 const SizedBox(height: 5),

//                 // Mobile Number Field
//                 _buildInputField(
//                   label: 'Mobile Number',
//                   hint: 'Enter your Mobile Number',
//                   controller: mobileController,
//                   keyboardType: TextInputType.phone,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.digitsOnly,
//                     LengthLimitingTextInputFormatter(10),
//                   ],
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Mobile number is required';
//                     }
//                     if (value.length != 10) {
//                       return 'Please enter a valid 10-digit mobile number';
//                     }
//                     return null;
//                   },
//                   isValid: _isValidMobile,
//                 ),
//                 const SizedBox(height: 5),

//                 // Invitation Code Field
//                 // _buildInputField(
//                 //   label: 'Invitation Code ( Optional )',
//                 //   hint: 'Enter Invitation Code',
//                 //   controller: invitationController,
//                 //   isOptional: true,
//                 // ),
//                 const SizedBox(height: 20),

//                 // Signup Button with loading state
//                 Consumer<AuthProvider>(
//                   builder: (context, authProvider, child) {
//                     final isLoading = authProvider.status == AuthStatus.loading;

//                     return SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: ElevatedButton(
//                         onPressed: isLoading || !_isFormValid 
//                           ? null 
//                           : _handleSignup,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF5E35B1),
//                           disabledBackgroundColor: Colors.grey.shade300,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           elevation: 0,
//                         ),
//                         child: isLoading
//                           ? const SizedBox(
//                               width: 20,
//                               height: 20,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2,
//                                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                               ),
//                             )
//                           : const Text(
//                               'Signup',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 20),

//                 // Or divider
//                 // Row(
//                 //   children: [
//                 //     Expanded(
//                 //       child: Container(
//                 //         height: 1,
//                 //         color: Colors.grey.withOpacity(0.3),
//                 //       ),
//                 //     ),
//                 //     const Padding(
//                 //       padding: EdgeInsets.symmetric(horizontal: 16.0),
//                 //       child: Text(
//                 //         'Or',
//                 //         style: TextStyle(
//                 //           color: Colors.grey,
//                 //           fontSize: 14,
//                 //         ),
//                 //       ),
//                 //     ),
//                 //     Expanded(
//                 //       child: Container(
//                 //         height: 1,
//                 //         color: Colors.grey.withOpacity(0.3),
//                 //       ),
//                 //     ),
//                 //   ],
//                 // ),
//                 const SizedBox(height: 15),

//                 // Social Login buttons
//                 Consumer<AuthProvider>(
//                   builder: (context, authProvider, child) {
//                     final isLoading = authProvider.status == AuthStatus.loading;

//                     return Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // _socialLoginButton(
//                         //   'assets/icons/google.png', 
//                         //   isLoading ? null : () => _showComingSoonDialog('Google Signup'),
//                         //   isLoading,
//                         // ),
//                         // const SizedBox(width: 24),
//                         // _socialLoginButton(
//                         //   'assets/icons/facebook.png', 
//                         //   isLoading ? null : () => _showComingSoonDialog('Facebook Signup'),
//                         //   isLoading,
//                         // ),
//                         // const SizedBox(width: 24),
//                         // _socialLoginButton(
//                         //   'assets/icons/x.png', 
//                         //   isLoading ? null : () => _showComingSoonDialog('X Signup'),
//                         //   isLoading,
//                         // ),
//                       ],
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 30),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInputField({
//     required String label,
//     required String hint,
//     required TextEditingController controller,
//     TextInputType keyboardType = TextInputType.text,
//     List<TextInputFormatter>? inputFormatters,
//     String? Function(String?)? validator,
//     bool isOptional = false,
//     bool isValid = false,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           keyboardType: keyboardType,
//           inputFormatters: inputFormatters,
//           validator: isOptional ? null : validator,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: const TextStyle(
//               color: Colors.black38,
//               fontSize: 14,
//             ),
//             filled: true,
//             fillColor: Colors.grey.withOpacity(0.05),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide.none,
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(
//                 color: !isOptional && controller.text.isNotEmpty
//                   ? (isValid ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3))
//                   : Colors.grey.withOpacity(0.3),
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(
//                 color: Color(0xFF5E35B1),
//                 width: 2,
//               ),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(
//                 color: Colors.red.shade400,
//                 width: 1,
//               ),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(
//                 color: Colors.red.shade400,
//                 width: 2,
//               ),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 16,
//               vertical: 16,
//             ),
//             suffixIcon: !isOptional && controller.text.isNotEmpty && isValid
//               ? const Icon(Icons.check_circle, color: Colors.green)
//               : null,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _socialLoginButton(String assetName, VoidCallback? onPressed, bool isDisabled) {
//     return InkWell(
//       onTap: onPressed,
//       child: Container(
//         width: 34,
//         height: 34,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(
//             color: isDisabled 
//               ? Colors.grey.withOpacity(0.1)
//               : Colors.grey.withOpacity(0.3),
//             width: 1,
//           ),
//         ),
//         child: Center(
//           child: Opacity(
//             opacity: isDisabled ? 0.5 : 1.0,
//             child: Image.asset(
//               assetName,
//               width: 24,
//               height: 24,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }










// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:medical_user_app/view/otp_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:medical_user_app/providers/auth_provider.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final nameController = TextEditingController();
//   final mobileController = TextEditingController();
//   final emailController=TextEditingController();
//   final invitationController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
  
//   bool _isValidName = false;
//   bool _isValidMobile = false;
//   bool _isValidEmail=false;
//   bool _isAgeConfirmed = false; // Age verification checkbox state

//   @override
//   void initState() {
//     super.initState();
//     nameController.addListener(_validateForm);
//     mobileController.addListener(_validateForm);
//     emailController.addListener(_validateForm);
    
//     // Listen to auth state changes
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final authProvider = Provider.of<AuthProvider>(context, listen: false);
//       // authProvider.addListener(_handleAuthStateChange);
//     });
//   }

//   void _validateForm() {
//     setState(() {
//       _isValidName = nameController.text.trim().length >= 2;
//       _isValidMobile = mobileController.text.length == 10;
//     });
//   }
  
//   @override
//   void dispose() {
//     nameController.removeListener(_validateForm);
//     mobileController.removeListener(_validateForm);
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     // authProvider.removeListener(_handleAuthStateChange);
//     nameController.dispose();
//     mobileController.dispose();
//     invitationController.dispose();
//     super.dispose();
//   }

//   bool get _isFormValid => _isValidName && _isValidMobile && _isAgeConfirmed;

//   Future<void> _handleSignup() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     if (!_isAgeConfirmed) {
//       _showErrorSnackBar('Please confirm that you are 18 years of age or older.');
//       return;
//     }

//     final authProvider = Provider.of<AuthProvider>(context, listen: false);

//     try {
//       await authProvider.register(
//         name: nameController.text.trim(),
//         mobile: mobileController.text.trim(),
//       );

//       // Wait a bit for the state to update
//       // await Future.delayed(const Duration(milliseconds: 100));

//       if (mounted) {
//         if (authProvider.status == AuthStatus.authenticated) {
//           _showSuccessSnackBar('Registration successful! OTP sent to your mobile.');
          
//           // Navigate to OTP screen instead of Login screen
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => OtpScreen(phoneNumber: mobileController.text,)),
//           );
          
//         } else if (authProvider.status == AuthStatus.error) {
//           String errorMessage = 'Registration failed. Please try again.';
          
//           // Check for specific error messages
//           if (authProvider.errorMessage?.isNotEmpty == true) {
//             errorMessage = authProvider.errorMessage!;
            
//             // Handle common error cases
//             if (errorMessage.toLowerCase().contains('already') || 
//                 errorMessage.toLowerCase().contains('exists')) {
//               errorMessage = 'User already registered with this mobile number.';
//             }
//           }
          
//           _showErrorSnackBar(errorMessage);
          
//           // Debug print for APK debugging
//           print('Registration Error: $errorMessage');
//         } else {
//           // Handle case where status is not clear
//           _showErrorSnackBar('Registration failed. Please check your details and try again.');
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         String errorMessage = 'An unexpected error occurred. Please try again.';
        
//         // Handle specific exceptions
//         if (e.toString().contains('already') || e.toString().contains('exists')) {
//           errorMessage = 'User already registered with this mobile number.';
//         }
        
//         _showErrorSnackBar(errorMessage);
        
//         // Debug print for APK debugging
//         print('Registration Exception: ${e.toString()}');
//       }
//     }
//   }

//   void _showErrorSnackBar(String message) {
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(message),
//           backgroundColor: Colors.red,
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//     }
//   }

//   void _showSuccessSnackBar(String message) {
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(message),
//           backgroundColor: Colors.green,
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//     }
//   }

//   void _showComingSoonDialog(String feature) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(feature),
//           content: Text('$feature is coming soon!'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text(
//                 'OK',
//                 style: TextStyle(color: Color(0xFF5E35B1)),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Back',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 16,
//             fontWeight: FontWeight.normal,
//           ),
//         ),
//         titleSpacing: -10,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 20),

//                 // Center the image using Align
//                 Align(
//                   alignment: Alignment.center,
//                   child: SizedBox(
//                     width: 150,
//                     height: 173.5,
//                     child: Image.asset("assets/mainlogo.jpg"),
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 // Title (aligned left)
//                 const Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Signup Account',
//                     style: TextStyle(
//                       fontSize: 36,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8),

//                 // Subtitle (aligned left)
//                 const Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Hello! Let\'s Join with Us',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black54,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // Name Field
//                 _buildInputField(
//                   label: 'Name',
//                   hint: 'Enter your Name',
//                   controller: nameController,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Name is required';
//                     }
//                     if (value.trim().length < 2) {
//                       return 'Name must be at least 2 characters';
//                     }
//                     return null;
//                   },
//                   isValid: _isValidName,
//                 ),
//                 const SizedBox(height: 5),

//                 // Mobile Number Field
//                 _buildInputField(
//                   label: 'Mobile Number',
//                   hint: 'Enter your Mobile Number',
//                   controller: mobileController,
//                   keyboardType: TextInputType.phone,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.digitsOnly,
//                     LengthLimitingTextInputFormatter(10),
//                   ],
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Mobile number is required';
//                     }
//                     if (value.length != 10) {
//                       return 'Please enter a valid 10-digit mobile number';
//                     }
//                     return null;
//                   },
//                   isValid: _isValidMobile,
//                 ),
//                 const SizedBox(height: 20),

//                 // Age Verification Checkbox
//                 _buildAgeVerificationCheckbox(),
                
//                 const SizedBox(height: 20),

//                 // Signup Button with loading state
//                 Consumer<AuthProvider>(
//                   builder: (context, authProvider, child) {
//                     final isLoading = authProvider.status == AuthStatus.loading;

//                     return SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: ElevatedButton(
//                         onPressed: isLoading || !_isFormValid 
//                           ? null 
//                           : _handleSignup,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF5E35B1),
//                           disabledBackgroundColor: Colors.grey.shade300,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           elevation: 0,
//                         ),
//                         child: isLoading
//                           ? const SizedBox(
//                               width: 20,
//                               height: 20,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2,
//                                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                               ),
//                             )
//                           : const Text(
//                               'Signup',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 30),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAgeVerificationCheckbox() {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           _isAgeConfirmed = !_isAgeConfirmed;
//         });
//       },
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.grey.withOpacity(0.05),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: _isAgeConfirmed 
//               ? const Color(0xFF5E35B1).withOpacity(0.3)
//               : Colors.grey.withOpacity(0.3),
//             width: 1,
//           ),
//         ),
//         child: Row(
//           children: [
//             SizedBox(
//               width: 24,
//               height: 24,
//               child: Checkbox(
//                 value: _isAgeConfirmed,
//                 onChanged: (value) {
//                   setState(() {
//                     _isAgeConfirmed = value ?? false;
//                   });
//                 },
//                 activeColor: const Color(0xFF5E35B1),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 'By continuing, you confirm that you are 18 years of age or older.',
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: Colors.black87,
//                   height: 1.4,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInputField({
//     required String label,
//     required String hint,
//     required TextEditingController controller,
//     TextInputType keyboardType = TextInputType.text,
//     List<TextInputFormatter>? inputFormatters,
//     String? Function(String?)? validator,
//     bool isOptional = false,
//     bool isValid = false,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           keyboardType: keyboardType,
//           inputFormatters: inputFormatters,
//           validator: isOptional ? null : validator,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: const TextStyle(
//               color: Colors.black38,
//               fontSize: 14,
//             ),
//             filled: true,
//             fillColor: Colors.grey.withOpacity(0.05),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide.none,
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(
//                 color: !isOptional && controller.text.isNotEmpty
//                   ? (isValid ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3))
//                   : Colors.grey.withOpacity(0.3),
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(
//                 color: Color(0xFF5E35B1),
//                 width: 2,
//               ),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(
//                 color: Colors.red.shade400,
//                 width: 1,
//               ),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(
//                 color: Colors.red.shade400,
//                 width: 2,
//               ),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 16,
//               vertical: 16,
//             ),
//             suffixIcon: !isOptional && controller.text.isNotEmpty && isValid
//               ? const Icon(Icons.check_circle, color: Colors.green)
//               : null,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _socialLoginButton(String assetName, VoidCallback? onPressed, bool isDisabled) {
//     return InkWell(
//       onTap: onPressed,
//       child: Container(
//         width: 34,
//         height: 34,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(
//             color: isDisabled 
//               ? Colors.grey.withOpacity(0.1)
//               : Colors.grey.withOpacity(0.3),
//             width: 1,
//           ),
//         ),
//         child: Center(
//           child: Opacity(
//             opacity: isDisabled ? 0.5 : 1.0,
//             child: Image.asset(
//               assetName,
//               width: 24,
//               height: 24,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }














import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_user_app/view/otp_screen.dart';
import 'package:provider/provider.dart';
import 'package:medical_user_app/providers/auth_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final invitationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  bool _isValidName = false;
  bool _isValidMobile = false;
  bool _isValidEmail = false;
  bool _isAgeConfirmed = false; // Age verification checkbox state

  @override
  void initState() {
    super.initState();
    nameController.addListener(_validateForm);
    mobileController.addListener(_validateForm);
    emailController.addListener(_validateForm);
    
    // Listen to auth state changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      // authProvider.addListener(_handleAuthStateChange);
    });
  }

  void _validateForm() {
    setState(() {
      _isValidName = nameController.text.trim().length >= 2;
      _isValidMobile = mobileController.text.length == 10;
      _isValidEmail = _isValidEmailFormat(emailController.text.trim());
    });
  }

  bool _isValidEmailFormat(String email) {
    if (email.isEmpty) return false;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
  
  @override
  void dispose() {
    nameController.removeListener(_validateForm);
    mobileController.removeListener(_validateForm);
    emailController.removeListener(_validateForm);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    // authProvider.removeListener(_handleAuthStateChange);
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    invitationController.dispose();
    super.dispose();
  }

  // Button is enabled when all fields have content and checkbox is checked
  bool get _isFormValid => 
    nameController.text.trim().isNotEmpty && 
    mobileController.text.isNotEmpty && 
    emailController.text.trim().isNotEmpty && 
    _isAgeConfirmed;

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_isAgeConfirmed) {
      _showErrorSnackBar('Please confirm that you are 18 years of age or older.');
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      await authProvider.register(
        name: nameController.text.trim(),
        mobile: mobileController.text.trim(),
        email: emailController.text.trim(),
      );

      // Wait a bit for the state to update
      // await Future.delayed(const Duration(milliseconds: 100));

      if (mounted) {
        if (authProvider.status == AuthStatus.authenticated) {
          _showSuccessSnackBar('SignUp successful! OTP sent to your mobile.');
          
          // Navigate to OTP screen instead of Login screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OtpScreen(phoneNumber: mobileController.text,)),
          );
          
        } else if (authProvider.status == AuthStatus.error) {
          String errorMessage = 'SignUp failed. Please try again.';
          
          // Check for specific error messages
          if (authProvider.errorMessage?.isNotEmpty == true) {
            errorMessage = authProvider.errorMessage!;
            
            // Handle common error cases
            if (errorMessage.toLowerCase().contains('already') || 
                errorMessage.toLowerCase().contains('exists')) {
              errorMessage = 'User already registered with this mobile number or email.';
            }
          }
          _showErrorSnackBar('User already exists');
          
          // Debug print for APK debugging
          print('Registration Error: $errorMessage');
        } else {
          // Handle case where status is not clear
          _showErrorSnackBar('SignUp failed. Please check your details and try again.');
        }
      }
    } catch (e) {
      if (mounted) {
        String errorMessage = 'An unexpected error occurred. Please try again.';
        
        // Handle specific exceptions
        if (e.toString().contains('already') || e.toString().contains('exists')) {
          errorMessage = 'User already registered with this mobile number or email.';
        }
        
        _showErrorSnackBar(errorMessage);
        
        // Debug print for APK debugging
        print('Registration Exception: ${e.toString()}');
      }
    }
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showSuccessSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showComingSoonDialog(String feature) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(feature),
          content: Text('$feature is coming soon!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'OK',
                style: TextStyle(color: Color(0xFF5E35B1)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Back',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        titleSpacing: -10,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // Center the image using Align
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 150,
                    height: 173.5,
                    child: Image.asset("assets/mainlogo.jpg"),
                  ),
                ),
                const SizedBox(height: 16),

                // Title (aligned left)
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Signup Account',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Subtitle (aligned left)
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Hello! Let\'s Join with Us',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Name Field
                _buildInputField(
                  label: 'Name',
                  hint: 'Enter your Name',
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Name is required';
                    }
                    if (value.trim().length < 2) {
                      return 'Name must be at least 2 characters';
                    }
                    return null;
                  },
                  isValid: _isValidName,
                ),
                const SizedBox(height: 5),

                // Mobile Number Field
                _buildInputField(
                  label: 'Mobile Number',
                  hint: 'Enter your Mobile Number',
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mobile number is required';
                    }
                    if (value.length != 10) {
                      return 'Please enter a valid 10-digit mobile number';
                    }
                    return null;
                  },
                  isValid: _isValidMobile,
                ),
                const SizedBox(height: 5),

                // Email Field
                _buildInputField(
                  label: 'Email',
                  hint: 'Enter your Email',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }
                    if (!_isValidEmailFormat(value.trim())) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  isValid: _isValidEmail,
                ),
                const SizedBox(height: 20),

                // Age Verification Checkbox
                _buildAgeVerificationCheckbox(),
                
                const SizedBox(height: 20),

                // Signup Button with loading state
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    final isLoading = authProvider.status == AuthStatus.loading;

                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isLoading || !_isFormValid 
                          ? null 
                          : _handleSignup,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5E35B1),
                          disabledBackgroundColor: Colors.grey.shade300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              'Signup',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAgeVerificationCheckbox() {
    return InkWell(
      onTap: () {
        setState(() {
          _isAgeConfirmed = !_isAgeConfirmed;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isAgeConfirmed 
              ? const Color(0xFF5E35B1).withOpacity(0.3)
              : Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: _isAgeConfirmed,
                onChanged: (value) {
                  setState(() {
                    _isAgeConfirmed = value ?? false;
                  });
                },
                activeColor: const Color(0xFF5E35B1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'By continuing, you confirm that you are 18 years of age or older.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    bool isOptional = false,
    bool isValid = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: isOptional ? null : validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.black38,
              fontSize: 14,
            ),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: !isOptional && controller.text.isNotEmpty
                  ? (isValid ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3))
                  : Colors.grey.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF5E35B1),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.red.shade400,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.red.shade400,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            suffixIcon: !isOptional && controller.text.isNotEmpty && isValid
              ? const Icon(Icons.check_circle, color: Colors.green)
              : null,
          ),
        ),
      ],
    );
  }

  // Widget _socialLoginButton(String assetName, VoidCallback? onPressed, bool isDisabled) {
  //   return InkWell(
  //     onTap: onPressed,
  //     child: Container(
  //       width: 34,
  //       height: 34,
  //       decoration: BoxDecoration(
  //         shape: BoxShape.circle,
  //         border: Border.all(
  //           color: isDisabled 
  //             ? Colors.grey.withOpacity(0.1)
  //             : Colors.grey.withOpacity(0.3),
  //           width: 1,
  //         ),
  //       ),
  //       child: Center(
  //         child: Opacity(
  //           opacity: isDisabled ? 0.5 : 1.0,
  //           child: Image.asset(
  //             assetName,
  //             width: 24,
  //             height: 24,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}