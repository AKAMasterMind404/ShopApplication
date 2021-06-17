import 'dart:math';
import 'package:flutter/material.dart';
import 'package:state_management/controller/orders.dart';
import 'package:intl/intl.dart';

class OrderItemSingle extends StatefulWidget {
  final OrderItem order;

  const OrderItemSingle(this.order);

  @override
  _OrderItemSingleState createState() => _OrderItemSingleState();
}

class _OrderItemSingleState extends State<OrderItemSingle> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text("\$${widget.order.amount.toStringAsFixed(2)}"),
            subtitle: Text(
                "\$${DateFormat("dd/MM/yyyy hh:mm").format(widget.order.dateTime)}"),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  expanded = !expanded;
                });
              },
            ),
          ),
          expanded
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  height: min(
                      (widget.order.products.length * 20 + 10).toDouble(),
                      180),
                  child: ListView.builder(
                    itemCount: widget.order.products.length,
                    itemBuilder: (context,i)=>widget.order.products.map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e.title,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "${e.quantity}x  \$${e.price}",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey
                            ),
                          )
                        ],
                      ),
                    )).toList()[i],
                  )
              )
              : SizedBox()
        ],
      ),
    );
  }
}
