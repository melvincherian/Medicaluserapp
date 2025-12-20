// // class User {
// //   final String id;
// //   final String name;
// //   final String mobile;
// //   final String code;
// //   final DateTime createdAt;

// //   User({
// //     required this.id,
// //     required this.name,
// //     required this.mobile,
// //     required this.code,
// //     required this.createdAt,
// //   });

// //   factory User.fromJson(Map<String, dynamic> json) {
// //     return User(
// //       id: json['id'] ?? '',
// //       name: json['name'] ?? '',
// //       mobile: json['mobile'] ?? '',
// //       code: json['code'] ?? '',
// //       createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'id': id,
// //       'name': name,
// //       'mobile': mobile,
// //       'code': code,
// //       'createdAt': createdAt.toIso8601String(),
// //     };
// //   }

// //   User copyWith({
// //     String? id,
// //     String? name,
// //     String? mobile,
// //     String? code,
// //     DateTime? createdAt,
// //   }) {
// //     return User(
// //       id: id ?? this.id,
// //       name: name ?? this.name,
// //       mobile: mobile ?? this.mobile,
// //       code: code ?? this.code,
// //       createdAt: createdAt ?? this.createdAt,
// //     );
// //   }
// // }


























// class User {
//   final String id;
//   final String name;
//   final String mobile;
//   final String email;
//   final String code;
//   final String? profileImage;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;

//   User({
//     required this.id,
//     required this.name,
//     required this.mobile,
//     required this.email,
//     required this.code,
//     this.profileImage,
//     this.createdAt,
//     this.updatedAt,
//   });

//   // Factory constructor to create User from JSON
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id']?.toString() ?? '',
//       name: json['name']?.toString() ?? '',
//       mobile: json['mobile']?.toString() ?? '',
//       email: json['email']?.toString() ??'',
//       code: json['code']?.toString() ?? '',
//       profileImage: json['profileImage']?.toString(),
//       createdAt: json['createdAt'] != null 
//           ? DateTime.tryParse(json['createdAt'].toString())
//           : null,
//       updatedAt: json['updatedAt'] != null 
//           ? DateTime.tryParse(json['updatedAt'].toString())
//           : null,
//     );
//   }

//   // Convert User to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'mobile': mobile,
//       'email':email,
//       'code': code,
//       'profileImage': profileImage,
//       'createdAt': createdAt?.toIso8601String(),
//       'updatedAt': updatedAt?.toIso8601String(),
//     };
//   }

//   // Create a copy of User with updated fields
//   User copyWith({
//     String? id,
//     String? name,
//     String? mobile,
//     String?email,
//     String? code,
//     String? profileImage,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//   }) {
//     return User(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       email: email??this.email,
//       mobile: mobile ?? this.mobile,
//       code: code ?? this.code,
//       profileImage: profileImage ?? this.profileImage,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//     );
//   }

//   // Check if user has complete profile information
//   bool get hasCompleteProfile {
//     return id.isNotEmpty && 
//            name.isNotEmpty &&
//            email.isNotEmpty&&
//            mobile.isNotEmpty;
//   }

//   // Get formatted mobile number
//   String get formattedMobile {
//     if (mobile.isEmpty) return '';
    
//     // If mobile already starts with +, return as is
//     if (mobile.startsWith('+')) return mobile;
    
//     // If mobile starts with country code without +, add +
//     if (mobile.length > 10) return '+$mobile';
    
//     // Default formatting for local numbers
//     return mobile;
//   }

//   // Get user initials for avatar
//   String get initials {
//     if (name.isEmpty) return 'U';
    
//     final parts = name.trim().split(' ');
//     if (parts.length >= 2) {
//       return (parts[0][0] + parts[1][0]).toUpperCase();
//     }
//     return parts[0][0].toUpperCase();
//   }

//   // Get display name (first name or full name)
//   String get displayName {
//     if (name.isEmpty) return 'User';
    
//     final parts = name.trim().split(' ');
//     return parts[0];
//   }

//   // Get full display name
//   String get fullDisplayName {
//     return name.isNotEmpty ? name : 'User';
//   }

//   // Check if user has profile image
//   bool get hasProfileImage {
//     return profileImage != null && profileImage!.isNotEmpty;
//   }

//   // Get safe profile image URL
//   String? get safeProfileImageUrl {
//     if (profileImage == null || profileImage!.isEmpty) return null;
    
//     // Check if it's a valid URL
//     final uri = Uri.tryParse(profileImage!);
//     if (uri != null && (uri.hasScheme)) {
//       return profileImage;
//     }
    
//     return null;
//   }

//   // Check if mobile number is valid
//   bool get hasValidMobile {
//     if (mobile.isEmpty) return false;
    
//     final cleanMobile = mobile.replaceAll(RegExp(r'[^\d]'), '');
//     return cleanMobile.length >= 10;
//   }

//   // Get account age in days
//   int get accountAgeInDays {
//     if (createdAt == null) return 0;
    
//     final now = DateTime.now();
//     return now.difference(createdAt!).inDays;
//   }

//   // Check if profile was recently updated (within last 24 hours)
//   bool get isRecentlyUpdated {
//     if (updatedAt == null) return false;
    
//     final now = DateTime.now();
//     final difference = now.difference(updatedAt!);
//     return difference.inHours < 24;
//   }

//   @override
//   String toString() {
//     return 'User{id: $id, name: $name, mobile: $mobile, code: $code, profileImage: $profileImage, createdAt: $createdAt, updatedAt: $updatedAt}';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
    
//     return other is User &&
//            other.id == id &&
//            other.name == name &&
//            other.mobile == mobile &&
//            other.code == code &&
//            other.profileImage == profileImage;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//            name.hashCode ^
//            mobile.hashCode ^
//            code.hashCode ^
//            profileImage.hashCode;
//   }

//   // Validation methods
//   static bool isValidName(String? name) {
//     return name != null && name.trim().isNotEmpty && name.length >= 2;
//   }

//   static bool isValidMobile(String? mobile) {
//     if (mobile == null || mobile.isEmpty) return false;
    
//     final cleanMobile = mobile.replaceAll(RegExp(r'[^\d]'), '');
//     return cleanMobile.length >= 10 && cleanMobile.length <= 15;
//   }

//   static bool isValidId(String? id) {
//     return id != null && id.trim().isNotEmpty;
//   }

//   // Create empty user
//   static User empty() {
//     return User(
//       id: '',
//       name: '',
//       email: '',
//       mobile: '',
//       code: '',
//     );
//   }

//   // Check if user is empty
//   bool get isEmpty {
//     return id.isEmpty && name.isEmpty && mobile.isEmpty;
//   }

//   bool get isNotEmpty => !isEmpty;
// }











class User {
  final String id;
  final String name;
  final String mobile;
  final String email;
  final String code;
  final String? profileImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.code,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor to create User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      mobile: json['mobile']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
      profileImage: json['profileImage']?.toString(),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
    );
  }

  // Convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'email': email,
      'code': code,
      'profileImage': profileImage,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  // Create a copy of User with updated fields
  User copyWith({
    String? id,
    String? name,
    String? mobile,
    String? email,
    String? code,
    String? profileImage,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      code: code ?? this.code,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Check if user has complete profile information
  bool get hasCompleteProfile {
    return id.isNotEmpty &&
        name.isNotEmpty &&
        mobile.isNotEmpty &&
        email.isNotEmpty;
  }

  // Get formatted mobile number
  String get formattedMobile {
    if (mobile.isEmpty) return '';

    if (mobile.startsWith('+')) return mobile;

    if (mobile.length > 10) return '+$mobile';

    return mobile;
  }

  // Get user initials for avatar
  String get initials {
    if (name.isEmpty) return 'U';

    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  // Get display name (first name or full name)
  String get displayName {
    if (name.isEmpty) return 'User';

    final parts = name.trim().split(' ');
    return parts[0];
  }

  // Get full display name
  String get fullDisplayName {
    return name.isNotEmpty ? name : 'User';
  }

  // Check if user has profile image
  bool get hasProfileImage {
    return profileImage != null && profileImage!.isNotEmpty;
  }

  // Get safe profile image URL
  String? get safeProfileImageUrl {
    if (profileImage == null || profileImage!.isEmpty) return null;

    final uri = Uri.tryParse(profileImage!);
    if (uri != null && uri.hasScheme) {
      return profileImage;
    }

    return null;
  }

  // Check if mobile number is valid
  bool get hasValidMobile {
    if (mobile.isEmpty) return false;

    final cleanMobile = mobile.replaceAll(RegExp(r'[^\d]'), '');
    return cleanMobile.length >= 10;
  }

  // Get account age in days
  int get accountAgeInDays {
    if (createdAt == null) return 0;

    final now = DateTime.now();
    return now.difference(createdAt!).inDays;
  }

  // Check if profile was recently updated (within last 24 hours)
  bool get isRecentlyUpdated {
    if (updatedAt == null) return false;

    final now = DateTime.now();
    final difference = now.difference(updatedAt!);
    return difference.inHours < 24;
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, mobile: $mobile, email: $email, code: $code, profileImage: $profileImage, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.mobile == mobile &&
        other.email == email &&
        other.code == code &&
        other.profileImage == profileImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        mobile.hashCode ^
        email.hashCode ^
        code.hashCode ^
        profileImage.hashCode;
  }

  // Validation methods
  static bool isValidName(String? name) {
    return name != null && name.trim().isNotEmpty && name.length >= 2;
  }

  static bool isValidMobile(String? mobile) {
    if (mobile == null || mobile.isEmpty) return false;

    final cleanMobile = mobile.replaceAll(RegExp(r'[^\d]'), '');
    return cleanMobile.length >= 10 && cleanMobile.length <= 15;
  }

  static bool isValidEmail(String? email) {
    if (email == null || email.isEmpty) return false;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  static bool isValidId(String? id) {
    return id != null && id.trim().isNotEmpty;
  }

  // Create empty user
  static User empty() {
    return User(
      id: '',
      name: '',
      email: '',
      mobile: '',
      code: '',
    );
  }

  // Check if user is empty
  bool get isEmpty {
    return id.isEmpty && name.isEmpty && mobile.isEmpty && email.isEmpty;
  }

  bool get isNotEmpty => !isEmpty;
}
