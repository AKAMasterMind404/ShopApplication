import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/controller/orders.dart';
import 'package:state_management/models/order_item.dart';
import 'package:state_management/views/app_drawer.dart';

class OrdersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Your Orders")),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: orderData.orders.toList().length,
          itemBuilder: (context,i){
            return OrderItemSingle(orderData.orders.toList()[i]);
          }),
    );
  }
}
