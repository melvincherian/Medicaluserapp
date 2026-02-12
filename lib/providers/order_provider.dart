// // order_provider.dart
// import 'package:flutter/material.dart';
// import 'package:medical_user_app/models/order_model.dart';
// import 'package:medical_user_app/models/user_model.dart';
// import 'package:medical_user_app/services/order_service.dart';

// import 'package:medical_user_app/utils/shared_preferences_helper.dart';

// class OrderProvider extends ChangeNotifier {
//   static const String _logTag = 'OrderProvider';

//   // State variables
//   bool _isLoading = false;
//   bool _isCreatingOrder = false;
//   bool _isDeletingOrder = false;
//   bool _isCancellingOrder = false;
//   String? _errorMessage;

//   // Orders data
//   List<OrderModel> _currentOrders = [];
//   List<OrderModel> _previousOrders = [];
//   List<OrderModel> _allOrders = [];

//   // Current user
//   User? _currentUser;

//   // Getters
//   bool get isLoading => _isLoading;
//   bool get isCreatingOrder => _isCreatingOrder;
//   bool get isDeletingOrder => _isDeletingOrder;
//   bool get isCancellingOrder => _isCancellingOrder;
//   String? get errorMessage => _errorMessage;

//   List<OrderModel> get currentOrders => _currentOrders;
//   List<OrderModel> get previousOrders => _previousOrders;
//   List<OrderModel> get allOrders => _allOrders;

//   User? get currentUser => _currentUser;

//   // Helper getters
//   int get currentOrdersCount => _currentOrders.length;
//   int get previousOrdersCount => _previousOrders.length;
//   int get totalOrdersCount => _allOrders.length;

//   bool get hasCurrentOrders => _currentOrders.isNotEmpty;
//   bool get hasPreviousOrders => _previousOrders.isNotEmpty;
//   bool get hasOrders => _allOrders.isNotEmpty;

//   // Constructor
//   OrderProvider() {
//     _initializeProvider();
//   }

//   // Initialize provider
//   Future<void> _initializeProvider() async {
//     try {
//       print('$_logTag: Initializing provider...');
//       await _loadCurrentUser();
//       if (_currentUser != null) {
//         await refreshOrders();
//       }
//     } catch (e) {
//       print('$_logTag: Error initializing provider: $e');
//       _setError('Failed to initialize order provider');
//     }
//   }

//   // Load current user from SharedPreferences
//   Future<void> _loadCurrentUser() async {
//     try {
//       final user = await SharedPreferencesHelper.getUser();
//       _currentUser = user;
//       print('$_logTag: Current user loaded: ${user?.name ?? 'No user'}');
//       notifyListeners();
//     } catch (e) {
//       print('$_logTag: Error loading current user: $e');
//     }
//   }

//   // Set loading state
//   void _setLoading(bool loading) {
//     _isLoading = loading;
//     notifyListeners();
//   }

//   // Set error message
//   void _setError(String? error) {
//     _errorMessage = error;
//     notifyListeners();
//   }

//   // Clear error message
//   void clearError() {
//     _errorMessage = null;
//     notifyListeners();
//   }

//   // Create a new order
//   Future<OrderModel?> createOrder({
//     required String addressId,
//     String notes = '',
//     String voiceNoteUrl = '',
//     String paymentMethod = 'Cash on Delivery',
//   }) async {
//     if (_currentUser == null) {
//       _setError('User not logged in');
//       return null;
//     }

//     _isCreatingOrder = true;
//     _setError(null);
//     notifyListeners();

//     try {
//       print('$_logTag: Creating order...');

//       final orderRequest = CreateOrderRequest(
//         addressId: addressId,
//         notes: notes,
//         voiceNoteUrl: voiceNoteUrl,
//         paymentMethod: paymentMethod,
//       );

//       // Validate request
//       if (!OrderService.validateOrderRequest(orderRequest)) {
//         _setError('Invalid order data');
//         return null;
//       }

//       final orderResponse = await OrderService.createOrder(
//         userId: _currentUser!.id,
//         orderRequest: orderRequest,
//       );

//       if (orderResponse != null) {
//         print('$_logTag: Order created successfully: ${orderResponse.order.id}');

//         // Add to current orders
//         _currentOrders.insert(0, orderResponse.order);
//         _allOrders.insert(0, orderResponse.order);

//         notifyListeners();
//         return orderResponse.order;
//       } else {
//         _setError('Failed to create order');
//         return null;
//       }
//     } catch (e) {
//       print('$_logTag: Error creating order: $e');
//       _setError('Error creating order: ${e.toString()}');
//       return null;
//     } finally {
//       _isCreatingOrder = false;
//       notifyListeners();
//     }
//   }

//   // Refresh all orders
//   Future<void> refreshOrders() async {
//     if (_currentUser == null) {
//       print('$_logTag: Cannot refresh orders - no current user');
//       return;
//     }

//     _setLoading(true);
//     _setError(null);

//     try {
//       print('$_logTag: Refreshing orders for user: ${_currentUser!.id}');

//       // Fetch current and previous orders concurrently
//       final results = await Future.wait([
//         OrderService.getCurrentOrders(_currentUser!.id),
//         OrderService.getPreviousOrders(_currentUser!.id),
//       ]);

//       _currentOrders = results[0];
//       _previousOrders = results[1];

//       // Combine and sort all orders
//       _allOrders = [..._currentOrders, ..._previousOrders];
//       _allOrders.sort((a, b) => b.createdAt.compareTo(a.createdAt));

//       print('$_logTag: Orders refreshed - Current: ${_currentOrders.length}, Previous: ${_previousOrders.length}');
//     } catch (e) {
//       print('$_logTag: Error refreshing orders: $e');
//       _setError('Failed to refresh orders');
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Delete a previous order
//   Future<bool> deletePreviousOrder(String orderId) async {
//     if (_currentUser == null) {
//       _setError('User not logged in');
//       return false;
//     }

//     _isDeletingOrder = true;
//     _setError(null);
//     notifyListeners();

//     try {
//       print('$_logTag: Deleting order: $orderId');

//       final success = await OrderService.deletePreviousOrder(
//         userId: _currentUser!.id,
//         orderId: orderId,
//       );

//       if (success) {
//         // Remove from local lists
//         _previousOrders.removeWhere((order) => order.id == orderId);
//         _allOrders.removeWhere((order) => order.id == orderId);

//         print('$_logTag: Order deleted successfully');
//         notifyListeners();
//         return true;
//       } else {
//         _setError('Failed to delete order');
//         return false;
//       }
//     } catch (e) {
//       print('$_logTag: Error deleting order: $e');
//       _setError('Error deleting order: ${e.toString()}');
//       return false;
//     } finally {
//       _isDeletingOrder = false;
//       notifyListeners();
//     }
//   }

//   // Cancel an ongoing order
//   Future<bool> cancelOrder(String orderId) async {
//     if (_currentUser == null) {
//       _setError('User not logged in');
//       return false;
//     }

//     _isCancellingOrder = true;
//     _setError(null);
//     notifyListeners();

//     try {
//       print('$_logTag: Cancelling order: $orderId');

//       final success = await OrderService.cancelOrder(
//         userId: _currentUser!.id,
//         orderId: orderId,
//       );

//       if (success) {
//         // Move from current to previous orders or update status
//         final orderIndex = _currentOrders.indexWhere((order) => order.id == orderId);
//         if (orderIndex != -1) {
//           final order = _currentOrders[orderIndex];
//           // Create updated order with cancelled status (simplified)
//           final updatedOrder = OrderModel(
//             id: order.id,
//             userId: order.userId,
//             deliveryAddress: order.deliveryAddress,
//             orderItems: order.orderItems,
//             statusTimeline: [
//               ...order.statusTimeline,
//               StatusTimeline(
//                 id: DateTime.now().millisecondsSinceEpoch.toString(),
//                 status: 'Cancelled',
//                 message: 'Order cancelled by user',
//                 timestamp: DateTime.now(),
//               ),
//             ],
//             totalAmount: order.totalAmount,
//             notes: order.notes,
//             voiceNoteUrl: order.voiceNoteUrl,
//             paymentMethod: order.paymentMethod,
//             status: 'Cancelled',
//             createdAt: order.createdAt,
//             updatedAt: DateTime.now(),
//           );

//           _currentOrders.removeAt(orderIndex);
//           _previousOrders.insert(0, updatedOrder);

//           // Update in all orders list
//           final allOrderIndex = _allOrders.indexWhere((o) => o.id == orderId);
//           if (allOrderIndex != -1) {
//             _allOrders[allOrderIndex] = updatedOrder;
//           }
//         }

//         print('$_logTag: Order cancelled successfully');
//         notifyListeners();
//         return true;
//       } else {
//         _setError('Failed to cancel order');
//         return false;
//       }
//     } catch (e) {
//       print('$_logTag: Error cancelling order: $e');
//       _setError('Error cancelling order: ${e.toString()}');
//       return false;
//     } finally {
//       _isCancellingOrder = false;
//       notifyListeners();
//     }
//   }

//   // Re-order based on previous order
//   Future<OrderModel?> reorder({
//     required OrderModel previousOrder,
//     required String addressId,
//     String? notes,
//     String paymentMethod = 'Cash on Delivery',
//   }) async {
//     if (_currentUser == null) {
//       _setError('User not logged in');
//       return null;
//     }

//     _isCreatingOrder = true;
//     _setError(null);
//     notifyListeners();

//     try {
//       print('$_logTag: Re-ordering previous order: ${previousOrder.id}');

//       final orderResponse = await OrderService.reorder(
//         userId: _currentUser!.id,
//         previousOrder: previousOrder,
//         addressId: addressId,
//         notes: notes,
//         paymentMethod: paymentMethod,
//       );

//       if (orderResponse != null) {
//         print('$_logTag: Re-order created successfully: ${orderResponse.order.id}');

//         // Add to current orders
//         _currentOrders.insert(0, orderResponse.order);
//         _allOrders.insert(0, orderResponse.order);

//         notifyListeners();
//         return orderResponse.order;
//       } else {
//         _setError('Failed to re-order');
//         return null;
//       }
//     } catch (e) {
//       print('$_logTag: Error re-ordering: $e');
//       _setError('Error re-ordering: ${e.toString()}');
//       return null;
//     } finally {
//       _isCreatingOrder = false;
//       notifyListeners();
//     }
//   }

//   // Get order by ID
//   OrderModel? getOrderById(String orderId) {
//     try {
//       return _allOrders.firstWhere((order) => order.id == orderId);
//     } catch (e) {
//       print('$_logTag: Order not found: $orderId');
//       return null;
//     }
//   }

//   // Check if an order exists in current orders
//   bool isCurrentOrder(String orderId) {
//     return _currentOrders.any((order) => order.id == orderId);
//   }

//   // Check if an order exists in previous orders
//   bool isPreviousOrder(String orderId) {
//     return _previousOrders.any((order) => order.id == orderId);
//   }

//   // Get orders by status
//   List<OrderModel> getOrdersByStatus(String status) {
//     return _allOrders.where((order) => order.status == status).toList();
//   }

//   // Get orders by date range
//   List<OrderModel> getOrdersByDateRange(DateTime startDate, DateTime endDate) {
//     return _allOrders.where((order) {
//       return order.createdAt.isAfter(startDate.subtract(const Duration(days: 1))) &&
//              order.createdAt.isBefore(endDate.add(const Duration(days: 1)));
//     }).toList();
//   }

//   // Get total amount spent
//   double getTotalAmountSpent() {
//     return _allOrders.fold(0.0, (sum, order) => sum + order.totalAmount);
//   }

//   // Get average order value
//   double getAverageOrderValue() {
//     if (_allOrders.isEmpty) return 0.0;
//     return getTotalAmountSpent() / _allOrders.length;
//   }

//   // Get orders count by status
//   Map<String, int> getOrdersCountByStatus() {
//     final Map<String, int> statusCount = {};
//     for (final order in _allOrders) {
//       statusCount[order.status] = (statusCount[order.status] ?? 0) + 1;
//     }
//     return statusCount;
//   }

//   // Clear all orders (useful for logout)
//   void clearOrders() {
//     _currentOrders.clear();
//     _previousOrders.clear();
//     _allOrders.clear();
//     _currentUser = null;
//     _setError(null);
//     notifyListeners();
//     print('$_logTag: Orders cleared');
//   }

//   // Force refresh from API
//   Future<void> forceRefresh() async {
//     print('$_logTag: Force refreshing orders...');
//     await refreshOrders();
//   }

//   // Update current user (call this when user logs in/out)
//   Future<void> updateCurrentUser(User? user) async {
//     _currentUser = user;
//     if (user != null) {
//       print('$_logTag: User updated: ${user.name}');
//       await refreshOrders();
//     } else {
//       print('$_logTag: User cleared');
//       clearOrders();
//     }
//   }

//   // Check if provider has data
//   bool get hasData => _allOrders.isNotEmpty;

//   // Check if provider needs refresh
//   bool get needsRefresh {
//     // Consider data stale after 5 minutes
//     final lastUpdate = DateTime.now().subtract(const Duration(minutes: 5));
//     return _allOrders.isEmpty ||
//            _allOrders.any((order) => order.updatedAt.isBefore(lastUpdate));
//   }

//   // Debug method to print current state
//   void debugState() {
//     print('$_logTag: === DEBUG STATE ===');
//     print('$_logTag: Current User: ${_currentUser?.name ?? 'None'}');
//     print('$_logTag: Is Loading: $_isLoading');
//     print('$_logTag: Is Creating Order: $_isCreatingOrder');
//     print('$_logTag: Is Deleting Order: $_isDeletingOrder');
//     print('$_logTag: Is Cancelling Order: $_isCancellingOrder');
//     print('$_logTag: Error Message: $_errorMessage');
//     print('$_logTag: Current Orders: ${_currentOrders.length}');
//     print('$_logTag: Previous Orders: ${_previousOrders.length}');
//     print('$_logTag: Total Orders: ${_allOrders.length}');
//     print('$_logTag: === END DEBUG STATE ===');
//   }

//   @override
//   void dispose() {
//     print('$_logTag: Provider disposed');
//     super.dispose();
//   }
// }

// order_provider.dart
import 'package:flutter/material.dart';
import 'package:medical_user_app/models/order_model.dart';
import 'package:medical_user_app/models/user_model.dart';
import 'package:medical_user_app/services/order_service.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';

class OrderProvider extends ChangeNotifier {
  static const String _logTag = 'OrderProvider';

  // State variables
  bool _isLoading = false;
  bool _isCreatingOrder = false;
  bool _isDeletingOrder = false;
  bool _isCancellingOrder = false;
  String? _errorMessage;

  // Orders data
  List<OrderModel> _currentOrders = [];
  List<OrderModel> _previousOrders = [];
  List<OrderModel> _allOrders = [];

  // Current user
  User? _currentUser;

  // Cancel order response
  Map<String, dynamic>? _lastCancelResponse;

  // Getters
  bool get isLoading => _isLoading;
  bool get isCreatingOrder => _isCreatingOrder;
  bool get isDeletingOrder => _isDeletingOrder;
  bool get isCancellingOrder => _isCancellingOrder;
  String? get errorMessage => _errorMessage;

  List<OrderModel> get currentOrders => _currentOrders;
  List<OrderModel> get previousOrders => _previousOrders;
  List<OrderModel> get allOrders => _allOrders;

  User? get currentUser => _currentUser;
  Map<String, dynamic>? get lastCancelResponse => _lastCancelResponse;

  // Helper getters
  int get currentOrdersCount => _currentOrders.length;
  int get previousOrdersCount => _previousOrders.length;
  int get totalOrdersCount => _allOrders.length;

  bool get hasCurrentOrders => _currentOrders.isNotEmpty;
  bool get hasPreviousOrders => _previousOrders.isNotEmpty;
  bool get hasOrders => _allOrders.isNotEmpty;

  // Constructor
  OrderProvider() {
    _initializeProvider();
  }

  // Initialize provider
  Future<void> _initializeProvider() async {
    try {
      print('$_logTag: Initializing provider...');
      await _loadCurrentUser();
      if (_currentUser != null) {
        print('ttttttttttttttttttttttttttttttttttttt$_currentUser');
        await refreshOrders();
      }
    } catch (e) {
      print('$_logTag: Error initializing provider: $e');
      _setError('Failed to initialize order provider');
    }
  }

  // Load current user from SharedPreferences
  Future<void> _loadCurrentUser() async {
    try {
      final user = await SharedPreferencesHelper.getUser();
      _currentUser = user;
      print('$_logTag: Current user loaded: ${user?.name ?? 'No user'}');
      notifyListeners();
    } catch (e) {
      print('$_logTag: Error loading current user: $e');
    }
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Set error message
  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Clear last cancel response
  void clearLastCancelResponse() {
    _lastCancelResponse = null;
    notifyListeners();
  }

  // Create a new order
  Future<OrderModel?> createOrder({
    required String addressId,
    String? paymentId,
    String? coupon,
    String? notes,
    String? voiceNoteUrl,
    required String paymentMethod,
  }) async {
    if (_currentUser == null) {
      _setError('User not logged in');
      return null;
    }

    _isCreatingOrder = true;
    _setError(null);
    notifyListeners();

    try {
      print('$_logTag: Creating order...');

      final orderRequest = CreateOrderRequest(
        addressId: addressId,
        transactionId: paymentId,
        coupouncode: coupon,
        notes: notes.toString(),
        voiceNoteUrl: voiceNoteUrl.toString(),
        paymentMethod: paymentMethod,
      );

      print('addddddddddddddddddddddddddd $addressId');
      print('trasactioniddddddddddddddddd $paymentId');
      print('couponnnnnnnnnnnnnnnnnnnnnn $coupon');
      print('noteeeeeeeeeeeeeeeeeeeeeeee $notes');
      print('voiceeeeeeeeeeeeeeeeeeeeeee $voiceNoteUrl');
      print('paymentMethoddddddddddddddd $paymentMethod');




      // Validate request
      if (!OrderService.validateOrderRequest(orderRequest)) {
        _setError('Invalid order data');
        return null;
      }

      final orderResponse = await OrderService.createOrder(
        userId: _currentUser!.id,
        orderRequest: orderRequest,
      );

      if (orderResponse != null) {
        print(
            '$_logTag: Order created successfully: ${orderResponse.order.id}');

        // Add to current orders
        _currentOrders.insert(0, orderResponse.order);
        _allOrders.insert(0, orderResponse.order);

        notifyListeners();
        return orderResponse.order;
      } else {
        _setError('Payment processing failed. Please try again or use a different payment method');
        return null;
      }
    } catch (e) {
      print('$_logTag: Error creating order: $e');
      _setError('Error creating order: ${e.toString()}');
      return null;
    } finally {
      _isCreatingOrder = false;
      notifyListeners();
    }
  }

  // Refresh all orders
  Future<void> refreshOrders() async {
    if (_currentUser == null) {
      print('$_logTag: Cannot refresh orders - no current user');
      return;
    }

    _setLoading(true);
    _setError(null);

    try {
      print('$_logTag: Refreshing orders for user: ${_currentUser!.id}');

      // Fetch current and previous orders concurrently
      final results = await Future.wait([
        OrderService.getCurrentOrders(_currentUser!.id),
        OrderService.getPreviousOrders(_currentUser!.id),
      ]);

      _currentOrders = results[0];
      _previousOrders = results[1];

      // Combine and sort all orders
      _allOrders = [..._currentOrders, ..._previousOrders];
      _allOrders.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      print(
          '$_logTag: Orders refreshed - Current: ${_currentOrders.length}, Previous: ${_previousOrders.length}');
    } catch (e) {
      print('$_logTag: Error refreshing orders: $e');
      _setError('Failed to refresh orders');
    } finally {
      _setLoading(false);
    }
  }

  // Delete a previous order
  Future<bool> deletePreviousOrder(String orderId) async {
    if (_currentUser == null) {
      _setError('User not logged in');
      return false;
    }

    _isDeletingOrder = true;
    _setError(null);
    notifyListeners();

    try {
      print('$_logTag: Deleting order: $orderId');

      final success = await OrderService.deletePreviousOrder(
        userId: _currentUser!.id,
        orderId: orderId,
      );

      if (success) {
        // Remove from local lists
        _previousOrders.removeWhere((order) => order.id == orderId);
        _allOrders.removeWhere((order) => order.id == orderId);

        print('$_logTag: Order deleted successfully');
        notifyListeners();
        return true;
      } else {
        _setError('Failed to delete order');
        return false;
      }
    } catch (e) {
      print('$_logTag: Error deleting order: $e');
      _setError('Error deleting order: ${e.toString()}');
      return false;
    } finally {
      _isDeletingOrder = false;
      notifyListeners();
    }
  }

  Future<bool> cancelOrder(String orderId, {String? cancelReason}) async {
    if (_currentUser == null) {
      _setError('User not logged in');
      return false;
    }

    _isCancellingOrder = true;
    _setError(null);
    _lastCancelResponse = null;
    notifyListeners();

    try {
      print('$_logTag: Cancelling order: $orderId');

      // First check if the order can be cancelled
      final canCancel = await OrderService.canCancelOrder(
        userId: _currentUser!.id,
        orderId: orderId,
      );

      if (!canCancel) {
        _setError('This order cannot be cancelled at its current stage');
        return false;
      }

      // Get detailed response from the cancel operation
      final cancelResponse = await OrderService.cancelOrderWithResponse(
        userId: _currentUser!.id,
        orderId: orderId,
        cancelReason: cancelReason,
      );

      _lastCancelResponse = cancelResponse;

      if (cancelResponse != null && cancelResponse['success'] == true) {
        // Find and update the order in local state
        final orderIndex =
            _currentOrders.indexWhere((order) => order.id == orderId);
        if (orderIndex != -1) {
          final order = _currentOrders[orderIndex];

          // Create updated order with cancelled status
          final updatedOrder = OrderModel(
            id: order.id,
            userId: order.userId,
            deliveryAddress: order.deliveryAddress,
            orderItems: order.orderItems,
            statusTimeline: [
              ...order.statusTimeline,
              StatusTimeline(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                status: 'Cancelled',
                message: cancelReason ?? 'Order cancelled by user',
                timestamp: DateTime.now(),
              ),
            ],
            totalAmount: order.totalAmount,
            notes: order.notes,
            voiceNoteUrl: order.voiceNoteUrl,
            paymentMethod: order.paymentMethod,
            status: 'Cancelled',
            createdAt: order.createdAt,
            updatedAt: DateTime.now(),
          );

          // Move from current to previous orders (keep in history)
          _currentOrders.removeAt(orderIndex);
          _previousOrders.insert(0, updatedOrder);

          // Update in all orders list
          final allOrderIndex = _allOrders.indexWhere((o) => o.id == orderId);
          if (allOrderIndex != -1) {
            _allOrders[allOrderIndex] = updatedOrder;
          }
        }

        print(
            '$_logTag: Order cancelled successfully and moved to previous orders');
        notifyListeners();
        return true;
      } else {
        // Handle cancellation failure
        final errorMessage =
            cancelResponse?['message'] ?? 'Failed to cancel order';
        _setError(errorMessage);
        print('$_logTag: Cancel failed: $errorMessage');
        return false;
      }
    } catch (e) {
      print('$_logTag: Error cancelling order: $e');
      _setError('Error cancelling order: ${e.toString()}');
      return false;
    } finally {
      _isCancellingOrder = false;
      notifyListeners();
    }
  }

  Future<bool> cancelOrderSimple(String orderId) async {
    if (_currentUser == null) {
      _setError('User not logged in');
      return false;
    }

    _isCancellingOrder = true;
    _setError(null);
    notifyListeners();

    try {
      print('$_logTag: Cancelling order (simple): $orderId');

      final success = await OrderService.cancelOrder(
        userId: _currentUser!.id,
        orderId: orderId,
      );

      if (success) {
        // Update local state - move to previous orders (keep in history)
        final orderIndex =
            _currentOrders.indexWhere((order) => order.id == orderId);
        if (orderIndex != -1) {
          final order = _currentOrders[orderIndex];

          final updatedOrder = OrderModel(
            id: order.id,
            userId: order.userId,
            deliveryAddress: order.deliveryAddress,
            orderItems: order.orderItems,
            statusTimeline: [
              ...order.statusTimeline,
              StatusTimeline(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                status: 'Cancelled',
                message: 'Order cancelled by user',
                timestamp: DateTime.now(),
              ),
            ],
            totalAmount: order.totalAmount,
            notes: order.notes,
            voiceNoteUrl: order.voiceNoteUrl,
            paymentMethod: order.paymentMethod,
            status: 'Cancelled',
            createdAt: order.createdAt,
            updatedAt: DateTime.now(),
          );

          // Move from current to previous orders (keep in history)
          _currentOrders.removeAt(orderIndex);
          _previousOrders.insert(0, updatedOrder);

          final allOrderIndex = _allOrders.indexWhere((o) => o.id == orderId);
          if (allOrderIndex != -1) {
            _allOrders[allOrderIndex] = updatedOrder;
          }
        }

        print(
            '$_logTag: Order cancelled successfully and moved to previous orders');
        notifyListeners();
        return true;
      } else {
        _setError('Failed to cancel order');
        return false;
      }
    } catch (e) {
      print('$_logTag: Error cancelling order: $e');
      _setError('Error cancelling order: ${e.toString()}');
      return false;
    } finally {
      _isCancellingOrder = false;
      notifyListeners();
    }
  }

  // Check if an order can be cancelled
  Future<bool> canCancelOrder(String orderId) async {
    if (_currentUser == null) {
      return false;
    }

    try {
      return await OrderService.canCancelOrder(
        userId: _currentUser!.id,
        orderId: orderId,
      );
    } catch (e) {
      print('$_logTag: Error checking if order can be cancelled: $e');
      return false;
    }
  }

  // Re-order based on previous order
  Future<OrderModel?> reorder({
    required OrderModel previousOrder,
    required String addressId,
    String? notes,
    String paymentMethod = 'Cash on Delivery',
  }) async {
    if (_currentUser == null) {
      _setError('User not logged in');
      return null;
    }

    _isCreatingOrder = true;
    _setError(null);
    notifyListeners();

    try {
      print('$_logTag: Re-ordering previous order: ${previousOrder.id}');

      final orderResponse = await OrderService.reorder(
        userId: _currentUser!.id,
        previousOrder: previousOrder,
        addressId: addressId,
        notes: notes,
        paymentMethod: paymentMethod,
      );

      if (orderResponse != null) {
        print(
            '$_logTag: Re-order created successfully: ${orderResponse.order.id}');

        // Add to current orders
        _currentOrders.insert(0, orderResponse.order);
        _allOrders.insert(0, orderResponse.order);

        notifyListeners();
        return orderResponse.order;
      } else {
        _setError('Failed to re-order');
        return null;
      }
    } catch (e) {
      print('$_logTag: Error re-ordering: $e');
      _setError('Error re-ordering: ${e.toString()}');
      return null;
    } finally {
      _isCreatingOrder = false;
      notifyListeners();
    }
  }

  // Get order by ID
  OrderModel? getOrderById(String orderId) {
    try {
      return _allOrders.firstWhere((order) => order.id == orderId);
    } catch (e) {
      print('$_logTag: Order not found: $orderId');
      return null;
    }
  }

  // Check if an order exists in current orders
  bool isCurrentOrder(String orderId) {
    return _currentOrders.any((order) => order.id == orderId);
  }

  // Check if an order exists in previous orders
  bool isPreviousOrder(String orderId) {
    return _previousOrders.any((order) => order.id == orderId);
  }

  // Get orders by status
  List<OrderModel> getOrdersByStatus(String status) {
    return _allOrders
        .where((order) => order.status.toLowerCase() == status.toLowerCase())
        .toList();
  }

  // Get cancellable orders
  List<OrderModel> getCancellableOrders() {
    final cancellableStatuses = [
      'pending',
      'confirmed',
      'processing',
      'placed',
      'accepted',
    ];

    return _currentOrders.where((order) {
      return cancellableStatuses.contains(order.status.toLowerCase());
    }).toList();
  }

  // Get orders by date range
  List<OrderModel> getOrdersByDateRange(DateTime startDate, DateTime endDate) {
    return _allOrders.where((order) {
      return order.createdAt
              .isAfter(startDate.subtract(const Duration(days: 1))) &&
          order.createdAt.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();
  }

  // Get total amount spent
  double getTotalAmountSpent() {
    return _allOrders.fold(0.0, (sum, order) => sum + order.totalAmount);
  }

  // Get average order value
  double getAverageOrderValue() {
    if (_allOrders.isEmpty) return 0.0;
    return getTotalAmountSpent() / _allOrders.length;
  }

  // Get orders count by status
  Map<String, int> getOrdersCountByStatus() {
    final Map<String, int> statusCount = {};
    for (final order in _allOrders) {
      statusCount[order.status] = (statusCount[order.status] ?? 0) + 1;
    }
    return statusCount;
  }

  // Clear all orders (useful for logout)
  void clearOrders() {
    _currentOrders.clear();
    _previousOrders.clear();
    _allOrders.clear();
    _currentUser = null;
    _lastCancelResponse = null;
    _setError(null);
    notifyListeners();
    print('$_logTag: Orders cleared');
  }

  // Force refresh from API
  Future<void> forceRefresh() async {
    print('$_logTag: Force refreshing orders...');
    await refreshOrders();
  }

  // Update current user (call this when user logs in/out)
  Future<void> updateCurrentUser(User? user) async {
    _currentUser = user;
    if (user != null) {
      print('$_logTag: User updated: ${user.name}');
      await refreshOrders();
    } else {
      print('$_logTag: User cleared');
      clearOrders();
    }
  }

  // Check if provider has data
  bool get hasData => _allOrders.isNotEmpty;

  // Check if provider needs refresh
  bool get needsRefresh {
    // Consider data stale after 5 minutes
    final lastUpdate = DateTime.now().subtract(const Duration(minutes: 5));
    return _allOrders.isEmpty ||
        _allOrders.any((order) => order.updatedAt.isBefore(lastUpdate));
  }

  // Get cancel response message for UI
  String? getCancelResponseMessage() {
    return _lastCancelResponse?['message'];
  }

  // Check if last cancel operation was successful
  bool get wasLastCancelSuccessful {
    return _lastCancelResponse?['success'] == true;
  }

  // Get detailed error information from last cancel attempt
  Map<String, dynamic>? getCancelErrorDetails() {
    if (_lastCancelResponse?['success'] != false) return null;
    return _lastCancelResponse;
  }

  // Debug method to print current state
  void debugState() {
    print('$_logTag: === DEBUG STATE ===');
    print('$_logTag: Current User: ${_currentUser?.name ?? 'None'}');
    print('$_logTag: Is Loading: $_isLoading');
    print('$_logTag: Is Creating Order: $_isCreatingOrder');
    print('$_logTag: Is Deleting Order: $_isDeletingOrder');
    print('$_logTag: Is Cancelling Order: $_isCancellingOrder');
    print('$_logTag: Error Message: $_errorMessage');
    print('$_logTag: Current Orders: ${_currentOrders.length}');
    print('$_logTag: Previous Orders: ${_previousOrders.length}');
    print('$_logTag: Total Orders: ${_allOrders.length}');
    print('$_logTag: Last Cancel Response: $_lastCancelResponse');
    print('$_logTag: === END DEBUG STATE ===');
  }

  @override
  void dispose() {
    print('$_logTag: Provider disposed');
    super.dispose();
  }
}
