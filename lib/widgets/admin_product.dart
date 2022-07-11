// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/edit_product_screen.dart';
import '../providers/products_provider.dart';

class AdminProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  const AdminProductItem({
    Key? key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final snackBar = ScaffoldMessenger.of(context);
    ProductList productsProvider =
        Provider.of<ProductList>(context, listen: true);
    return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        //title:Text(title),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text('₹ $price'),
            // IconButton(
            //   onPressed: () {
            //     Navigator.of(context).pushNamed(EditProductScreen.routeName);
            //   },
            //   icon: const Icon(
            //     Icons.edit,
            //     color: Colors.blue,
            //   ),
            // ),
            IconButton(
              onPressed: () async {
                try {
                  await productsProvider.deleteProduct(id);
                } catch (error) {
                  snackBar
                      .showSnackBar(SnackBar(content: Text(error.toString())));
                }
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.blue,
              ),
            ),
          ],
        ));
  }
}
