import 'package:flutter/material.dart';
import 'package:state_management/models/product.dart';

class Products_provider with ChangeNotifier{
    List <Product> _items = [

    ];

    // to return a copy of private list _items
    List <Product> get items{
      return [..._items];
    }

    void addProduct(){
      addListener(() { });
    }
}