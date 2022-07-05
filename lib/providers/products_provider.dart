import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './product.dart';
import '../dummay_data/dummayData.dart';

class ProductList with ChangeNotifier {
  final List<Product> _productList = [...dummyProduct];

  List<Product> get getProducts {
    return [..._productList];
  }

  List<Product> get getFavoriteProducts {
    return _productList
        .where((element) => element.isFavourite == true)
        .toList();
  }

  Product getProduct(String id) {
    return _productList.firstWhere((element) => element.id == id);
  }

  // Future<void> add(data) {
  //   final url = Uri.parse(
  //       'https://shop-c2818-default-rtdb.firebaseio.com/products');
  //   return http
  //       .post(
  //     url,
  //     body: json.encode({
  //       'title': data['title'],
  //       'description': data['description'],
  //       'price': data['price'],
  //       'imageUrl': data['image'],
  //       'isFavourite': false,
  //     }),
  //   )
  //   .then((response) {
  //     // print('Response status: ${response.statusCode}');
  //     // print('Response body: ${response.body}');
  //     final body = json.decode(response.body);
  //     _productList.add(Product(
  //       id: body['name'],
  //       title: data['title'],
  //       description: data['description'],
  //       price: double.parse(data['price']),
  //       imageUrl: data['image'],
  //     ));
  //     notifyListeners(); // it will call all the registered listeners
  //   }).catchError((error) {
  //     throw error;
  //   });
  // }

  add(data) async {
    final url =
        Uri.parse('https://shop-c2818-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': data['title'],
          'description': data['description'],
          'price': data['price'],
          'imageUrl': data['image'],
          'isFavourite': false,
        }),
      );
      final body = json.decode(response.body);
      final statusCode = response.statusCode;
      if (statusCode == 200) {
        _productList.add(Product(
          id: body['name'],
          title: data['title'],
          description: data['description'],
          price: double.parse(data['price']),
          imageUrl: data['image'],
        ));
        notifyListeners(); // it will call all the registered listeners
        return {
          'status':200,
          'success':true,
        };
      } else {
        return {
          'status':statusCode,
          'success':false,
        };
      }
    } catch (error) {
      rethrow;
    }
  }

  void deleteProduct(id) {
    _productList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
