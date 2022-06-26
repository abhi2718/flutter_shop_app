import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class Cart with ChangeNotifier {
  final Map<String, CartItem> _itemsInCart = {};

  Map<String, CartItem> get getItemsInCart {
    return {..._itemsInCart};
  }

  int get numberOfItemsInCart {
    return _itemsInCart.length;
  }

  void addItemsInCart(String id, String title, double price) {
    if (_itemsInCart.containsKey(id)) {
      _itemsInCart.update(
          id,
          (existingItem) => CartItem(
              id: existingItem.id,
              title: existingItem.title,
              quantity: existingItem.quantity + 1,
              price: existingItem.price));
    } else {
      _itemsInCart.putIfAbsent(
          id, () => CartItem(id: id, title: title, price: price, quantity: 1));
    }
    notifyListeners();
  }

  double get totalAmount {
    var total = 0.0;
    _itemsInCart.values.toList().forEach((element) {
      total += (element.price * element.quantity.toDouble());
    });
    return total;
  }

  void removeItemFromCart(id) {
    _itemsInCart.remove(id);
     notifyListeners();
  }
  void clearCart(){
    _itemsInCart.clear();
    notifyListeners();
  }
}
