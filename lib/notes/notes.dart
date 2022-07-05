// List Methods are following :-

// 1. Map
// List list=[1,2,3,4];
//   List even=list.map((item)=>item*2).toList();
//   print(even);
// output -> [2, 4, 6, 8]

// 2. Filter
// List list=[1,2,3,4];
//   List even=list.where((item)=>item%2==0).toList();
//   print(even);
// output -> [2, 4]

// 3. find
// List list=[1,2,3,4];
//   var even=list.firstWhere((item)=>item%2==0);
//   print(even);
// output -> 2

// 4. removing unwanted item from list -> list.removeWhere((item)=>item["id"]!=="34")
// 5. reversing a list -> List.reversed
// 6. is list empty -> List.isEmpty->bool
// 7. contains

// List list=[1,2,3,4];
//   var isContain=list.contains(2);
//   print(isContain);
// output - > true

// 8. finding index where test pass
// List list=[1,2,3,4];
//   int index=list.indexWhere((element) => element==2 );
//   print(index);
// output -> 1

// 9. removing item at given index
// List list=[1,2,3,4];
//   int index=list.indexWhere((element) => element==2 );
//   print(index);
//   list.removeAt(index);
//   print(list);

// 10 . any element of list pass test
//  List list=[1,2,3];
//   var ans=list.any((element) => element==2 );
//   print(ans);

// Map methods are following
Map map = {
  "name": "Abhishek Singh",
  "age": "22",
};
// 1.  map.containsKey('name')->bool
//print(map.containsKey('name'));

// 2.  map.update(key,(oldValue){ retun newValue});
// map.update('age',(oldValue){
//   print(oldValue);
//   return 23;
// });
// print(map);

// 3. putIfAbsent
// map.putIfAbsent('school',(){
//     return "DMA";
//   });
//   print(map);

//4. remove(key)
// map.remove('school');

// Navigation in Flutter
// 1 . From one screen to another screen with payload :-)

// -> Navigator.of(context).pushNamed(route,arguments:{});
// receiving payload on otherScreen ->
// final Map<String, String> routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, String>;

// 2. removing top screen from stack -> Navigator.of(context).pop();

// Making drawer and setting navigation -> 

// class MainDrawer extends StatelessWidget {
//   const MainDrawer({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: [
//           const SizedBox(height: 30,),
//           ListTile(
//             leading:const Icon(Icons.shop),
//             title: const Text('Home'),
//             onTap: () {
// =========> important-----> Navigator.of(context).pushReplacementNamed( ProductOverview.routeName);
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.shop_2_outlined),
//             title:const Text('Orders'),
//             onTap: () {
//               Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.edit),
//             title:const Text('Edit Product'),
//             onTap: () {
//               Navigator.of(context).pushReplacementNamed(EditOrDeleteProduct.routeName);
//             },
//           )
//         ],
//       ),
//     );
//   }
// }

// provvider 

// making provider class 
// -> ChangeNotifier (Mixin),notifyListeners();

// import 'package:flutter/material.dart';
// import './product.dart';
// import '../dummay_data/dummayData.dart';

// class ProductList with ChangeNotifier {
//   final List<Product> _productList = [...dummyProduct];

//   List<Product> get getProducts {
//     return [..._productList];
//   }

//   List<Product> get getFavoriteProducts {
//     return _productList
//         .where((element) => element.isFavourite == true)
//         .toList();
//   }

//   Product getProduct(String id) {
//     return _productList.firstWhere((element) => element.id == id);
//   }

//   void add(data) {
//     _productList.add(Product(
//       id: data['price'],
//       title: data['title'],
//       description: data['description'],
//       price: double.parse(data['price']),
//       imageUrl: data['image'],
//     ));
//     notifyListeners(); // it will call all the registered listeners
//   }

//   void deleteProduct(id) {
//     _productList.removeWhere((element) => element.id == id);
//     notifyListeners();
//   }
// }

// using provider class 

// 1. ChangeNotifierProvider :-

// ChangeNotifierProvider<ClassNameOfTheProviderClassWhichYouWantToUse>(
//       create: (context) {
//         return ObjectOfThatClassWhichProviderYouWantToUse();
//       },
//       child: ScreenWichWantToUseTheProviderClass,
//     );

// 2. MultiProvider

// MultiProvider(
//       providers: [
//         ChangeNotifierProvider<ProductList>(
//           create: (context) => ProductList(),
//         ),
//         ChangeNotifierProvider<Cart>(
//           create: (context) => Cart(),
//         ),
//         ChangeNotifierProvider<Order>(
//           create: (context) => Order(),
//         ),
//       ],
//       child: MaterialApp()
// );


// Listner ->

// 1 ->   Cart cartProvider = Provider.of<Cart>(context, listen: true);
// 2 ->   Consumer :-
// Consumer<Cart>(builder: (context, cart, child) {
//             return Badge(
//               value: '${cart.numberOfItemsInCart}',
//               child: IconButton(
//                 onPressed: () {
//                   Navigator.of(context).pushNamed(CartScreen.routeName);
//                 },
//                 icon: const Icon(
//                   Icons.shopping_cart,
//                   color: Colors.red,
//                 ),
//               ),
//             );
//           }),

// Input Form :-
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

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

  Map data = {"title": "", "description": "", "image": "", "price": ""};
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

  late ProductList productsProvider;
  void submitForm() {
    final isFormValid = _formKey.currentState!.validate();
    if (!isFormValid) {
      return;
    }
    _formKey.currentState?.save();
    productsProvider.add(data);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    productsProvider = Provider.of<ProductList>(context, listen: false);
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
                  data.update('title', (oldValue) => value);
                },
              ),
              TextFormField(
                initialValue: '100',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                    labelText: 'Price', hintText: 'Enter price of product'),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  data.update('price', (oldValue) => value);
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
                  data.update('description', (oldValue) => value);
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
                      data.update('image', (oldValue) => value);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Image URL is required';
                      }

                      if (!value.startsWith('https://') &&
                          !value.startsWith('http://')) {
                        return 'Please enter valid image URL';
                      }
                      if (!value.endsWith('.png') &&
                          !value.endsWith('.jpg') &&
                          !value.endsWith('.jpeg')) {
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

// API calling 
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// Future<void> add(data) {
//     final url = Uri.parse(
//         'https://shop-c2818-default-rtdb.firebaseio.com/products');
//     return http
//         .post(
//       url,
//       body: json.encode({
//         'title': data['title'],
//         'description': data['description'],
//         'price': data['price'],
//         'imageUrl': data['image'],
//         'isFavourite': false,
//       }),
//     )
//     .then((response) {
//       // print('Response status: ${response.statusCode}');
//       // print('Response body: ${response.body}');
//       final body = json.decode(response.body);
//       _productList.add(Product(
//         id: body['name'],
//         title: data['title'],
//         description: data['description'],
//         price: double.parse(data['price']),
//         imageUrl: data['image'],
//       ));
//       notifyListeners(); // it will call all the registered listeners
//     }).catchError((error) {
//       throw error;
//     });
//   }

// Handlling API calling response in widget
// productsProvider.add(data).catchError((error) {
//       return showDialog<Null>(
//         context:context,
//         builder: (ctx) =>  AlertDialog(
//           title:const Text('Error'),
//           content: const Text('Some things went wrong'),
//           actions: [
//             ElevatedButton(
//               child: const Text('OKAY'), 
//               onPressed: () {
//                 Navigator.of(ctx).pop();
//               }
//             )
//           ],
//           )
//       );
//     }).then((value) {
//       setState(() {
//         _loading = false;
//       });
//       Navigator.of(context).pop();
//     })