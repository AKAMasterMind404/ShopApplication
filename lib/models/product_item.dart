import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/cart.dart';
import 'product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final p = Provider.of<Product>(context);
    final c = Provider.of<Cart>(context);

    String id = p.id;
    String title = p.title;
    String imageUrl = p.imageUrl;
    bool isFav = p.isFavorite;

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
                isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                color: Theme.of(context).accentColor),
          ),
          trailing: IconButton(
            onPressed: () {
              c.addItem(
                pid: p.id,
                price: p.price,
                title: p.title,
              );
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text("Added item to the cart!"),
                      duration: Duration(seconds: 2),
                      action: SnackBarAction(
                        label: "Undo",
                        onPressed: (){
                          c.removeSingleItem(p.id);
                        },
                      ),
                  )
              );
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
