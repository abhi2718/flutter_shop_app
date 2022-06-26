import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/main_drawer.dart';
import '../widgets/productsgrid.dart';
import '../providers/cart.dart';
import '../widgets/badge.dart';
import '../screens/cart.dart';


enum FilterOptions {
  onlyFavorites,
  showAll,
}

class ProductOverview extends StatefulWidget {
  static const routeName = '/';
  const ProductOverview({Key? key}) : super(key: key);

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  bool _showFavorite = false;
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
      drawer:const MainDrawer(),
      body: ProductGrid(
        showFavorite: _showFavorite,
      ),
    );
  }
}
