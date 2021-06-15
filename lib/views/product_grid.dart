import 'package:flutter/material.dart';
import 'package:state_management/controller/products_provider.dart';
import 'package:state_management/models/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

  // This widget Products Grid is listening to the change notifier class
  final productsData = Provider.of<Products_provider>(context);
  final products = productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (cntx, i) => ChangeNotifierProvider(
        create: (context)=> products[i],
        child: ProductItem(),
      ),
    );
  }
}
