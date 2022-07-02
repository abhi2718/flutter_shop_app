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
    final isValidate = _formKey.currentState!.validate();
    if(isValidate){
         return;
    }
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                    labelText: 'Title', hintText: 'Enter title of product'),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                focusNode: _titleFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Titile is required';
                  }
                  if (value.length <= 4) {
                    return 'Titile must be at least 4 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  print(value);
                },
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                    labelText: 'Price', hintText: 'Enter price of product'),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  print(value);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Price is required';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Enter valid number';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Enter amount greater than zero';
                  }
                  return null;
                },
                // it will show the next button in keyboard
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Descripation is required';
                  }

                  if (value.length <= 10) {
                    return 'descripation  must be at least 10 characters';
                  }
                  return null;
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Image URL is required';
                      }

                      if (!value.startsWith('https://') &&
                          !value.startsWith('http://')) {
                        return 'Please enter valid image URL';
                      }
                      if(!value.endsWith('.png')&&!value.endsWith('.jpg')&&!value.endsWith('.jpeg')){
                        return 'Please enter valid image URL';
                      }
                      return null;
                    },
                  ),
                )
              ])
            ]),
          )),
    );
  }
}
