// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:medical_user_app/models/user_model.dart';
// import 'package:medical_user_app/utils/shared_preferences_helper.dart';

// class GetVendorPrescription extends StatefulWidget {
//   const GetVendorPrescription({super.key});

//   @override
//   State<GetVendorPrescription> createState() => _GetVendorPrescriptionState();
// }

// class _GetVendorPrescriptionState extends State<GetVendorPrescription> {
//   bool _isLoading = false;
//   bool _isFetching = true;
//   List<Map<String, dynamic>> _prescriptions = [];
//   String? _userId;
//   String? _token;

//   @override
//   void initState() {
//     super.initState();
//     _loadPrescriptions();
//   }

//   Future<void> _loadPrescriptions() async {
//     setState(() => _isFetching = true);

//     try {
//       final User? user = await SharedPreferencesHelper.getUser();
//       final String? token = await SharedPreferencesHelper.getToken();

//       if (user == null || token == null) {
//         _showSnackBar('Session expired. Please log in again.', isError: true);
//         return;
//       }

//       _userId = user.id;
//       _token = token;

//       final uri = Uri.parse(
//         'http://31.97.206.144:7021/api/users/userprescriptions/${user.id}',
//       );

//       final response = await http.get(
//         uri,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );

//       final responseData = jsonDecode(response.body);

//       print(
//           'Response status code for get user prescriptionnnnnnnnnnnn ${response.statusCode}');
//       print(
//           'Response  booooooooooooooody for get user prescriptionnnnnnnnnnnn ${response.body}');

//       if (response.statusCode == 200 && responseData['success'] == true) {
//         setState(() {
//           _prescriptions =
//               List<Map<String, dynamic>>.from(responseData['prescriptions']);
//         });
//       } else {
//         _showSnackBar(
//             responseData['message'] ?? 'Failed to fetch prescriptions.',
//             isError: true);
//       }
//     } catch (e) {
//       _showSnackBar('Network error: $e', isError: true);
//     } finally {
//       if (mounted) setState(() => _isFetching = false);
//     }
//   }

//   Future<void> _respondToPrescription(
//       String prescriptionId, bool accept) async {
//     setState(() => _isLoading = true);

//     try {
//       final uri = Uri.parse(
//         'http://31.97.206.144:7021/api/users/users/$_userId/prescription/$prescriptionId/respond',
//       );

//       final response = await http.post(
//         uri,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $_token',
//         },
//         body: jsonEncode({'accept': accept}),
//       );

//       final responseData = jsonDecode(response.body);

//       print(
//           'Response status code for get aaaaaaaaaceeeeeeeept prescriptionnnnnnnnnnnn ${response.statusCode}');
//       print(
//           'Response  booooooooooooooody for aaaaaaaaaceeeeeeeept user prescriptionnnnnnnnnnnn ${response.body}');
//       print('prescriptionnnnnnnnnnnnnn iddddddddddddd $prescriptionId');
//       print('submitted dataaaaaaaaaaaa $accept');

//       if (response.statusCode == 200 && responseData['success'] == true) {
//         _showSnackBar(
//           accept
//               ? 'Prescription accepted successfully!'
//               : 'Prescription rejected.',
//           isError: false,
//         );
//         await _loadPrescriptions(); // Refresh the list
//       } else {
//         _showSnackBar(responseData['message'] ?? 'Something went wrong.',
//             isError: true);
//       }
//     } catch (e) {
//       _showSnackBar('Network error: $e', isError: true);
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   void _showSnackBar(String message, {required bool isError}) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: isError ? Colors.red : Colors.green,
//         behavior: SnackBarBehavior.floating,
//       ),
//     );
//   }

//   void _confirmAndRespond(String prescriptionId, bool accept) {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: Text(accept ? 'Accept Quote' : 'Reject Quote'),
//         content: Text(
//           accept
//               ? 'Are you sure you want to accept this quote?'
//               : 'Are you sure you want to reject this prescription quote?',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: accept ? Colors.green : Colors.red,
//               foregroundColor: Colors.white,
//             ),
//             onPressed: () {
//               Navigator.pop(ctx);
//               _respondToPrescription(prescriptionId, accept);
//             },
//             child: Text(accept ? 'Accept' : 'Reject'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'My Prescriptions',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: _loadPrescriptions,
//           ),
//         ],
//       ),
//       body: _isFetching
//           ? const Center(child: CircularProgressIndicator())
//           : _prescriptions.isEmpty
//               ? const Center(child: Text('No prescriptions found.'))
//               : Stack(
//                   children: [
//                     ListView.builder(
//                       padding: const EdgeInsets.all(16),
//                       itemCount: _prescriptions.length,
//                       itemBuilder: (context, index) {
//                         final prescription = _prescriptions[index];
//                         return _buildPrescriptionCard(prescription);
//                       },
//                     ),
//                     if (_isLoading)
//                       const ColoredBox(
//                         color: Colors.black26,
//                         child: Center(child: CircularProgressIndicator()),
//                       ),
//                   ],
//                 ),
//     );
//   }

//   Widget _buildPrescriptionCard(Map<String, dynamic> prescription) {
//     final prescriptionId =
//         prescription['prescriptionId'] ?? prescription['_id'];
//     final pharmacy = prescription['pharmacy'] as Map<String, dynamic>?;
//     final status = prescription['status'] ?? 'Pending';
//     final proposedAmount = prescription['proposedAmount'];
//     final deliveryCharge = prescription['deliveryCharge'];
//     final platformFee = prescription['platformFee'];
//     final totalAmount = prescription['totalAmount'];
//     final proposedDescription = prescription['proposedDescription'];
//     final prescriptionUrl = prescription['prescriptionUrl'];

//     final bool canRespond = status == 'QuoteAccepted';

//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Prescription image
//             if (prescriptionUrl != null)
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Image.network(
//                   prescriptionUrl,
//                   width: double.infinity,
//                   height: 180,
//                   fit: BoxFit.cover,
//                   errorBuilder: (_, __, ___) => Container(
//                     height: 180,
//                     color: Colors.grey[200],
//                     child: const Center(child: Icon(Icons.image_not_supported)),
//                   ),
//                 ),
//               ),

//             const SizedBox(height: 12),

//             // Status chip
//             Align(
//               alignment: Alignment.center,
//               child: Chip(
//                 label: Text(status),
//                 backgroundColor: _statusColor(status).withOpacity(0.15),
//                 labelStyle: TextStyle(
//                   color: _statusColor(status),
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 12),

//             // Pharmacy info
//             if (pharmacy != null) ...[
//               ListTile(
//                 contentPadding: EdgeInsets.zero,
//                 leading: pharmacy['image'] != null
//                     ? ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.network(
//                           pharmacy['image'],
//                           width: 48,
//                           height: 48,
//                           fit: BoxFit.cover,
//                         ),
//                       )
//                     : const Icon(Icons.local_pharmacy),
//                 title: Text(
//                   pharmacy['name'] ?? '',
//                   style: const TextStyle(fontWeight: FontWeight.w600),
//                 ),
//                 subtitle: Text(pharmacy['address'] ?? ''),
//               ),
//               const Divider(),
//             ],

//             // Proposed description
//             if (proposedDescription != null &&
//                 (proposedDescription as String).isNotEmpty) ...[
//               const Text('Items',
//                   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
//               const SizedBox(height: 6),
//               Text(proposedDescription, style: const TextStyle(fontSize: 14)),
//               const SizedBox(height: 12),
//             ],

//             // Amount breakdown
//             if (proposedAmount != null) ...[
//               const Text('Quote Breakdown',
//                   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
//               const SizedBox(height: 8),
//               _buildAmountRow('Medicine amount', '₹$proposedAmount'),
//               if (deliveryCharge != null)
//                 _buildAmountRow('Delivery charge', '₹$deliveryCharge'),
//               if (platformFee != null)
//                 _buildAmountRow('Platform fee', '₹$platformFee'),
//               const Divider(),
//               _buildAmountRow('Total', '₹${totalAmount ?? proposedAmount}',
//                   isBold: true),
//               const SizedBox(height: 16),
//             ],

//             // Accept / Reject buttons — only shown when canRespond
//             if (canRespond)
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       style: OutlinedButton.styleFrom(
//                         foregroundColor: Colors.red,
//                         side: const BorderSide(color: Colors.red),
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       onPressed: () =>
//                           _confirmAndRespond(prescriptionId, false),
//                       child: const Text('Reject',
//                           style: TextStyle(
//                               fontSize: 15, fontWeight: FontWeight.w600)),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       onPressed: () => _confirmAndRespond(prescriptionId, true),
//                       child: const Text('Accept',
//                           style: TextStyle(
//                               fontSize: 15, fontWeight: FontWeight.w600)),
//                     ),
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAmountRow(String label, String value, {bool isBold = false}) {
//     final style = TextStyle(
//       fontSize: 14,
//       fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
//     );
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: style),
//           Text(value, style: style),
//         ],
//       ),
//     );
//   }

//   Color _statusColor(String status) {
//     switch (status) {
//       case 'QuoteAccepted':
//         return Colors.green;
//       case 'Pending':
//         return Colors.orange;
//       case 'Rejected':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }
// }



















import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:medical_user_app/models/user_model.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';

class GetVendorPrescription extends StatefulWidget {
  const GetVendorPrescription({super.key});

  @override
  State<GetVendorPrescription> createState() => _GetVendorPrescriptionState();
}

class _GetVendorPrescriptionState extends State<GetVendorPrescription> {
  bool _isLoading = false;
  bool _isFetching = true;
  List<Map<String, dynamic>> _prescriptions = [];
  String? _userId;
  String? _token;

  @override
  void initState() {
    super.initState();
    _loadPrescriptions();
  }

  Future<void> _loadPrescriptions() async {
    setState(() => _isFetching = true);

    try {
      final User? user = await SharedPreferencesHelper.getUser();
      final String? token = await SharedPreferencesHelper.getToken();

      if (user == null || token == null) {
        _showSnackBar('Session expired. Please log in again.', isError: true);
        return;
      }

      _userId = user.id;
      _token = token;

      final uri = Uri.parse(
        'http://31.97.206.144:7021/api/users/prescription-previews/${user.id}',
      );

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final responseData = jsonDecode(response.body);

      print('Response status [prescription-previews]: ${response.statusCode}');
      print('Response body [prescription-previews]: ${response.body}');

      if (response.statusCode == 200 && responseData['success'] == true) {
        setState(() {
          _prescriptions =
              List<Map<String, dynamic>>.from(responseData['previews'] ?? []);
        });
      } else {
        _showSnackBar(
          responseData['message'] ?? 'Failed to fetch prescriptions.',
          isError: true,
        );
      }
    } catch (e) {
      _showSnackBar('Network error: $e', isError: true);
    } finally {
      if (mounted) setState(() => _isFetching = false);
    }
  }

  Future<void> _respondToPrescription(
      String prescriptionId, bool accept) async {
    setState(() => _isLoading = true);

    try {
      final action = accept ? 'confirm' : 'reject';

      final uri = Uri.parse(
        'http://31.97.206.144:7021/api/users/confirm-prescription-order/$_userId/$prescriptionId',
      );

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode({'action': action}),
      );

      final responseData = jsonDecode(response.body);

      print(
          'Response status [confirm-prescription-order]: ${response.statusCode}');
      print('Response body [confirm-prescription-order]: ${response.body}');
      print('Prescription ID: $prescriptionId');
      print('Action submitted: $action');

      if (response.statusCode == 200 && responseData['success'] == true) {
        _showSnackBar(
          accept
              ? 'Prescription confirmed successfully!'
              : 'Prescription rejected.',
          isError: false,
        );
        await _loadPrescriptions();
      } else {
        _showSnackBar(
          responseData['message'] ?? 'Something went wrong.',
          isError: true,
        );
      }
    } catch (e) {
      _showSnackBar('Network error: $e', isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message, {required bool isError}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _confirmAndRespond(String prescriptionId, bool accept) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(accept ? 'Accept Quote' : 'Reject Quote'),
        content: Text(
          accept
              ? 'Are you sure you want to accept this quote?'
              : 'Are you sure you want to reject this prescription quote?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: accept ? Colors.green : Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              _respondToPrescription(prescriptionId, accept);
            },
            child: Text(accept ? 'Accept' : 'Reject'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Prescriptions',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadPrescriptions,
          ),
        ],
      ),
      body: _isFetching
          ? const Center(child: CircularProgressIndicator())
          : _prescriptions.isEmpty
              ? const Center(child: Text('No prescriptions found.'))
              : Stack(
                  children: [
                    ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _prescriptions.length,
                      itemBuilder: (context, index) {
                        final prescription = _prescriptions[index];
                        return _buildPrescriptionCard(prescription);
                      },
                    ),
                    if (_isLoading)
                      const ColoredBox(
                        color: Colors.black26,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                  ],
                ),
    );
  }

  Widget _buildPrescriptionCard(Map<String, dynamic> prescription) {
    final prescriptionId =
        prescription['prescriptionId'] ?? prescription['_id'];
    final pharmacy = prescription['pharmacy'] as Map<String, dynamic>?;
    final status = prescription['status'] ?? 'Pending';
    final proposedAmount = prescription['proposedAmount'];
    final deliveryCharge = prescription['deliveryCharge'];
    final platformFee = prescription['platformFee'];
    final totalAmount = prescription['totalAmount'];
    final proposedDescription = prescription['proposedDescription'];
    final prescriptionUrl = prescription['prescriptionUrl'];

    final bool canRespond = status == 'QuoteAccepted';

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Prescription image
            if (prescriptionUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  prescriptionUrl,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 180,
                    color: Colors.grey[200],
                    child: const Center(child: Icon(Icons.image_not_supported)),
                  ),
                ),
              ),

            const SizedBox(height: 12),

            // Status chip
            Align(
              alignment: Alignment.center,
              child: Chip(
                label: Text(status),
                backgroundColor: _statusColor(status).withOpacity(0.15),
                labelStyle: TextStyle(
                  color: _statusColor(status),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Pharmacy info
            if (pharmacy != null) ...[
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: pharmacy['image'] != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          pharmacy['image'],
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Icon(Icons.local_pharmacy),
                title: Text(
                  pharmacy['name'] ?? '',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(pharmacy['address'] ?? ''),
              ),
              const Divider(),
            ],

            // Proposed description
            if (proposedDescription != null &&
                (proposedDescription as String).isNotEmpty) ...[
              const Text(
                'Items',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              const SizedBox(height: 6),
              Text(proposedDescription, style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 12),
            ],

            // Amount breakdown
            if (proposedAmount != null) ...[
              const Text(
                'Quote Breakdown',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              const SizedBox(height: 8),
              _buildAmountRow('Medicine amount', '₹$proposedAmount'),
              if (deliveryCharge != null)
                _buildAmountRow('Delivery charge', '₹$deliveryCharge'),
              if (platformFee != null)
                _buildAmountRow('Platform fee', '₹$platformFee'),
              const Divider(),
              _buildAmountRow(
                'Total',
                '₹${totalAmount ?? proposedAmount}',
                isBold: true,
              ),
              const SizedBox(height: 16),
            ],

            // Accept / Reject buttons — only shown when canRespond
            if (canRespond)
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () =>
                          _confirmAndRespond(prescriptionId, false),
                      child: const Text(
                        'Reject',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () =>
                          _confirmAndRespond(prescriptionId, true),
                      child: const Text(
                        'Accept',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountRow(String label, String value, {bool isBold = false}) {
    final style = TextStyle(
      fontSize: 14,
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'QuoteAccepted':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
