import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/product_overview.dart';
import './screens/product_detail.dart';
import './screens/cart.dart';
import './screens/order.dart';
import './providers/products_provider.dart';
import './providers/cart.dart';
import './providers/order.dart';
import './screens/admin.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './providers/auth.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider<ProductList>(
          create: (context) => ProductList(),
        ),
        ChangeNotifierProvider<Cart>(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider<Order>(
          create: (context) => Order(),
        ),
      ],
      child: Consumer<Auth>(builder: ((context, auth, child) {
        return MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                .copyWith(secondary: Colors.deepOrange),
            fontFamily: 'Lato',
          ),
          home:auth.isAuth?  ProductOverview(token: auth.dbSecret):const AuthScreen(),
          routes: {
            ProductOverview.routeName: (context) =>  ProductOverview(token: auth.dbSecret),
            ProductDetail.routeName: (context) => const ProductDetail(),
            CartScreen.routeName: (context) =>  CartScreen(token: auth.dbSecret),
            OrderScreen.routeName: (context) =>  OrderScreen(token: auth.dbSecret),
            EditOrDeleteProduct.routeName: (context) =>
                EditOrDeleteProduct(token: auth.dbSecret),
            EditProductScreen.routeName: (context) =>  EditProductScreen(token: auth.dbSecret)
          },
        );
      })),
    );
  }
}
