// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';

class InvoiceScreen extends StatefulWidget {
  final String? orderId;
  
  const InvoiceScreen({super.key, this.orderId});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  bool _isLoading = false;
  Map<String, dynamic>? _orderDetails;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchInvoiceData();
  }

  Future<void> _fetchInvoiceData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Get user data from SharedPreferences
      final user = await SharedPreferencesHelper.getUser();
      if (user == null) {
        throw Exception('User not found. Please login again.');
      }

      final userId = user.id;
      final orderIdToUse = widget.orderId ?? _orderDetails?['_id'];
      
      if (orderIdToUse == null) {
        throw Exception('Order ID not provided');
      }

      // Fetch invoice data from API
      final response = await http.get(
        Uri.parse('http://31.97.206.144:7021/api/users/generate-invoice/$userId/$orderIdToUse'),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
          // 'Authorization': 'Bearer ${await SharedPreferencesHelper.getToken()}',
        },
      );



      print('response status codeeeeeeeeeeeeeeeeeeeeee ${response.statusCode}');
            print('response bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy ${response.body}');


      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _orderDetails = data['invoice'];
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch invoice data: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
      print('Error fetching invoice data: $e');
    }
  }

  Future<Uint8List> _generatePDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            // Header
            _buildHeader(),
            pw.SizedBox(height: 20),
            
            // Invoice Details
            _buildInvoiceDetails(),
            pw.SizedBox(height: 20),
            
            // Customer Details
            _buildCustomerDetails(),
            pw.SizedBox(height: 20),
            
            // Order Items
            _buildOrderItems(),
            pw.SizedBox(height: 20),
            
            // Total Summary
            _buildTotalSummary(),
            pw.SizedBox(height: 30),
            
            // Footer
            _buildFooter(),
          ];
        },
      ),
    );

    return pdf.save();
  }

  pw.Widget _buildHeader() {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Text-based logo only
            pw.Container(
              width: 100,
              height: 80,
              decoration: pw.BoxDecoration(
                color: PdfColors.blue,
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Center(
                child: pw.Text(
                  'CLYNIX',
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              'Medical Delivery Service',
              style: pw.TextStyle(fontSize: 12, color: PdfColors.grey600),
            ),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(
              'INVOICE',
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.blue,
              ),
            ),
            pw.SizedBox(height: 5),
            pw.Text(
              'Invoice #${_orderDetails?['orderId']?.toString().substring(0, 8) ?? 'N/A'}',
              style: pw.TextStyle(fontSize: 12, color: PdfColors.grey600),
            ),
          ],
        ),
      ],
    );
  }

  // pw.Widget _buildInvoiceDetails() {
  //   final createdAt = _orderDetails?['createdAt'];
  //   String formattedDate = 'N/A';
    
  //   if (createdAt != null) {
  //     try {
  //       formattedDate = DateTime.parse(createdAt.toString()).toString().split(' ')[0];
  //     } catch (e) {
  //       print('Error parsing date: $e');
  //       formattedDate = 'N/A';
  //     }
  //   }

  //   return pw.Container(
  //     padding: const pw.EdgeInsets.all(15),
  //     decoration: pw.BoxDecoration(
  //       border: pw.Border.all(color: PdfColors.grey300),
  //       borderRadius: pw.BorderRadius.circular(5),
  //     ),
  //     child: pw.Row(
  //       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //       children: [
  //         pw.Column(
  //           crossAxisAlignment: pw.CrossAxisAlignment.start,
  //           children: [
  //             pw.Text('Order ID:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
  //             pw.Text(_orderDetails?['_id']?.toString().substring(0, 12) ?? 'N/A'),
  //             pw.SizedBox(height: 5),
  //             pw.Text('Order Date:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
  //             pw.Text(formattedDate),
  //           ],
  //         ),
  //         pw.Column(
  //           crossAxisAlignment: pw.CrossAxisAlignment.end,
  //           children: [
  //             pw.Text('Status:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
  //             pw.Container(
  //               padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 2),
  //               decoration: pw.BoxDecoration(
  //                 color: _getStatusColor(_orderDetails?['status']?.toString()),
  //                 borderRadius: pw.BorderRadius.circular(3),
  //               ),
  //               child: pw.Text(
  //                 _orderDetails?['status']?.toString() ?? 'Unknown',
  //                 style: pw.TextStyle(color: PdfColors.white, fontSize: 10),
  //               ),
  //             ),
  //             pw.SizedBox(height: 5),
  //             pw.Text('Payment:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
  //             pw.Text(_orderDetails?['paymentMethod']?.toString() ?? 'N/A'),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }



  pw.Widget _buildInvoiceDetails() {
  final orderDate = _orderDetails?['orderDate'];
  String formattedDate = 'N/A';
  
  if (orderDate != null) {
    try {
      formattedDate = DateTime.parse(orderDate.toString()).toString().split(' ')[0];
    } catch (e) {
      print('Error parsing date: $e');
      formattedDate = 'N/A';
    }
  }

  return pw.Container(
    padding: const pw.EdgeInsets.all(15),
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: PdfColors.grey300),
      borderRadius: pw.BorderRadius.circular(5),
    ),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Order ID:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text(_orderDetails?['orderId']?.toString().substring(0, 12) ?? 'N/A'),
            pw.SizedBox(height: 5),
            pw.Text('Order Date:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text(formattedDate),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text('Payment Status:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Container(
              padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: pw.BoxDecoration(
                color: _getStatusColor(_orderDetails?['paymentStatus']?.toString()),
                borderRadius: pw.BorderRadius.circular(3),
              ),
              child: pw.Text(
                _orderDetails?['paymentStatus']?.toString() ?? 'Unknown',
                style: pw.TextStyle(color: PdfColors.white, fontSize: 10),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

  // pw.Widget _buildCustomerDetails() {
  //   final user = _orderDetails?['userId'];
  //   final address = _orderDetails?['deliveryAddress'];
    
  //   return pw.Container(
  //     padding: const pw.EdgeInsets.all(15),
  //     decoration: pw.BoxDecoration(
  //       border: pw.Border.all(color: PdfColors.grey300),
  //       borderRadius: pw.BorderRadius.circular(5),
  //     ),
  //     child: pw.Column(
  //       crossAxisAlignment: pw.CrossAxisAlignment.start,
  //       children: [
  //         pw.Text('Customer Details', 
  //           style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
  //         pw.SizedBox(height: 10),
  //         pw.Text('Name: ${user?['name']?.toString() ?? 'N/A'}'),
  //         pw.Text('Mobile: ${user?['mobile']?.toString() ?? 'N/A'}'),
  //         pw.SizedBox(height: 10),
  //         pw.Text('Delivery Address:', 
  //           style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
  //         if (address != null) ...[
  //           pw.Text('${address['house']?.toString() ?? ''}, ${address['street']?.toString() ?? ''}'),
  //           pw.Text('${address['city']?.toString() ?? ''}, ${address['state']?.toString() ?? ''} - ${address['pincode']?.toString() ?? ''}'),
  //           pw.Text('${address['country']?.toString() ?? ''}'),
  //         ] else
  //           pw.Text('Address not available'),
  //       ],
  //     ),
  //   );
  // }


  pw.Widget _buildCustomerDetails() {
  final customer = _orderDetails?['customer'];
  final rider = _orderDetails?['rider'];
  
  return pw.Container(
    padding: const pw.EdgeInsets.all(15),
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: PdfColors.grey300),
      borderRadius: pw.BorderRadius.circular(5),
    ),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Customer Details', 
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 10),
        pw.Text('Name: ${customer?['name']?.toString() ?? 'N/A'}'),
        pw.Text('Phone: ${customer?['phone']?.toString() ?? 'N/A'}'),
        pw.SizedBox(height: 10),
        if (rider != null) ...[
          pw.Text('Rider Details:', 
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Text('Rider: ${rider['name']?.toString() ?? 'N/A'}'),
          pw.Text('Phone: ${rider['phone']?.toString() ?? 'N/A'}'),
        ],
      ],
    ),
  );
}

  // pw.Widget _buildOrderItems() {
  //   final items = _orderDetails?['orderItems'] as List<dynamic>? ?? [];
    
  //   return pw.Column(
  //     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //     children: [
  //       pw.Text('Order Items', 
  //         style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
  //       pw.SizedBox(height: 10),
  //       pw.Table(
  //         border: pw.TableBorder.all(color: PdfColors.grey300),
  //         columnWidths: {
  //           0: const pw.FlexColumnWidth(3),
  //           1: const pw.FlexColumnWidth(1),
  //           2: const pw.FlexColumnWidth(1),
  //           3: const pw.FlexColumnWidth(1),
  //         },
  //         children: [
  //           // Header
  //           pw.TableRow(
  //             decoration: const pw.BoxDecoration(color: PdfColors.grey200),
  //             children: [
  //               _buildTableCell('Medicine', isHeader: true),
  //               _buildTableCell('Qty', isHeader: true),
  //               _buildTableCell('Price', isHeader: true),
  //               _buildTableCell('Total', isHeader: true),
  //             ],
  //           ),
  //           // Items
  //           ...items.map((item) {
  //             final medicine = item['medicineId'];
  //             final quantity = _safeParseInt(item['quantity']) ?? 1;
  //             final price = _safeParseInt(medicine?['price']) ?? 0;
  //             final total = quantity * price;
              
  //             return pw.TableRow(
  //               children: [
  //                 _buildTableCell('${medicine?['name']?.toString() ?? 'Unknown'}\n${medicine?['description']?.toString() ?? ''}'),
  //                 _buildTableCell('$quantity'),
  //                 _buildTableCell('₹$price'),
  //                 _buildTableCell('₹$total'),
  //               ],
  //             );
  //           }).toList(),
  //         ],
  //       ),
  //     ],
  //   );
  // }




  pw.Widget _buildOrderItems() {
  final items = _orderDetails?['orderItems'] as List<dynamic>? ?? [];
  
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text('Order Items', 
        style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
      pw.SizedBox(height: 10),
      pw.Table(
        border: pw.TableBorder.all(color: PdfColors.grey300),
        columnWidths: {
          0: const pw.FlexColumnWidth(3),
          1: const pw.FlexColumnWidth(1),
          2: const pw.FlexColumnWidth(2),
        },
        children: [
          // Header
          pw.TableRow(
            decoration: const pw.BoxDecoration(color: PdfColors.grey200),
            children: [
              _buildTableCell('Medicine', isHeader: true),
              _buildTableCell('Qty', isHeader: true),
              _buildTableCell('Pharmacy', isHeader: true),
            ],
          ),
          // Items
          ...items.map((item) {
            return pw.TableRow(
              children: [
                _buildTableCell(item['medicineName']?.toString() ?? 'Unknown'),
                _buildTableCell(item['quantity']?.toString() ?? '1'),
                _buildTableCell(item['pharmacy']?.toString() ?? 'N/A'),
              ],
            );
          }).toList(),
        ],
      ),
    ],
  );
}

  pw.Widget _buildTableCell(String text, {bool isHeader = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: isHeader ? 12 : 10,
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }

  // pw.Widget _buildTotalSummary() {
  //   final subtotal = _getTotalItemsAmount();
  //   final deliveryCharge = _safeParseInt(_orderDetails?['deliveryCharge']) ?? 0;
  //   final platformCharge = _safeParseInt(_orderDetails?['platformCharge']) ?? 0;
  //   final totalAmount = _safeParseInt(_orderDetails?['totalAmount']) ?? 0;

  //   return pw.Container(
  //     width: 200,
  //     child: pw.Column(
  //       crossAxisAlignment: pw.CrossAxisAlignment.end,
  //       children: [
  //         pw.Container(
  //           padding: const pw.EdgeInsets.all(15),
  //           decoration: pw.BoxDecoration(
  //             border: pw.Border.all(color: PdfColors.grey300),
  //             borderRadius: pw.BorderRadius.circular(5),
  //           ),
  //           child: pw.Column(
  //             children: [
  //               _buildSummaryRow('Subtotal:', '₹$subtotal'),
  //               _buildSummaryRow('Delivery Charge:', '₹$deliveryCharge'),
  //               _buildSummaryRow('Platform Charge:', '₹$platformCharge'),
  //               pw.Divider(color: PdfColors.grey400),
  //               pw.Row(
  //                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   pw.Text('Total Amount:', 
  //                     style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
  //                   pw.Text('₹$totalAmount', 
  //                     style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }


  pw.Widget _buildTotalSummary() {
  final deliveryCharge = _safeParseInt(_orderDetails?['deliveryCharge']) ?? 0;
  final totalAmount = _safeParseInt(_orderDetails?['totalAmount']) ?? 0;
  final subtotal = totalAmount - deliveryCharge; // Calculate subtotal

  return pw.Container(
    width: 200,
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.all(15),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey300),
            borderRadius: pw.BorderRadius.circular(5),
          ),
          child: pw.Column(
            children: [
              _buildSummaryRow('Subtotal:', '$subtotal'),
              // _buildSummaryRow('Delivery Charge:', '$deliveryCharge'),
              pw.Divider(color: PdfColors.grey400),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Total Amount:', 
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
                  pw.Text('$totalAmount', 
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


  pw.Widget _buildSummaryRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style:const pw.TextStyle(fontSize: 12)),
          pw.Text(value, style:const pw.TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  pw.Widget _buildFooter() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Divider(color: PdfColors.grey400),
        pw.SizedBox(height: 10),
        pw.Text(
          'Thank you for your order!',
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          'For any queries, please contact our customer support.',
          style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
        ),
        pw.Text(
          'Email: Simcurarx@gmail.com | Phone: +91 8309056333',
          style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
        ),
      ],
    );
  }

  PdfColor _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'accepted':
        return PdfColors.green;
      case 'pending':
        return PdfColors.orange;
      case 'delivered':
        return PdfColors.blue;
      case 'cancelled':
        return PdfColors.red;
      default:
        return PdfColors.grey;
    }
  }

  int _getTotalItemsAmount() {
    final items = _orderDetails?['orderItems'] as List<dynamic>? ?? [];
    int total = 0;
    
    for (var item in items) {
      try {
        final medicine = item['medicineId'];
        final quantity = _safeParseInt(item['quantity']) ?? 1;
        final price = _safeParseInt(medicine?['price']) ?? 0;
        total += quantity * price;
      } catch (e) {
        print('Error calculating item total: $e');
      }
    }
    
    return total;
  }

  // Helper method to safely parse integers
  int? _safeParseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) {
      try {
        return int.parse(value);
      } catch (e) {
        try {
          return double.parse(value).toInt();
        } catch (e) {
          return null;
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26),),
        backgroundColor: Color(0xFF5931DD),
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios_new, size: 18,color: Colors.black,),
            ),
          ),
        ),
        actions:const [
          // if (_orderDetails != null)
          //   IconButton(
          //     icon: const Icon(Icons.download),
          //     onPressed: _downloadPDF,
          //     tooltip: 'Download PDF',
          //   ),
          // if (_orderDetails != null)
          //   IconButton(
          //     icon: const Icon(Icons.share),
          //     onPressed: _sharePDF,
          //     tooltip: 'Share PDF',
          //   ),
        ],
      ),
      
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading invoice data...'),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading invoice',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                _error!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchInvoiceData,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_orderDetails == null) {
      return const Center(
        child: Text('No invoice data available'),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Preview Card
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.receipt_long, color: Colors.blue.shade600),
                      const SizedBox(width: 8),
                      Text(
                        'Invoice Preview',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildPreviewContent(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _previewPDF,
                  icon: const Icon(Icons.visibility),
                  label: const Text('Preview PDF'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _downloadPDF,
                  icon: const Icon(Icons.share),
                  label: const Text('Share'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget _buildPreviewContent() {
  //   final user = _orderDetails?['userId'];
  //   final items = _orderDetails?['orderItems'] as List<dynamic>? ?? [];
    
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         'Order ID: ${_orderDetails?['_id']?.substring(0, 12) ?? 'N/A'}',
  //         style: const TextStyle(fontWeight: FontWeight.bold),
  //       ),
  //       Text('Customer: ${user?['name'] ?? 'N/A'}'),
  //       Text('Total Amount: ₹${_orderDetails?['totalAmount'] ?? 0}'),
  //       Text('Status: ${_orderDetails?['status'] ?? 'Unknown'}'),
  //       const SizedBox(height: 12),
  //       Text(
  //         'Items (${items.length}):',
  //         style: const TextStyle(fontWeight: FontWeight.bold),
  //       ),
  //       ...items.take(3).map((item) {
  //         final medicine = item['medicineId'];
  //         return Padding(
  //           padding: const EdgeInsets.only(left: 16, top: 4),
  //           child: Text('• ${medicine?['name'] ?? 'Unknown'} (${item['quantity']} x ₹${medicine?['price'] ?? 0})'),
  //         );
  //       }).toList(),
  //       if (items.length > 3)
  //         Padding(
  //           padding: const EdgeInsets.only(left: 16, top: 4),
  //           child: Text('... and ${items.length - 3} more items'),
  //         ),
  //     ],
  //   );
  // }



  Widget _buildPreviewContent() {
  final customer = _orderDetails?['customer'];
  final items = _orderDetails?['orderItems'] as List<dynamic>? ?? [];
  
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Order ID: ${_orderDetails?['orderId']?.toString().substring(0, 12) ?? 'N/A'}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Customer: ${customer?['name'] ?? 'N/A'}'),
      Text('Total Amount: ₹${_orderDetails?['totalAmount'] ?? 0}'),
      Text('Payment Status: ${_orderDetails?['paymentStatus'] ?? 'Unknown'}'),
      const SizedBox(height: 12),
      Text(
        'Items (${items.length}):',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      ...items.take(3).map((item) {
        return Padding(
          padding: const EdgeInsets.only(left: 16, top: 4),
          child: Text('• ${item['medicineName'] ?? 'Unknown'} (Qty: ${item['quantity']} - ${item['pharmacy'] ?? 'N/A'})'),
        );
      }).toList(),
      if (items.length > 3)
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 4),
          child: Text('... and ${items.length - 3} more items'),
        ),
    ],
  );
}

  Future<void> _previewPDF() async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      final pdfData = await _generatePDF();
      
      // Hide loading indicator
      Navigator.of(context).pop();
      
      // Try to use Printing.layoutPdf, fallback to share if not supported
      try {
        await Printing.layoutPdf(
          onLayout: (_) => pdfData,
          name: 'Invoice_${_orderDetails?['_id']?.toString().substring(0, 8) ?? 'unknown'}',
        );
      } catch (previewError) {
        print('Preview not supported, falling back to share: $previewError');
        // If preview is not supported, directly share the PDF
        await Printing.sharePdf(
          bytes: pdfData,
          filename: 'invoice_${_orderDetails?['_id']?.toString().substring(0, 8) ?? 'unknown'}.pdf',
        );
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PDF preview not supported on this platform. PDF has been shared instead.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      // Hide loading indicator if still showing
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      
      print('PDF Preview Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error generating PDF: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  Future<void> _downloadPDF() async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      final pdfData = await _generatePDF();
      
      // Hide loading indicator
      Navigator.of(context).pop();
      
      try {
        await Printing.sharePdf(
          bytes: pdfData,
          filename: 'invoice_${_orderDetails?['_id']?.toString().substring(0, 8) ?? 'unknown'}.pdf',
        );
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PDF ready for download/sharing!'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (shareError) {
        print('Share not supported, trying alternative: $shareError');
        // Alternative: Save to app documents or show dialog with options
        _showPDFSaveDialog(pdfData);
      }
    } catch (e) {
      // Hide loading indicator if still showing
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      
      print('PDF Download Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error generating PDF: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  Future<void> _sharePDF() async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      final pdfData = await _generatePDF();
      
      // Hide loading indicator
      Navigator.of(context).pop();
      
      try {
        await Printing.sharePdf(
          bytes: pdfData,
          filename: 'invoice_${_orderDetails?['_id']?.toString().substring(0, 8) ?? 'unknown'}.pdf',
        );
      } catch (shareError) {
        print('Share not supported: $shareError');
        _showPDFSaveDialog(pdfData);
      }
    } catch (e) {
      // Hide loading indicator if still showing
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      
      print('PDF Share Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error generating PDF: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  void _showPDFSaveDialog(Uint8List pdfData) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('PDF Generated'),
        content: const Text(
          'Your PDF has been generated successfully. '
          'The printing/sharing feature is not available on this platform. '
          'You can implement file saving functionality using packages like path_provider and permission_handler.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}