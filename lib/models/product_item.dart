import 'dart:html';

import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  String id;
  String title;
  String imageUrl;

  ProductItem({Key key, this.id, this.title, this.imageUrl,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        title: Text(title, textAlign: TextAlign.center),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite_border_rounded, color: Colors.pinkAccent),
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(Icons.shopping_cart),
        ),
      ),
    );
  }
}
