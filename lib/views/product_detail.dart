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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                height: 300,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12)),
                   child: Image.network(productItemWithPid.imageUrl,
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 10),
              Text("${productItemWithPid.price}",
                  style: TextStyle(color: Colors.grey, fontSize: 20)),
              SizedBox(height: 10),
              Center(
                child: Text("${productItemWithPid.description}",
                    style: TextStyle(fontSize: 20),
                    softWrap: true),
              )
            ],
          ),
        ));
  }
}
