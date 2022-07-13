import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order.dart';
import '../widgets/main_drawer.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/order';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late Future _ordersFuture;
  Future _obtainOrderFuture(){
    return Provider.of<Order>(context, listen: false).fetchAndAddOrders();
  }
  @override 
  void initState() {
    _ordersFuture=_obtainOrderFuture();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const MainDrawer(),
      body: FutureBuilder(
          future:_ordersFuture,
          builder: (ctx, dataSnapShot) {
            if (dataSnapShot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (dataSnapShot.error != null) {
              return const Center(child: Text('Some things went wrong'));
            } else {
              return Consumer<Order>(builder: (ctx, order, child) {
                return ListView.builder(
                  itemBuilder: (ctx, index) {
                    return ListTile(
                        tileColor: Colors.white,
                        style: ListTileStyle.drawer,
                        leading:
                            Text(order.allOrders[index].id.substring(0, 9)),
                        title: Text(
                          'qty : ${order.allOrders[index].items.length}',
                          textAlign: TextAlign.center,
                        ),
                        trailing:
                            Text('₹ ${order.allOrders[index].totalAmount}'));
                  },
                  itemCount: order.allOrders.length,
                );
              });
            }
          }),
    );
  }
}
