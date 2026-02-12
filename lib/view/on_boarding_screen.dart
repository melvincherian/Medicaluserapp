// import 'package:flutter/material.dart';
// import 'package:medical_user_app/view/login_screen.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;

//   final List<OnboardingContent> _contents = [
//     OnboardingContent(
//       image: 'assets/ad_img.png',
//       title: 'Order Medicines To\nYour Door Steps',
//       description: 'Get your medications delivered straight to your doorstep with just a few taps',
//     ),
//     OnboardingContent(
//       image: 'assets/ad_img.png',
//       title: 'Consult With\nSpecialists Online',
//       description: 'Connect with healthcare professionals anytime, anywhere through secure video calls',
//     ),
//     OnboardingContent(
//       image: 'assets/ad_img.png',
//       title: 'Track Your\nHealth Progress',
//       description: 'Monitor your health metrics and medication schedules all in one place',
//     ),
//   ];

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   void _goToLoginScreen() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Align(
//                 alignment: Alignment.topRight,
//                 child: TextButton(
//                   onPressed: _goToLoginScreen,
//                   child: const Text(
//                     'Skip',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Color(0xFF5931DD),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: PageView.builder(
//                 controller: _pageController,
//                 onPageChanged: (value) {
//                   setState(() {
//                     _currentPage = value;
//                   });
//                 },
//                 itemCount: _contents.length,
//                 itemBuilder: (context, index) {
//                   return OnboardingPage(
//                     content: _contents[index],
//                   );
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 60),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List.generate(
//                       _contents.length,
//                       (index) => _buildDotIndicator(index),
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   Container(
//                     width: 48,
//                     height: 48,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF5931DD),
//                       borderRadius: BorderRadius.circular(100),
//                     ),
//                     child: IconButton(
//                       onPressed: () {
//                         if (_currentPage == _contents.length - 1) {
//                           _goToLoginScreen();
//                         } else {
//                           _pageController.nextPage(
//                             duration: const Duration(milliseconds: 300),
//                             curve: Curves.easeInOut,
//                           );
//                         }
//                       },
//                       icon: const Icon(
//                         Icons.arrow_forward,
//                         color: Colors.white,
//                         size: 24,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDotIndicator(int index) {
//     return Container(
//       height: 10,
//       width: _currentPage == index ? 25 : 10,
//       margin: const EdgeInsets.only(right: 5),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: _currentPage == index
//             ? const Color(0xFF5931DD)
//             : const Color(0xFFD9D9D9),
//       ),
//     );
//   }
// }

// class OnboardingContent {
//   final String image;
//   final String title;
//   final String description;

//   OnboardingContent({
//     required this.image,
//     required this.title,
//     required this.description,
//   });
// }

// class OnboardingPage extends StatelessWidget {
//   final OnboardingContent content;

//   const OnboardingPage({
//     super.key,
//     required this.content,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         children: [
//           Expanded(
//             flex: 3,
//             child: Image.asset(
//               content.image,
//               fit: BoxFit.contain,
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Column(
//               children: [
//                 Text(
//                   content.title,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   content.description,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }














import 'package:flutter/material.dart';
import 'package:medical_user_app/view/login_screen.dart';
import 'package:medical_user_app/view/welcome_back_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      image: 'assets/ad_img.png',
      title: 'Order Medicines To\nYour Door Steps',
      description:
          'Get your medications delivered straight to your doorstep with just a few taps',
    ),
    OnboardingContent(
      image: 'assets/ad_img.png',
      title: 'Consult With\nSpecialists Online',
      description:
          'Connect with healthcare professionals anytime, anywhere through secure video calls',
    ),
    OnboardingContent(
      image: 'assets/ad_img.png',
      title: 'Track Your\nHealth Progress',
      description:
          'Monitor your health metrics and medication schedules all in one place',
    ),
  ];

  @override
  void initState() {
    super.initState();
    
    // Initialize fade animation controller
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    // Initialize scale animation controller
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );

    // Start initial animations
    _fadeController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _onPageChanged(int value) {
    setState(() {
      _currentPage = value;
    });
    
    // Reset and replay animations on page change
    _fadeController.reset();
    _scaleController.reset();
    _fadeController.forward();
    _scaleController.forward();
  }

  void _goToLoginScreen() {
     Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeBackScreen()),
    );
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => const LoginScreen()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button with Fade Animation
            FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: _goToLoginScreen,
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 206, 204, 213),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            // PageView with animated content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _contents.length,
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    content: _contents[index],
                    fadeAnimation: _fadeAnimation,
                    scaleAnimation: _scaleAnimation,
                  );
                },
              ),
            ),
            
            // Bottom Section with Indicators and Button
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Column(
                children: [
                  // Animated Dot Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _contents.length,
                      (index) => _buildDotIndicator(index),
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // Animated Next Button
                  AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFF5931DD),
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF5931DD).withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {
                              if (_currentPage == _contents.length - 1) {
                                _goToLoginScreen();
                              } else {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            icon: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDotIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: 10,
      width: _currentPage == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: _currentPage == index
            ? const Color(0xFF5931DD)
            : const Color(0xFFD9D9D9),
      ),
    );
  }
}

class OnboardingContent {
  final String image;
  final String title;
  final String description;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnboardingPage extends StatefulWidget {
  final OnboardingContent content;
  final Animation<double> fadeAnimation;
  final Animation<double> scaleAnimation;

  const OnboardingPage({
    super.key,
    required this.content,
    required this.fadeAnimation,
    required this.scaleAnimation,
  });

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    
    // Create juggling/bouncing animation for the image
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(
        parent: _bounceController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Image with juggling animation
          Expanded(
            flex: 3,
            child: AnimatedBuilder(
              animation: _bounceAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _bounceAnimation.value),
                  child: FadeTransition(
                    opacity: widget.fadeAnimation,
                    child: ScaleTransition(
                      scale: widget.scaleAnimation,
                      child: Image.asset(
                        widget.content.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Text content with slide-up animation
          Expanded(
            flex: 2,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: widget.fadeAnimation,
                  curve: Curves.easeOut,
                ),
              ),
              child: FadeTransition(
                opacity: widget.fadeAnimation,
                child: Column(
                  children: [
                    Text(
                      widget.content.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.content.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}