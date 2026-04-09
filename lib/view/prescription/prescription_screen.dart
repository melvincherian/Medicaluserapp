
// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:medical_user_app/providers/prescription_provider.dart';
import 'package:medical_user_app/providers/get_prescription_provider.dart';
import 'package:medical_user_app/services/prescription_service.dart';
import 'package:medical_user_app/models/prescription_model.dart';

class PrescriptionScreen extends StatefulWidget {
  const PrescriptionScreen({super.key});

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // Initialize providers
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PrescriptionProvider>().initialize();
      context.read<GetPrescriptionProvider>().initialize();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(),
      body: Consumer2<PrescriptionProvider, GetPrescriptionProvider>(
        builder: (context, prescriptionProvider, getPrescriptionProvider, child) {
          if (prescriptionProvider.isLoading && getPrescriptionProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildMyPrescriptionsTab(getPrescriptionProvider),
                    _buildPrescriptionTab(prescriptionProvider),
                    // _buildQueryTab(prescriptionProvider),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: const Text(
        'Prescription Services',
        style: TextStyle(
          color: Color(0xFF1E293B),
          fontWeight: FontWeight.w600,
        ),
      ),
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
              child: const Icon(Icons.arrow_back_ios_new, size: 18),
            ),
          ),
        ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        indicatorColor: const Color(0xFF3B82F6),
        indicatorWeight: 3,
        labelColor: const Color(0xFF3B82F6),
        unselectedLabelColor: const Color(0xFF64748B),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        tabs: const [
          Tab(
            icon: Icon(Icons.receipt_long, size: 20),
            text: 'My Prescriptions',
          ),
          Tab(
            icon: Icon(Icons.file_upload, size: 20),
            text: 'Upload',
          ),
          // Tab(
          //   icon: Icon(Icons.help_outline, size: 20),
          //   text: 'Ask Question',
          // ),
        ],
      ),
    );
  }

  Widget _buildMyPrescriptionsTab(GetPrescriptionProvider provider) {
    return RefreshIndicator(
      onRefresh: provider.refreshPrescriptions,
      color: const Color(0xFF3B82F6),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMessageCard(provider),
            const SizedBox(height: 16),
            _buildPrescriptionStats(provider),
            const SizedBox(height: 16),
            _buildPrescriptionsList(provider),
          ],
        ),
      ),
    );
  }

  Widget _buildPrescriptionStats(GetPrescriptionProvider provider) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient:const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF1E40AF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:const Color(0xFF3B82F6).withOpacity(0.3),
            blurRadius: 10,
            offset:const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Prescriptions',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${provider.prescriptionCount}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.receipt_long,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrescriptionsList(GetPrescriptionProvider provider) {
    if (provider.isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (!provider.hasPrescriptions) {
      return _buildEmptyPrescriptions();
    }

    final sortedPrescriptions = provider.getSortedPrescriptions();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Prescriptions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sortedPrescriptions.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return _buildPrescriptionCard(sortedPrescriptions[index]);
          },
        ),
      ],
    );
  }

  Widget _buildPrescriptionCard(UserPrescription prescription) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _showPrescriptionDetails(prescription),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFF10B981).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.receipt,
                      color: Color(0xFF10B981),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Prescription #${prescription.id.substring(0, 8)}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatDate(prescription.createdAt),
                          style: TextStyle(
                            color: Color(0xFF64748B),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFF94A3B8),
                    size: 16,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Divider(color: Color(0xFFE2E8F0)),
              const SizedBox(height: 12),
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(prescription.prescriptionUrl.toString()),
                    backgroundColor: Color(0xFF10B981),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      prescription.pharmacy.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF374151),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  if (prescription.notes.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFFF59E0B).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Notes',
                        style: TextStyle(
                          color: Color(0xFFF59E0B),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
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
  }

  Widget _buildEmptyPrescriptions() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Color(0xFF3B82F6).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.receipt_long,
                size: 48,
                color: Color(0xFF3B82F6),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No Prescriptions Yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Upload your first prescription to get started with our pharmacy services.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _tabController.animateTo(1), // Switch to upload tab
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF5931DD),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon:const Icon(Icons.file_upload, size: 20,color: Colors.white,),
              label:const Text('Upload Prescription',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
   
  Widget _buildPrescriptionTab(PrescriptionProvider provider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPrescriptionMessageCard(provider),
          const SizedBox(height: 16),
          _buildPrescriptionUploadCard(provider),
          const SizedBox(height: 16),
          _buildPharmacySelectionCard(provider),
          const SizedBox(height: 16),
          _buildNotesCard(provider),
          const SizedBox(height: 24),
          _buildSubmitPrescriptionButton(provider),
        ],
      ),
    );
  }

  Widget _buildQueryTab(PrescriptionProvider provider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPrescriptionMessageCard(provider),
          const SizedBox(height: 16),
          // _buildQueryFormCard(provider),
          const SizedBox(height: 24),
          // _buildSubmitQueryButton(provider),
        ],
      ),
    );
  }

  Widget _buildMessageCard(GetPrescriptionProvider provider) {
  if (provider.errorMessage == null && provider.successMessage == null) {
    return const SizedBox.shrink();
  }

  // Start a timer when a message is shown
  Future.delayed(const Duration(seconds: 3), () {
    if (provider.errorMessage != null || provider.successMessage != null) {
      provider.clearMessages();
    }
  });

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: provider.errorMessage != null 
          ? const Color(0xFFFEF2F2) 
          : const Color(0xFFF0FDF4),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: provider.errorMessage != null 
            ? const Color(0xFFFECACA) 
            : const Color(0xFFBBF7D0),
      ),
    ),
    child: Row(
      children: [
        Icon(
          provider.errorMessage != null ? Icons.error : Icons.check_circle,
          color: provider.errorMessage != null 
              ? const Color(0xFFDC2626) 
              : const Color(0xFF16A34A),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            provider.errorMessage ?? provider.successMessage ?? '',
            style: TextStyle(
              color: provider.errorMessage != null 
                  ? const Color(0xFFDC2626) 
                  : const Color(0xFF16A34A),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close, size: 20),
          onPressed: provider.clearMessages,
        ),
      ],
    ),
  );
}
  Widget _buildPrescriptionMessageCard(PrescriptionProvider provider) {
  if (provider.errorMessage == null && provider.successMessage == null) {
    return const SizedBox.shrink();
  }

  // Start a timer when message is shown
  Future.delayed(const Duration(seconds: 3), () {
    if (provider.errorMessage != null || provider.successMessage != null) {
      provider.clearMessages();
    }
  });

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: provider.errorMessage != null 
          ? const Color(0xFFFEF2F2) 
          : const Color(0xFFF0FDF4),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: provider.errorMessage != null 
            ? const Color(0xFFFECACA) 
            : const Color(0xFFBBF7D0),
      ),
    ),
    child: Row(
      children: [
        Icon(
          provider.errorMessage != null ? Icons.error : Icons.check_circle,
          color: provider.errorMessage != null 
              ? const Color(0xFFDC2626) 
              : const Color(0xFF16A34A),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            provider.errorMessage ?? provider.successMessage ?? '',
            style: TextStyle(
              color: provider.errorMessage != null 
                  ? const Color(0xFFDC2626) 
                  : const Color(0xFF16A34A),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close, size: 20),
          onPressed: provider.clearMessages,
        ),
      ],
    ),
  );
}


  void _showPrescriptionDetails(UserPrescription prescription) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFF3B82F6),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.receipt, color: Colors.white),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Prescription Details',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              // Content
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('ID', prescription.id.substring(0, 8)),
                      _buildDetailRow('Date', _formatDate(prescription.createdAt)),
                      _buildDetailRow('Pharmacy', prescription.pharmacy.name),
                      if (prescription.notes.isNotEmpty)
                        _buildDetailRow('Notes', prescription.notes),
                      const SizedBox(height: 20),
                      Text(
                        'Prescription Image',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          prescription.prescriptionUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              height: 200,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200,
                              color: Color(0xFFF1F5F9),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.error, color: Color(0xFF94A3B8)),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Image not available',
                                      style: TextStyle(color: Color(0xFF64748B)),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Color(0xFF1E293B),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  // Keep all existing methods from the original code
  Widget _buildPrescriptionUploadCard(PrescriptionProvider provider) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
         const   Row(
              children: [
                SizedBox(width: 50,),
                Icon(Icons.file_upload, color: Color(0xFF3B82F6)),
                SizedBox(width: 8),
                Text(
                  'Upload Prescription',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            if (provider.prescriptionFile == null)
              _buildFileUploadArea()
            else
              _buildSelectedFileCard(provider),
            
            const SizedBox(height: 16),
            Text(
              'Supported formats: JPG, PNG, PDF (max 10MB)',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileUploadArea() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE2E8F0), width: 2),
        borderRadius: BorderRadius.circular(8),
        color: Color(0xFFF8FAFC),
      ),
      child: InkWell(
        onTap: _showFilePickerOptions,
        borderRadius: BorderRadius.circular(8),
        child:const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_upload,
              size: 45,
              color: Color(0xFF94A3B8),
            ),
            SizedBox(height: 12),
            Text(
              'Tap to upload prescription',
              style: TextStyle(
                color: Color(0xFF475569),
                fontWeight: FontWeight.w500,
                fontSize: 12
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Choose from camera or gallery',
              style: TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedFileCard(PrescriptionProvider provider) {
    final file = provider.prescriptionFile!;
    final fileName = file.path.split('/').last;
    final fileSize = PrescriptionService.getFileSize(file);
    final isImage = fileName.toLowerCase().endsWith('.jpg') ||
                    fileName.toLowerCase().endsWith('.jpeg') ||
                    fileName.toLowerCase().endsWith('.png');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF0F9FF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFF7DD3FC)),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xFF3B82F6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isImage ? Icons.image : Icons.picture_as_pdf,
              color: Colors.white,
              size: 24,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1E293B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  fileSize,
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: Color(0xFF64748B)),
            onPressed: provider.removePrescriptionFile,
          ),
        ],
      ),
    );
  }

  Widget _buildPharmacySelectionCard(PrescriptionProvider provider) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.local_pharmacy, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  'Select Pharmacy',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            if (provider.selectedPharmacy == null)
              _buildPharmacySelector(provider)
            else
              _buildSelectedPharmacyCard(provider),
          ],
        ),
      ),
    );
  }

  Widget _buildPharmacySelector(PrescriptionProvider provider) {
    return InkWell(
      onTap: () => _showPharmacySelectionDialog(provider),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFE2E8F0)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.store, color: Color(0xFF64748B)),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Choose a pharmacy',
                style: TextStyle(color: Color(0xFF64748B)),
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Color(0xFF64748B)),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedPharmacyCard(PrescriptionProvider provider) {
    final pharmacy = provider.selectedPharmacy!;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color.fromARGB(255, 152, 188, 216)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(pharmacy.image),
            backgroundColor: Color(0xFF10B981),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pharmacy.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  provider.getPharmacyDistance(pharmacy),
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => _showPharmacySelectionDialog(provider),
            child: Text('Change'),
          ),
        ],
      ),
    );
  }

 Widget _buildNotesCard(PrescriptionProvider provider) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.note, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  'Additional Notes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: provider.notesController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Add any special instructions or notes for the pharmacy...',
                hintStyle: TextStyle(color: Color(0xFF94A3B8)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xFFE2E8F0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xFF3B82F6)),
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildSubmitPrescriptionButton(PrescriptionProvider provider) {
    final canSubmit = provider.prescriptionFile != null && 
                     provider.selectedPharmacy != null && 
                     !provider.isLoading;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: canSubmit ? () => _submitPrescription(provider) : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF5931DD),
          disabledBackgroundColor: Color(0xFF94A3B8),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: provider.isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                'Submit Prescription',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
                ),
              ),
      ),
    );
  }
  void _showFilePickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Upload Prescription',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFF3B82F6).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.camera_alt, color: Color(0xFF3B82F6)),
                ),
                title: Text('Take Photo'),
                subtitle: Text('Use camera to capture prescription'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromCamera();
                },
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFF10B981).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.photo_library, color: Color(0xFF10B981)),
                ),
                title: Text('Choose from Gallery'),
                subtitle: Text('Select image from photo library'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGallery();
                },
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFF59E0B).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.file_present, color: Color(0xFFF59E0B)),
                ),
                title: Text('Choose File'),
                subtitle: Text('Select PDF or image file'),
                onTap: () {
                  Navigator.pop(context);
                  _pickFile();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPharmacySelectionDialog(PrescriptionProvider provider) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.local_pharmacy, color: Colors.white),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Select Pharmacy',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              // Pharmacy List
              Flexible(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: provider.pharmacies.length,
                  separatorBuilder: (context, index) => Divider(color: Color(0xFFE2E8F0)),
                  itemBuilder: (context, index) {
                    final pharmacy = provider.pharmacies[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(pharmacy.image),
                        backgroundColor: Color(0xFF10B981),
                      ),
                      title: Text(
                        pharmacy.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      subtitle: Text(
                        provider.getPharmacyDistance(pharmacy),
                        style: TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 12,
                        ),
                      ),
                      onTap: () {
                        provider.selectPharmacy(pharmacy);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1080,
      );
      
      if (image != null) {
        final provider = context.read<PrescriptionProvider>();
        provider.setPrescriptionFile(File(image.path));
      }
    } catch (e) {
      _showErrorSnackBar('Failed to capture image: ${e.toString()}');
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1080,
      );
      
      if (image != null) {
        final provider = context.read<PrescriptionProvider>();
        provider.setPrescriptionFile(File(image.path));
      }
    } catch (e) {
      _showErrorSnackBar('Failed to pick image: ${e.toString()}');
    }
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );

      if (result != null) {
        final provider = context.read<PrescriptionProvider>();
        provider.setPrescriptionFile(File(result.files.single.path!));
      }
    } catch (e) {
      _showErrorSnackBar('Failed to pick file: ${e.toString()}');
    }
  }

  Future<void> _submitPrescription(PrescriptionProvider provider) async {
    try {
      await provider.submitPrescription();
      if (provider.successMessage != null) {
        // Refresh the prescriptions list
        context.read<GetPrescriptionProvider>().refreshPrescriptions();
        // Switch to the first tab to show the new prescription
        _tabController.animateTo(0);

        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Prescription uploaded successfully!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
      }
    } catch (e) {
      _showErrorSnackBar('Failed to submit prescription: ${e.toString()}');
    }
  }

  Future<void> _submitQuery(PrescriptionProvider provider) async {
    try {
      await provider.submitQuery();
      if (provider.successMessage != null) {
        // Show success message and clear the query
        _showSuccessSnackBar('Your question has been submitted successfully!');
      }
    } catch (e) {
      _showErrorSnackBar('Failed to submit query: ${e.toString()}');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Color(0xFFDC2626),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Color(0xFF16A34A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}