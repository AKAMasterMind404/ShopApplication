import 'dart:html';

import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final String title;

  ProductDetail({Key key,this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pid = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(pid),
      ),
    );
  }
}
