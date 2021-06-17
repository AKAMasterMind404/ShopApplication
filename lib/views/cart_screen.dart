import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/controller/cart.dart';
import 'package:state_management/controller/orders.dart';
import 'package:state_management/views/card_item_SHOPPING_CART.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart c = Provider.of<Cart>(context);
    double s = c.sumTotal;
    //Provider.of<Cart>(context).cartItems.length;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total  ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Chip(
                    label: Text(
                      "\$ ${s.toStringAsFixed(2)}",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false)
                          .addOrder(c.cartItems.values.toList(), c.sumTotal);
                      c.clearCart();
                    },
                    child: Text(
                      "ORDER NOW",
                      style: TextStyle(color: Colors.purpleAccent),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: c.cartItems.values.length,
                itemBuilder: (context, i) {
                  CartItem ci = c.cartItems.values.toList()[i];
                  return CartSingleItem(
                      id: ci.id,
                      productId: c.cartItems.keys.toList()[i],
                      title: ci.title,
                      quantity: ci.quantity,
                      price: ci.price);
                }),
          )
        ],
      ),
    ));
  }
}
