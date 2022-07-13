import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/order.dart';
import '../screens/order.dart';

 class CartScreen extends StatefulWidget {
   static const routeName = '/cart';
   const CartScreen({ Key? key }) : super(key: key);
   @override
   State<CartScreen> createState() => _CartScreenState();
 }
 
 class _CartScreenState extends State<CartScreen> {
   bool _loading = false;
   @override
  Widget build(BuildContext context) {
    Cart cartProvider = Provider.of<Cart>(context, listen: true);
    Order orderProvider = Provider.of<Order>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
        ),
        body: Column(children: [
          Container(
            margin: const EdgeInsets.all(16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total'),
                    Chip(label: Text('₹ ${cartProvider.totalAmount}')),
                    _loading?const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(
                      strokeWidth:2,
                    )):
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _loading=true;
                        });
                        try {
                          await orderProvider.addOrderItem(
                              DateTime.now().toString(),
                              cartProvider.totalAmount,
                              cartProvider.getItemsInCart.values.toList());
                          setState(() {
                           _loading=false;
                          });
                          cartProvider.clearCart();
                          Navigator.of(context)
                              .pushNamed(OrderScreen.routeName);
                        } catch (error) {
                           setState(() {
                           _loading=false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Some things went wrong'),
                            ),
                            );
                        }
                      },
                      child: const Text('Order Now'),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => Dismissible(
                  direction: DismissDirection.horizontal,
                  key: ValueKey(
                      cartProvider.getItemsInCart.values.toList()[index].id),
                  confirmDismiss: (dismissDirection) {
                    return showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Are you sure ?"),
                        content:
                            const Text("Do you want to remove item from cart"),
                        actions: [
                          ElevatedButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                                cartProvider.removeItemFromCart(cartProvider
                                    .getItemsInCart.values
                                    .toList()[index]
                                    .id);
                              }),
                          ElevatedButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              }),
                        ],
                      ),
                    );
                  },
                  background: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      tileColor: Colors.white,
                      leading: CircleAvatar(
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: FittedBox(
                            child: Text(
                                '${cartProvider.getItemsInCart.values.toList()[index].price}'),
                          ),
                        ),
                      ),
                      title: Text(cartProvider.getItemsInCart.values
                          .toList()[index]
                          .title),
                      subtitle: Text(
                          '₹ ${cartProvider.getItemsInCart.values.toList()[index].price * cartProvider.getItemsInCart.values.toList()[index].quantity}'),
                      trailing: Text(
                          '${cartProvider.getItemsInCart.values.toList()[index].quantity} X'),
                    ),
                  )),
              itemCount: cartProvider.numberOfItemsInCart,
            ),
          ),
        ]));
  }
 }

