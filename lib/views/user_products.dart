import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/controller/products_provider.dart';
import 'package:state_management/views/app_drawer.dart';
import 'package:state_management/views/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products_provider>(context);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('edit_product');
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (context, i) {
              return Column(
                children: [
                  UserProductItem(
                    id: productsData.items[i].id,
                    title: productsData.items[i].title,
                    imageUrl: productsData.items[i].imageUrl,
                  ),
                  Divider()
                ],
              );
            }),
      ),
    );
  }
}
