import 'package:flutter/material.dart';
import 'package:state_management/controller/cart.dart';
import 'package:state_management/controller/products_provider.dart';
import 'package:state_management/views/Home.dart';
import 'package:state_management/views/product_detail.dart';
import 'package:provider/provider.dart';

void main() => runApp(Builder(builder: (BuildContext context) {
  return MultiProvider(
    // Every widget that listens to this provider will receive
    // an object of the Products_provider class
    providers: [
      ChangeNotifierProvider(create: (context)=>Products_provider()),
      ChangeNotifierProvider(create: (context)=>Cart()),
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
        '/':(context)=>home(),
        'productDetail':(context)=>ProductDetail(),
      },
    ),
  );

}));
