import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/controller/products_provider.dart';
import 'package:state_management/models/product.dart';

class ProductDetail extends StatelessWidget {
  final String title;

  ProductDetail({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pid = ModalRoute.of(context).settings.arguments as String;
    final Product productItemWithPid = Provider.of<Products_provider>(context)
        .items
        // firstWhere: A list method that returns the first value where a boolean expression
        // condition is met
        .firstWhere((element) => element.id == pid);
    return Scaffold(
      appBar: AppBar(
        title: Text(productItemWithPid.title),
      ),
    );
  }
}
