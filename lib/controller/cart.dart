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

  void removeItem(String productId){
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart(){
    _cartItems = {};
    notifyListeners();
  }

  double get sumTotal{
    double s = 0;
    for (var o in _cartItems.values){
      double price = o.price;
      int q = o.quantity;
      s += price*q;
    }
  return s;
  }

}
