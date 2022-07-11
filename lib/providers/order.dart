import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/orderItem.dart';
import '../models/http_exception_handler.dart';

class Order with ChangeNotifier {
  final List<OrderItem> _orderItems = [];

  List<OrderItem> get allOrders {
    return [..._orderItems];
  }

  addOrderItem(id, totalAmount, items) async {
    final url =
        Uri.parse('https://shop-c2818-default-rtdb.firebaseio.com/orders');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'totalAmount': totalAmount,
          'dateTime': DateTime.now().toIso8601String(),
          'items': items.map((item) {
            return {
              'title':item.title,
              'price':item.price,
              'quantity':item.quantity,
            };
          }).toList(),
        }),
      );
      final body = json.decode(response.body);
      final statusCode = response.statusCode;
      if (statusCode == 200) {
        _orderItems.insert(
            0,
            OrderItem(
                id: body['name'],
                totalAmount: totalAmount,
                items: items,
                dateTime: DateTime.now()));
        notifyListeners();
        return {
          'status': 200,
          'success': true,
        };
      } else {
        throw HttpException('Some things went wrong !');
      }
    } catch (error) {
      rethrow;
    }
  }
}
