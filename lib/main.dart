import 'package:flutter/material.dart';
import './screens/product_overview.dart';
void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
       theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(secondary: Colors.deepOrange),
        fontFamily: 'Lato',
      ),
      home: const ProductOverview(),
    );
  }
}
