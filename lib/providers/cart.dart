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
              price: existingItem.price)
              );
    } else {
      _itemsInCart.putIfAbsent(
          id, () => CartItem(id: id, title: title, price: price, quantity: 1)
          );
    }
    notifyListeners();
  }
}
