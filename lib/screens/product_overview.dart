import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/productsgrid.dart';
import '../providers/cart.dart';
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
          const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.red,
            ),
          ),
          Consumer<Cart>(builder: (context, cart, child) {
            return Text('${cart.numberOfItemsInCart}');
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
      body: ProductGrid(
        showFavorite: _showFavorite,
      ),
    );
  }
}
