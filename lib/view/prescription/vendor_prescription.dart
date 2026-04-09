// import 'package:flutter/material.dart';

// class GetVendorPrescription extends StatelessWidget {
//   const GetVendorPrescription({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold();
//   }
// }

















import 'package:flutter/material.dart';

class GetVendorPrescription extends StatefulWidget {
  const GetVendorPrescription({super.key});

  @override
  State<GetVendorPrescription> createState() => _GetVendorPrescriptionState();
}

class _GetVendorPrescriptionState extends State<GetVendorPrescription> {
  bool _isActioned = false;

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontWeight: FontWeight.w500)),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
    setState(() => _isActioned = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title:  Text('Prescription Details',style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0.5,
        centerTitle: true,
        leading:IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildMedicineList(),
            const SizedBox(height: 16),
            _buildSummary(),
            const SizedBox(height: 24),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('PRESCRIPTION', style: TextStyle(fontSize: 11, color: Colors.blueGrey, letterSpacing: 1.2)),
          const SizedBox(height: 4),
          const Text('Rx #2024-00847', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text('Issued: 09 Apr 2026  ·  Valid for 30 days',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  Widget _buildMedicineList() {
    final medicines = [
      {
        'name': 'Dolo 650',
        'generic': 'Paracetamol 650mg · Tablet',
        'dose': '1 tab × 3/day',
        'timing': 'After meals',
        'duration': '5 days',
        'color': Colors.orange,
        'icon': Icons.medication_rounded,
      },
      {
        'name': 'Azithromycin 500',
        'generic': 'Azithromycin 500mg · Tablet',
        'dose': '1 tab × 1/day',
        'timing': 'Before meals',
        'duration': '3 days',
        'color': Colors.blue,
        'icon': Icons.shield_rounded,
      },
      {
        'name': 'Pan-D',
        'generic': 'Pantoprazole + Domperidone · Capsule',
        'dose': '1 cap × 2/day',
        'timing': 'Empty stomach',
        'duration': '7 days',
        'color': Colors.green,
        'icon': Icons.local_pharmacy_rounded,
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Text('PRESCRIBED MEDICINES',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
                    color: Colors.grey.shade500, letterSpacing: 1.1)),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: medicines.length,
            separatorBuilder: (_, __) => Divider(color: Colors.grey.shade100, height: 1),
            itemBuilder: (context, index) {
              final m = medicines[index];
              final color = m['color'] as Color;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(m['icon'] as IconData, color: color, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(m['name'] as String,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 2),
                          Text(m['generic'] as String,
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: [
                              _buildChip(m['dose'] as String, color),
                              _buildChip(m['timing'] as String, Colors.grey),
                              _buildChip(m['duration'] as String, Colors.grey),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyle(fontSize: 11, color: Colors.blue)),
    );
  }

  Widget _buildSummary() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _buildSummaryRow('Total items', '3 medicines'),
          Divider(color: Colors.grey.shade100, height: 1),
          _buildSummaryRow('Estimated amount', '₹480.00'),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
          Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _isActioned
                ? null
                : () => _showSnackBar('Order rejected successfully.', Colors.red.shade600),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Reject', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: _isActioned
                ? null
                : () => _showSnackBar('Your order has been accepted successfully!', Colors.green.shade600),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Accept', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          ),
        ),
      ],
    );
  }
}