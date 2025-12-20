// import 'package:flutter/material.dart';

// class ContactScreen extends StatelessWidget {
//   const ContactScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Contact Us"),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           // Header
//           Column(
//             children: [
//               const Icon(Icons.support_agent_rounded, size: 80, color: Colors.blue),
//               const SizedBox(height: 12),
//               Text(
//                 "We’re here to help!",
//                 style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 "Reach us anytime via call, email, or visit our office.",
//                 style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),

//           const SizedBox(height: 24),

//           // Phone
//           _ContactCard(
//             icon: Icons.call_rounded,
//             title: "Customer Care",
//             subtitle: "+91 98765 43210",
//             onTap: () => _showInfo(context, "Dial +91 98765 43210"),

//           ),

//           // Email
//           _ContactCard(
//             icon: Icons.email_rounded,
//             title: "Email Us",
//             subtitle: "support@clynix.com",
//             onTap: () => _showInfo(context, "Compose email to support@medapp.com"),
//           ),

//           // Address
//         //   _ContactCard(
//         //     icon: Icons.location_on_rounded,
//         //     title: "Office Address",
//         //     subtitle: "MedApp HQ, 2nd Floor,\n123 Health Street,\nKochi, Kerala - 682001",
//         //     onTap: () => _showInfo(context, "Open location in Maps"),
//         //   ),

//         // const  _ContactCard(
//         //     icon: Icons.access_time_rounded,
//         //     title: "Working Hours",
//         //     subtitle: "Mon - Sat: 9 AM - 8 PM\nSunday: Closed",
//         //   ),

//           const SizedBox(height: 24),

//           // Footer
//           Center(
//             child: Text(
//               "© 2025 MedApp. All rights reserved.",
//               style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _ContactCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final VoidCallback? onTap;

//   const _ContactCard({
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
//           child: Icon(icon, color: theme.colorScheme.primary),
//         ),
//         title: Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
//         subtitle: Text(subtitle, style: theme.textTheme.bodyMedium),
//         onTap: onTap,
//       ),
//     );
//   }
// }

// void _showInfo(BuildContext context, String msg) {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
// }
