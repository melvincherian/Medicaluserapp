// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:medical_user_app/providers/profile_provider.dart';
// import 'package:medical_user_app/providers/language_provider.dart';

// class PersonalInformationScreen extends StatefulWidget {
//   const PersonalInformationScreen({Key? key}) : super(key: key);

//   @override
//   State<PersonalInformationScreen> createState() =>
//       _PersonalInformationScreenState();
// }

// class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
//   // Text editing controllers for form fields
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _mobileController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
  
//   final _formKey = GlobalKey<FormState>();
//   File? _selectedImage;
//   final ImagePicker _imagePicker = ImagePicker();

//   // Store original values to preserve them
//   String _originalName = '';
//   String _originalMobile = '';
//   bool _isDataInitialized = false; // Add this flag

//   @override
//   void initState() {
//     super.initState();
//     // Initialize data after the first frame
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _initializeUserData();
//     });
//   }

//   void _initializeUserData() {
//     final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
//     final user = profileProvider.user;
    
//     // Debug print to check if user data exists
//     print('Initializing user data: ${user?.name}, ${user?.mobile}');
    
//     if (user != null && !_isDataInitialized) {
//       _originalName = user.name ?? '';
//       _originalMobile = user.mobile ?? '';
      
//       // Set controller values
//       _nameController.text = _originalName;
//       _mobileController.text = _originalMobile;
      
//       _isDataInitialized = true;
      
//       // Force rebuild to show the data
//       if (mounted) {
//         setState(() {});
//       }
//     } else if (user == null) {
//       // If user is null, try to initialize the provider
//       print('User is null, trying to initialize provider...');
//       profileProvider.initializeUser().then((_) {
//         if (profileProvider.user != null && mounted && !_isDataInitialized) {
//           _initializeUserData(); // Recursive call after initialization
//         }
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _mobileController.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickImage() async {
//     try {
//       showModalBottomSheet(
//         context: context,
//         builder: (BuildContext context) {
//           return SafeArea(
//             child: Wrap(
//               children: [
//                 ListTile(
//                   leading: const Icon(Icons.photo_library),
//                   title: const Text('Gallery'),
//                   onTap: () async {
//                     Navigator.pop(context);
//                     final XFile? image = await _imagePicker.pickImage(
//                       source: ImageSource.gallery,
//                       maxWidth: 1024,
//                       maxHeight: 1024,
//                       imageQuality: 85,
//                     );
//                     if (image != null) {
//                       setState(() {
//                         _selectedImage = File(image.path);
//                       });
//                     }
//                   },
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.photo_camera),
//                   title: const Text('Camera'),
//                   onTap: () async {
//                     Navigator.pop(context);
//                     final XFile? image = await _imagePicker.pickImage(
//                       source: ImageSource.camera,
//                       maxWidth: 1024,
//                       maxHeight: 1024,
//                       imageQuality: 85,
//                     );
//                     if (image != null) {
//                       setState(() {
//                         _selectedImage = File(image.path);
//                       });
//                     }
//                   },
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error picking image: $e')),
//       );
//     }
//   }

//   Future<void> _saveProfile() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    
//     final nameValue = _nameController.text.trim();
//     final mobileValue = _mobileController.text.trim();
    
//     // Validate input
//     if (!profileProvider.isValidName(nameValue)) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter a valid name (at least 2 characters)')),
//       );
//       return;
//     }

//     if (!profileProvider.isValidMobile(mobileValue)) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter a valid mobile number (at least 10 digits)')),
//       );
//       return;
//     }

//     // Update original values to reflect current input
//     _originalName = nameValue;
//     _originalMobile = mobileValue;

//     try {
//       bool success;
      
//       if (_selectedImage != null) {
//         // Update complete profile with image
//         success = await profileProvider.updateCompleteProfile(
//           name: nameValue,
//           mobile: mobileValue,
//           profileImage: _selectedImage,
//         );
//       } else {
//         // Update only user data
//         success = await profileProvider.updateUserProfile(
//           name: nameValue,
//           mobile: mobileValue,
//         );
//       }

//       if (success) {
//         // Ensure the form still shows the correct values after update
//         setState(() {
//           _nameController.text = _originalName;
//           _mobileController.text = _originalMobile;
//         });
        
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Profile updated successfully!'),
//             backgroundColor: Colors.green,
//           ),
//         );
        
//         // Clear the selected image since it's now uploaded
//         setState(() {
//           _selectedImage = null;
//         });
        
//         // Optionally pop back to previous screen
//         // Navigator.pop(context);
//       } else {
//         // Restore the form values if update failed
//         setState(() {
//           _nameController.text = _originalName;
//           _mobileController.text = _originalMobile;
//         });
        
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(profileProvider.errorMessage ?? 'Failed to update profile'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } catch (e) {
//       // Restore the form values if error occurred
//       setState(() {
//         _nameController.text = _originalName;
//         _mobileController.text = _originalMobile;
//       });
      
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   Widget _buildProfileImage(ProfileProvider profileProvider) {
//     return Center(
//       child: Stack(
//         children: [
//           Container(
//             width: 80,
//             height: 80,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.amber,
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: _selectedImage != null
//                   ? Image.file(
//                       _selectedImage!,
//                       fit: BoxFit.cover,
//                     )
//                   : profileProvider.hasProfileImage()
//                       ? Image.network(
//                           profileProvider.getProfileImageUrl()!,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Image.asset(
//                               'assets/profile.png',
//                               fit: BoxFit.cover,
//                             );
//                           },
//                         )
//                       : Image.asset(
//                           'assets/profile.png',
//                           fit: BoxFit.cover,
//                         ),
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             right: 0,
//             child: InkWell(
//               onTap: _pickImage,
//               child: Container(
//                 padding: const EdgeInsets.all(4),
//                 decoration: const BoxDecoration(
//                   color: Colors.indigo,
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.add,
//                   color: Colors.white,
//                   size: 16,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         title: const AppText(
//           'personal_information',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//         leading: InkWell(
//           onTap: () => Navigator.pop(context),
//           child: Container(
//             margin: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(color: Colors.grey.shade300),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: const Icon(Icons.arrow_back_ios_new, size: 18),
//           ),
//         ),
//       ),
//       body: Consumer<ProfileProvider>(
//         builder: (context, profileProvider, child) {
//           // Auto-initialize if data is available but not yet set
//           if (profileProvider.user != null && !_isDataInitialized) {
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               _initializeUserData();
//             });
//           }
          
//           return SafeArea(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 16),

//                     // Profile Image
//                     _buildProfileImage(profileProvider),
//                     const SizedBox(height: 24),

    
//                     const SizedBox(height: 16),

//                     // Name Field
//                     TextFormField(
//                       controller: _nameController,
//                       validator: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return 'Please enter your name';
//                         }
//                         if (!profileProvider.isValidName(value.trim())) {
//                           return 'Name must be at least 2 characters';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         labelText: AppText.translate(context, 'name'),
//                         labelStyle: const TextStyle(
//                           fontSize: 13,
//                           color: Colors.black87,
//                           fontWeight: FontWeight.w500,
//                         ),
//                         floatingLabelBehavior: FloatingLabelBehavior.always,
//                         contentPadding: const EdgeInsets.symmetric(
//                           vertical: 14,
//                           horizontal: 12,
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(color: Colors.grey[400]!),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(color: Colors.grey[400]!),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: const BorderSide(
//                             color: Colors.deepPurple,
//                             width: 1.2,
//                           ),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: const BorderSide(color: Colors.red),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),

//                     // Mobile Field
//                     TextFormField(
//                       controller: _mobileController,
//                       keyboardType: TextInputType.phone,
//                       validator: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return 'Please enter your mobile number';
//                         }
//                         if (!profileProvider.isValidMobile(value.trim())) {
//                           return 'Please enter a valid mobile number';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         labelText: AppText.translate(context, 'mobile_number'),
//                         labelStyle: const TextStyle(
//                           fontSize: 13,
//                           color: Colors.black87,
//                           fontWeight: FontWeight.w500,
//                         ),
//                         floatingLabelBehavior: FloatingLabelBehavior.always,
//                         contentPadding: const EdgeInsets.symmetric(
//                           vertical: 14,
//                           horizontal: 12,
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(color: Colors.grey[400]!),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(color: Colors.grey[400]!),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: const BorderSide(
//                             color: Colors.deepPurple,
//                             width: 1.2,
//                           ),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: const BorderSide(color: Colors.red),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 24),

//                     // Save Button
//                     SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: ElevatedButton(
//                         onPressed: profileProvider.isUpdating ? null : _saveProfile,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF6A3DE8),
//                           disabledBackgroundColor: Colors.grey,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: profileProvider.isUpdating
//                             ? const Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   SizedBox(
//                                     width: 20,
//                                     height: 20,
//                                     child: CircularProgressIndicator(
//                                       color: Colors.white,
//                                       strokeWidth: 2,
//                                     ),
//                                   ),
//                                   SizedBox(width: 8),
//                                   Text(
//                                     'Updating...',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             : const AppText(
//                                 'save',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                       ),
//                     ),

//                     const SizedBox(height: 24),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }












import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:medical_user_app/providers/profile_provider.dart';
import 'package:medical_user_app/providers/language_provider.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({Key? key}) : super(key: key);

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  // Text editing controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  final ImagePicker _imagePicker = ImagePicker();

  // Store original values to preserve them
  String _originalName = '';
  String _originalMobile = '';
  bool _isDataInitialized = false;

  @override
  void initState() {
    super.initState();
    // Initialize data after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeUserData();
    });
  }

  void _initializeUserData() {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    final user = profileProvider.user;
    
    // Debug print to check if user data exists
    print('Initializing user data: ${user?.name}, ${user?.mobile}');
    
    if (user != null && !_isDataInitialized) {
      _originalName = user.name ?? '';
      _originalMobile = user.mobile ?? '';
      
      // Set controller values
      _nameController.text = _originalName;
      _mobileController.text = _originalMobile;
      
      _isDataInitialized = true;
      
      // Force rebuild to show the data
      if (mounted) {
        setState(() {});
      }
    } else if (user == null) {
      // If user is null, try to initialize the provider
      print('User is null, trying to initialize provider...');
      profileProvider.initializeUser().then((_) {
        if (profileProvider.user != null && mounted && !_isDataInitialized) {
          _initializeUserData(); // Recursive call after initialization
        }
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    final XFile? image = await _imagePicker.pickImage(
                      source: ImageSource.gallery,
                      maxWidth: 1024,
                      maxHeight: 1024,
                      imageQuality: 85,
                    );
                    if (image != null) {
                      setState(() {
                        _selectedImage = File(image.path);
                      });
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () async {
                    Navigator.pop(context);
                    final XFile? image = await _imagePicker.pickImage(
                      source: ImageSource.camera,
                      maxWidth: 1024,
                      maxHeight: 1024,
                      imageQuality: 85,
                    );
                    if (image != null) {
                      setState(() {
                        _selectedImage = File(image.path);
                      });
                    }
                  },
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    
    final nameValue = _nameController.text.trim();
    // Mobile number is not editable, so we use the original value
    final mobileValue = _originalMobile;
    
    // Validate name input only
    if (!profileProvider.isValidName(nameValue)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid name (at least 2 characters)')),
      );
      return;
    }

    // Update original name to reflect current input
    _originalName = nameValue;

    try {
      bool success;
      
      if (_selectedImage != null) {
        // Update complete profile with image
        success = await profileProvider.updateCompleteProfile(
          name: nameValue,
          mobile: mobileValue,
          profileImage: _selectedImage,
        );
      } else {
        // Update only user data
        success = await profileProvider.updateUserProfile(
          name: nameValue,
          mobile: mobileValue,
        );
      }

      if (success) {
        // Ensure the form still shows the correct values after update
        setState(() {
          _nameController.text = _originalName;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        
        // Clear the selected image since it's now uploaded
        setState(() {
          _selectedImage = null;
        });
        
        // Optionally pop back to previous screen
        // Navigator.pop(context);
      } else {
        // Restore the form values if update failed
        setState(() {
          _nameController.text = _originalName;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(profileProvider.errorMessage ?? 'Failed to update profile'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Restore the form values if error occurred
      setState(() {
        _nameController.text = _originalName;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildProfileImage(ProfileProvider profileProvider) {
    return Center(
      child: Stack(
        children: [
          // Container(
          //   width: 80,
          //   height: 80,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     color: Colors.amber,
          //   ),
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(10),
          //     child: _selectedImage != null
          //         ? Image.file(
          //             _selectedImage!,
          //             fit: BoxFit.cover,
          //           )
          //         : profileProvider.hasProfileImage()
          //             ? Image.network(
          //                 profileProvider.getProfileImageUrl()!,
          //                 fit: BoxFit.cover,
          //                 errorBuilder: (context, error, stackTrace) {
          //                   return Image.asset(
          //                     'assets/profile.png',
          //                     fit: BoxFit.cover,
          //                   );
          //                 },
          //               )
          //             : Image.asset(
          //                 'assets/profile.png',
          //                 fit: BoxFit.cover,
          //               ),
          //   ),
          // ),
          Container(
  width: 80,
  height: 80,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.grey[300],
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: _selectedImage != null
        ? Image.file(
            _selectedImage!,
            fit: BoxFit.cover,
          )
        : profileProvider.hasProfileImage()
            ? Image.network(
                profileProvider.getProfileImageUrl()!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.grey[700],
                    ),
                  );
                },
              )
            : Center(
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.grey[700],
                ),
              ),
  ),
),

          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: _pickImage,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.indigo,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const AppText(
          'personal_information',
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
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          // Auto-initialize if data is available but not yet set
          if (profileProvider.user != null && !_isDataInitialized) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _initializeUserData();
            });
          }
          
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Profile Image
                    _buildProfileImage(profileProvider),
                    const SizedBox(height: 24),

    
                    const SizedBox(height: 16),

                    // Name Field (Editable)
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your name';
                        }
                        if (!profileProvider.isValidName(value.trim())) {
                          return 'Name must be at least 2 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: AppText.translate(context, 'name'),
                        labelStyle: const TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[400]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[400]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                            width: 1.2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Mobile Field (Read-only)
                    TextFormField(
                      controller: _mobileController,
                      enabled: false, // Make field non-editable
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                        color: Colors.grey[600], // Indicate read-only state
                      ),
                      decoration: InputDecoration(
                        labelText: AppText.translate(context, 'mobile_number'),
                        labelStyle: const TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 12,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100], // Visual indicator of disabled state
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: profileProvider.isUpdating ? null : _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6A3DE8),
                          disabledBackgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: profileProvider.isUpdating
                            ? const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Updating...',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            : const AppText(
                                'save',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}