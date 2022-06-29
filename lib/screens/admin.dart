import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/main_drawer.dart';
import '../providers/products_provider.dart';
import '../widgets/admin_product.dart';
class EditOrDeleteProduct extends StatelessWidget {
  static const routeName = '/edit_or_delete_product';
  const EditOrDeleteProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: Consumer<ProductList>(
        builder: (context, value, child) {
          return ListView.builder(itemBuilder:
            (context, index) => AdminProductItem(
              id:value.getProducts[index].id,
              title: value.getProducts[index].title,
              imageUrl: value.getProducts[index].imageUrl,
            ),
            itemCount: value.getProducts.length,
            );
        },
      ),
      drawer: const MainDrawer(),
    );
  }
}
