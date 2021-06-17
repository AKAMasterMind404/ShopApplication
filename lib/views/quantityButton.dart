import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/models/product.dart';
import 'package:state_management/models/product_item.dart';

class QuantityButton extends StatelessWidget {
  const QuantityButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Provider.of<Product>(context);
    int q = 0;
    return Container(
      child: Row(
        children: [
          Container(child: Icon(Icons.minimize_outlined)),
          Container(child: Text("$q"),),
          Container(child: Icon(Icons.add)),
        ],
      ),
    );
  }
}
