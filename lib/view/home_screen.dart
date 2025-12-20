// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:medical_user_app/models/medicine_model.dart';
import 'package:medical_user_app/models/user_model.dart';
import 'package:medical_user_app/providers/category_provider.dart';
import 'package:medical_user_app/providers/language_provider.dart';
import 'package:medical_user_app/providers/location_provider.dart';
import 'package:medical_user_app/providers/medicine_provider.dart';
import 'package:medical_user_app/providers/notification_provider.dart';
import 'package:medical_user_app/providers/profile_provider.dart';
import 'package:medical_user_app/providers/services_provider.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';
import 'package:medical_user_app/view/category_screen.dart';
import 'package:medical_user_app/view/checkout_screen.dart';
import 'package:medical_user_app/view/near_pharmacy_screen.dart';
import 'package:medical_user_app/view/notification_screen.dart';
import 'package:medical_user_app/view/order_hystory_screen.dart';
import 'package:medical_user_app/view/profile_screen.dart';
import 'package:medical_user_app/view/scanned_medicine_screen.dart';
import 'package:medical_user_app/view/search/search_screen.dart';
import 'package:medical_user_app/view/search/user_location_screen.dart';
import 'package:medical_user_app/widgets/all_medicines.dart';
import 'package:medical_user_app/widgets/bottom_navigation.dart';
import 'package:medical_user_app/widgets/courosel_widget.dart';
import 'package:medical_user_app/widgets/desclaimer_dialog_widget.dart';
import 'package:medical_user_app/widgets/order_widget.dart';
import 'package:medical_user_app/widgets/periodic_plans.dart' hide Pharmacy;
import 'package:medical_user_app/widgets/previous_order.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' hide RefreshIndicator;
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RefreshController _refreshController = RefreshController();
  bool _isRefreshing = false;

  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _isListening = false;
  String _lastWords = '';
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;
  String _lastLang = 'en';
  String? userId;
  bool isLoading = true;

  bool _isLoadingCurrentLocation = false;

  @override
  void initState() {
    _loadUserId();
    super.initState();
    _initSpeech();
    _handleRefresh();
    _handleCurrentLocation();
    Future.microtask(() {
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      profileProvider.initializeUser();
      profileProvider.fetchUserProfile();
    });

    // Use addPostFrameCallback to access Provider after the widget tree is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DisclaimerDialog.showIfNeeded(context);
      final langCode = Provider.of<LanguageProvider>(context, listen: false)
          .locale
          .languageCode;

      // Fetch services when the screen loads
      context.read<ServiceProvider>().fetchAllServices();
      context
          .read<CategoryProvider>()
          .fetchCategories(serviceName: "", languageCode: langCode);
      context.read<MedicineProvider>().loadMedicines();
    });
  }

  Future<void> _handleRefresh() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
    });

    try {
      // Refresh all necessary data
      await _refreshAllData();

      if (mounted) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content: Text('Page refreshed successfully'),
        //     backgroundColor: Colors.green,
        //     duration: Duration(seconds: 2),
        //   ),
        // );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Refresh failed: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isRefreshing = false;
        });
      }
    }
  }

  Future<void> _refreshAllData() async {
    try {
      // Refresh user data
      await _loadUserId();

      // Refresh location
      await _handleCurrentLocation();

      // Refresh profile
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      await profileProvider.initializeUser();

      // Refresh services, categories, and medicines
      final langCode = Provider.of<LanguageProvider>(context, listen: false)
          .locale
          .languageCode;

      await context.read<ServiceProvider>().fetchAllServices();
      await context
          .read<CategoryProvider>()
          .fetchCategories(serviceName: "", languageCode: langCode);
      await context.read<MedicineProvider>().loadMedicines();

      // Refresh notifications if needed
      await context
          .read<NotificationProvider>()
          .loadNotifications(userId.toString());
    } catch (e) {
      print('Error during refresh: $e');
      rethrow;
    }
  }

  Future<void> _loadUserId() async {
    try {
      final storedUser = await SharedPreferencesHelper.getUser();
      setState(() {
        userId = storedUser?.id;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error loading user: $e');
    }
  }

  Future<void> _handleCurrentLocation() async {
    setState(() {
      _isLoadingCurrentLocation = true;
    });

    try {
      final locationProvider = Provider.of<LocationProvider>(
        context,
        listen: false,
      );
      await locationProvider.initLocation(userId.toString());

      if (mounted) {
        if (locationProvider.hasError) {
          _showError(locationProvider.errorMessage);
        }
      }
    } catch (e) {
      if (mounted) {
        _showError("Failed to get current location: ${e.toString()}");
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingCurrentLocation = false;
        });
      }
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _initSpeech() async {
    // Check and request microphone permission
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      print('Microphone permission denied');
      return;
    }

    try {
      _speechEnabled = await _speechToText.initialize(
        onStatus: (status) {
          print('Speech recognition status: $status');
          if (status == 'done' || status == 'notListening') {
            setState(() {
              _isListening = false;
            });
          }
        },
        onError: (error) {
          print('Speech recognition error: $error');
          setState(() {
            _isListening = false;
          });
          _showErrorSnackBar('Voice recognition error: ${error.errorMsg}');
        },
      );
    } catch (e) {
      print('Failed to initialize speech recognition: $e');
      _speechEnabled = false;
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _startListening() async {
    if (!_speechEnabled) {
      _showErrorSnackBar('Speech recognition not available');
      return;
    }

    try {
      await _speechToText.listen(
        onResult: (result) {
          setState(() {
            _lastWords = result.recognizedWords;
            _searchController.text = _lastWords;
          });

          // Automatically search when speech is recognized
          if (result.finalResult && _lastWords.isNotEmpty) {
            _performSearch(_lastWords);
          }
        },
        listenFor: Duration(seconds: 30), // Listen for up to 30 seconds
        pauseFor:
            Duration(seconds: 3), // Stop listening after 3 seconds of silence
        partialResults: true,
        localeId: _getCurrentLanguageCode(),
        cancelOnError: true,
        listenMode: ListenMode.confirmation,
      );

      setState(() {
        _isListening = true;
      });
    } catch (e) {
      print('Error starting speech recognition: $e');
      _showErrorSnackBar('Failed to start voice recognition');
    }
  }

  String _getCurrentLanguageCode() {
    final langCode = Provider.of<LanguageProvider>(context, listen: false)
        .locale
        .languageCode;

    // Map your app's language codes to speech recognition locale IDs
    switch (langCode) {
      case 'te':
        return 'te-IN'; // Telugu (India)
      case 'hi':
        return 'hi-IN'; // Hindi (India)
      case 'en':
      default:
        return 'en-US'; // English (US)
    }
  }

  void _performSearch(String query) {
    if (query.trim().isEmpty) return;

    // Search in medicines
    // final medicineProvider = Provider.of<MedicineProvider>(context, listen: false);
    // medicineProvider.searchMedicines(query);

    // You can also add category search here if needed
    _showSuccessSnackBar('Searching for: $query');
  }

  /// Show error message
  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
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
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      _isListening = false;
    });
  }

  void _initializeUserData() {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final user = profileProvider.user;

    // Debug print to check if user data exists
    print('Initializing user data: ${user?.name}, ${user?.mobile}');

    if (user != null) {
      _initializeUserData();

      // Force rebuild to show the data
      if (mounted) {
        setState(() {});
      }
    } else if (user == null) {
      // If user is null, try to initialize the provider
      print('User is null, trying to initialize provider...');
      profileProvider.initializeUser().then((_) {
        if (profileProvider.user != null) {
          _initializeUserData(); // Recursive call after initialization
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final langCode = Provider.of<LanguageProvider>(context).locale.languageCode;
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);

    if (_lastLang != langCode) {
      _lastLang = langCode;
      categoryProvider.loadAllCategories(langCode);
    }
  }

  String? _selectedCategory;
  void _onCategorySelected(String categoryName) {
    setState(() {
      _selectedCategory = categoryName;
    });
    final medicineProvider =
        Provider.of<MedicineProvider>(context, listen: false);

    if (categoryName.toLowerCase() == 'all' || categoryName.isEmpty) {
      // Show all medicines
      medicineProvider.loadAllMedicines();
    } else {
      // Show medicines for selected category
      medicineProvider.loadMedicinesByCategory(categoryName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Consumer<ProfileProvider>(
                      //   builder: (context, profileProvider, child) {
                      //     return GestureDetector(
                      //       onTap: () {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => ProfileScreen()));
                      //       },
                      //       child: CircleAvatar(
                      //         radius: 24,
                      //         backgroundColor: Colors.grey[300],
                      //         backgroundImage: profileProvider.hasProfileImage()
                      //             ? NetworkImage(
                      //                 profileProvider.getProfileImageUrl()!)
                      //             : const AssetImage('assets/profile.png')
                      //                 as ImageProvider,
                      //         onBackgroundImageError:
                      //             profileProvider.hasProfileImage()
                      //                 ? (exception, stackTrace) {
                      //                     // This will cause the CircleAvatar to fall back to showing backgroundColor
                      //                     // You could also set a flag here to show the asset image instead
                      //                   }
                      //                 : null,
                      //         child: profileProvider.hasProfileImage()
                      //             ? null
                      //             : Image.asset(
                      //                 'assets/profile.png',
                      //                 fit: BoxFit.cover,
                      //               ),
                      //       ),
                      //     );
                      //   },
                      // ),

                      // Consumer<ProfileProvider>(
                      //   builder: (context, profileProvider, child) {
                      //     return GestureDetector(
                      //       onTap: () {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) =>
                      //                     const ProfileScreen()));
                      //       },
                      //       child: CircleAvatar(
                      //         radius: 24,
                      //         backgroundColor: Colors.grey[300],
                      //         backgroundImage: profileProvider.hasProfileImage()
                      //             ? NetworkImage(
                      //                 profileProvider.getProfileImageUrl()!)
                      //             : null,
                      //         onBackgroundImageError:
                      //             profileProvider.hasProfileImage()
                      //                 ? (exception, stackTrace) {
                      //                     // This will cause the CircleAvatar to fall back to showing backgroundColor
                      //                   }
                      //                 : null,
                      //       ),
                      //     );
                      //   },
                      // ),

                      Consumer<ProfileProvider>(
                        builder: (context, profileProvider, child) {
                          final hasImage = profileProvider.hasProfileImage();
                          final imageUrl = profileProvider.getProfileImageUrl();

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProfileScreen()),
                              );
                            },
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.grey[300],
                              backgroundImage:
                                  hasImage ? NetworkImage(imageUrl!) : null,
                              onBackgroundImageError: hasImage
                                  ? (exception, stackTrace) {
                                      // fallback happens automatically
                                    }
                                  : null,
                              child: !hasImage
                                  ? Icon(
                                      Icons.person,
                                      size: 28,
                                      color: Colors.grey[700],
                                    )
                                  : null,
                            ),
                          );
                        },
                      ),

                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                               AppText('Hello 👋',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey[600])),
                            // AppText('wish',
                            //     style: TextStyle(
                            //         fontSize: 16, color: Colors.grey[600])),
                            Row(
                              children: [
                                // User name section
                                Expanded(
                                  child: FutureBuilder<User?>(
                                    future: SharedPreferencesHelper.getUser(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Text(
                                          "Loading...",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        );
                                      } else if (snapshot.hasError) {
                                        return const Text(
                                          "User",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        );
                                      } else if (snapshot.hasData &&
                                          snapshot.data != null) {
                                        return Text(
                                          snapshot.data!.name,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        );
                                      } else {
                                        return const Text(
                                          "Guest",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Location Consumer integrated here
                            Consumer<LocationProvider>(
                              builder: (context, locationProvider, child) {
                                final addressParts =
                                    (locationProvider?.address ?? '')
                                        .split(',')
                                        .map((e) => e.trim())
                                        .toList();
                                final primaryAddress = addressParts.isNotEmpty
                                    ? addressParts[0]
                                    : 'Unknown location';
                                final secondaryAddress = addressParts.length > 1
                                    ? addressParts.sublist(1).join(', ')
                                    : '';

                                return GestureDetector(
                                  onTap: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            LocationSearchScreen(
                                                userId: userId.toString()),
                                      ),
                                    );

                                    if (result == true && mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: const Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              SizedBox(width: 8),
                                              Text('Updating location...'),
                                            ],
                                          ),
                                          backgroundColor:
                                              const Color(0xFF6366F1),
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          margin: const EdgeInsets.all(16),
                                        ),
                                      );
                                      // await _handleRefresh();
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 6,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF6366F1)
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Icon(
                                            Icons.location_on,
                                            color: Color(0xFF6366F1),
                                            size: 16,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (locationProvider?.isLoading ==
                                                  true)
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 10,
                                                      height: 10,
                                                      child:
                                                          CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        color:
                                                            Color(0xFF6366F1),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      'Loading',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey[600],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              else if (locationProvider
                                                      ?.hasError ==
                                                  true)
                                                const Text(
                                                  'Tap to set location',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFF6366F1),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )
                                              else ...[
                                                Text(
                                                  primaryAddress,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFF1F2937),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                if (secondaryAddress.isNotEmpty)
                                                  Text(
                                                    secondaryAddress,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.grey[600],
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Container(
                      //   padding: const EdgeInsets.all(8),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(12),
                      //     border: Border.all(color: Colors.black12),
                      //   ),
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       showModalBottomSheet(
                      //         context: context,
                      //         shape: const RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.vertical(
                      //               top: Radius.circular(20)),
                      //         ),
                      //         builder: (BuildContext context) {
                      //           return Consumer<LanguageProvider>(
                      //             builder: (context, languageProvider, child) {
                      //               return Padding(
                      //                 padding: const EdgeInsets.all(16.0),
                      //                 child: Column(
                      //                   mainAxisSize: MainAxisSize.min,
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   children: [
                      //                     // Header
                      //                     Row(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.spaceBetween,
                      //                       children: [
                      //                         const Text(
                      //                           'Select Language',
                      //                           style: TextStyle(
                      //                             fontSize: 20,
                      //                             fontWeight: FontWeight.bold,
                      //                           ),
                      //                         ),
                      //                         IconButton(
                      //                           onPressed: () =>
                      //                               Navigator.pop(context),
                      //                           icon: const Icon(Icons.close),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                     const SizedBox(height: 16),
                      //                     // _buildLanguageOption(
                      //                     //   context: context,
                      //                     //   languageCode: 'te',
                      //                     //   languageName: 'తెలుగు (Telugu)',
                      //                     //   languageProvider: languageProvider,
                      //                     // ),
                      //                     // _buildLanguageOption(
                      //                     //   context: context,
                      //                     //   languageCode: 'en',
                      //                     //   languageName: 'English',
                      //                     //   languageProvider: languageProvider,
                      //                     // ),
                      //                     // _buildLanguageOption(
                      //                     //   context: context,
                      //                     //   languageCode: 'hi',
                      //                     //   languageName: 'हिंदी (Hindi)',
                      //                     //   languageProvider: languageProvider,
                      //                     // ),
                      //                     const SizedBox(height: 20),
                      //                   ],
                      //                 ),
                      //               );
                      //             },
                      //           );
                      //         },
                      //       );
                      //     },
                      //     child: const Icon(Icons.translate, size: 24),
                      //   ),
                      // ),
                      const SizedBox(width: 12),
                      // SizedBox(
                      //   width: 40,
                      //   height: 40,
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => NotificationScreen()),
                      //       );
                      //     },
                      //     child: Container(
                      //       padding: EdgeInsets.all(8),
                      //       decoration: BoxDecoration(
                      //         color: Colors.grey[100],
                      //         shape: BoxShape.circle,
                      //       ),
                      //       child: Stack(
                      //         clipBehavior: Clip.none,
                      //         children: [
                      //           // Notification Bell Icon
                      //           Icon(
                      //             Icons.notifications_none,
                      //             size: 24,
                      //             color: Colors.black54,
                      //           ),
                      //           // Red Badge Dot
                      //           Positioned(
                      //             right: -2,
                      //             top: -2,
                      //             child: Container(
                      //               width: 14,
                      //               height: 14,
                      //               decoration: BoxDecoration(
                      //                 color: Colors.red,
                      //                 shape: BoxShape.circle,
                      //                 border: Border.all(
                      //                   color: Colors.white,
                      //                   width: 2,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // )

                      SizedBox(
                        width: 40,
                        height: 40,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const NotificationScreen()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              shape: BoxShape.circle,
                            ),
                            child: Consumer<NotificationProvider>(
                              builder: (context, notificationProvider, child) {
                                return Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    // Notification Bell Icon
                                    const Icon(
                                      Icons.notifications_none,
                                      size: 24,
                                      color: Colors.black54,
                                    ),
                                    // Conditional Red Badge Dot
                                    if (notificationProvider
                                        .notifications.isNotEmpty)
                                      Positioned(
                                        right: -2,
                                        top: -2,
                                        child: Container(
                                          width: 14,
                                          height: 14,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  // Profile and notification row
                  // Row(
                  //   children: [
                  //     Consumer<ProfileProvider>(
                  //       builder: (context, profileProvider, child) {
                  //         return GestureDetector(
                  //           onTap: () {
                  //             Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                     builder: (context) => ProfileScreen()));
                  //           },
                  //           child: CircleAvatar(
                  //             radius: 24,
                  //             backgroundColor: Colors.grey[300],
                  //             backgroundImage: profileProvider.hasProfileImage()
                  //                 ? NetworkImage(
                  //                     profileProvider.getProfileImageUrl()!)
                  //                 : const AssetImage('')
                  //                     as ImageProvider,
                  //             onBackgroundImageError:
                  //                 profileProvider.hasProfileImage()
                  //                     ? (exception, stackTrace) {
                  //                         // This will cause the CircleAvatar to fall back to showing backgroundColor
                  //                         // You could also set a flag here to show the asset image instead
                  //                       }
                  //                     : null,
                  //             child: profileProvider.hasProfileImage()
                  //                 ? null
                  //                 : Image.asset(
                  //                     'assets/profile.png',
                  //                     fit: BoxFit.cover,
                  //                   ),
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //     SizedBox(width: 12),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         AppText('wish',
                  //             style: TextStyle(
                  //                 fontSize: 16, color: Colors.grey[600])),
                  //         FutureBuilder<User?>(
                  //           future: SharedPreferencesHelper.getUser(),
                  //           builder: (context, snapshot) {
                  //             if (snapshot.connectionState ==
                  //                 ConnectionState.waiting) {
                  //               return Text(
                  //                 "Loading...",
                  //                 style: TextStyle(
                  //                     fontSize: 18, fontWeight: FontWeight.bold),
                  //               );
                  //             } else if (snapshot.hasError) {
                  //               return Text(
                  //                 "User",
                  //                 style: TextStyle(
                  //                     fontSize: 18, fontWeight: FontWeight.bold),
                  //               );
                  //             } else if (snapshot.hasData &&
                  //                 snapshot.data != null) {
                  //               return Text(
                  //                 snapshot.data!.name,
                  //                 style: TextStyle(
                  //                     fontSize: 18, fontWeight: FontWeight.bold),
                  //               );
                  //             } else {
                  //               return Text(
                  //                 "Guest",
                  //                 style: TextStyle(
                  //                     fontSize: 18, fontWeight: FontWeight.bold),
                  //               );
                  //             }
                  //           },
                  //         ),
                  //       ],
                  //     ),
                  //     Spacer(),
                  //     Container(
                  //       padding: const EdgeInsets.all(8),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(12),
                  //         border: Border.all(color: Colors.black12),
                  //       ),
                  //       child: GestureDetector(
                  //         onTap: () {
                  //           showModalBottomSheet(
                  //             context: context,
                  //             shape: const RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.vertical(
                  //                   top: Radius.circular(20)),
                  //             ),
                  //             builder: (BuildContext context) {
                  //               return Consumer<LanguageProvider>(
                  //                 builder: (context, languageProvider, child) {
                  //                   return Padding(
                  //                     padding: const EdgeInsets.all(16.0),
                  //                     child: Column(
                  //                       mainAxisSize: MainAxisSize.min,
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.start,
                  //                       children: [
                  //                         // Header
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             const Text(
                  //                               'Select Language',
                  //                               style: TextStyle(
                  //                                 fontSize: 20,
                  //                                 fontWeight: FontWeight.bold,
                  //                               ),
                  //                             ),
                  //                             IconButton(
                  //                               onPressed: () =>
                  //                                   Navigator.pop(context),
                  //                               icon: const Icon(Icons.close),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                         const SizedBox(height: 16),
                  //                         _buildLanguageOption(
                  //                           context: context,
                  //                           languageCode: 'te',
                  //                           languageName: 'తెలుగు (Telugu)',
                  //                           languageProvider: languageProvider,
                  //                         ),
                  //                         _buildLanguageOption(
                  //                           context: context,
                  //                           languageCode: 'en',
                  //                           languageName: 'English',
                  //                           languageProvider: languageProvider,
                  //                         ),
                  //                         _buildLanguageOption(
                  //                           context: context,
                  //                           languageCode: 'hi',
                  //                           languageName: 'हिंदी (Hindi)',
                  //                           languageProvider: languageProvider,
                  //                         ),

                  //                         const SizedBox(height: 20),
                  //                       ],
                  //                     ),
                  //                   );
                  //                 },
                  //               );
                  //             },
                  //           );
                  //         },
                  //         child: const Icon(Icons.translate, size: 24),
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 12,
                  //     ),
                  //     SizedBox(
                  //       width: 40,
                  //       height: 40,
                  //       child: GestureDetector(
                  //         onTap: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => NotificationScreen()),
                  //           );
                  //         },
                  //         child: Container(
                  //           padding: EdgeInsets.all(8),
                  //           decoration: BoxDecoration(
                  //             color: Colors.grey[100],
                  //             shape: BoxShape.circle,
                  //           ),
                  //           child: Stack(
                  //             clipBehavior: Clip.none,
                  //             children: [
                  //               // Notification Bell Icon
                  //               Icon(
                  //                 Icons.notifications_none,
                  //                 size: 24,
                  //                 color: Colors.black54,
                  //               ),

                  //               // Red Badge Dot
                  //               Positioned(
                  //                 right: -2,
                  //                 top: -2,
                  //                 child: Container(
                  //                   width: 14,
                  //                   height: 14,
                  //                   decoration: BoxDecoration(
                  //                     color: Colors.red,
                  //                     shape: BoxShape.circle,
                  //                     border: Border.all(
                  //                       color: Colors
                  //                           .white, // White border to match background
                  //                       width: 2,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SearchScreen()),
                            );
                          },
                          decoration: InputDecoration(
                            hintText:
                                AppText.translate(context, 'search_medicine'),
                            hintStyle: const TextStyle(color: Colors.grey),
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.grey),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            fillColor: const Color(0xFFEFF3F7),
                            filled: true,
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),
                      // Container(
                      //   padding: const EdgeInsets.all(12),
                      //   decoration: const BoxDecoration(
                      //     color: Color(0xFF5931DD),
                      //     shape: BoxShape.circle,
                      //   ),
                      //   child: const Icon(Icons.mic, color: Colors.white),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  const OrderMedicineCarouselWithAppText(),

                  const SizedBox(height: 24),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        "services",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Consumer<ServiceProvider>(
                    builder: (context, serviceProvider, child) {
                      if (serviceProvider.isLoading) {
                        return Container(
                          height: 110,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF5931DD),
                            ),
                          ),
                        );
                      }

                      if (serviceProvider.hasError) {
                        return Container(
                          height: 110,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Text(
                                //   'Error loading services',
                                //   style:
                                //       TextStyle(color: Colors.red, fontSize: 14),
                                // ),
                                SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    serviceProvider.fetchAllServices();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF5931DD),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                  ),
                                  child: Text(
                                    'Retry',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      if (!serviceProvider.hasServices) {
                        return Container(
                          height: 110,
                          child: Center(
                            child: Text(
                              'No services available',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                        );
                      }

                      // Display services in a horizontal scrollable list
                      return Container(
                        height: 110,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: serviceProvider.services.length,
                          itemBuilder: (context, index) {
                            final service = serviceProvider.services[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                right:
                                    index < serviceProvider.services.length - 1
                                        ? 12
                                        : 0,
                              ),
                              child: _buildServicesItem(
                                context: context,
                                imagePath: service.image.isNotEmpty
                                    ? service.image
                                    : 'assets/icons/pharmacy.png', // fallback image
                                label: service.servicesName,
                                serviceId: service.id,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 24),

                  // Category section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AppText(
                        "categories",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CategoryScreen()));
                            },
                            child: AppText(
                              "see_all",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Colors.grey[600], // gray color
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Consumer<CategoryProvider>(
                    builder: (context, categoryProvider, child) {
                      print("=== Debug Info ===");
                      print(
                          "isShowingAllCategories: ${categoryProvider.isShowingAllCategories}");
                      print(
                          "selectedServiceName: '${categoryProvider.selectedServiceName}'");
                      print("==================");

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedCategory = null;
                                  });
                                  print("Tapped All button");
                                  final langCode =
                                      Provider.of<LanguageProvider>(context,
                                              listen: false)
                                          .locale
                                          .languageCode;
                                  categoryProvider.loadAllCategories(langCode);
                                  // Load all medicines when "All" is selected
                                  _onCategorySelected('all');
                                },
                                child: _buildCategoryItem(
                                  imagePath: 'assets/icons/all.png',
                                  label: "All",
                                  isSelected:
                                      categoryProvider.isShowingAllCategories,
                                  categoryName: 'all',
                                ),
                              ),
                            ),

                            // Create individual category items for each unique category
                            ...categoryProvider.categories.map((category) {
                              bool isSelected =
                                  !categoryProvider.isShowingAllCategories &&
                                      categoryProvider.selectedServiceName ==
                                          category.serviceName;

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: GestureDetector(
                                  onTap: () {
                                    print(
                                        "Tapped category: ${category.categoryName}");

                                    setState(() {
                                      _selectedCategory = category
                                          .categoryName; // update selected
                                    });

                                    // Show popup/snackbar
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "Selected category: ${category.categoryName}"),
                                        duration: const Duration(seconds: 2),
                                        backgroundColor:
                                            const Color(0xFF5931DD),
                                      ),
                                    );

                                    categoryProvider.loadCategoriesByService(
                                        category.serviceName, _lastLang);

                                    _onCategorySelected(category.categoryName);
                                  },
                                  child: _buildCategoryItem(
                                    imagePath: category.image.isNotEmpty
                                        ? category.image
                                        : 'assets/icons/default_category.png',
                                    label: category.categoryName,
                                    isSelected: isSelected,
                                    categoryName: category.categoryName,
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),
                  FutureBuilder<User?>(
                    future: SharedPreferencesHelper.getUser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          // Loading state
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (snapshot.hasError || snapshot.data == null) {
                        return Container(
                          // Error or no user state
                          child: const Text('No active orders'),
                        );
                      } else {
                        // User exists, show order status
                        return OrderStatusWidget(userId: snapshot.data!.id);
                      }
                    },
                  ),

                  // OrderStatusWidget(userId: userId.toString(),),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AppText(
                        "previous_orders",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const OrdersHistoryScreen()));
                            },
                            child: AppText(
                              "see_all",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600], // gray color
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(
                              width: 4), // small space between text and icon
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Colors.grey[600], // gray color
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // Previous Orders Section
                  const MedicationOrdersList(),

                  const SizedBox(height: 24),

                  // Periodic Meds Plan
                  const PeriodicMedsPlanCardSimple(),
                  const SizedBox(height: 24),

                  // All Medicines
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        "all_medicines",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // AppText(
                      //   "filter",
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     color: Color(0xFF5931DD),
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Medicine grid
                  _buildAllMedicineCardGrid(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAllMedicineCardGrid(BuildContext context) {
    return Consumer<MedicineProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.medicines.isEmpty) {
          return const Center(child: Text("No medicines available."));
        }

        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 0.65,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: List.generate(
            provider.medicines.length,
            (index) =>
                _buildMedicineCardItem(context, provider.medicines[index]),
          ),
        );
      },
    );
  }

  Widget _buildMedicineCardItem(BuildContext context, MedicineModel medicine) {
    final String name = medicine.name;
    final String description = medicine.description;
    final String price = '₹${medicine.mrp}';
    // final String location =
    //     'Unknown Pharmacy'; // Replace when pharmacy is added
    final String imagePath =
        medicine.images.isNotEmpty ? medicine.images[0] : '';

    return Container(
      height: 280, // Fixed height for all cards
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScannedMedicineScreen(
                            medicineId: medicine.medicineId,
                            address: medicine.pharmacy.address,
                            mrp: medicine.mrp,
                          )));
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Stack(
                children: [
                  imagePath.isNotEmpty
                      ? Image.network(
                          imagePath,
                          height:
                              90, // Fixed the height from 78 to 120 to match the else case
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 120,
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported),
                        ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        price,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content section with fixed layout
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Medicine name - fixed height container
                  SizedBox(
                    height: 40, // Fixed height to accommodate 2 lines
                    child: Text(
                      name,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Description - single line
                  Text(
                    description.length > 25
                        ? '${description.substring(0, 25)}...'
                        : description,
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Location
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.deepPurple, size: 14),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${medicine.pharmacy.address}',
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  // Spacer to push button to bottom
                  const Spacer(),

                  // Button section - always at bottom
                  SizedBox(
                    width: double.infinity,
                    height: 36, // Consistent button height
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScannedMedicineScreen(
                                      medicineId: medicine.medicineId,
                                      address: medicine.pharmacy.address,
                                      mrp: medicine.mrp,
                                    )));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5931DD),
                        foregroundColor: Colors.white,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const AppText(
                        'Add On',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildLanguageOption({
  //   required BuildContext context,
  //   required String languageCode,
  //   required String languageName,
  //   required LanguageProvider languageProvider,
  // }) {
  //   final isSelected = languageProvider.locale.languageCode == languageCode;

  //   return ListTile(
  //     leading: Icon(
  //       Icons.language,
  //       color: isSelected ? Colors.blue : Colors.grey,
  //     ),
  //     title: Text(
  //       languageName,
  //       style: TextStyle(
  //         fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
  //         color: isSelected ? Colors.blue : Colors.black,
  //       ),
  //     ),
  //     trailing: isSelected ? const Icon(Icons.check, color: Colors.blue) : null,
  //     onTap: () async {
  //       try {
  //         // Change the language using your provider
  //         await languageProvider.setLocale(Locale(languageCode));

  //         // Close the modal
  //         if (context.mounted) {
  //           Navigator.pop(context);

  //           // Show confirmation with translated message
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(
  //               backgroundColor: Colors.green,
  //               content: Text(
  //                 LocalizationService.translate(
  //                     'language_switched', languageCode),
  //               ),
  //               duration: const Duration(seconds: 2),
  //             ),
  //           );
  //         }
  //       } catch (e) {
  //         print('Error changing language: $e');
  //         if (context.mounted) {
  //           Navigator.pop(context);
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(
  //               content: Text('Failed to change language'),
  //               duration: Duration(seconds: 2),
  //             ),
  //           );
  //         }
  //       }
  //     },
  //   );
  // }
}

// Helper methods for building UI components
Widget _buildStepItem({
  required String imagePath,
  required String label,
}) {
  return Column(
    children: [
      Container(
        width: 44,
        height: 44,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Image.asset(
          imagePath,
          width: 24,
          height: 24,
        ),
      ),
      const SizedBox(height: 6),
      AppText(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Colors.grey[600],
        ),
      ),
    ],
  );
}

String? _selectedCategory;

Widget _buildCategoryItem({
  required String imagePath,
  required String label,
  bool isSelected = false,
  required String categoryName,
}) {
  final bool actuallySelected = _selectedCategory == categoryName;

  return Container(
    width: 75,
    height: 90,
    decoration: BoxDecoration(
      color: actuallySelected
          ? const Color(0xFF5931DD).withOpacity(0.1)
          : Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: actuallySelected
            ? const Color(0xFF5931DD)
            : const Color(0xFF5931DD),
        width: 2,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildImageWidget(imagePath),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: actuallySelected
                    ? const Color(0xFF5931DD)
                    : Colors.grey[600],
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    ),
  );
}

// // Helper method to handle both network and asset images
Widget _buildImageWidget(String imagePath) {
  print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiii$imagePath");
  if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
    // Network image
    return Image.network(
      imagePath,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
            strokeWidth: 2,
          ),
        );
      },
    );
  } else {
    // Asset image
    return Image.asset(
      imagePath,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.category,
          size: 24,
          color: Colors.grey,
        );
      },
    );
  }
}

Widget _buildServicesItem({
  required BuildContext context, // <-- Add context here
  required String imagePath,
  required String label,
  required String serviceId,
}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NearPharmacyScreen()),
      );
    },
    child: Container(
      width: 90,
      height: 110,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF5931DD), // Purple border
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipOval(
                child: Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5931DD), // Purple text
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

class MedicineDetailsModal extends StatefulWidget {
  final String pharmacyName;
  final String medicineName;
  final String description;
  final String price;
  final String location;
  final String pharmacyImage;

  const MedicineDetailsModal({
    Key? key,
    required this.pharmacyName,
    required this.medicineName,
    required this.description,
    required this.price,
    required this.location,
    required this.pharmacyImage,
  }) : super(key: key);

  @override
  State<MedicineDetailsModal> createState() => _MedicineDetailsModalState();
}

class _MedicineDetailsModalState extends State<MedicineDetailsModal> {
  bool isChecked = false;
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _searchText = '';
  late TextEditingController _searchController;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchText = _searchController.text;
      _isSearching = _searchText.isNotEmpty;
    });
  }

  Future<void> _initSpeech() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        setState(() {
          _isListening = status == 'listening';
        });
      },
      onError: (error) {
        setState(() {
          _isListening = false;
        });
        _showErrorSnackBar('Voice recognition error: ${error.errorMsg}');
      },
    );

    if (!available) {
      _showErrorSnackBar('Speech recognition not available on this device');
    }
  }

  Future<void> _startListening() async {
    // Request microphone permission
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      _showErrorSnackBar('Microphone permission is required for voice search');
      return;
    }

    if (!_isListening) {
      await _initSpeech();
      if (_speech.isAvailable) {
        setState(() {
          _isListening = true;
        });

        await _speech.listen(
          onResult: (result) {
            setState(() {
              _searchController.text = result.recognizedWords;
            });
          },
          listenFor: const Duration(seconds: 10),
          pauseFor: const Duration(seconds: 3),
        );
      }
    } else {
      await _stopListening();
    }
  }

  Future<void> _stopListening() async {
    await _speech.stop();
    setState(() {
      _isListening = false;
    });
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  bool _matchesSearch() {
    if (_searchText.isEmpty) return true;

    final searchLower = _searchText.toLowerCase();
    return widget.medicineName.toLowerCase().contains(searchLower) ||
        widget.description.toLowerCase().contains(searchLower) ||
        widget.pharmacyName.toLowerCase().contains(searchLower);
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchText = '';
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 40),
                const Text(
                  'Periodic Meds Plan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          // Search results indicator
          if (_isSearching) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Searching for "$_searchText"',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  if (!_matchesSearch()) ...[
                    const SizedBox(width: 8),
                    const Text(
                      '• No matches',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Pharmacy/Medicine card - only show if matches search
          if (_matchesSearch()) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: widget.pharmacyImage.isNotEmpty
                        ? Image.network(
                            widget.pharmacyImage,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Icon(
                                  Icons.local_pharmacy,
                                  size: 30,
                                  color: Colors.grey[400],
                                ),
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Color(0xFF5931DD),
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.local_pharmacy,
                              size: 30,
                              color: Colors.grey[400],
                            ),
                          ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Pharmacy Name
                      Text(
                        widget.pharmacyName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 14,
                            color: Color.fromARGB(255, 87, 106, 245),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              widget.location,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Checkbox(
                    value: isChecked,
                    activeColor: const Color(0xFF5931DD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    onChanged: (value) {
                      setState(() {
                        isChecked = !isChecked;
                      });
                      // Handle checkbox change
                    },
                  ),
                ),
              ),
            ),
          ] else if (_isSearching) ...[
            // No results found state
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No medicines found for "$_searchText"',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: _clearSearch,
                      child: const Text(
                        'Clear search',
                        style: TextStyle(
                          color: Color(0xFF5931DD),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          if (!_isSearching || _matchesSearch()) const Spacer(),

          // Continue button
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CheckoutScreen(
                            pharmacyImage: widget.pharmacyImage,
                            pharmacyName: widget.pharmacyName,
                          )),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5931DD),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Continue',
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
    );
  }
}
