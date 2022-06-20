import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './product_item.dart';
import '../providers/products_provider.dart';
import '../providers/product.dart';
class ProductGrid extends StatelessWidget {
  final bool showFavorite;
  const ProductGrid({Key? key, required this.showFavorite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductList productsProvider = Provider.of<ProductList>(context,
        listen: true); // creating provider listener
    List productsList = showFavorite?
    productsProvider.getFavoriteProducts:productsProvider.getProducts;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      // SliverGridDelegateWithFixedCrossAxisCount -> use to give fix number of column
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //number of column
          mainAxisSpacing: 20, // margin between rows
          crossAxisSpacing: 20, // margin between columns
          childAspectRatio: 3 / 2),
      itemBuilder: (ctx, index) {
        return ChangeNotifierProvider<Product>.value(
          value: productsList[index],
          child: const ProductItem()
          );
      },
      itemCount:productsList.length,
    );
  }
}
