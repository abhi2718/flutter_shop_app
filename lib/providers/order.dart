import 'package:flutter/foundation.dart';
import '../models/orderItem.dart';

class Order with ChangeNotifier {
  final List<OrderItem> _orderItems = [];

  List<OrderItem> get allOrders {
    return [..._orderItems];
  }

  void addOrderItem(id, totalAmount, items) {
    _orderItems.insert(
        0,
        OrderItem(
            id: id,
            totalAmount: totalAmount,
            items: items,
            dateTime: DateTime.now())
            );
    notifyListeners();
  }
}
