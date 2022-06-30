import 'dart:ffi';

import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit_product_screen';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _titleFocusNode = FocusNode();
  @override
  void dispose(){
    super.dispose();
    _titleFocusNode.dispose();
  }
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_titleFocusNode);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product '),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            child: ListView(children: [
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Title', hintText: 'Enter title of product'),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                focusNode: _titleFocusNode,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Price', hintText: 'Enter price of product'),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction
                    .next, // it will show the next button in keyboard
              ),
              TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Descripation',
                      hintText: 'Enter Descripation of product'),
                  keyboardType:
                      TextInputType.multiline, // when we need multiline input
                  maxLines: 3,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (text) {
                    FocusScope.of(context).requestFocus(_titleFocusNode);
                  })
            ]),
          )),
    );
  }
}
