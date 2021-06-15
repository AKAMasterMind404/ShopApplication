import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/models/product.dart';

class ProductItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<Product>(context);
    final imageUrl = p.imageUrl;
    final title = p.title;
    final id = p.id;
    final currFav = p.isFavorite;

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
            onPressed: () {
              p.toggleFavoriteStatus();
            },
            icon: Icon(
                currFav?Icons.favorite_rounded:
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
