import 'package:flutter/material.dart';
import 'package:medical_user_app/view/welcome_back_screen.dart';
import 'package:medical_user_app/view/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Illustration
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 330,
                  height: 278,
                  child: Image.asset("assets/getstart.jpg"),
                ),
              ),
              const SizedBox(height: 40),

              // Title
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Get Started',
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
                  'Start with Login Or Signup',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Login Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomeBackScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5931DD),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Or divider
              // Row(
              //   children: const [
              //     Expanded(child: Divider(thickness: 1)),
              //     Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 16),
              //       child: Text(
              //         'Or',
              //         style: TextStyle(color: Colors.grey),
              //       ),
              //     ),
              //     Expanded(child: Divider(thickness: 1)),
              //   ],
              // ),
              const SizedBox(height: 20),
              // Social Login Options
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     _socialLoginButton('assets/icons/google.png', () {
              //       // Google login logic
              //     }),
              //     const SizedBox(width: 24),
              //     _socialLoginButton('assets/icons/facebook.png', () {
              //       // Facebook login logic
              //     }),
              //     const SizedBox(width: 24),
              //     _socialLoginButton('assets/icons/x.png', () {
              //       // Twitter/X login logic
              //     }),
              //   ],
              // ),
              const Spacer(),
              // Sign Up Option
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      }, 
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xFF5931DD),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialLoginButton(String assetName, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Center(
          child: Image.asset(
            assetName,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}