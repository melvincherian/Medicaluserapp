import 'package:flutter/material.dart';
import 'package:medical_user_app/providers/vendor_prescription_provider.dart';
import 'package:medical_user_app/services/vendor_prescription_service.dart';
import 'package:provider/provider.dart';

// ─── Call this after initState data loads ─────────────────────────────────────
void checkAndShowPrescriptionPopup(BuildContext context) {
  final provider = Provider.of<PrescriptionPreviewProvider>(context, listen: false);
  if (provider.hasPreviews) {
    Future.delayed(const Duration(milliseconds: 600), () {
      if (context.mounted) {
        showPrescriptionOrderPopup(context, provider.previews.first);
      }
    });
  }
}

// ─── Main popup trigger ───────────────────────────────────────────────────────
void showPrescriptionOrderPopup(BuildContext context, PrescriptionPreview preview) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (_) => PrescriptionOrderPopup(preview: preview),
  );
}

// ─── Popup Widget ─────────────────────────────────────────────────────────────
class PrescriptionOrderPopup extends StatefulWidget {
  final PrescriptionPreview preview;
  const PrescriptionOrderPopup({super.key, required this.preview});

  @override
  State<PrescriptionOrderPopup> createState() => _PrescriptionOrderPopupState();
}

class _PrescriptionOrderPopupState extends State<PrescriptionOrderPopup>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _itemsController;
  late AnimationController _badgeController;
  late AnimationController _timerPulseController;

  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _badgeScaleAnimation;
  late Animation<double> _timerPulseAnimation;

  late List<Animation<double>> _itemFadeAnimations;

  int _remainingSeconds = 600; // 10 min countdown
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();

    // Slide-up sheet
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    _fadeAnimation = CurvedAnimation(parent: _slideController, curve: Curves.easeOut);

    // "NEW" badge pop
    _badgeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _badgeScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _badgeController, curve: Curves.elasticOut),
    );

    // Timer pulse when < 60s
    _timerPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
    _timerPulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _timerPulseController, curve: Curves.easeInOut),
    );

    // Staggered item fade-ins
    _itemsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    final items = widget.preview.orderPreview.orderItems;
    _itemFadeAnimations = List.generate(items.length, (i) {
      final start = 0.3 + (i * 0.15);
      final end = (start + 0.25).clamp(0.0, 1.0);
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _itemsController,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
      );
    });

    // Kick off animations
    _slideController.forward();
    Future.delayed(const Duration(milliseconds: 200), () => _badgeController.forward());
    Future.delayed(const Duration(milliseconds: 300), () => _itemsController.forward());

    // Countdown timer
    _startCountdown();
  }

  void _startCountdown() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;
      setState(() => _remainingSeconds--);
      return _remainingSeconds > 0 && mounted;
    });
  }

  String get _timerText {
    final m = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final s = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  void dispose() {
    _slideController.dispose();
    _itemsController.dispose();
    _badgeController.dispose();
    _timerPulseController.dispose();
    super.dispose();
  }

  // Future<void> _handleAction(bool accept) async {
  //   setState(() => _isProcessing = true);

  //   // Haptic-like feedback via quick scale
  //   final provider = Provider.of<PrescriptionPreviewProvider>(context, listen: false);

  //   final success = await provider.confirmOrder(
  //     prescriptionId: widget.preview.prescriptionId,
  //     accept: accept,
  //     onSuccess: () {
  //       if (mounted) Navigator.pop(context);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(accept ? 'Order accepted! 🎉' : 'Order rejected'),
  //           backgroundColor: accept ? Colors.green : Colors.red,
  //           behavior: SnackBarBehavior.floating,
  //           margin: const EdgeInsets.only(bottom: 80, left: 16, right: 16),
  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //         ),
  //       );
  //     },
  //     onError: (err) {
  //       if (mounted) {
  //         setState(() => _isProcessing = false);
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text(err), backgroundColor: Colors.red),
  //         );
  //       }
  //     },
  //   );
  // }




  Future<void> _handleAction(bool accept) async {
  if (_isProcessing) return;
  setState(() => _isProcessing = true);

  final provider = Provider.of<PrescriptionPreviewProvider>(context, listen: false);

  await provider.confirmOrder(
    prescriptionId: widget.preview.prescriptionId,
    accept: accept,
    onSuccess: () {
      // Close modal first
      Navigator.pop(context);
      // Then show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(accept ? '🎉 Order confirmed! Rider assigned.' : 'Order rejected.'),
          backgroundColor: accept ? const Color(0xFF5931DD) : Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(bottom: 80, left: 16, right: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: const Duration(seconds: 3),
        ),
      );
    },
    onError: (err) {
      if (mounted) {
        setState(() => _isProcessing = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(err),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.only(bottom: 80, left: 16, right: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    },
  );
}

  @override
  Widget build(BuildContext context) {
    final order = widget.preview.orderPreview;

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Drag handle ──
              Container(
                width: 40, height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(99),
                ),
              ),

              // ── Header ──
              _buildHeader(order),
              const SizedBox(height: 16),

              // ── Pharmacy card + items ──
              _buildPharmacyCard(order),
              const SizedBox(height: 16),

              // ── Timer ──
              // _buildTimer(),
              const SizedBox(height: 16),

              // ── Action buttons ──
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(OrderPreview order) {
    return Row(
      children: [
        const Text('🔔', style: TextStyle(fontSize: 22)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'New prescription order',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 8),
                  ScaleTransition(
                    scale: _badgeScaleAnimation,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: const Text(
                        'NEW',
                        style: TextStyle(
                          color: Color(0xFFE65100),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                '${order.pharmacyName} sent you a quote',
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.close, color: Colors.grey[500], size: 20),
        ),
      ],
    );
  }

  Widget _buildPharmacyCard(OrderPreview order) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Pharmacy header
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFFF3F0FF),
              borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xFF5931DD),
                  child: order.pharmacyImage.isNotEmpty
                      ? ClipOval(child: Image.network(order.pharmacyImage, fit: BoxFit.cover))
                      : const Icon(Icons.local_pharmacy, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.pharmacyName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3C2B8C),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 12, color: Color(0xFF5931DD)),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              order.pharmacyAddress,
                              style: const TextStyle(fontSize: 12, color: Color(0xFF5931DD)),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Delivery in', style: TextStyle(fontSize: 11, color: Colors.grey)),
                    Text('~25 min', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF5931DD))),
                  ],
                ),
              ],
            ),
          ),

          // Items list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ITEMS QUOTED',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.grey[500], letterSpacing: 0.5),
                ),
                const SizedBox(height: 8),
                ...order.orderItems.asMap().entries.map((entry) {
                  final i = entry.key;
                  final item = entry.value;
                  final anim = i < _itemFadeAnimations.length
                      ? _itemFadeAnimations[i]
                      : const AlwaysStoppedAnimation(1.0);
                  return FadeTransition(
                    opacity: anim,
                    child: SlideTransition(
                      position: Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
                          .animate(anim as Animation<double>),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            const Text('💊', style: TextStyle(fontSize: 16)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                                  Text('Qty: ${item.quantity}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                                ],
                              ),
                            ),
                            Text(
                              '₹${item.price.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),

          // Price summary
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(14)),
            ),
            child: Row(
              children: [
                _priceCol('Subtotal', '₹${order.subTotal.toStringAsFixed(2)}'),
                const SizedBox(width: 20),
                _priceCol('Delivery', '₹${order.deliveryCharge.toStringAsFixed(2)}'),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Total', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                    Text(
                      '₹${order.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF5931DD)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceCol(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildTimer() {
    final isUrgent = _remainingSeconds < 60;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.access_time_rounded, size: 14, color: isUrgent ? Colors.red : Colors.orange[700]),
        const SizedBox(width: 4),
        Text('Quote valid for ', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ScaleTransition(
          scale: isUrgent ? _timerPulseAnimation : const AlwaysStoppedAnimation(1.0),
          child: Text(
            _timerText,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isUrgent ? Colors.red : Colors.orange[700],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        // Reject
        Expanded(
          child: _AnimatedButton(
            onTap: _isProcessing ? null : () => _handleAction(false),
            backgroundColor: const Color(0xFFFFF0F0),
            foregroundColor: const Color(0xFFC0392B),
            child: _isProcessing
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFFC0392B)))
                : const Text('Reject', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          ),
        ),
        const SizedBox(width: 12),
        // Accept
        Expanded(
          flex: 2,
          child: _AnimatedButton(
            onTap: _isProcessing ? null : () => _handleAction(true),
            backgroundColor: const Color(0xFF5931DD),
            foregroundColor: Colors.white,
            elevation: true,
            child: _isProcessing
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Text('Accept Order', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          ),
        ),
      ],
    );
  }
}

// ─── Animated tap button ──────────────────────────────────────────────────────
class _AnimatedButton extends StatefulWidget {
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color foregroundColor;
  final Widget child;
  final bool elevation;

  const _AnimatedButton({
    required this.onTap,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.child,
    this.elevation = false,
  });

  @override
  State<_AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    _scale = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) { _controller.reverse(); widget.onTap?.call(); },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(14),
            boxShadow: widget.elevation
                ? [BoxShadow(color: const Color(0xFF5931DD).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))]
                : null,
          ),
          child: Center(
            child: DefaultTextStyle(
              style: TextStyle(color: widget.foregroundColor, fontFamily: 'sans-serif'),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}