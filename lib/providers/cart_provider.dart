// // providers/cart_provider.dart
// import 'package:flutter/material.dart';
// import 'package:medical_user_app/models/cart_model.dart';
// import 'package:medical_user_app/services/cart_services.dart';

// class CartProvider extends ChangeNotifier {
//   CartModel _cart = CartModel.empty();
//   bool _isLoading = false;
//   String? _errorMessage;

//   // Getters
//   CartModel get cart => _cart;
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   int get itemCount => _cart.totalItems;
//   double get totalAmount => _cart.totalPayable;
//   bool get isEmpty => _cart.items.isEmpty;

//   // Set loading state
//   void _setLoading(bool loading) {
//     _isLoading = loading;
//     notifyListeners();
//   }

//   // Set error message
//   void _setError(String? message) {
//     _errorMessage = message;
//     notifyListeners();
//   }

//   // Clear error
//   void clearError() {
//     _errorMessage = null;
//     notifyListeners();
//   }

//   // Initialize cart (fetch from API)
//   Future<void> initializeCart() async {
//     _setLoading(true);
//     _setError(null);

//     try {
//       final result = await CartServices.getCart();
      
//       if (result['success']) {
//         _cart = result['data'] as CartModel;
//         print('Cart initialized with ${_cart.items.length} items');
//       } else {
//         _setError(result['message']);
//         _cart = CartModel.empty();
//       }
//     } catch (e) {
//       _setError('Failed to initialize cart: ${e.toString()}');
//       _cart = CartModel.empty();
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Add item to cart
//   Future<bool> addToCart(String medicineId, {bool showLoading = true}) async {
//     if (showLoading) _setLoading(true);
//     _setError(null);

//     try {
//       final result = await CartServices.addToCart(
//         medicineId: medicineId,
//         increment: true,
//       );

//       if (result['success']) {
//         // Refresh cart after adding
//         await _refreshCart(showLoading: false);
//         return true;
//       } else {
//         _setError(result['message']);
//         return false;
//       }
//     } catch (e) {
//       _setError('Failed to add item to cart: ${e.toString()}');
//       return false;
//     } finally {
//       if (showLoading) _setLoading(false);
//     }
//   }



//   // Increase item quantity (optimistic update)
// Future<bool> increaseQuantity(String medicineId) async {
//   _setError(null);

//   // ✅ Optimistic update
//   final previousCart = _cart;
//   final updatedItems = _cart.items.map((item) {
//     if (item.medicineId == medicineId) {
//       return item.copyWith(quantity: item.quantity + 1);
//     }
//     return item;
//   }).toList();

//   double newSubTotal = updatedItems.fold(0.0, (sum, item) => sum + (item.totalPrice * item.quantity));
//   int newTotalItems = updatedItems.fold(0, (sum, item) => sum + item.quantity);

//   _cart = _cart.copyWith(
//     items: updatedItems,
//     subTotal: newSubTotal,
//     totalItems: newTotalItems,
//     totalPayable: newSubTotal + _cart.platformFee + _cart.deliveryCharge,
//   );
//   notifyListeners();

//   try {
//     final result = await CartServices.increaseQuantity(medicineId: medicineId);
//     if (result['success']) {
//       await _refreshCart(showLoading: false);
//       return true;
//     } else {
//       _cart = previousCart;
//       _setError(result['message']);
//       notifyListeners();
//       return false;
//     }
//   } catch (e) {
//     _cart = previousCart;
//     _setError('Failed to increase quantity: ${e.toString()}');
//     notifyListeners();
//     return false;
//   }
// }

// // Decrease item quantity (optimistic update)
// Future<bool> decreaseQuantity(String medicineId) async {
//   _setError(null);

//   final previousCart = _cart;
//   final updatedItems = _cart.items.map((item) {
//     if (item.medicineId == medicineId) {
//       return item.copyWith(quantity: item.quantity - 1);
//     }
//     return item;
//   }).toList();

//   double newSubTotal = updatedItems.fold(0.0, (sum, item) => sum + (item.totalPrice * item.quantity));
//   int newTotalItems = updatedItems.fold(0, (sum, item) => sum + item.quantity);

//   _cart = _cart.copyWith(
//     items: updatedItems,
//     subTotal: newSubTotal,
//     totalItems: newTotalItems,
//     totalPayable: newSubTotal + _cart.platformFee + _cart.deliveryCharge,
//   );
//   notifyListeners();

//   try {
//     final result = await CartServices.decreaseQuantity(medicineId: medicineId);
//     if (result['success']) {
//       await _refreshCart(showLoading: false);
//       return true;
//     } else {
//       _cart = previousCart;
//       _setError(result['message']);
//       notifyListeners();
//       return false;
//     }
//   } catch (e) {
//     _cart = previousCart;
//     _setError('Failed to decrease quantity: ${e.toString()}');
//     notifyListeners();
//     return false;
//   }
// }

//   // Increase item quantity
//   // Future<bool> increaseQuantity(String medicineId) async {
//   //   _setLoading(true);
//   //   _setError(null);

//   //   try {
//   //     final result = await CartServices.increaseQuantity(medicineId: medicineId);

//   //     if (result['success']) {
//   //       await _refreshCart(showLoading: false);
//   //       return true;
//   //     } else {
//   //       _setError(result['message']);
//   //       return false;
//   //     }
//   //   } catch (e) {
//   //     _setError('Failed to increase quantity: ${e.toString()}');
//   //     return false;
//   //   } finally {
//   //     _setLoading(false);
//   //   }
//   // }

//   // // Decrease item quantity
//   // Future<bool> decreaseQuantity(String medicineId) async {
//   //   _setLoading(true);
//   //   _setError(null);

//   //   try {
//   //     final result = await CartServices.decreaseQuantity(medicineId: medicineId);

//   //     if (result['success']) {
//   //       await _refreshCart(showLoading: false);
//   //       return true;
//   //     } else {
//   //       _setError(result['message']);
//   //       return false;
//   //     }
//   //   } catch (e) {
//   //     _setError('Failed to decrease quantity: ${e.toString()}');
//   //     return false;
//   //   } finally {
//   //     _setLoading(false);
//   //   }
//   // }

//   // Remove item from cart completely
//   // Future<bool> removeFromCart(String medicineId) async {
//   //   _setLoading(true);
//   //   _setError(null);

//   //   try {
//   //     final result = await CartServices.removeFromCart(medicineId: medicineId);

//   //     if (result['success']) {
//   //       await _refreshCart(showLoading: false);
//   //       return true;
//   //     } else {
//   //       _setError(result['message']);
//   //       return false;
//   //     }
//   //   } catch (e) {
//   //     _setError('Failed to remove item from cart: ${e.toString()}');
//   //     return false;
//   //   } finally {
//   //     _setLoading(false);
//   //   }
//   // }



//   // Remove item from cart completely (optimistic update)
// Future<bool> removeFromCart(String medicineId) async {
//   _setError(null);

//   // ✅ Optimistic update: remove immediately from local state
//   final previousCart = _cart;
//   final updatedItems = _cart.items.where((item) => item.medicineId != medicineId).toList();

//   // Recalculate totals locally
//   double newSubTotal = updatedItems.fold(0.0, (sum, item) => sum + (item.totalPrice * item.quantity));
//   int newTotalItems = updatedItems.fold(0, (sum, item) => sum + item.quantity);

//   _cart = _cart.copyWith(
//     items: updatedItems,
//     subTotal: newSubTotal,
//     totalItems: newTotalItems,
//     totalPayable: newSubTotal + _cart.platformFee + _cart.deliveryCharge,
//   );
//   notifyListeners(); // 👈 UI updates instantly

//   try {
//     final result = await CartServices.removeFromCart(medicineId: medicineId);

//     if (result['success']) {
//       // Silently sync with server in background
//       await _refreshCart(showLoading: false);
//       return true;
//     } else {
//       // ❌ Rollback on failure
//       _cart = previousCart;
//       _setError(result['message']);
//       notifyListeners();
//       return false;
//     }
//   } catch (e) {
//     // ❌ Rollback on error
//     _cart = previousCart;
//     _setError('Failed to remove item from cart: ${e.toString()}');
//     notifyListeners();
//     return false;
//   }
// }

//   // Refresh cart data
//   Future<void> refreshCart() async {
//     await _refreshCart();
//   }

//   // Private method to refresh cart
//   Future<void> _refreshCart({bool showLoading = true}) async {
//     if (showLoading) _setLoading(true);

//     try {
//       final result = await CartServices.getCart();
      
//       if (result['success']) {
//         _cart = result['data'] as CartModel;
//       } else {
//         _setError(result['message']);
//       }
//     } catch (e) {
//       _setError('Failed to refresh cart: ${e.toString()}');
//     } finally {
//       if (showLoading) _setLoading(false);
//     }
//   }

//   // Clear entire cart
//   Future<void> clearCart() async {
//     _setLoading(true);
//     _setError(null);

//     try {
//       // Remove all items one by one
//       final List<String> medicineIds = _cart.items.map((item) => item.medicineId).toList();
      
//       for (String medicineId in medicineIds) {
//         await CartServices.removeFromCart(medicineId: medicineId);
//       }
      
//       // Refresh cart to get updated state
//       await _refreshCart(showLoading: false);
//     } catch (e) {
//       _setError('Failed to clear cart: ${e.toString()}');
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Get specific item from cart
//   CartItem? getCartItem(String medicineId) {
//     try {
//       return _cart.items.firstWhere((item) => item.medicineId == medicineId);
//     } catch (e) {
//       return null;
//     }
//   }

//   // Check if item exists in cart
//   bool isInCart(String medicineId) {
//     return _cart.items.any((item) => item.medicineId == medicineId);
//   }

//   // Get quantity of specific item
//   int getItemQuantity(String medicineId) {
//     final item = getCartItem(medicineId);
//     return item?.quantity ?? 0;
//   }

//   // Calculate totals manually (for verification)
//   void recalculateTotals() {
//     double subTotal = 0;
//     int totalItems = 0;

//     for (var item in _cart.items) {
//       subTotal += item.totalPrice;
//       totalItems += item.quantity;
//     }

//     // Platform fee and delivery charges should come from API
//     // This is just for local calculation
//     const double platformFee = 10.0;
//     const double deliveryCharge = 22.0;
//     final double totalPayable = subTotal + platformFee + deliveryCharge;

//     _cart = _cart.copyWith(
//       totalItems: totalItems,
//       subTotal: subTotal,
//       totalPayable: totalPayable,
//     );

//     notifyListeners();
//   }

//   // Reset provider state
//   void reset() {
//     _cart = CartModel.empty();
//     _isLoading = false;
//     _errorMessage = null;
//     notifyListeners();
//   }
// }











/////////////// New cart provider for fix the multiple amount issueeeee//////////////////////




// providers/cart_provider.dart
import 'package:flutter/material.dart';
import 'package:medical_user_app/models/cart_model.dart';
import 'package:medical_user_app/services/cart_services.dart';

class CartProvider extends ChangeNotifier {
  CartModel _cart = CartModel.empty();
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  CartModel get cart => _cart;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get itemCount => _cart.totalItems;
  double get totalAmount => _cart.totalPayable;
  bool get isEmpty => _cart.items.isEmpty;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Initialize cart (fetch from API)
  Future<void> initializeCart() async {
    _setLoading(true);
    _setError(null);

    try {
      final result = await CartServices.getCart();

      if (result['success']) {
        _cart = result['data'] as CartModel;
        print('Cart initialized with ${_cart.items.length} items');
      } else {
        _setError(result['message']);
        _cart = CartModel.empty();
      }
    } catch (e) {
      _setError('Failed to initialize cart: ${e.toString()}');
      _cart = CartModel.empty();
    } finally {
      _setLoading(false);
    }
  }

  // Add item to cart
  Future<bool> addToCart(String medicineId, {bool showLoading = true}) async {
    if (showLoading) _setLoading(true);
    _setError(null);

    try {
      final result = await CartServices.addToCart(
        medicineId: medicineId,
        increment: true,
      );

      if (result['success']) {
        await _refreshCart(showLoading: false);
        return true;
      } else {
        _setError(result['message']);
        return false;
      }
    } catch (e) {
      _setError('Failed to add item to cart: ${e.toString()}');
      return false;
    } finally {
      if (showLoading) _setLoading(false);
    }
  }

  // Increase item quantity
  // FIX: optimistic update shown immediately; on success we keep the optimistic
  // state (no _refreshCart) — this eliminates the double-render flicker.
  // Only on failure do we roll back and re-fetch.
  Future<bool> increaseQuantity(String medicineId) async {
    _setError(null);

    final previousCart = _cart;

    // 1. Apply optimistic update immediately
    final updatedItems = _cart.items.map((item) {
      if (item.medicineId == medicineId) {
        return item.copyWith(quantity: item.quantity + 1);
      }
      return item;
    }).toList();

    final double newSubTotal = updatedItems.fold(
        0.0, (sum, item) => sum + (item.totalPrice * item.quantity));
    final int newTotalItems =
        updatedItems.fold(0, (sum, item) => sum + item.quantity);

    _cart = _cart.copyWith(
      items: updatedItems,
      subTotal: newSubTotal,
      totalItems: newTotalItems,
      totalPayable: newSubTotal + _cart.platformFee + _cart.deliveryCharge,
    );
    notifyListeners(); // single notify — shows correct value immediately

    try {
      final result =
          await CartServices.increaseQuantity(medicineId: medicineId);

      if (result['success']) {
        // ✅ FIX: Do NOT call _refreshCart here.
        // The optimistic state is already correct — calling _refreshCart
        // triggers a second notifyListeners with server data that causes flicker.
        return true;
      } else {
        // API failed → roll back to previous state and re-sync
        _cart = previousCart;
        _setError(result['message']);
        await _refreshCart(showLoading: false);
        notifyListeners();
        return false;
      }
    } catch (e) {
      // Error → roll back and re-sync
      _cart = previousCart;
      _setError('Failed to increase quantity: ${e.toString()}');
      await _refreshCart(showLoading: false);
      notifyListeners();
      return false;
    }
  }

  // Decrease item quantity
  // Same fix as increaseQuantity — no _refreshCart on success.
  Future<bool> decreaseQuantity(String medicineId) async {
    _setError(null);

    final previousCart = _cart;

    // 1. Apply optimistic update immediately
    final updatedItems = _cart.items.map((item) {
      if (item.medicineId == medicineId) {
        return item.copyWith(quantity: item.quantity - 1);
      }
      return item;
    }).toList();

    final double newSubTotal = updatedItems.fold(
        0.0, (sum, item) => sum + (item.totalPrice * item.quantity));
    final int newTotalItems =
        updatedItems.fold(0, (sum, item) => sum + item.quantity);

    _cart = _cart.copyWith(
      items: updatedItems,
      subTotal: newSubTotal,
      totalItems: newTotalItems,
      totalPayable: newSubTotal + _cart.platformFee + _cart.deliveryCharge,
    );
    notifyListeners(); // single notify — shows correct value immediately

    try {
      final result =
          await CartServices.decreaseQuantity(medicineId: medicineId);

      if (result['success']) {
        // ✅ FIX: Do NOT call _refreshCart here.
        return true;
      } else {
        // API failed → roll back and re-sync
        _cart = previousCart;
        _setError(result['message']);
        await _refreshCart(showLoading: false);
        notifyListeners();
        return false;
      }
    } catch (e) {
      // Error → roll back and re-sync
      _cart = previousCart;
      _setError('Failed to decrease quantity: ${e.toString()}');
      await _refreshCart(showLoading: false);
      notifyListeners();
      return false;
    }
  }

  // Remove item from cart completely (optimistic update)
  Future<bool> removeFromCart(String medicineId) async {
    _setError(null);

    final previousCart = _cart;
    final updatedItems =
        _cart.items.where((item) => item.medicineId != medicineId).toList();

    final double newSubTotal = updatedItems.fold(
        0.0, (sum, item) => sum + (item.totalPrice * item.quantity));
    final int newTotalItems =
        updatedItems.fold(0, (sum, item) => sum + item.quantity);

    _cart = _cart.copyWith(
      items: updatedItems,
      subTotal: newSubTotal,
      totalItems: newTotalItems,
      totalPayable: newSubTotal + _cart.platformFee + _cart.deliveryCharge,
    );
    notifyListeners();

    try {
      final result = await CartServices.removeFromCart(medicineId: medicineId);

      if (result['success']) {
        // Sync once after removal — acceptable since this is a less frequent action
        await _refreshCart(showLoading: false);
        return true;
      } else {
        _cart = previousCart;
        _setError(result['message']);
        notifyListeners();
        return false;
      }
    } catch (e) {
      _cart = previousCart;
      _setError('Failed to remove item from cart: ${e.toString()}');
      notifyListeners();
      return false;
    }
  }

  // Refresh cart data (public)
  Future<void> refreshCart() async {
    await _refreshCart();
  }

  // Private refresh
  Future<void> _refreshCart({bool showLoading = true}) async {
    if (showLoading) _setLoading(true);

    try {
      final result = await CartServices.getCart();

      if (result['success']) {
        _cart = result['data'] as CartModel;
        notifyListeners();
      } else {
        _setError(result['message']);
      }
    } catch (e) {
      _setError('Failed to refresh cart: ${e.toString()}');
    } finally {
      if (showLoading) _setLoading(false);
    }
  }

  // Clear entire cart
  Future<void> clearCart() async {
    _setLoading(true);
    _setError(null);

    try {
      final List<String> medicineIds =
          _cart.items.map((item) => item.medicineId).toList();

      for (String medicineId in medicineIds) {
        await CartServices.removeFromCart(medicineId: medicineId);
      }

      await _refreshCart(showLoading: false);
    } catch (e) {
      _setError('Failed to clear cart: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Get specific item from cart
  CartItem? getCartItem(String medicineId) {
    try {
      return _cart.items.firstWhere((item) => item.medicineId == medicineId);
    } catch (e) {
      return null;
    }
  }

  bool isInCart(String medicineId) {
    return _cart.items.any((item) => item.medicineId == medicineId);
  }

  int getItemQuantity(String medicineId) {
    final item = getCartItem(medicineId);
    return item?.quantity ?? 0;
  }

  void recalculateTotals() {
    double subTotal = 0;
    int totalItems = 0;

    for (var item in _cart.items) {
      subTotal += item.totalPrice;
      totalItems += item.quantity;
    }

    const double platformFee = 10.0;
    const double deliveryCharge = 22.0;
    final double totalPayable = subTotal + platformFee + deliveryCharge;

    _cart = _cart.copyWith(
      totalItems: totalItems,
      subTotal: subTotal,
      totalPayable: totalPayable,
    );

    notifyListeners();
  }

  void reset() {
    _cart = CartModel.empty();
    _isLoading = false;
    _errorMessage = null;
    notifyListeners();
  }
}