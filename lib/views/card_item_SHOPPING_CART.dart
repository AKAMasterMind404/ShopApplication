import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/controller/cart.dart';

class CartSingleItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  CartSingleItem(
      {this.id, this.productId, this.price, this.quantity, this.title});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (d){
        return showDialog(
            context: context, 
            builder: (c){
              return AlertDialog(
                title: Text("Are you sure?"),
                content: Text("This will remove this item from the cart"),
                actions: [
                  TextButton(
                      onPressed: (){
                        Navigator.of(context).pop(true);
                      },
                      child: Text("Yes")
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.of(context).pop(false);
                      },
                      child: Text("No")
                  )
                ],
              );
            }
        );
      },
      key: ValueKey(id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      background: Container(
        child: Icon(Icons.delete, color: Colors.white),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        color: Theme.of(context).errorColor,
      ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
                child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(child: Text("\$${price.toStringAsFixed(2)}")),
            )),
            title: Text(title),
            subtitle: Text("Total: \$${(quantity * price).toStringAsFixed(2)}"),
            trailing: Text("$quantity x"),
          ),
        ),
      ),
    );
  }
}
