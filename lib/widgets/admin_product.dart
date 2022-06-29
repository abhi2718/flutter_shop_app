import 'package:flutter/material.dart';

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
    return Container(
      child: ListTile(
        leading:CircleAvatar(
          backgroundImage:NetworkImage(imageUrl) ,
          ),
          //title:Text(title),
          title: Container(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text(title),
            IconButton(onPressed: (){},icon: const Icon(Icons.edit,color: Colors.blue,),),
            IconButton(onPressed: (){},icon: const Icon(Icons.remove_circle,color: Colors.blue,),),
          ],),)
      ),
    );
  }
}
