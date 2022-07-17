import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './product.dart';
import '../models/http_exception_handler.dart';

class ProductList with ChangeNotifier {
  List<Product> _productList = [];

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

  add(data,token) async {
    try {
      final url = Uri.parse(
          'https://shop-c2818-default-rtdb.firebaseio.com/products.json?auth=$token');
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
          'status': 200,
          'success': true,
        };
      } else {
        return {
          'status': statusCode,
          'success': false,
        };
      }
    } catch (error) {
      rethrow;
    }
  }

  fetchAndAddProducts(token) async {
    final url = Uri.parse(
        'https://shop-c2818-default-rtdb.firebaseio.com/products.json?auth=$token');
    try {
      final response = await http.get(url);
      final body = json.decode(response.body) as Map<String, dynamic>;
      final statusCode = response.statusCode;
      if (statusCode == 200) {
        List<Product> _products = [];
        body.forEach((key, value) {
          _products.add(Product(
            id: key,
            title: value['title'],
            description: value['description'],
            price: double.parse(value['price']),
            imageUrl: value['imageUrl'],
            isFavourite: value['isFavourite'],
          ));
        });
        _productList = [..._products];
        notifyListeners(); // it will call all the registered listeners
        return {
          'status': 200,
          'success': true,
        };
      } else {
        return {
          'status': statusCode,
          'success': false,
        };
      }
    } catch (error) {
      rethrow;
    }
  }

  void addProducts(productList) {
    _productList = [...productList];
    notifyListeners();
  }

  deleteProduct(id,token) async {
    final existingProductIndex =
        _productList.indexWhere((element) => element.id == id);
    Product? existingProduct = _productList[existingProductIndex];
    _productList.removeWhere((element) => element.id == id);
    notifyListeners();
    try {
      final url = Uri.parse(
          'https://shop-c2818-default-rtdb.firebaseio.com/products/$id.json?auth=$token');
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        existingProduct = null;
      } else {
        throw HttpException('Some things went wrong');
      }
    } catch (error) {
      _productList.insert(existingProductIndex, existingProduct!);
      notifyListeners();
      rethrow;
    }
  }
}
