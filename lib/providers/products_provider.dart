import 'package:flutter/material.dart';
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

  void add(data) {
    _productList.add(Product(
      id: data['price'],
      title: data['title'],
      description: data['description'],
      price: double.parse(data['price']),
      imageUrl: data['image'],
    ));
    notifyListeners(); // it will call all the registered listeners
  }

  void deleteProduct(id) {
    _productList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
