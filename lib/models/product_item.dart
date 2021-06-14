import 'package:flutter/material.dart';
import 'package:state_management/views/product_detail.dart';

class ProductItem extends StatelessWidget {
  String id;
  String title;
  String imageUrl;

  ProductItem({
    Key key,
    this.id,
    this.title,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('productDetail', arguments: id);
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(title, textAlign: TextAlign.center),
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
                Icons.favorite_border_rounded,
                color: Theme
                    .of(context)
                    .accentColor
            ),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart,
              color: Theme
                  .of(context)
                  .accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
