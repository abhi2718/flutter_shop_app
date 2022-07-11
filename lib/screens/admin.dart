import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/main_drawer.dart';
import '../providers/products_provider.dart';
import '../widgets/admin_product.dart';
import '../screens/edit_product_screen.dart';

class EditOrDeleteProduct extends StatelessWidget {
  static const routeName = '/edit_or_delete_product';
  const EditOrDeleteProduct({Key? key}) : super(key: key);
  Future<void> reloadProduct(BuildContext context) async {
    try {
      await Provider.of<ProductList>(context, listen: false)
          .fetchAndAddProducts();
    } catch (error) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Error'),
                content: const Text('Some things went wrong'),
                actions: [
                  ElevatedButton(
                      child:const  Text('OK'),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      })
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => reloadProduct(context),
        child: Consumer<ProductList>(
          builder: (context, value, child) {
            return ListView.builder(
              itemBuilder: (context, index) => AdminProductItem(
                id: value.getProducts[index].id,
                title: value.getProducts[index].title,
                price: value.getProducts[index].price,
                imageUrl: value.getProducts[index].imageUrl,
              ),
              itemCount: value.getProducts.length,
            );
          },
        ),
      ),
      drawer: const MainDrawer(),
    );
  }
}
