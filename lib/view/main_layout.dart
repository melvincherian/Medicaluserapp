import 'package:flutter/material.dart';
import 'package:medical_user_app/providers/language_provider.dart';
import 'package:medical_user_app/view/cart_screen.dart';
import 'package:medical_user_app/view/checkout_screen.dart';
import 'package:medical_user_app/view/global/global_widget.dart';
import 'package:medical_user_app/view/home_screen.dart' hide CheckoutScreen;
import 'package:medical_user_app/view/near_pharmacy_screen.dart';
import 'package:medical_user_app/view/pharmacy_screen.dart';
import 'package:medical_user_app/view/profile_screen.dart';
import 'package:medical_user_app/view/medicine_scanner_screen.dart';

// Custom painter for the curved navigation bar
class NavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw the curved path for outline only (stroke)
    Paint linePaint = Paint()
      ..color = Colors.grey.shade400 // Slightly dark gray line
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5; // Thin line

    Path curvePath = Path();
    curvePath.moveTo(0, 0);
    curvePath.lineTo(size.width * 0.2, 0);

    // Left curve
    curvePath.quadraticBezierTo(
      size.width * 0.30,
      0,
      size.width * 0.38,
      30,
    );

    // Bottom of notch
    curvePath.quadraticBezierTo(
      size.width * 0.50,
      70,
      size.width * 0.62,
      30,
    );

    // Right curve
    curvePath.quadraticBezierTo(
      size.width * 0.70,
      0,
      size.width * 0.80,
      0,
    );

    curvePath.lineTo(size.width, 0);

    canvas.drawPath(curvePath, linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class MainLayout extends StatefulWidget {
  final int initialIndex;

  const MainLayout({
    Key? key,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _selectedIndex;
  DateTime? currentBackPressTime;

  bool _isNavigating = false;

  final amount = 100;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  // List of screens to navigate between
  static final List<Widget> _screens = [
    const HomeScreen(),
    CartScreen(
      amount: 100,
    ),
    const ProfileScreen(),
    const CheckoutScreen(),
    const NearPharmacyScreen(),
    const PharmacyScreen()
  ];

  void _onItemTapped(int index) {
    // Only allow navigation to Home and Cart
    if (index == 0 || index == 1) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _navigateToPrescriptionUpload() {
    if (!_isNavigating) {
      _isNavigating = true;
      Navigator.of(context)
          .push(
        MaterialPageRoute(
          builder: (context) => const PrescriptionUploadScreen(),
        ),
      )
          .then((_) {
        _isNavigating = false;
      });
    }
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Do you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  'No',
                  style: TextStyle(color: Color(0XFF5931DD)),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Color(0XFF5931DD)),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            IndexedStack(
              index: _selectedIndex,
              children: _screens,
            ),

            // GLOBAL ORDER BOX
            // Positioned(
            //   left: 0,
            //   right: 0,
            //   bottom: 140, // above navbar
            //   child: const GlobalOrderBox(),
            // ),
          ],
        ),
        bottomNavigationBar: _buildCustomBottomNavBar(),
        extendBody: true,
      ),
    );
  }

  Widget _buildCustomBottomNavBar() {
    // Get the bottom padding (system navigation bar height)
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        // Custom curved navigation bar with SafeArea
        Container(
          height: 80 + bottomPadding, // Add bottom padding to height
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 0,
                blurRadius: 0,
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Custom curved shape for the navigation bar
              CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 80),
                painter: NavBarPainter(),
              ),

              // Nav bar content with bottom padding
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: bottomPadding, // Push content up from system navbar
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Home button
                    Expanded(
                      child: InkWell(
                        onTap: () => _onItemTapped(0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home,
                              color: _selectedIndex == 0
                                  ? const Color(0XFF5931DD)
                                  : Colors.grey,
                            ),
                            const SizedBox(height: 4),
                            AppText(
                              'home',
                              style: TextStyle(
                                color: _selectedIndex == 0
                                    ? const Color(0XFF5931DD)
                                    : Colors.grey,
                                fontWeight: _selectedIndex == 0
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Empty space for the center button
                    const Expanded(child: SizedBox()),

                    // Cart button
                    Expanded(
                      child: InkWell(
                        onTap: () => _onItemTapped(1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: _selectedIndex == 1
                                  ? const Color(0XFF5931DD)
                                  : Colors.grey,
                            ),
                            const SizedBox(height: 4),
                            AppText(
                              'cart',
                              style: TextStyle(
                                color: _selectedIndex == 1
                                    ? const Color(0XFF5931DD)
                                    : Colors.grey,
                                fontWeight: _selectedIndex == 1
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Center scan button (positioned outside the curve) - FIXED
        // 55 is the correct one
        Positioned(
          bottom: 45 + bottomPadding,
          left: 0,
          right: 0,
          child: Center(
            child: GestureDetector(
              onTap: _navigateToPrescriptionUpload,
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0XFF5931DD),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0XFF5931DD).withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.crop_free,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
