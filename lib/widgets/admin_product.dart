import 'package:flutter/material.dart';
import '../screens/edit_product_screen.dart';
class AdminProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  const AdminProductItem({
    Key? key,
    required this.id,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        //title:Text(title),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.blue,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.remove_circle,
                color: Colors.blue,
              ),
            ),
          ],
        ));
  }
}
