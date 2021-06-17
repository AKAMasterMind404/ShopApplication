import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem {
  final String id;
  final String title;
  int quantity;
  double price;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

  void addItem({String pid, double price, String title}) {
    if (_cartItems.containsKey(pid)) {
      _cartItems[pid].quantity+=1;
      // _cartItems.update(
      //     pid,
      //     (value) => CartItem(
      //         id: value.id,
      //         title: value.title,
      //         quantity: value.quantity+1,
      //         price: value.price
      //     )
      // );
    }
    else {
      _cartItems.putIfAbsent(
          pid,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price)
      );
      // print("Absent");
    }
    notifyListeners();
  }
}
