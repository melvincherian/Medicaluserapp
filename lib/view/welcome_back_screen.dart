
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_user_app/view/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:medical_user_app/view/otp_screen.dart';
import 'package:medical_user_app/providers/auth_provider.dart';

class WelcomeBackScreen extends StatefulWidget {
  const WelcomeBackScreen({super.key});

  @override
  State<WelcomeBackScreen> createState() => _WelcomeBackScreenState();
}

class _WelcomeBackScreenState extends State<WelcomeBackScreen> {
  final mobileController = TextEditingController();
  bool _isValidPhoneNumber = false;

  @override
  void initState() {
    super.initState();
    mobileController.addListener(_validatePhoneNumber);
    
    // Listen to auth state changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      // authProvider.addListener(_handleAuthStateChange);
    });
  }

  void _validatePhoneNumber() {
    setState(() {
      _isValidPhoneNumber = mobileController.text.length == 10;
    });
  }

  // void _handleAuthStateChange() {
  //   final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
  //   if (authProvider.isAuthenticated && mounted) {
  //     // User successfully logged in, navigate to home
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (context) => const HomeScreen()),
  //       (route) => false,
  //     );
  //   }
  // }

  @override
  void dispose() {
    mobileController.removeListener(_validatePhoneNumber);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    // authProvider.removeListener(_handleAuthStateChange);
    mobileController.dispose();
    super.dispose();
  }

//  Future<void> _handleLogin() async {
//   if (!_isValidPhoneNumber) {
//     _showErrorSnackBar('Please enter a valid 10-digit mobile number');
//     return;
//   }

//   final authProvider = Provider.of<AuthProvider>(context, listen: false);

//   try {
//     await authProvider.login(mobile: mobileController.text.trim());

//     if (authProvider.status == AuthStatus.authenticated) {
//       _showSuccessSnackBar('OTP sent successfully!');
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) =>  OtpScreen(phoneNumber: mobileController.text,)),
//       );
//     } else if (authProvider.status == AuthStatus.error) {
//       _showErrorSnackBar(
//         'Login Failed Please SignUp'
//       );
//       // _showErrorSnackBar(
//       //   authProvider.errorMessage?.isNotEmpty == true
//       //     ? authProvider.errorMessage!
//       //     : 'Login failed. Please try again.',
//       // );
//     }
//   } catch (e) {
//     _showErrorSnackBar('An unexpected error occurred. Please try again.');
//   }
// }



Future<void> _handleLogin() async {
  if (!_isValidPhoneNumber) {
    _showErrorSnackBar('Please enter a valid 10-digit mobile number');
    return;
  }

  final authProvider = Provider.of<AuthProvider>(context, listen: false);

  try {
    await authProvider.login(mobile: mobileController.text.trim());

    if (authProvider.status == AuthStatus.authenticated) {
      _showSuccessSnackBar('OTP sent successfully!');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OtpScreen(phoneNumber: mobileController.text)),
      );
    } else if (authProvider.status == AuthStatus.error) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignupScreen()),
      );
    }
  } catch (e) {
    _showErrorSnackBar('An unexpected error occurred. Please try again.');
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
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
        //   onPressed: () => Navigator.pop(context),
        // ),
        // title: const Text(
        //   'Back',
        //   style: TextStyle(
        //     color: Colors.black,
        //     fontSize: 16,
        //     fontWeight: FontWeight.normal,
        //   ),
        // ),
        titleSpacing: -10,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Illustration
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 330,
                  height: 278,
                  child: Image.asset("assets/mainlogo.jpg"),
                ),
              ),

              const SizedBox(height: 30),

              // Title
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome back',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Subtitle (aligned left)
               Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hey! Good to see you again',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(height: 50),

              // Mobile Number Input
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mobile Number',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: InputDecoration(
                      hintText: 'Enter your Mobile Number',
                      hintStyle: const TextStyle(
                        color: Colors.black38,
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: _isValidPhoneNumber 
                            ? Colors.green.withOpacity(0.3)
                            : Colors.grey.withOpacity(0.3),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFF5E35B1),
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      suffixIcon: _isValidPhoneNumber
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : null,
                    ),
                  ),
                  if (mobileController.text.isNotEmpty && !_isValidPhoneNumber)
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        'Please enter a valid 10-digit mobile number',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 30),

              // Login Button with loading state
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed:  !_isValidPhoneNumber 
                        ? null 
                        : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5931DD)
,
                        disabledBackgroundColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: authProvider.status == AuthStatus.loading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Get OTP',
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

              const SizedBox(height: 20),

              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
              }, child: Text('Sign Up')),


              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //         height: 1,
              //         color: Colors.grey.withOpacity(0.3),
              //       ),
              //     ),
              //     const Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 16.0),
              //       child: Text(
              //         'Or',
              //         style: TextStyle(
              //           color: Colors.grey,
              //           fontSize: 14,
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //       child: Container(
              //         height: 1,
              //         color: Colors.grey.withOpacity(0.3),
              //       ),
              //     ),
              //   ],
              // ),

              const SizedBox(height: 30),

              // Social Login buttons
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  final isLoading = authProvider.status == AuthStatus.loading;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // _socialLoginButton(
                      //   'assets/icons/google.png', 
                      //   isLoading ? null : () => _showComingSoonDialog('Google Login'),
                      //   isLoading,
                      // ),
                      // const SizedBox(width: 24),
                      // _socialLoginButton(
                      //   'assets/icons/facebook.png', 
                      //   isLoading ? null : () => _showComingSoonDialog('Facebook Login'),
                      //   isLoading,
                      // ),
                      // const SizedBox(width: 24),
                      // _socialLoginButton(
                      //   'assets/icons/x.png', 
                      //   isLoading ? null : () => _showComingSoonDialog('X Login'),
                      //   isLoading,
                      // ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialLoginButton(String assetName, VoidCallback? onPressed, bool isDisabled) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isDisabled 
              ? Colors.grey.withOpacity(0.1)
              : Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Center(
          child: Opacity(
            opacity: isDisabled ? 0.5 : 1.0,
            child: Image.asset(
              assetName,
              width: 24,
              height: 24,
            ),
          ),
        ),
      ),
    );
  }
}