import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order.dart';
import '../widgets/main_drawer.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Order orderProvider = Provider.of<Order>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer:const MainDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return ListTile(
              tileColor: Colors.white,
              style: ListTileStyle.drawer,
              leading: Text(orderProvider.allOrders[index].id.substring(0, 9)),
              title: Text(
                'qty : ${orderProvider.allOrders[index].items.length}',
                textAlign: TextAlign.center,
              ),
              trailing:
                  Text('₹ ${orderProvider.allOrders[index].totalAmount}'));
        },
        itemCount: orderProvider.allOrders.length,
      ),
    );
  }
}
