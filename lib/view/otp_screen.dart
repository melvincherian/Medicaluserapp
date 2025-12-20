// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'dart:async';
// // import 'package:medical_user_app/view/main_layout.dart';

// // class OtpScreen extends StatefulWidget {
// //   final String phoneNumber;

// //   const OtpScreen({
// //     super.key,
// //     this.phoneNumber = '9999999999'
// //   });

// //   @override
// //   State<OtpScreen> createState() => _OtpScreenState();
// // }

// // class _OtpScreenState extends State<OtpScreen> {
// //   final List<TextEditingController> _otpControllers = List.generate(
// //     4,
// //     (_) => TextEditingController()
// //   );
// //   final List<FocusNode> _focusNodes = List.generate(
// //     4,
// //     (_) => FocusNode()
// //   );

// //   int _timerValue = 600; // 10 minutes in seconds
// //   late Timer _timer;
// //   bool _isTimerRunning = true;

// //   @override
// //   void initState() {
// //     super.initState();
// //     startTimer();
// //   }

// //   void startTimer() {
// //     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
// //       setState(() {
// //         if (_timerValue > 0) {
// //           _timerValue--;
// //         } else {
// //           _timer.cancel();
// //           _isTimerRunning = false;
// //         }
// //       });
// //     });
// //   }

// //   String getFormattedTime() {
// //     int minutes = _timerValue ~/ 60;
// //     int seconds = _timerValue % 60;
// //     return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
// //   }

// //   void resendOtp() {
// //     // Reset timer and controllers
// //     for (var controller in _otpControllers) {
// //       controller.clear();
// //     }
// //     setState(() {
// //       _timerValue = 600;
// //       _isTimerRunning = true;
// //     });
// //     startTimer();

// //     // Show resend confirmation
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       const SnackBar(content: Text('OTP has been resent'))
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _timer.cancel();
// //     for (var controller in _otpControllers) {
// //       controller.dispose();
// //     }
// //     for (var node in _focusNodes) {
// //       node.dispose();
// //     }
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       // appBar: AppBar(
// //       //   backgroundColor: Colors.white,
// //       //   elevation: 0,
// //       //   leading: IconButton(
// //       //     icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
// //       //     onPressed: () => Navigator.pop(context),
// //       //   ),
// //       //   title: const Text(
// //       //     'Back',
// //       //     style: TextStyle(
// //       //       color: Colors.black,
// //       //       fontSize: 16,
// //       //       fontWeight: FontWeight.normal,
// //       //     ),
// //       //   ),
// //       //   titleSpacing: -10,
// //       // ),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 24.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               const SizedBox(height: 20),

// //               // Illustration
// //               Stack(
// //                 alignment: Alignment.center,
// //                 children: [
// //                   Container(
// //                     width: 240,
// //                     height: 240,
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(120),
// //                     ),
// //                   ),
// //                   Image.asset(
// //                     'assets/otp.png',
// //                     width: 220,
// //                     height: 220,
// //                     fit: BoxFit.contain,
// //                     errorBuilder: (context, error, stackTrace) {
// //                       return Container(
// //                         width: 220,
// //                         height: 220,
// //                         decoration: BoxDecoration(
// //                           color: Colors.white.withOpacity(0.5),
// //                           borderRadius: BorderRadius.circular(20),
// //                         ),
// //                         child: Column(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           children: [
// //                             Container(
// //                               padding: const EdgeInsets.all(16),
// //                               decoration: BoxDecoration(
// //                                 color: const Color(0xFF5E35B1),
// //                                 shape: BoxShape.circle,
// //                               ),
// //                               child: const Text(
// //                                 'OTP',
// //                                 style: TextStyle(
// //                                   color: Colors.white,
// //                                   fontWeight: FontWeight.bold,
// //                                 ),
// //                               ),
// //                             ),
// //                             const SizedBox(height: 16),
// //                             Container(
// //                               width: 120,
// //                               child: Row(
// //                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                                 children: List.generate(
// //                                   4,
// //                                   (index) => Container(
// //                                     width: 16,
// //                                     height: 16,
// //                                     decoration: BoxDecoration(
// //                                       color: Colors.purple,
// //                                       borderRadius: BorderRadius.circular(8),
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                 ],
// //               ),

// //               const SizedBox(height: 30),

// //               // Title
// //               const Text(
// //                 'OTP Verification',
// //                 style: TextStyle(
// //                   fontSize: 32,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.black,
// //                 ),
// //               ),

// //               const SizedBox(height: 16),

// //               // Description
// //               RichText(
// //                 textAlign: TextAlign.center,
// //                 text: TextSpan(
// //                   style: const TextStyle(
// //                     fontSize: 14,
// //                     color: Colors.black54,
// //                   ),
// //                   children: [
// //                     const TextSpan(
// //                       text: 'We\'ve sent a verification code to ',
// //                     ),
// //                     TextSpan(
// //                       text: widget.phoneNumber,
// //                       style: const TextStyle(
// //                         color: Colors.blue,
// //                         fontWeight: FontWeight.w500,
// //                       ),
// //                     ),
// //                     const TextSpan(
// //                       text: ' to help keep your account secure. Enter it below to log in.',
// //                     ),
// //                   ],
// //                 ),
// //               ),

// //               const SizedBox(height: 12),

// //               // Timer
// //               Text(
// //                 'Your code will be valid for ${_isTimerRunning ? getFormattedTime() : "0 minutes"}.',
// //                 style: const TextStyle(
// //                   fontSize: 14,
// //                   color: Colors.black54,
// //                 ),
// //               ),

// //               const SizedBox(height: 30),

// //               // OTP Input Fields
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                 children: List.generate(
// //                   4,
// //                   (index) => SizedBox(
// //                     width: 50,
// //                     child: TextField(
// //                       controller: _otpControllers[index],
// //                       focusNode: _focusNodes[index],
// //                       keyboardType: TextInputType.number,
// //                       textAlign: TextAlign.center,
// //                       maxLength: 1,
// //                       style: const TextStyle(
// //                         fontSize: 20,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                       decoration: InputDecoration(
// //                         counterText: '',
// //                         enabledBorder: UnderlineInputBorder(
// //                           borderSide: BorderSide(
// //                             color: Colors.grey.shade300,
// //                             width: 2,
// //                           ),
// //                         ),
// //                         focusedBorder: const UnderlineInputBorder(
// //                           borderSide: BorderSide(
// //                             color: Color(0xFF5E35B1),
// //                             width: 2,
// //                           ),
// //                         ),
// //                       ),
// //                       inputFormatters: [
// //                         FilteringTextInputFormatter.digitsOnly,
// //                       ],
// //                       onChanged: (value) {
// //                         if (value.isNotEmpty) {
// //                           // Move to next field
// //                           if (index < 3) {
// //                             _focusNodes[index + 1].requestFocus();
// //                           } else {
// //                             // Last field, hide keyboard
// //                             FocusScope.of(context).unfocus();
// //                           }
// //                         } else if (value.isEmpty && index > 0) {
// //                           // Move to previous field on backspace
// //                           _focusNodes[index - 1].requestFocus();
// //                         }
// //                       },
// //                     ),
// //                   ),
// //                 ),
// //               ),

// //               const SizedBox(height: 16),

// //               // Resend button
// //               Align(
// //                 alignment: Alignment.centerRight,
// //                 child: TextButton(
// //                   onPressed: _isTimerRunning ? null : resendOtp,
// //                   child: Text(
// //                     'Resend OTP',
// //                     style: TextStyle(
// //                       color: _isTimerRunning
// //                           ? Colors.grey
// //                           : const Color(0xFF5E35B1),
// //                       fontWeight: FontWeight.w500,
// //                     ),
// //                   ),
// //                 ),
// //               ),

// //               const SizedBox(height: 80),

// //               // Verify button
// //               SizedBox(
// //                 width: double.infinity,
// //                 height: 50,
// //                 child: ElevatedButton(
// //                   onPressed: () {
// //                     // Get OTP value
// //                     String otp = _otpControllers
// //                         .map((controller) => controller.text)
// //                         .join();

// //                     if (otp == "1234") {
// //                               _showSuccessSnackBar('Login successful!');
// //                       // Navigator.pushReplacement(
// //                       //   context,
// //                       //   MaterialPageRoute(builder: (context) => MainLayout()),
// //                       // );

// //                        Navigator.pushAndRemoveUntil(
// //       context,
// //       MaterialPageRoute(builder: (context) => MainLayout()),
// //       (route) => false, // This removes all previous routes
// //     );

// //                     } else {
// //                       // Show error
// //                       ScaffoldMessenger.of(context).showSnackBar(
// //                         const SnackBar(
// //                           content: Text('Please enter a valid OTP'),
// //                         ),
// //                       );
// //                     }
// //                   },
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: const Color(0xFF5E35B1),
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(8),
// //                     ),
// //                     elevation: 0,
// //                   ),
// //                   child: const Text(
// //                     'Verify',
// //                     style: TextStyle(
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.bold,
// //                       color: Colors.white,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //     void _showSuccessSnackBar(String message) {
// //     if (mounted) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text(message),
// //           backgroundColor: Colors.green,
// //           behavior: SnackBarBehavior.floating,
// //         ),
// //       );
// //     }
// //   }
// // }



// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:async';
// import 'package:medical_user_app/view/main_layout.dart';

// class OtpScreen extends StatefulWidget {
//   final String phoneNumber;

//   const OtpScreen({super.key, required this.phoneNumber});

//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {
//   final List<TextEditingController> _otpControllers =
//       List.generate(4, (_) => TextEditingController());
//   final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

//   int _timerValue = 600; // 10 minutes in seconds
//   late Timer _timer;
//   bool _isTimerRunning = true;

//   @override
//   void initState() {
//     super.initState();
//     startTimer();
//   }

//   void startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         if (_timerValue > 0) {
//           _timerValue--;
//         } else {
//           _timer.cancel();
//           _isTimerRunning = false;
//         }
//       });
//     });
//   }

//   String getFormattedTime() {
//     int minutes = _timerValue ~/ 60;
//     int seconds = _timerValue % 60;
//     return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
//   }

//   // void resendOtp() {
//   //   // Reset timer and controllers
//   //   for (var controller in _otpControllers) {
//   //     controller.clear();
//   //   }
//   //   setState(() {
//   //     _timerValue = 600;
//   //     _isTimerRunning = true;
//   //   });
//   //   startTimer();

//   //   // Show resend confirmation
//   //   ScaffoldMessenger.of(context)
//   //       .showSnackBar(const SnackBar(content: Text('OTP has been resent')));
//   // }

//   @override
//   void dispose() {
//     _timer.cancel();
//     for (var controller in _otpControllers) {
//       controller.dispose();
//     }
//     for (var node in _focusNodes) {
//       node.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 20),

//               // Illustration
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                     width: 240,
//                     height: 240,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(120),
//                     ),
//                   ),
//                   Image.asset(
//                     'assets/otp.png',
//                     width: 220,
//                     height: 220,
//                     fit: BoxFit.contain,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         width: 220,
//                         height: 220,
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.5),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.all(16),
//                               decoration: BoxDecoration(
//                                 color: const Color(0xFF5E35B1),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: const Text(
//                                 'OTP',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                             Container(
//                               width: 120,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: List.generate(
//                                   4,
//                                   (index) => Container(
//                                     width: 16,
//                                     height: 16,
//                                     decoration: BoxDecoration(
//                                       color: Colors.purple,
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 30),

//               // Title
//               const Text(
//                 'OTP Verification',
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // Description
//               RichText(
//                 textAlign: TextAlign.center,
//                 text: TextSpan(
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.black54,
//                   ),
//                   children: [
//                     const TextSpan(
//                       text: 'We\'ve sent a verification code to ',
//                     ),
//                     TextSpan(
//                       text: widget.phoneNumber,
//                       style: const TextStyle(
//                         color: Colors.blue,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const TextSpan(
//                       text:
//                           ' to help keep your account secure. Enter it below to log in.',
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 12),

//               // Timer
//               Text(
//                 'Your code will be valid for ${_isTimerRunning ? getFormattedTime() : "0 minutes"}.',
//                 style: const TextStyle(
//                   fontSize: 14,
//                   color: Colors.black54,
//                 ),
//               ),

//               const SizedBox(height: 30),

//               // OTP Input Fields
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: List.generate(
//                   4,
//                   (index) => SizedBox(
//                     width: 50,
//                     child: TextField(
//                       controller: _otpControllers[index],
//                       focusNode: _focusNodes[index],
//                       keyboardType: TextInputType.number,
//                       textAlign: TextAlign.center,
//                       maxLength: 1,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       decoration: InputDecoration(
//                         counterText: '',
//                         enabledBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Colors.grey.shade300,
//                             width: 2,
//                           ),
//                         ),
//                         focusedBorder: const UnderlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Color(0xFF5E35B1),
//                             width: 2,
//                           ),
//                         ),
//                       ),
//                       inputFormatters: [
//                         FilteringTextInputFormatter.digitsOnly,
//                       ],
//                       onChanged: (value) {
//                         if (value.length == 1) {
//                           // Digit entered - move to next field
//                           if (index < 3) {
//                             _focusNodes[index + 1].requestFocus();
//                           } else {
//                             // Last field, hide keyboard
//                             FocusScope.of(context).unfocus();
//                           }
//                         } else if (value.isEmpty && index > 0) {
//                           // Backspace pressed - move to previous field
//                           _focusNodes[index - 1].requestFocus();
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // Resend button
//               // Align(
//               //   alignment: Alignment.centerRight,
//               //   child: TextButton(
//               //     onPressed: _isTimerRunning ? null : resendOtp,
//               //     child: Text(
//               //       'Resend OTP',
//               //       style: TextStyle(
//               //         color: _isTimerRunning
//               //             ? Colors.grey
//               //             : const Color(0xFF5E35B1),
//               //         fontWeight: FontWeight.w500,
//               //       ),
//               //     ),
//               //   ),
//               // ),

//               const SizedBox(height: 80),

//               // Verify button
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Get OTP value
//                     String otp = _otpControllers
//                         .map((controller) => controller.text)
//                         .join();

//                     if (otp == "1234") {
//                       _showSuccessSnackBar('Login successful!');
//                       Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(builder: (context) => MainLayout()),
//                         (route) => false,
//                       );
//                     } else {
//                       // Show error
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Please enter a valid OTP'),
//                         ),
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF5931DD),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     elevation: 0,
//                   ),
//                   child: const Text(
//                     'Verify',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
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
// }













import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:medical_user_app/view/main_layout.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  int _timerValue = 600; // 10 minutes in seconds
  late Timer _timer;
  bool _isTimerRunning = true;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerValue > 0) {
          _timerValue--;
        } else {
          _timer.cancel();
          _isTimerRunning = false;
        }
      });
    });
  }

  String getFormattedTime() {
    int minutes = _timerValue ~/ 60;
    int seconds = _timerValue % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // void resendOtp() {
  //   // Reset timer and controllers
  //   for (var controller in _otpControllers) {
  //     controller.clear();
  //   }
  //   setState(() {
  //     _timerValue = 600;
  //     _isTimerRunning = true;
  //   });
  //   startTimer();

  //   // Show resend confirmation
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(const SnackBar(content: Text('OTP has been resent')));
  // }

  @override
  void dispose() {
    _timer.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Illustration
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 240,
                    height: 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(120),
                    ),
                  ),
                  Image.asset(
                    'assets/otp.png',
                    width: 220,
                    height: 220,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 220,
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFF5E35B1),
                                shape: BoxShape.circle,
                              ),
                              child: const Text(
                                'OTP',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              width: 120,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List.generate(
                                  4,
                                  (index) => Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius: BorderRadius.circular(8),
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
                ],
              ),

              const SizedBox(height: 30),

              // Title
              const Text(
                'OTP Verification',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 16),

              // Description
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  children: [
                    const TextSpan(
                      text: 'We\'ve sent a verification code to ',
                    ),
                    TextSpan(
                      text: widget.phoneNumber,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const TextSpan(
                      text:
                          ' to help keep your account secure. Enter it below to log in.',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Timer
              Text(
                'Your code will be valid for ${_isTimerRunning ? getFormattedTime() : "0 minutes"}.',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 30),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => SizedBox(
                    width: 50,
                    child: RawKeyboardListener(
                      focusNode: FocusNode(),
                      onKey: (event) {
                        if (event is RawKeyDownEvent) {
                          if (event.logicalKey == LogicalKeyboardKey.backspace) {
                            if (_otpControllers[index].text.isEmpty && index > 0) {
                              _focusNodes[index - 1].requestFocus();
                            }
                          }
                        }
                      },
                      child: TextField(
                        controller: _otpControllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF5E35B1),
                              width: 2,
                            ),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) {
                          if (value.length == 1) {
                            // Digit entered - move to next field
                            if (index < 3) {
                              _focusNodes[index + 1].requestFocus();
                            } else {
                              // Last field, hide keyboard
                              FocusScope.of(context).unfocus();
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Resend button
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: TextButton(
              //     onPressed: _isTimerRunning ? null : resendOtp,
              //     child: Text(
              //       'Resend OTP',
              //       style: TextStyle(
              //         color: _isTimerRunning
              //             ? Colors.grey
              //             : const Color(0xFF5E35B1),
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //   ),
              // ),

              const SizedBox(height: 80),

              // Verify button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Get OTP value
                    String otp = _otpControllers
                        .map((controller) => controller.text)
                        .join();

                    if (otp == "1234") {
                      _showSuccessSnackBar('Login successful!');
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MainLayout()),
                        (route) => false,
                      );
                    } else {
                      // Show error
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a valid OTP'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5931DD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Verify',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
}