import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/orderItem.dart';
import '../models/http_exception_handler.dart';
import '../models/cart_item.dart';

class Order with ChangeNotifier {
  final List<OrderItem> _orderItems = [];

  List<OrderItem> get allOrders {
    return [..._orderItems];
  }

  addOrderItem(id, totalAmount, items,token) async {
    final url =
        Uri.parse('https://shop-c2818-default-rtdb.firebaseio.com/orders.json?auth=$token');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'totalAmount': totalAmount,
          'dateTime': DateTime.now().toIso8601String(),
          'items': items.map((item) {
            return {
              'title': item.title,
              'price': item.price,
              'quantity': item.quantity,
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

  Future<void> fetchAndAddOrders(token) async {
    final url =
        Uri.parse('https://shop-c2818-default-rtdb.firebaseio.com/orders.json?auth=$token');
    try {
      final response = await http.get(url);
      final body = json.decode(response.body) as Map<String, dynamic>;
      final statusCode = response.statusCode;
      if (statusCode == 200) {
        body.forEach((key, value) {
          _orderItems.insert(
              0,
              OrderItem(
                  id: key,
                  totalAmount: value['totalAmount'],
                  items: [
                    ...value['items'].map((order) {
                      return CartItem(
                        id: DateTime.now().toString(),
                        title:order['title'],
                        price:order['price'],
                        quantity:order['quantity'],
                      );
                    }).toList()
                  ],
                  dateTime: DateTime.parse(value['dateTime'])));
        });
      } else {
        throw HttpException('Some things went wrong !');
      }
    } catch (error) {
      rethrow;
    }
  }
}
