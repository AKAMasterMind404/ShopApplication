import 'package:flutter/material.dart';
import 'package:state_management/views/product_grid.dart';

class home extends StatefulWidget {
  const home({Key key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("My Shop")),
      body: ProductsGrid()
    ));
  }
}
