import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../providers/product.dart';

class ProductDetail extends StatelessWidget {
  static const routeName = '/product-details';
  const ProductDetail({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Map routeData =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    Product selectedProduct =
        Provider.of<ProductList>(context, listen: true).getProduct(routeData["id"]);
    return Scaffold(
      appBar: AppBar(
          title:  Text(selectedProduct.title),
          ),
      body: const Text('welcome'),
    );
  }
}
