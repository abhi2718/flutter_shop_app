import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception_handler.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite = false;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavourite = false});

  toggleFavourite(token) async {
    var oldFavouriteStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners(); // it will call all the registered listeners
    try {
      final url = Uri.parse(
          'https://shop-c2818-default-rtdb.firebaseio.com/products/$id.json?auth=$token');
      final response = await http.patch(url,
          body: json.encode({'isFavourite': isFavourite}));
      if (response.statusCode == 200) {
      } else {
        throw HttpException('Some things went wrong !');
      }
    } catch (error) {
      isFavourite = oldFavouriteStatus;
      notifyListeners(); // it will call all the registered listeners
      rethrow;
    }
  }
}
