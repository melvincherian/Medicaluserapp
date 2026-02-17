import 'package:flutter/material.dart';
import 'package:medical_user_app/constant/api_constants.dart';
import 'package:medical_user_app/models/pharmacy_model.dart';
import 'package:medical_user_app/providers/cart_provider.dart';
import 'package:medical_user_app/providers/pharmacy_medicine_provider.dart';
import 'package:medical_user_app/view/cart_screen.dart';
import 'package:medical_user_app/view/scanned_medicine_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';

import '../models/pharmacy_category_model.dart';

class PharmacyScreen extends StatefulWidget {
  final String? pharmacyId;

  const PharmacyScreen({super.key, this.pharmacyId});

  @override
  State<PharmacyScreen> createState() => _PharmacyScreenState();
}

class _PharmacyScreenState extends State<PharmacyScreen>
    with TickerProviderStateMixin {
  int _selectedCategoryIndex = 0;
  Pharmacy? pharmacy;
  bool isLoading = true;
  String errorMessage = '';

  // Search functionality
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchActive = false;

  // Voice functionality
  late SpeechToText _speechToText;
  bool _isListening = false;
  String _speechText = '';
  late AnimationController _voiceAnimationController;
  late Animation<double> _voiceAnimation;

  // Track adding to cart states for individual medicines
  Set<String> _addingToCartMedicines = {};

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
    _initializeAnimations();
    _fetchPharmacyDetails();
    _searchController.addListener(_onSearchChanged);
  }

  void _initializeAnimations() {
    _voiceAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _voiceAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
          parent: _voiceAnimationController, curve: Curves.easeInOut),
    );
  }

  void _initializeSpeech() async {
    _speechToText = SpeechToText();
    bool available = await _speechToText.initialize();
    if (!available) {
      print('Speech recognition not available');
    }
  }

  void _onSearchChanged() {
    if (!mounted) return;

    final provider =
        Provider.of<PharmacyMedicineProvider>(context, listen: false);

    final searchText = _searchController.text.trim();

    setState(() {
      _isSearchActive = searchText.isNotEmpty;
    });

    if (searchText.isEmpty) {
      // When search is cleared, reload the current category
      if (pharmacy != null && pharmacy!.categories.isNotEmpty) {
        final selectedCategory = pharmacy!.categories[_selectedCategoryIndex];
        provider.filterByCategory(
          pharmacyId: widget.pharmacyId!,
          category: selectedCategory.name.toLowerCase(),
        );
      }
    } else {
      // Perform search
      provider.searchMedicines(searchText);
    }
  }

  void _clearSearch() {
    _searchController.clear();
    final provider =
        Provider.of<PharmacyMedicineProvider>(context, listen: false);

    setState(() {
      _isSearchActive = false;
    });

    // Reload current category medicines when search is cleared
    if (pharmacy != null && pharmacy!.categories.isNotEmpty) {
      final selectedCategory = pharmacy!.categories[_selectedCategoryIndex];
      provider.filterByCategory(
        pharmacyId: widget.pharmacyId!,
        category: selectedCategory.name.toLowerCase(),
      );
    }
  }

  // void _onSearchChanged() {
  //   if (!mounted) return;

  //   final provider =
  //       Provider.of<PharmacyMedicineProvider>(context, listen: false);
  //   setState(() {
  //     _isSearchActive = _searchController.text.isNotEmpty;
  //   });

  //   // Use provider's search functionality
  //   provider.searchMedicines(_searchController.text);
  // }

  // Future<void> _addToCart(Medicine medicine) async {
  //   if (_addingToCartMedicines.contains(medicine.id)) return;

  //   setState(() {
  //     _addingToCartMedicines.add(medicine.id);
  //   });

  //   final cartProvider = Provider.of<CartProvider>(context, listen: false);
  //   final success = await cartProvider.addToCart(medicine.id);

  //   setState(() {
  //     _addingToCartMedicines.remove(medicine.id);
  //   });

  //   if (success) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('${medicine.name} added to cart'),
  //         backgroundColor: Colors.green,
  //         duration: const Duration(seconds: 2),
  //       ),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(cartProvider.errorMessage ?? 'Failed to add to cart'),
  //         backgroundColor: Colors.red,
  //         duration: const Duration(seconds: 3),
  //       ),
  //     );
  //   }
  // }

  Future<void> _addToCart(Medicine medicine) async {
    // Check if already in cart
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    if (cartProvider.isInCart(medicine.id)) {
      // Optionally show a message that it's already in cart
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${medicine.name} is already in cart'),
          backgroundColor: Colors.orange,
          duration: const Duration(seconds: 2),
        ),
      );
      return; // Exit early
    }

    if (_addingToCartMedicines.contains(medicine.id)) return;

    setState(() {
      _addingToCartMedicines.add(medicine.id);
    });

    final success = await cartProvider.addToCart(medicine.id);

    setState(() {
      _addingToCartMedicines.remove(medicine.id);
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${medicine.name} added to cart'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(cartProvider.errorMessage ?? 'Failed to add to cart'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _navigateToMedicineDetail(Medicine medicine) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScannedMedicineScreen(
          medicineId: medicine.id,
          mrp: medicine.mrp.toDouble(),
          address: pharmacy!.address,
        ),
      ),
    );
  }

  void _startListening() async {
    try {
      // Check if already listening
      if (_isListening) {
        _stopListening();
        return;
      }

      // Request microphone permission
      final permission = await Permission.microphone.request();
      if (permission != PermissionStatus.granted) {
        _showPermissionDialog();
        return;
      }

      // Initialize speech recognition if not already initialized
      if (!_speechToText.isAvailable) {
        bool initialized = await _speechToText.initialize(
          onStatus: (status) {
            if (!mounted) return;
            print('Speech status: $status');

            // Handle different statuses
            if (status == 'done' || status == 'notListening') {
              _stopListening();
            }
          },
          onError: (error) {
            if (!mounted) return;
            print('Speech error: $error');
            _stopListening();

            // Show error to user
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text('Speech recognition error: $error'),
            //     backgroundColor: Colors.red,
            //     duration: const Duration(seconds: 3),
            //   ),
            // );
          },
        );

        if (!initialized) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Speech recognition not available'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
      }

      if (!mounted) return;

      setState(() {
        _isListening = true;
        _speechText = '';
      });

      _voiceAnimationController.repeat(reverse: true);

      // Start listening with better configuration
      await _speechToText.listen(
        onResult: (result) {
          if (!mounted) return;

          setState(() {
            _speechText = result.recognizedWords;
            _searchController.text = _speechText;
          });

          // If we have final results and speech contains completion indicators
          if (result.finalResult) {
            // Auto-stop after getting final results
            Future.delayed(const Duration(milliseconds: 500), () {
              if (mounted) {
                _stopListening();
              }
            });
          }
        },
        listenFor: const Duration(seconds: 10),
        pauseFor: const Duration(seconds: 3),
        partialResults: true,
        cancelOnError: true,
        listenMode: ListenMode.dictation,
        onSoundLevelChange: (level) {
          // Optional: You can use this for visual feedback
        },
      );
    } catch (error) {
      print('Speech listening error: $error');
      if (mounted) {
        _stopListening();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to start speech recognition: $error'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  void _stopListening() async {
    if (_isListening) {
      await _speechToText.stop();

      if (!mounted) return;

      setState(() {
        _isListening = false;
      });
      _voiceAnimationController.stop();
      _voiceAnimationController.reset();
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Microphone Permission'),
          content: const Text(
              'This app needs microphone access to use voice search. Please enable it in settings.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                openAppSettings();
              },
              child: const Text('Settings'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _fetchPharmacyDetails() async {
    try {
      if (!mounted) return;

      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      final String apiUrl =
          '${ApiConstants.baseUrl}/pharmacy/singlepharmacy/${widget.pharmacyId}';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        setState(() {
          pharmacy = Pharmacy.fromJson(data['pharmacy']);
          isLoading = false;
        });

        // After getting pharmacy details, load medicines using provider
        if (pharmacy!.categories.isNotEmpty) {
          final provider =
              Provider.of<PharmacyMedicineProvider>(context, listen: false);
          await provider.loadMedicinesByPharmacy(
            pharmacyId: widget.pharmacyId!,
            category: pharmacy!.categories[0].name.toLowerCase(),
          );
        }
      } else {
        setState(() {
          errorMessage = 'Failed to load pharmacy details';
          isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        errorMessage = 'Network error: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  // void _clearSearch() {
  //   _searchController.clear();
  //   final provider = Provider.of<PharmacyMedicineProvider>(context, listen: false);
  //   provider.clearSearch();
  //   setState(() {
  //     _isSearchActive = false;
  //   });
  // }

  // void _clearSearch() {
  //   _searchController.clear();
  //   final provider =
  //       Provider.of<PharmacyMedicineProvider>(context, listen: false);
  //   provider.clearSearch();
  //   setState(() {
  //     _isSearchActive = false;
  //   });
  // }

  Widget _buildCategoryItemWithLoading({
    required String imagePath,
    required String label,
    required int index,
    bool isSelected = false,
    bool isNetworkImage = false,
  }) {
    return Consumer<PharmacyMedicineProvider>(
      builder: (context, provider, child) {
        final isLoading = provider.isLoading && isSelected;

        return GestureDetector(
          onTap: isLoading ? null : () => _onCategorySelected(index),
          child: Container(
            width: 75,
            height: 96,
            decoration: BoxDecoration(
              color: const Color(0XFFEFF3F7),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? Colors.black
                    : const Color.fromARGB(255, 188, 188, 188),
              ),
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: isNetworkImage && imagePath.isNotEmpty
                              ? Image.network(
                                  imagePath,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: double.infinity,
                                      color: Colors.grey.shade200,
                                      child: Icon(
                                        Icons.category,
                                        size: 24,
                                        color: Colors.grey.shade500,
                                      ),
                                    );
                                  },
                                )
                              : imagePath.isNotEmpty
                                  ? Image.asset(
                                      imagePath,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          width: double.infinity,
                                          color: Colors.grey.shade200,
                                          child: Icon(
                                            Icons.category,
                                            size: 24,
                                            color: Colors.grey.shade500,
                                          ),
                                        );
                                      },
                                    )
                                  : Container(
                                      width: double.infinity,
                                      color: Colors.grey.shade200,
                                      child: Icon(
                                        Icons.category,
                                        size: 24,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          label,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected
                                ? Colors.black
                                : Colors.grey.shade700,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                if (isLoading)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // void _onCategorySelected(int index) async {
  //   if (pharmacy == null || index >= pharmacy!.categories.length) return;

  //   setState(() {
  //     _selectedCategoryIndex = index;
  //     _clearSearch(); // Clear search when category changes
  //   });

  //   // Use provider to fetch medicines for the selected category
  //   final provider = Provider.of<PharmacyMedicineProvider>(context, listen: false);
  //   final selectedCategory = pharmacy!.categories[index];

  //   await provider.filterByCategory(
  //     pharmacyId: widget.pharmacyId!,
  //     category: selectedCategory.name.toLowerCase(),
  //   );
  // }

  void _onCategorySelected(int index) async {
    if (pharmacy == null || index >= pharmacy!.categories.length) return;

    // Don't proceed if the same category is already selected
    if (_selectedCategoryIndex == index) return;

    setState(() {
      _selectedCategoryIndex = index;
      // Clear search when category changes
      _searchController.clear();
      _isSearchActive = false;
    });

    // Use provider to fetch medicines for the selected category
    final provider =
        Provider.of<PharmacyMedicineProvider>(context, listen: false);

    final selectedCategory = pharmacy!.categories[index];

    print(
        'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy${selectedCategory.name.toLowerCase()}');

    // Call the API to filter by category - this will trigger a rebuild via Consumer
    await provider.filterByCategory(
      pharmacyId: widget.pharmacyId!,
      category: selectedCategory.name.toLowerCase(),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _voiceAnimationController.dispose();
    _speechToText.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isLoading
            ? _buildLoadingState()
            : errorMessage.isNotEmpty
                ? _buildErrorState()
                : pharmacy == null
                    ? _buildNoDataState()
                    : _buildPharmacyContent(),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading pharmacy details...'),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red),
          SizedBox(height: 16),
          Text(
            errorMessage,
            style: TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _fetchPharmacyDetails,
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildNoDataState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.local_pharmacy, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('No pharmacy data found'),
        ],
      ),
    );
  }

  Widget _buildPharmacyContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildPharmacyHeader(),
          SizedBox(height: 24),
          _buildSearchBar(),
          SizedBox(height: 24),
          if (!_isSearchActive) ...[
            _buildCategorySection(),
            SizedBox(height: 24),
          ],
          _buildSectionTitle(),
          _buildMedicineGrid(),
        ],
      ),
    );
  }

  Widget _buildPharmacyHeader() {
    return Container(
      height: 246,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0XFFEFF3F7),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new, size: 18),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 120, // Fixed width - adjust as needed
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const Icon(Icons.location_on,
                          size: 24, color: Colors.black54),
                      Text(
                        pharmacy!.address,
                        style: const TextStyle(fontSize: 9),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8), // Added proper spacing
              Consumer<CartProvider>(
                builder: (context, cartProvider, child) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.shopping_cart_outlined),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CartScreen(
                                  amount: cartProvider.cart.subTotal.toDouble(),
                                ),
                              ),
                            );
                          },
                        ),
                        if (cartProvider.itemCount > 0)
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                '${cartProvider.itemCount}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
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
          // Row(
          //   children: [
          //     InkWell(
          //       onTap: () => Navigator.pop(context),
          //       child: Container(
          //         padding: const EdgeInsets.all(8),
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           border: Border.all(color: Colors.grey.shade300),
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //         child: const Icon(Icons.arrow_back_ios_new, size: 18),
          //       ),
          //     ),
          //     const Spacer(),
          //     Flexible(
          //       child: Container(
          //         padding: const EdgeInsets.all(8),
          //         child: Column(
          //           children: [
          //             const Icon(Icons.location_on,
          //                 size: 24, color: Colors.black54),
          //             Text(
          //               pharmacy!.address,
          //               style: const TextStyle(fontSize: 9),
          //               overflow: TextOverflow.ellipsis,
          //               maxLines: 1,
          //               textAlign: TextAlign.center,
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //     const SizedBox(width: 1),
          //     Consumer<CartProvider>(
          //       builder: (context, cartProvider, child) {
          //         return Container(
          //           decoration: BoxDecoration(
          //             color: Colors.white,
          //             border: Border.all(color: Colors.grey.shade300),
          //             borderRadius: BorderRadius.circular(8),
          //           ),
          //           child: Stack(
          //             children: [
          //               IconButton(
          //                 icon: const Icon(Icons.shopping_cart_outlined),
          //                 onPressed: () {
          //                   Navigator.push(
          //                     context,
          //                     MaterialPageRoute(
          //                       builder: (context) => CartScreen(
          //                         amount: cartProvider.cart.subTotal.toInt(),
          //                       ),
          //                     ),
          //                   );
          //                 },
          //               ),
          //               if (cartProvider.itemCount > 0)
          //                 Positioned(
          //                   right: 8,
          //                   top: 8,
          //                   child: Container(
          //                     padding: const EdgeInsets.all(2),
          //                     decoration: const BoxDecoration(
          //                       color: Colors.red,
          //                       shape: BoxShape.circle,
          //                     ),
          //                     constraints: const BoxConstraints(
          //                       minWidth: 16,
          //                       minHeight: 16,
          //                     ),
          //                     child: Text(
          //                       '${cartProvider.itemCount}',
          //                       style: const TextStyle(
          //                         color: Colors.white,
          //                         fontSize: 10,
          //                         fontWeight: FontWeight.bold,
          //                       ),
          //                       textAlign: TextAlign.center,
          //                     ),
          //                   ),
          //                 ),
          //             ],
          //           ),
          //         );
          //       },
          //     ),
          //   ],
          // ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: pharmacy!.image.isNotEmpty
                      ? Image.network(
                          pharmacy!.image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey.shade200,
                              child: Icon(Icons.local_pharmacy, size: 40),
                            );
                          },
                        )
                      : Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.local_pharmacy, size: 40),
                        ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pharmacy!.name,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              size: 16, color: Colors.indigo.shade700),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              pharmacy!.address,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Row(
          //   children: [
          //     InkWell(
          //       onTap: () => Navigator.pop(context),
          //       child: Container(
          //         padding: const EdgeInsets.all(8),
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           border: Border.all(color: Colors.grey.shade300),
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //         child: const Icon(Icons.arrow_back_ios_new, size: 18),
          //       ),
          //     ),
          //     const Spacer(),
          //     Container(
          //       padding: const EdgeInsets.all(8),
          //       child: Column(
          //         children: [
          //           const Icon(Icons.location_on,
          //               size: 24, color: Colors.black54),
          //           Text(
          //             pharmacy!.address,
          //             style: const TextStyle(fontSize: 9),
          //           )
          //         ],
          //       ),
          //     ),
          //     const SizedBox(width: 1),
          //     Consumer<CartProvider>(
          //       builder: (context, cartProvider, child) {
          //         return Container(
          //           decoration: BoxDecoration(
          //             color: Colors.white,
          //             border: Border.all(color: Colors.grey.shade300),
          //             borderRadius: BorderRadius.circular(8),
          //           ),
          //           child: Stack(
          //             children: [
          //               IconButton(
          //                 icon: const Icon(
          //                   Icons.shopping_cart_outlined,
          //                 ),
          //                 onPressed: () {
          //                   Navigator.push(
          //                     context,
          //                     MaterialPageRoute(
          //                       builder: (context) => CartScreen(
          //                         amount: cartProvider.cart.subTotal.toInt(),
          //                       ),
          //                     ),
          //                   );
          //                 },
          //               ),
          //               if (cartProvider.itemCount > 0)
          //                 Positioned(
          //                   right: 8,
          //                   top: 8,
          //                   child: Container(
          //                     padding: const EdgeInsets.all(2),
          //                     decoration: const BoxDecoration(
          //                       color: Colors.red,
          //                       shape: BoxShape.circle,
          //                     ),
          //                     constraints: const BoxConstraints(
          //                       minWidth: 16,
          //                       minHeight: 16,
          //                     ),
          //                     child: Text(
          //                       '${cartProvider.itemCount}',
          //                       style: const TextStyle(
          //                         color: Colors.white,
          //                         fontSize: 10,
          //                         fontWeight: FontWeight.bold,
          //                       ),
          //                       textAlign: TextAlign.center,
          //                     ),
          //                   ),
          //                 ),
          //             ],
          //           ),
          //         );
          //       },
          //     ),
          //   ],
          // ),
          // Container(
          //   padding:const EdgeInsets.all(8),
          //   decoration: BoxDecoration(
          //       color: Colors.white, borderRadius: BorderRadius.circular(20)),
          //   child: Row(
          //     children: [
          //       ClipRRect(
          //         borderRadius: BorderRadius.circular(8),
          //         child: pharmacy!.image.isNotEmpty
          //             ? Image.network(
          //                 pharmacy!.image,
          //                 width: 80,
          //                 height: 80,
          //                 fit: BoxFit.cover,
          //                 errorBuilder: (context, error, stackTrace) {
          //                   return Container(
          //                     width: 80,
          //                     height: 80,
          //                     color: Colors.grey.shade200,
          //                     child: Icon(Icons.local_pharmacy, size: 40),
          //                   );
          //                 },
          //               )
          //             : Container(
          //                 width: 80,
          //                 height: 80,
          //                 color: Colors.grey.shade200,
          //                 child: Icon(Icons.local_pharmacy, size: 40),
          //               ),
          //       ),
          //       const SizedBox(width: 16),
          //       Expanded(
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               pharmacy!.name,
          //               style: TextStyle(
          //                 fontSize: 22,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //               maxLines: 2,
          //               overflow: TextOverflow.ellipsis,
          //             ),
          //             const SizedBox(height: 8),
          //             Row(
          //               children: [
          //                 Icon(Icons.location_on,
          //                     size: 16, color: Colors.indigo.shade700),
          //                 const SizedBox(width: 4),
          //                 Expanded(
          //                   child: Text(
          //                     '${pharmacy?.address}',
          //                     style: TextStyle(
          //                       fontSize: 13,
          //                       color: Colors.grey.shade600,
          //                     ),
          //                     maxLines: 1,
          //                     overflow: TextOverflow.ellipsis,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF3F7),
                borderRadius: BorderRadius.circular(24),
                border: _isSearchActive
                    ? Border.all(color: const Color(0xFF6434E0), width: 2)
                    : null,
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Medicine,...',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                  suffixIcon: _isSearchActive
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey.shade600),
                          onPressed: _clearSearch,
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // AnimatedBuilder(
          //   animation: _voiceAnimation,
          //   builder: (context, child) {
          //     return Transform.scale(
          //       scale: _isListening ? _voiceAnimation.value : 1.0,
          //       child: GestureDetector(
          //         onTap: _isListening ? _stopListening : _startListening,
          //         child: Container(
          //           height: 48,
          //           width: 48,
          //           decoration: BoxDecoration(
          //             color:
          //                 _isListening ? Colors.red : const Color(0xFF5931DD),
          //             borderRadius: BorderRadius.circular(24),
          //             boxShadow: _isListening
          //                 ? [
          //                     BoxShadow(
          //                       color: Colors.red.withOpacity(0.3),
          //                       blurRadius: 10,
          //                       spreadRadius: 2,
          //                     )
          //                   ]
          //                 : null,
          //           ),
          //           child: Icon(
          //             Icons.mic,
          //             color: Colors.white,
          //             size: _isListening ? 28 : 24,
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Categories',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   padding: const EdgeInsets.symmetric(horizontal: 16),
        //   child: Row(
        //     children: List.generate(
        //       pharmacy!.categories.length,
        //       (index) => Padding(
        //         padding: const EdgeInsets.only(right: 12),
        //         child: _buildCategoryItem(
        //           imagePath: pharmacy!.categories[index].image,
        //           label: pharmacy!.categories[index].name,
        //           isSelected: _selectedCategoryIndex == index,
        //           isNetworkImage: true,
        //           onTap: () => _onCategorySelected(index),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),

        SizedBox(
          height: 96, // Match your category item height
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: pharmacy!.categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _buildCategoryItem(
                  imagePath: pharmacy!.categories[index].image,
                  label: pharmacy!.categories[index].name,
                  isSelected: _selectedCategoryIndex == index,
                  isNetworkImage: true,
                  onTap: () => _onCategorySelected(index),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMedicineGrid() {
    return Consumer<PharmacyMedicineProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Container(
            height: 200,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading medicines...'),
                ],
              ),
            ),
          );
        }

        if (provider.hasError) {
          return Container(
            height: 200,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon(Icons.error_outline, size: 64, color: Colors.red),
                SizedBox(height: 16),
                Text(
                  'No category found ',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                // ElevatedButton(
                //   onPressed: () async {
                //     if (pharmacy != null && pharmacy!.categories.isNotEmpty) {
                //       final selectedCategory = pharmacy!.categories[_selectedCategoryIndex];
                //       await provider.filterByCategory(
                //         pharmacyId: widget.pharmacyId!,
                //         category: selectedCategory.name.toLowerCase(),
                //       );
                //     }
                //   },
                //   child: Text('Retry'),
                // ),
              ],
            ),
          );
        }

        if (provider.medicines.isEmpty && _isSearchActive) {
          return Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No medicines found for "${provider.searchQuery}"',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Try searching with different keywords',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          );
        }

        if (provider.medicines.isEmpty) {
          return Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.medication, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No medicines available in this category',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: provider.medicines.length,
            itemBuilder: (context, index) {
              final medicine = provider.medicines[index];
              return _buildMedicineCardItem(medicine);
            },
          ),
        );
      },
    );
  }

  Widget _buildMedicineCardItem(Medicine medicine) {
    return GestureDetector(
      onTap: () => _navigateToMedicineDetail(medicine),
      child: Container(
        height: 292,
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
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Stack(
                children: [
                  medicine.images.isNotEmpty
                      ? Image.network(
                          medicine.images.first,
                          height: 90,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 90,
                              width: double.infinity,
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.medication,
                                  size: 40, color: Colors.grey),
                            );
                          },
                        )
                      : Container(
                          height: 90,
                          width: double.infinity,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.medication,
                              size: 40, color: Colors.grey),
                        ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '₹${medicine.mrp}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          // if (medicine.mrp != null && medicine.mrp! > medicine.price)
                          //   Text(
                          //     '₹${medicine.mrp!.toStringAsFixed(0)}',
                          //     style: const TextStyle(
                          //       color: Colors.grey,
                          //       fontSize: 12,
                          //       decoration: TextDecoration.lineThrough,
                          //     ),
                          //   ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medicine.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    medicine.description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.local_pharmacy,
                        color: Colors.deepPurple,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          pharmacy!.name,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      final isInCart = cartProvider.isInCart(medicine.id);
                      final isAddingToCart =
                          _addingToCartMedicines.contains(medicine.id);

                      return ElevatedButton(
                        onPressed:
                            isAddingToCart || cartProvider.isLoading || isInCart
                                ? null // Disable if in cart
                                : () => _addToCart(medicine),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isInCart ? Colors.green : Color(0xFF5931DD),
                          minimumSize: const Size(double.infinity, 36),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          disabledBackgroundColor: isInCart
                              ? Colors.green
                              : Colors.grey, // Style when disabled
                        ),
                        // child: isAddingToCart
                        //     ? const SizedBox(
                        //         width: 20,
                        //         height: 20,
                        //         child: CircularProgressIndicator(
                        //           strokeWidth: 2,
                        //           valueColor: AlwaysStoppedAnimation<Color>(
                        //               Colors.white),
                        //         ),
                        //       )
                        //     : Text(
                        //         isInCart
                        //             ? 'In Cart (${cartProvider.getItemQuantity(medicine.id)})'
                        //             : 'Add to Cart',
                        //         style: const TextStyle(
                        //           color: Colors.white,
                        //         ),
                        //       ),

                        child: isAddingToCart
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : isInCart
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CartScreen(
                                            amount: cartProvider.cart.subTotal
                                                .toDouble(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'In Cart (${cartProvider.getItemQuantity(medicine.id)})',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        decoration: TextDecoration
                                            .underline, // 👈 optional UX hint
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                : const Text(
                                    'Add to Cart',
                                    style: TextStyle(color: Colors.white),
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

  Widget _buildCategoryItem({
    required String imagePath,
    required String label,
    bool isSelected = false,
    bool isNetworkImage = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 75,
        height: 96,
        decoration: BoxDecoration(
            color: const Color(0XFFEFF3F7),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: isSelected
                    ? Colors.black
                    : const Color.fromARGB(255, 188, 188, 188))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: isNetworkImage && imagePath.isNotEmpty
                      ? Image.network(
                          imagePath,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: double.infinity,
                              color: Colors.grey.shade200,
                              child: Icon(
                                Icons.category,
                                size: 24,
                                color: Colors.grey.shade500,
                              ),
                            );
                          },
                        )
                      : imagePath.isNotEmpty
                          ? Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: double.infinity,
                                  color: Colors.grey.shade200,
                                  child: Icon(
                                    Icons.category,
                                    size: 24,
                                    color: Colors.grey.shade500,
                                  ),
                                );
                              },
                            )
                          : Container(
                              width: double.infinity,
                              color: Colors.grey.shade200,
                              child: Icon(
                                Icons.category,
                                size: 24,
                                color: Colors.grey.shade500,
                              ),
                            ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? Colors.black : Colors.grey.shade700,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle() {
    return Consumer<PharmacyMedicineProvider>(
      builder: (context, provider, child) {
        String title;
        if (_isSearchActive && provider.searchQuery.isNotEmpty) {
          title = 'Search Results (${provider.medicines.length})';
        } else if (pharmacy != null &&
            pharmacy!.categories.isNotEmpty &&
            _selectedCategoryIndex < pharmacy!.categories.length) {
          final selectedCategory = pharmacy!.categories[_selectedCategoryIndex];
          title = '${selectedCategory.name} (${provider.medicines.length})';
        } else {
          title = 'All Medicines (${provider.medicines.length})';
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (provider.medicines.isNotEmpty)
                Text(
                  'Total: ${provider.medicines.length}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
