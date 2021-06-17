import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/controller/cart.dart';
import 'package:state_management/models/badge.dart';
import 'package:state_management/views/product_grid.dart';

enum FilterOptions { FAVORITES, ALL }

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  bool _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    // int l = Provider.of<Cart>(context).cartItems.length;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("My Shop"),
              actions: [
                PopupMenuButton(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (FilterOptions f) {
                    setState(() {
                      if (f == FilterOptions.FAVORITES) {
                        _showOnlyFavorites = true;
                      } else {
                        _showOnlyFavorites = false;
                      }
                    });
                  },
                  itemBuilder: (c) => [
                    const PopupMenuItem(
                        child: const Text("Only Favorites"),
                        value: FilterOptions.FAVORITES),
                    const PopupMenuItem(
                        child: const Text("Show All"),
                        value: FilterOptions.ALL),
                  ],
                ),
                Consumer<Cart>(
                  builder:(c,cartObj,iconButton)=> Badge(
                      child: iconButton,
                      value: cartObj.cartItems.length.toString()),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.shopping_cart),
                  ),
                )
              ],
            ),
            body: ProductsGrid(_showOnlyFavorites)));
  }
}
