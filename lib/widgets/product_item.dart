import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/product_detail.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Product product = Provider.of<Product>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetail.routeName,
                arguments: {"id": product.id});
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.fill,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            onPressed: () {
              product.toggleFavourite();
            },
            icon: Consumer<Product>(
              builder: (ctx, product, child) => Icon(
              product.isFavourite ? Icons.favorite : Icons.favorite_border_outlined,
              color: Theme.of(context).colorScheme.secondary,
            ),
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}

// Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (ctx)=> const ProductDetail()
//                 )
//               );
