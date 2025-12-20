
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:medical_user_app/providers/language_provider.dart';
// import 'package:medical_user_app/utils/shared_preferences_helper.dart';
// import 'package:medical_user_app/view/main_layout.dart';
// import 'package:provider/provider.dart';
// import 'package:medical_user_app/view/on_boarding_screen.dart';
// import 'package:medical_user_app/view/home_screen.dart'; // Your home screen
// import 'package:medical_user_app/providers/auth_provider.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _initializeApp();
//   }

// Future<void> _initializeApp() async {
//   await Future.delayed(const Duration(seconds: 2));

//   final token = await SharedPreferencesHelper.getToken();
//   print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk$token");

//   if (mounted) {
//     _navigateToNextScreen(token.toString());
//   }
// }


// void _navigateToNextScreen(String token) {
//   Widget nextScreen;

//   print("lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll$token");

//   if (token != "null" && token.trim().isNotEmpty) {
//     // Valid token → go to MainLayout
//     nextScreen = const MainLayout();
//   } else {
//     // Invalid token → go to Onboarding
//     nextScreen = const OnboardingScreen();
//   }



//   Navigator.pushReplacement(
//     context,
//     MaterialPageRoute(builder: (context) => nextScreen),
//   );
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // const SizedBox(height: 120),
//               // App Logo
//               Center(
//                 child: Image.asset(
//                   'assets/finallogo.png',
//                   width: 238,
//                   height: 238,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               // Welcome Text
//               const AppText(
//                 'welcome',
//                 style: TextStyle(
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               // Slogan Text
//               const AppText(
//                 'slogan',
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.grey,
//                 ),
//               ),
//               const SizedBox(height: 80),
//               // Loading Indicator
//               const CircularProgressIndicator(
//                 color: Color(0xFF5931DD),
//                 strokeWidth: 5,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

















import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medical_user_app/providers/language_provider.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';
import 'package:medical_user_app/view/main_layout.dart';
import 'package:provider/provider.dart';
import 'package:medical_user_app/view/on_boarding_screen.dart';
import 'package:medical_user_app/view/home_screen.dart';
import 'package:medical_user_app/providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _progressController;
  late AnimationController _backgroundController;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _textOpacity;
  late Animation<Offset> _textSlide;
  late Animation<double> _progressOpacity;
  late Animation<Color?> _backgroundGradient;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
    _initializeApp();
  }

  void _initializeAnimations() {
    // Logo Animation Controller
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Text Animation Controller
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Progress Animation Controller
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Background Animation Controller
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Logo Animations
    _logoScale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    _logoOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    ));

    // Text Animations
    _textOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOut,
    ));

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutCubic,
    ));

    // Progress Animation
    _progressOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeIn,
    ));

    // Background Gradient Animation
    _backgroundGradient = ColorTween(
      begin: const Color(0xFF5931DD).withOpacity(0.1),
      end: const Color(0xFF5931DD).withOpacity(0.05),
    ).animate(CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.easeInOut,
    ));
  }

  void _startAnimations() {
    // Start logo animation immediately
    _logoController.forward();

    // Start text animation after a delay
    Timer(const Duration(milliseconds: 500), () {
      if (mounted) _textController.forward();
    });

    // Start progress animation after text
    Timer(const Duration(milliseconds: 1000), () {
      if (mounted) _progressController.forward();
    });

    // Start background animation
    _backgroundController.repeat(reverse: true);
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 3));

    final token = await SharedPreferencesHelper.getToken();
    print("Token retrieved: $token");

    if (mounted) {
      _navigateToNextScreen(token.toString());
    }
  }

  void _navigateToNextScreen(String token) {
    Widget nextScreen;

    if (token != "null" && token.trim().isNotEmpty) {
      nextScreen = const MainLayout();
    } else {
      nextScreen = const OnboardingScreen();
    }

    // Add a fade transition for smoother navigation
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _progressController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _backgroundController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  _backgroundGradient.value ?? Colors.white,
                  Colors.white,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),
                    
                    // Animated Logo Section
                    AnimatedBuilder(
                      animation: _logoController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _logoScale.value,
                          child: Opacity(
                            opacity: _logoOpacity.value,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF5931DD).withOpacity(0.2),
                                    blurRadius: 30,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                'assets/finallogo.png',
                                width: 200,
                                height: 200,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Animated Text Section
                    AnimatedBuilder(
                      animation: _textController,
                      builder: (context, child) {
                        return SlideTransition(
                          position: _textSlide,
                          child: FadeTransition(
                            opacity: _textOpacity,
                            child: Column(
                              children: [
                                // Welcome Text with shimmer effect
                                ShaderMask(
                                  shaderCallback: (bounds) => const LinearGradient(
                                    colors: [
                                      Color(0xFF5931DD),
                                      Color(0xFF8B5CF6),
                                      Color(0xFF5931DD),
                                    ],
                                    stops: [0.0, 0.5, 1.0],
                                  ).createShader(bounds),
                                  child: const AppText(
                                    'welcome',
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                                
                                const SizedBox(height: 12),
                                
                                // Slogan Text
                                const AppText(
                                  'slogan',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    
                    const Spacer(flex: 2),
                    
                    // Animated Progress Indicator
                    AnimatedBuilder(
                      animation: _progressController,
                      builder: (context, child) {
                        return FadeTransition(
                          opacity: _progressOpacity,
                          child: Column(
                            children: [
                              // Custom animated progress indicator
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: Stack(
                                  children: [
                                    // Background circle
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color(0xFF5931DD).withOpacity(0.1),
                                      ),
                                    ),
                                    // Animated progress
                                    CircularProgressIndicator(
                                      color: const Color(0xFF5931DD),
                                      strokeWidth: 3,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(height: 24),
                              
                              // Loading text with dots animation
                              AnimatedBuilder(
                                animation: _backgroundController,
                                builder: (context, child) {
                                  return Text(
                                    'Loading${_getLoadingDots()}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w400,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _getLoadingDots() {
    double progress = _backgroundController.value;
    if (progress < 0.33) {
      return '';
    } else if (progress < 0.66) {
      return '.';
    } else if (progress < 0.99) {
      return '..';
    } else {
      return '...';
    }
  }
}

// Custom AppText widget (assuming this is your localized text widget)
class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const AppText(
    this.text, {
    Key? key,
    this.style,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace this with your actual localization logic
    return Text(
      _getLocalizedText(text),
      style: style,
      textAlign: textAlign,
    );
  }

  String _getLocalizedText(String key) {
    // This should connect to your actual localization system
    switch (key) {
      case 'welcome':
        return 'Welcome';
      case 'slogan':
        return 'Your Health is Our Priority';
      default:
        return key;
    }
  }
}