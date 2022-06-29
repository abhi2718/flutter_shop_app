import 'package:flutter/material.dart';
import '../screens/order.dart';
import '../screens/product_overview.dart';
import '../screens/admin.dart';
class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const SizedBox(height: 30,),
          ListTile(
            leading:const Icon(Icons.shop),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed( ProductOverview.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.shop_2_outlined),
            title:const Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title:const Text('Edit Product'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(EditOrDeleteProduct.routeName);
            },
          )
        ],
      ),
    );
  }
}
