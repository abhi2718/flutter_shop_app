import 'package:flutter/material.dart';
import './product.dart';
import '../dummay_data/dummayData.dart';

class ProductList with ChangeNotifier {
  final List<Product> _productList = [...dummyProduct];

  List<Product> get getProducts {
    return [..._productList];
  }

  Product getProduct(String id) {
    return _productList.firstWhere((element) => element.id == id);
  }

  void add(Product product) {
    _productList.add(product);
    notifyListeners(); // it will call all the registered listeners
  }
}
