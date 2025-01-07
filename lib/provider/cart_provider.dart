import 'package:flutter/material.dart';

import '../Database/DBHandler.dart';
import '../Model/cart_model.dart';

class CartProvider with ChangeNotifier {
  final DBHandler _dbHandler = DBHandler();
  final List<CartModel> _cartItems = [];

  List<CartModel> get cartItems => _cartItems;

  double get totalPrice => _cartItems.fold(0.0,
      (sum, item) => sum + (double.parse(item.price) * int.parse(item.count)));

  int get totalItems =>
      _cartItems.fold(0, (sum, item) => sum + int.parse(item.count));

  // Load items from the database
  Future<void> loadCartFromDatabase() async {
    final items = await _dbHandler.readCourses();
    _cartItems.clear();
    _cartItems.addAll(items);
    notifyListeners();
  }

  Future<void> addItem(CartModel item, BuildContext context) async {
    // Check if the item already exists
    final existingItemIndex = _cartItems.indexWhere(
      (cartItem) => cartItem.name == item.name && cartItem.size == item.size,
    );

    if (existingItemIndex >= 0) {
      // If it exists, show a snackbar with a message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${item.name} is already in the cart'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      // Otherwise, add the item
      _cartItems.add(item);
      await _dbHandler.addNewItemToCart(
        item.name,
        item.price,
        item.size,
        item.count,
        item.imageUrl,
        item.type,
        context, // Pass BuildContext
      );
    }

    notifyListeners(); // Notify UI about the change
  }

  //
  // Future<void> addItem(CartModel item, BuildContext context) async {
  //   // Check if the item already exists
  //   final existingItemIndex = _cartItems.indexWhere(
  //     (cartItem) => cartItem.name == item.name && cartItem.size == item.size,
  //   );
  //
  //   if (existingItemIndex >= 0) {
  //     // If it exists, update the count
  //     final existingItem = _cartItems[existingItemIndex];
  //     existingItem.count =
  //         (int.parse(existingItem.count) + int.parse(item.count)).toString();
  //
  //     await _dbHandler.updateItemCount(
  //       existingItem.name,
  //       existingItem.size,
  //       existingItem.count,
  //     );
  //   } else {
  //     // Otherwise, add the item
  //     _cartItems.add(item);
  //     await _dbHandler.addNewItemToCart(
  //       item.name,
  //       item.price,
  //       item.size,
  //       item.count,
  //       item.imageUrl,
  //       item.type,
  //       context, // Pass BuildContext
  //     );
  //   }
  //
  //   notifyListeners();
  // }

  // Update item count
  Future<void> updateItemCount(String name, String size, int newCount) async {
    final existingItemIndex = _cartItems.indexWhere(
      (cartItem) => cartItem.name == name && cartItem.size == size,
    );

    if (existingItemIndex >= 0) {
      if (newCount > 0) {
        _cartItems[existingItemIndex].count =
            newCount.toString(); // Update count
        await _dbHandler.updateItemCount(name, size, newCount.toString());
      } else {
        _cartItems.removeAt(existingItemIndex); // Remove item if count is zero
        await _dbHandler.deleteItem(name, size);
      }
      notifyListeners(); // Notify UI about the change
    }
  }

  // Clear the cart
  Future<void> clearCart() async {
    _cartItems.clear();
    await _dbHandler.deleteAll();
    notifyListeners();
  }
}
