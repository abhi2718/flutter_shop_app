// ignore_for_file: avoid_print

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
  final _imageController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  void setImage() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _imageFocusNode.addListener(setImage);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _titleFocusNode.dispose();
    _imageController.dispose();
    _imageFocusNode.removeListener(setImage);
  }

  void submitForm() {
    _formKey.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_titleFocusNode);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product '),
        actions: [
          IconButton(
              onPressed: () {
                submitForm();
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(children: [
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Title', hintText: 'Enter title of product'),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                focusNode: _titleFocusNode,
                onSaved: (value) {
                  print(value);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Price', hintText: 'Enter price of product'),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  print(value);
                },
                // it will show the next button in keyboard
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
                },
                onSaved: (value) {
                  print(value);
                },
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: _imageController.text.isNotEmpty
                        ? Image.network(
                            _imageController.text,
                            fit: BoxFit.fill,
                          )
                        : const Text('Image URL')),
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Image Url',
                      hintText: 'Image URL',
                    ),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageController,
                    focusNode: _imageFocusNode,
                    onFieldSubmitted: (_) {
                      submitForm();
                    },
                    onSaved: (value) {
                      print(value);
                    },
                  ),
                )
              ])
            ]),
          )),
    );
  }
}
