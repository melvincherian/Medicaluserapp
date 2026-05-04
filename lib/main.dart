import 'package:flutter/material.dart';
import 'package:medical_user_app/providers/add_query_provider.dart';
import 'package:medical_user_app/providers/address_provider.dart';
import 'package:medical_user_app/providers/cart_provider.dart';
import 'package:medical_user_app/providers/category_provider.dart';
import 'package:medical_user_app/providers/chat_provider.dart';
import 'package:medical_user_app/providers/get_prescription_provider.dart';
import 'package:medical_user_app/providers/language_provider.dart';
import 'package:medical_user_app/providers/location_provider.dart';
import 'package:medical_user_app/providers/medicine_provider.dart';
import 'package:medical_user_app/providers/notification_provider.dart';
import 'package:medical_user_app/providers/order_provider.dart';
import 'package:medical_user_app/providers/order_status_provider.dart';
import 'package:medical_user_app/providers/periodic_plan_provider.dart';
import 'package:medical_user_app/providers/pharmacy_medicine_provider.dart';
import 'package:medical_user_app/providers/pharmacy_provider.dart';
import 'package:medical_user_app/providers/prescription_provider.dart';
import 'package:medical_user_app/providers/profile_provider.dart';
import 'package:medical_user_app/providers/services_provider.dart';
import 'package:medical_user_app/providers/theame_provider.dart';
import 'package:medical_user_app/providers/vendor_prescription_provider.dart';
import 'package:provider/provider.dart';
import 'package:medical_user_app/view/splash_screen.dart';
import 'package:medical_user_app/providers/auth_provider.dart';

// Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print("Background message: ${message.messageId}");
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //   await Firebase.initializeApp();

  // // Background handler
  // FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ServiceProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => MedicineProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => PharmacyProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => AddressProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => AddQueryProvider()),
        ChangeNotifierProvider(create: (context) => PrescriptionProvider()),
        ChangeNotifierProvider(create: (context) => GetPrescriptionProvider()),
        ChangeNotifierProvider(create: (context) => OrderStatusProvider()),
        ChangeNotifierProvider(create: (context) => PeriodicPlanProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => PharmacyMedicineProvider()),
        ChangeNotifierProvider(create: (context) => ChatProvider()),
        ChangeNotifierProvider(
            create: (context) => PrescriptionPreviewProvider()),

        // Add more providers here as needed
      ],
      child: Consumer2<ThemeProvider, LanguageProvider>(
        builder: (context, themeProvider, languageProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: languageProvider.locale,
            theme: ThemeData.light().copyWith(
              textTheme:
                  ThemeData.light().textTheme.apply(fontFamily: 'Poppins'),
            ),
            darkTheme: ThemeData.dark().copyWith(
              textTheme:
                  ThemeData.dark().textTheme.apply(fontFamily: 'Poppins'),
            ),
            themeMode: themeProvider.themeMode,
            home: SplashScreen(),
            // home: NavbarScreen(),
          );
        },
      ),
    );
  }
}
