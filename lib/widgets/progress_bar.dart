// import 'package:flutter/material.dart';

// class CustomProgressBar extends StatelessWidget {
//   final int currentStep;
//   final int totalSteps;

//   const CustomProgressBar({
//     Key? key,
//     required this.currentStep,
//     required this.totalSteps,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Calculate progress percentage based on current step
//     double progressPercentage = currentStep / totalSteps;

//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           // Background track
//           Container(
//             height: 4,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.blue.shade100,
//               borderRadius: BorderRadius.circular(2),
//             ),
//           ),

//           // Progress line - NOW DYNAMIC!
//           Positioned(
//             left: 0,
//             child: Container(
//               height: 10,
//               width: (MediaQuery.of(context).size.width - 32) * progressPercentage, // Dynamic width based on current step
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Colors.blue.shade400, Colors.indigo.shade500],
//                   begin: Alignment.centerLeft,
//                   end: Alignment.centerRight,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           ),

//           // Step indicators
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: List.generate(totalSteps, (index) {
//               bool isCompleted = index < currentStep;
//               bool isCurrent = index == currentStep - 1;

//               return Container(
//                 width: 24,
//                 height: 24,
//                 decoration: BoxDecoration(
//                   color: isCompleted ?
//                     (isCurrent ? Colors.indigo.shade500 : Colors.blue.shade400) :
//                     Colors.white,
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: isCompleted ? Colors.transparent : Colors.grey.shade300,
//                     width: 1,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.05),
//                       blurRadius: 2,
//                       spreadRadius: 1,
//                     ),
//                   ],
//                 ),
//                 child: Center(
//                   child: Icon(
//                     Icons.check,
//                     size: 16,
//                     color: isCompleted ? Colors.white : Colors.grey.shade400,
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ---------------- Progress Bar Widget ----------------
class CustomProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const CustomProgressBar({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progressPercentage = currentStep / totalSteps;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background track
          Container(
            height: 4,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Progress line - Dynamic width
          Positioned(
            left: 0,
            child: Container(
              height: 10,
              width:
                  (MediaQuery.of(context).size.width - 32) * progressPercentage,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.indigo.shade500],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          // Step indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(totalSteps, (index) {
              bool isCompleted = index < currentStep;
              bool isCurrent = index == currentStep - 1;

              return Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? (isCurrent
                          ? Colors.indigo.shade500
                          : Colors.blue.shade400)
                      : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        isCompleted ? Colors.transparent : Colors.grey.shade300,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 2,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.check,
                    size: 16,
                    color: isCompleted ? Colors.white : Colors.grey.shade400,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ---------------- Models ----------------
class OrderStatus {
  final String status;
  final String message;
  final DateTime timestamp;
  final String id;

  OrderStatus({
    required this.status,
    required this.message,
    required this.timestamp,
    required this.id,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) {
    return OrderStatus(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      timestamp: DateTime.parse(json['timestamp']),
      id: json['_id'] ?? '',
    );
  }
}

class Medicine {
  final String name;
  final double mrp;
  final String description;
  final List<String> images;
  final int quantity;

  Medicine({
    required this.name,
    required this.mrp,
    required this.description,
    required this.images,
    required this.quantity,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      name: json['name'] ?? '',
      mrp: (json['mrp'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      quantity: json['quantity'] ?? 0,
    );
  }
}

class OrderStatusResponse {
  final String message;
  final List<OrderStatus> statusTimeline;
  final String? deliveryNote;
  final List<Medicine> medicines;

  OrderStatusResponse({
    required this.message,
    required this.statusTimeline,
    this.deliveryNote,
    required this.medicines,
  });

  factory OrderStatusResponse.fromJson(Map<String, dynamic> json) {
    return OrderStatusResponse(
      message: json['message'] ?? '',
      statusTimeline: (json['statusTimeline'] as List<dynamic>?)
              ?.map((item) => OrderStatus.fromJson(item))
              .toList() ??
          [],
      deliveryNote: json['deliveryNote'],
      medicines: (json['medicines'] as List<dynamic>?)
              ?.map((item) => Medicine.fromJson(item))
              .toList() ??
          [],
    );
  }
}

// ---------------- API Service ----------------
class OrderStatusService {
  static const String baseUrl = 'https://api.simcurarx.com/api/users';

  static Future<OrderStatusResponse?> getOrderStatus(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/order-status/$userId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return OrderStatusResponse.fromJson(jsonData);
      } else {
        print('Failed to load order status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching order status: $e');
      return null;
    }
  }
}
