import 'package:flutter/foundation.dart';

/// Product class
class Product {
  final String id;
  final String name;
  final double price;
  
  Product({
    required this.id,
    required this.name,
    required this.price,
  });
}

/// Q22: Complex ChangeNotifier with multiple operations
class CartModel extends ChangeNotifier {
  // Private state: Map of product ID to quantity
  final Map<String, int> _items = {};
  
  // Available products
  final List<Product> availableProducts = [
    Product(id: '1', name: 'Laptop', price: 999.99),
    Product(id: '2', name: 'Mouse', price: 29.99),
    Product(id: '3', name: 'Keyboard', price: 79.99),
    Product(id: '4', name: 'Monitor', price: 299.99),
  ];
  
  // Getters
  Map<String, int> get items => Map.unmodifiable(_items);
  
  int get itemCount => _items.values.fold(0, (sum, qty) => sum + qty);
  
  double get totalPrice {
    double total = 0;
    _items.forEach((id, qty) {
      final product = availableProducts.firstWhere((p) => p.id == id);
      total += product.price * qty;
    });
    return total;
  }
  
  // Methods
  void addItem(String productId) {
    if (_items.containsKey(productId)) {
      _items[productId] = _items[productId]! + 1;
    } else {
      _items[productId] = 1;
    }
    
    notifyListeners();
    print('Added product $productId. Cart: $_items');
  }
  
  void removeItem(String productId) {
    if (_items.containsKey(productId)) {
      if (_items[productId]! > 1) {
        _items[productId] = _items[productId]! - 1;
      } else {
        _items.remove(productId);
      }
      
      notifyListeners();
    }
  }
  
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}