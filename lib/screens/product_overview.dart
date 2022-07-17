import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../widgets/main_drawer.dart';
import '../widgets/productsgrid.dart';
import '../providers/cart.dart';
import '../widgets/badge.dart';
import '../screens/cart.dart';
import '../providers/products_provider.dart';
import '../providers/product.dart';
import '../providers/auth.dart';

enum FilterOptions {
  onlyFavorites,
  showAll,
}

class ProductOverview extends StatefulWidget {
  static const routeName = '/products';
  final String token;
  const ProductOverview({Key? key, required this.token}) : super(key: key);
  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  bool _showFavorite = false;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    final uri =
        'https://shop-c2818-default-rtdb.firebaseio.com/products.json?auth=${widget.token}';
    final url = Uri.parse(uri);
    http.get(url).then((response) {
      final body = json.decode(response.body);
      final statusCode = response.statusCode;
      if (statusCode == 200) {
        List<Product> _products = [];
        body.forEach((key, value) {
          _products.add(Product(
            id: key,
            title: value['title'],
            description: value['description'],
            price: double.parse(value['price']),
            imageUrl: value['imageUrl'],
            isFavourite: value['isFavourite'],
          ));
        });
        Provider.of<ProductList>(context, listen: false).addProducts(_products);
        setState(() {
          _isLoading = false;
        });
      } else {
        throw body;
      }
    }).catchError((error) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
          context: context,
          builder: (context) =>  AlertDialog(
                title: const Text('Some things went wrong'),
                actions: [
                  ElevatedButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        actions: [
          Consumer<Cart>(builder: (context, cart, child) {
            return Badge(
              value: '${cart.numberOfItemsInCart}',
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.red,
                ),
              ),
            );
          }),
          PopupMenuButton(
              onSelected: (FilterOptions selectedFilter) {
                if (selectedFilter == FilterOptions.onlyFavorites) {
                  setState(() => _showFavorite = true);
                } else {
                  setState(() => _showFavorite = false);
                }
              },
              itemBuilder: (context) => [
                    const PopupMenuItem(
                      child: Text(
                        'Only Favorites',
                      ),
                      value: FilterOptions.onlyFavorites,
                    ),
                    const PopupMenuItem(
                      child: Text(
                        'Show All',
                      ),
                      value: FilterOptions.showAll,
                    )
                  ]),
        ],
      ),
      drawer: const MainDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductGrid(
              showFavorite: _showFavorite,
              token:widget.token
            ),
    );
  }
}
