import 'package:flutter/material.dart';
import 'package:medical_user_app/providers/auth_provider.dart';
import 'package:medical_user_app/view/welcome_back_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisclaimerDialog {
  static const String _disclaimerShownKey = 'disclaimer_shown';

  /// Shows the disclaimer dialog if it hasn't been shown before
  static Future<void> showIfNeeded(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final hasShown = prefs.getBool(_disclaimerShownKey) ?? false;

    if (!hasShown && context.mounted) {
      await _showDisclaimerDialog(context);
      await prefs.setBool(_disclaimerShownKey, true);
    }
  }

  /// Force show the disclaimer (for testing purposes)
  static Future<void> show(BuildContext context) async {
    await _showDisclaimerDialog(context);
  }

  /// Reset the disclaimer shown flag (for testing purposes)
  static Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_disclaimerShownKey);
  }

  static Future<void> _showDisclaimerDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Color(0xFF5931DD),
                  size: 28,
                ),
                SizedBox(width: 12),
                Text(
                  'Disclaimer',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: const Text(
              'This app provides approved over-the-counter (OTC) medicines from licensed pharmacies.  '
              'This app does not provide medical advice. Please consult a qualified doctor for any health concerns ',
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await Provider.of<AuthProvider>(context, listen: false)
                      .logout(context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const WelcomeBackScreen()),
                    (route) => false,
                  );
                  // Exit the app
                  // Navigator.of(context).pop();
                  // You might want to call SystemNavigator.pop() to exit the app
                },
                child: const Text(
                  'Exit App',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5931DD),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Accept',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
