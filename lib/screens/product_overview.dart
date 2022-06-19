import 'package:flutter/material.dart';
import '../widgets/productsgrid.dart';
class ProductOverview extends StatelessWidget {
  const ProductOverview({Key? key}) : super(key: key);
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Shop'),
        ),
        body: const ProductGrid(),
        );
  }
}
