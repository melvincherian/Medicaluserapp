import 'package:flutter/material.dart';
import 'package:medical_user_app/providers/order_provider.dart';
import 'package:medical_user_app/view/radar_animation_screen.dart';
import 'package:provider/provider.dart';

class GlobalOrderBox extends StatefulWidget {
  const GlobalOrderBox({super.key});

  @override
  State<GlobalOrderBox> createState() => _GlobalOrderBoxState();
}

class _GlobalOrderBoxState extends State<GlobalOrderBox> {
  bool isClosed = false; // hides until app restart

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        if (isClosed) return const SizedBox();

        // ✅ Use your existing flow
        if (!orderProvider.hasCurrentOrders) {
          return const SizedBox();
        }

        final order = orderProvider.currentOrders.first;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0XFF5931DD),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 8,
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.local_shipping, color: Colors.white),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order ${order.status}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Order ID: ${order.id}",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // ✅ View button
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RadarAnimationScreen(),
                    ),
                  );
                },
                child: const Text(
                  "View",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              // ✅ Close button
              GestureDetector(
                onTap: () {
                  setState(() {
                    isClosed = true;
                  });
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
