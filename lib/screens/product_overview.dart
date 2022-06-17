import 'package:flutter/material.dart';
import '../dummay_data/dummayData.dart';
import '../widgets/product_item.dart';

class ProductOverview extends StatelessWidget {
  const ProductOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Shop'),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(10),
          // SliverGridDelegateWithFixedCrossAxisCount -> use to give fix number of column
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, //number of column
              mainAxisSpacing: 20, // margin between rows
              crossAxisSpacing: 20, // margin between columns
              childAspectRatio: 3 / 2),
          itemBuilder: (ctx, index) => ProductItem(
            id: dummyProduct[index].id,
            title: dummyProduct[index].title,
            imageUrl: dummyProduct[index].imageUrl,
            ),
          itemCount: dummyProduct.length,
        ));
  }
}
