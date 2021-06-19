import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/controller/products_provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem({this.id, this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed('edit_product', arguments: id);
                },
                icon: Icon(Icons.edit, color: Theme.of(context).primaryColor)),

            // DELETE
            Consumer<Products_provider>(
              builder: (c, p, _) {
                return IconButton(
                    onPressed: () {
                      p.deleteProduct(id);
                    },
                    icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor
                    )
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
