import 'package:flutter/material.dart';
import 'package:state_management/controller/cart.dart';
import 'package:state_management/controller/orders.dart';
import 'package:state_management/controller/products_provider.dart';
import 'package:state_management/models/edit_product_screen.dart';
import 'package:state_management/views/Home.dart';
import 'package:state_management/views/cart_screen.dart';
import 'package:state_management/views/orders_screen.dart';
import 'package:state_management/views/product_detail.dart';
import 'package:provider/provider.dart';
import 'package:state_management/views/user_products.dart';

const url = "cloud-projects-8ea6a-default-rtdb.firebaseio.com";
const String httpsHeader = "https://";
const String productsPath = "/products";
const String ordersPath = "/orders";
const String jsonExt = ".json";

void main() => runApp(Builder(builder: (BuildContext context) {
      return MultiProvider(
        // Every widget that listens to this provider will receive
        // an object of the Products_provider class
        providers: [
          ChangeNotifierProvider(create: (context) => Products_provider()),
          ChangeNotifierProvider(create: (context) => Cart()),
          ChangeNotifierProvider(create: (context) => Orders()),
        ],
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => home(),
            'productDetail': (context) => ProductDetail(),
            'cartScreen': (context) => CartScreen(),
            'orders': (context) => OrdersScreen(),
            'userProducts': (context) => UserProductsScreen(),
            'edit_product': (context) => EditProductScreen(),
          },
        ),
      );
    })
);
