import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:medical_user_app/providers/address_provider.dart'; 

class MapLocationScreen extends StatefulWidget {
  const MapLocationScreen({Key? key}) : super(key: key);

  @override
  State<MapLocationScreen> createState() => _MapLocationScreenState();
}

class _MapLocationScreenState extends State<MapLocationScreen> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  LatLng? _selectedPosition;
  String _selectedAddress = '';
  bool _isLoading = true;
  bool _isLoadingAddress = false;
  bool _isSavingAddress = false; // Add this for save loading state
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showErrorSnackBar('Location permission denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showErrorSnackBar('Location permission permanently denied');
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _selectedPosition = _currentPosition;
        _isLoading = false;
      });

      // Add marker for current location
      _addMarker(_currentPosition!);
      
      // Get address for current location
      await _getAddressFromLatLng(_currentPosition!);

    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorSnackBar('Error getting location: ${e.toString()}');
    }
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    setState(() {
      _isLoadingAddress = true;
    });

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        setState(() {
          _selectedAddress = _formatAddress(placemark);
          _isLoadingAddress = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoadingAddress = false;
      });
      _showErrorSnackBar('Error getting address: ${e.toString()}');
    }
  }

  String _formatAddress(Placemark placemark) {
    List<String> addressParts = [];
    
    if (placemark.subThoroughfare != null && placemark.subThoroughfare!.isNotEmpty) {
      addressParts.add(placemark.subThoroughfare!);
    }
    if (placemark.thoroughfare != null && placemark.thoroughfare!.isNotEmpty) {
      addressParts.add(placemark.thoroughfare!);
    }
    if (placemark.locality != null && placemark.locality!.isNotEmpty) {
      addressParts.add(placemark.locality!);
    }
    if (placemark.administrativeArea != null && placemark.administrativeArea!.isNotEmpty) {
      addressParts.add(placemark.administrativeArea!);
    }
    if (placemark.postalCode != null && placemark.postalCode!.isNotEmpty) {
      addressParts.add(placemark.postalCode!);
    }
    
    return addressParts.join(', ');
  }

  void _addMarker(LatLng position) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('selected_location'),
          position: position,
          infoWindow: const InfoWindow(
            title: 'Selected Location',
            snippet: 'Tap to confirm this location',
          ),
        ),
      );
    });
  }

  void _onMapTap(LatLng position) {
    setState(() {
      _selectedPosition = position;
    });
    _addMarker(position);
    _getAddressFromLatLng(position);
  }

  void _confirmLocation() {
    if (_selectedPosition != null && _selectedAddress.isNotEmpty) {
      Map<String, String> addressComponents = _parseAddress(_selectedAddress);
      _showLocationDetailsModal(addressComponents);
    } else {
      _showErrorSnackBar('Please select a location first');
    }
  }

  Future<void> _saveAddressToProvider(Map<String, String> components) async {
    final addressProvider = Provider.of<AddressProvider>(context, listen: false);
    
    setState(() {
      _isSavingAddress = true;
    });

    try {
      bool success = await addressProvider.addAddress(
        house: components['house'] ?? '',
        street: components['street'] ?? '',
        city: components['city'] ?? '',
        state: components['state'] ?? '',
        pincode: components['pincode'] ?? '',
        country: components['country'] ?? 'India',
      );

      setState(() {
        _isSavingAddress = false;
      });

      if (success) {
        // Show success message
        _showSuccessSnackBar('Address saved successfully!');
        
        // Return success result to previous screen
        Navigator.pop(context, {
          'success': true,
          'latitude': _selectedPosition!.latitude,
          'longitude': _selectedPosition!.longitude,
          'address': _buildFullAddress(
            components['house'] ?? '',
            components['street'] ?? '',
            components['country'] ?? 'India',
            components['city'] ?? '',
            components['state'] ?? '',
            components['pincode'] ?? '',
          ),
          'components': components,
        });
      } else {
        // Show error from provider
        _showErrorSnackBar(addressProvider.errorMessage.isNotEmpty 
            ? addressProvider.errorMessage 
            : 'Failed to save address');
      }
    } catch (e) {
      setState(() {
        _isSavingAddress = false;
      });
      _showErrorSnackBar('Error saving address: ${e.toString()}');
    }
  }

  void _showLocationDetailsModal(Map<String, String> addressComponents) {
    // Text controllers for editing
    final TextEditingController houseNoController = TextEditingController(text: addressComponents['house'] ?? '');
    final TextEditingController streetController = TextEditingController(text: addressComponents['street'] ?? '');
    final TextEditingController countryController = TextEditingController(text: addressComponents['country'] ?? 'India');
    final TextEditingController cityController = TextEditingController(text: addressComponents['city'] ?? '');
    final TextEditingController stateController = TextEditingController(text: addressComponents['state'] ?? '');
    final TextEditingController pincodeController = TextEditingController(text: addressComponents['pincode'] ?? '');
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: !_isSavingAddress, // Prevent dismissing while saving
      enableDrag: !_isSavingAddress,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Modal header
                      Row(
                        children: [
                          const Text(
                            'Confirm Location Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          if (!_isSavingAddress)
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.close, size: 20),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      // Loading indicator when saving
                      if (_isSavingAddress)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            children: [
                              CircularProgressIndicator(
                                color: Color(0xFF6A3DE8),
                                strokeWidth: 2,
                              ),
                              SizedBox(width: 16),
                              Text(
                                'Saving address...',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      
                      if (_isSavingAddress) const SizedBox(height: 16),
                      
                      // Coordinates display
                      // Container(
                      //   padding: const EdgeInsets.all(12),
                      //   decoration: BoxDecoration(
                      //     color: Colors.blue.shade50,
                      //     borderRadius: BorderRadius.circular(8),
                      //     border: Border.all(color: Colors.blue.shade200),
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       const Icon(Icons.location_on, color: Color(0xFF6A3DE8)),
                      //       const SizedBox(width: 8),
                      //       Expanded(
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             const Text(
                      //               'Selected Coordinates:',
                      //               style: TextStyle(
                      //                 fontSize: 12,
                      //                 color: Colors.grey,
                      //               ),
                      //             ),
                      //             Text(
                      //               '${_selectedPosition!.latitude.toStringAsFixed(6)}, ${_selectedPosition!.longitude.toStringAsFixed(6)}',
                      //               style: const TextStyle(
                      //                 fontSize: 14,
                      //                 fontWeight: FontWeight.w500,
                      //               ),
                      //               overflow: TextOverflow.ellipsis,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(height: 20),
                      
                      const Text(
                        'Address Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Address fields
                      _buildTextField('House/Flat/Building No.', houseNoController, Icons.home),
                      const SizedBox(height: 12),
                      
                      _buildTextField('Street/Area', streetController, Icons.straight),
                      const SizedBox(height: 12),
                      
                      _buildTextField('Country', countryController, Icons.place),
                      const SizedBox(height: 12),
                      
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField('City', cityController, Icons.location_city),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildTextField('Pincode', pincodeController, Icons.local_post_office),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      
                      _buildTextField('State', stateController, Icons.map),
                      const SizedBox(height: 24),
                      
                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _isSavingAddress ? null : () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: _isSavingAddress ? Colors.grey : const Color(0xFF6A3DE8),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: _isSavingAddress ? Colors.grey : const Color(0xFF6A3DE8),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _isSavingAddress ? null : () async {
                                // Validate required fields
                                if (houseNoController.text.trim().isEmpty) {
                                  _showErrorSnackBar('Please enter house/flat/building number');
                                  return;
                                }
                                if (streetController.text.trim().isEmpty) {
                                  _showErrorSnackBar('Please enter street/area');
                                  return;
                                }
                                if (cityController.text.trim().isEmpty) {
                                  _showErrorSnackBar('Please enter city');
                                  return;
                                }
                                if (stateController.text.trim().isEmpty) {
                                  _showErrorSnackBar('Please enter state');
                                  return;
                                }
                                if (pincodeController.text.trim().isEmpty) {
                                  _showErrorSnackBar('Please enter pincode');
                                  return;
                                }

                                Navigator.pop(context); // Close modal first
                                
                                // Create the address components map
                                Map<String, String> components = {
                                  'house': houseNoController.text.trim(),
                                  'street': streetController.text.trim(),
                                  'country': countryController.text.trim(),
                                  'city': cityController.text.trim(),
                                  'state': stateController.text.trim(),
                                  'pincode': pincodeController.text.trim(),
                                };
                                
                                // Save to provider
                                await _saveAddressToProvider(components);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isSavingAddress ? Colors.grey : const Color(0xFF6A3DE8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: _isSavingAddress
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      'Confirm & Save',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          enabled: !_isSavingAddress, // Disable while saving
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon, 
              color: _isSavingAddress ? Colors.grey.shade400 : Colors.grey.shade600, 
              size: 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF6A3DE8)),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            hintText: 'Enter $label',
            hintStyle: TextStyle(color: Colors.grey.shade500),
          ),
        ),
      ],
    );
  }

  String _buildFullAddress(String houseNo, String street, String country, String city, String state, String pincode) {
    List<String> parts = [];
    if (houseNo.isNotEmpty) parts.add(houseNo);
    if (street.isNotEmpty) parts.add(street);
    if (city.isNotEmpty) parts.add(city);
    if (state.isNotEmpty) parts.add(state);
    if (country.isNotEmpty) parts.add(country);
    if (pincode.isNotEmpty) parts.add(pincode);
    return parts.join(', ');
  }

  Map<String, String> _parseAddress(String address) {
    if (address.isEmpty) {
      return {
        'house': '',
        'street': '',
        'country': 'India',
        'city': '',
        'state': '',
        'pincode': '',
      };
    }

    List<String> parts = address.split(', ').map((e) => e.trim()).toList();
    
    // Initialize result map
    Map<String, String> result = {
      'house': '', // User will fill this manually
      'street': '',
      'country': 'India', // Default to India
      'city': '',
      'state': '',
      'pincode': '',
    };

    // Helper function to check if a string is a pincode (6 digits)
    bool isPincode(String str) {
      return RegExp(r'^\d{6}$').hasMatch(str.trim());
    }

    // Helper function to check if a string might be a state (common Indian states)
    bool isLikelyState(String str) {
      final commonStates = [
        'andhra pradesh', 'arunachal pradesh', 'assam', 'bihar', 'chhattisgarh',
        'goa', 'gujarat', 'haryana', 'himachal pradesh', 'jharkhand', 'karnataka',
        'kerala', 'madhya pradesh', 'maharashtra', 'manipur', 'meghalaya',
        'mizoram', 'nagaland', 'odisha', 'punjab', 'rajasthan', 'sikkim',
        'tamil nadu', 'telangana', 'tripura', 'uttar pradesh', 'uttarakhand',
        'west bengal', 'delhi', 'jammu and kashmir', 'ladakh', 'puducherry'
      ];
      
      return commonStates.any((state) => 
        state.toLowerCase() == str.toLowerCase() ||
        str.toLowerCase().contains(state.toLowerCase().split(' ').first)
      );
    }

    if (parts.isNotEmpty) {
      // Find pincode first
      String? pincode;
      String? state;
      
      for (int i = parts.length - 1; i >= 0; i--) {
        if (isPincode(parts[i])) {
          pincode = parts[i];
          parts.removeAt(i);
          break;
        }
      }
      
      // Find state
      for (int i = parts.length - 1; i >= 0; i--) {
        if (isLikelyState(parts[i])) {
          state = parts[i];
          parts.removeAt(i);
          break;
        }
      }
      
      // Assign found values
      if (pincode != null) result['pincode'] = pincode;
      if (state != null) result['state'] = state;
      
      // Assign remaining parts
      if (parts.isNotEmpty) {
        // Last remaining part is likely the city
        result['city'] = parts.removeLast();
      }
      
      if (parts.isNotEmpty) {
        // Remaining parts form the street address
        result['street'] = parts.join(', ');
      }
    }
    
    return result;
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
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
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _goToCurrentLocation() {
    if (_currentPosition != null && _mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(_currentPosition!, 16.0),
      );
      setState(() {
        _selectedPosition = _currentPosition;
      });
      _addMarker(_currentPosition!);
      _getAddressFromLatLng(_currentPosition!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Choose Location',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.arrow_back_ios_new, size: 18),
          ),
        ),
        actions: [
          IconButton(
            onPressed: _goToCurrentLocation,
            icon: const Icon(
              Icons.my_location,
              color: Color(0xFF6A3DE8),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF6A3DE8),
              ),
            )
          : Column(
              children: [
                // Map
                Expanded(
                  flex: 3,
                  child: GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                    },
                    initialCameraPosition: CameraPosition(
                      target: _currentPosition ?? const LatLng(17.3850, 78.4867), // Default to Hyderabad
                      zoom: 16.0,
                    ),
                    markers: _markers,
                    onTap: _onMapTap,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    mapType: MapType.normal,
                    zoomControlsEnabled: false,
                  ),
                ),
                
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Color(0xFF6A3DE8),
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Selected Location',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          if (_isLoadingAddress)
                            const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Color(0xFF6A3DE8),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Text(
                          _selectedAddress.isEmpty ? 'Tap on the map to select a location' : _selectedAddress,
                          style: TextStyle(
                            fontSize: 14,
                            color: _selectedAddress.isEmpty ? Colors.grey.shade600 : Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Confirm Location Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _selectedPosition != null && _selectedAddress.isNotEmpty && !_isLoadingAddress && !_isSavingAddress
                              ? _confirmLocation
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6A3DE8),
                            disabledBackgroundColor: Colors.grey.shade300,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: _isSavingAddress
                              ? const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Saving...',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              : const Text(
                                  'Confirm Location',
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
              ],
            ),
    );
  }
}