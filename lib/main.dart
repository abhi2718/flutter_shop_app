import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/product_overview.dart';
import './screens/product_detail.dart';
import './screens/cart.dart';
import './screens/order.dart';
import './providers/products_provider.dart';
import './providers/cart.dart';
import './providers/order.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ProductList>(
            create: (context) => ProductList(),
            ),
          ChangeNotifierProvider<Cart>(
            create: (context) =>  Cart(),
            ),
          ChangeNotifierProvider<Order>(
            create: (context) => Order(),
            ),
        ],
        child: MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                  .copyWith(secondary: Colors.deepOrange),
              fontFamily: 'Lato',
            ),
            initialRoute: '/',
            routes: {
              ProductOverview.routeName: (context) => const ProductOverview(),
              ProductDetail.routeName: (context) => const ProductDetail(),
              CartScreen.routeName: (context) => const CartScreen(),
              OrderScreen.routeName: (context) =>  const OrderScreen(),
            }));
  }
}
