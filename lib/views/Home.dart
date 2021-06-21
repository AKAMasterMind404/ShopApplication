import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/controller/cart.dart';
import 'package:state_management/controller/products_provider.dart';
import 'package:state_management/models/badge.dart';
import 'package:state_management/views/app_drawer.dart';
import 'package:state_management/views/product_grid.dart';

enum FilterOptions { FAVORITES, ALL }

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  bool _showOnlyFavorites = false;
  bool _isLoading = false;

  Future<void> loadData() async {
    await Provider.of<Products_provider>(context,listen: false).fetchAndSetProducts();
  }

  @override
  void initState() {
    // _isLoading = true;
    // setState(() {
    //   _isLoading = false;
    // });
    loadData();
    super.initState();
  }

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
                  child: const Text("Show All"), value: FilterOptions.ALL),
            ],
          ),
          Consumer<Cart>(
            builder: (c, cartObj, iconButton) => Badge(
                child: iconButton, value: cartObj.cartItems.length.toString()),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "cartScreen");
              },
              icon: Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ProductsGrid(_showOnlyFavorites),
      drawer: AppDrawer(),
    ));
  }
}
