import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/models/product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Products_provider with ChangeNotifier {
  static const url = "cloud-projects-8ea6a-default-rtdb.firebaseio.com";
  static const String httpsHeader = "https://";
  static const String productsPath = "/products";
  static const String jsonExt = ".json";

  Map<String, int> isLoaded = {};

  List<Product> _items = [
    // Product(
    //   id: 'McjF_A6Yh0njX1i2dbU',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //   'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'McjFrCnmhrjbbw28rS9',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //   'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'McjGBJ6r9nTbTII5br3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //   'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'McjGPRrO56EMRV4qgkw',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //   'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];
  final String token;
  final String userId;

  Products_provider(this.token, this._items,this.userId);

  // to return a copy of private list _items
  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  /// GETTER
  Future<void> fetchAndSetProducts() async {
    try {
      final response = await http.get(Uri.parse(
          httpsHeader + url + productsPath + jsonExt + "?auth=" + token));
      Map<String, dynamic> data =
          json.decode(response.body) as Map<String, dynamic>;

      if(data==null){return;}
      final favResponse = Uri.parse(httpsHeader +
          url +
          "userFavorites/"+
          "$userId/"+
          jsonExt +
          "?auth=$token");
      data.forEach((key, value) {
        if (!isLoaded.containsKey(key)) {
          isLoaded[key] = 1;
          _items.add(Product(
              id: key,
              title: value['title'],
              description: value['description'],
              price: value['price'],
              imageUrl: value['imageUrl'],
              isFavorite: value['isFavorite']));
        }
      });
      notifyListeners();
    } catch (e) {
      print(e.toString() + "hih");
      print("ERROR OCCURRED");
    }
  }

  /// SETTER
  Future<void> addProduct(Product product) async {
    var url2 = Uri.https(url, "/products.json");

    if (!isLoaded.containsKey(product.id)) {
      print("This ran");
      var response = await http.post(url2,
          body: json.encode({
            "title": product.title,
            "description": product.description,
            "imageUrl": product.imageUrl,
            "price": product.price,
            "isFavorite": product.isFavorite,
          }));
      _items.add(Product(
          title: product.title,
          description: product.description,
          imageUrl: product.imageUrl,
          price: product.price,
          id: DateTime.now().toString()));
      notifyListeners();
    }
    // var unique_id = jsonDecode(response.body)["name"];

    // Looks something like: {name: -McYzGK85hSpqrA0fDe5}, hence using ["name"]
  }

  Future<void> deleteProduct(String id) async {
    try {
      // print(httpsHeader + url + productsPath + "/$id" + jsonExt);
      // print(id);
      await http.delete(Uri.parse(httpsHeader +
          url +
          productsPath +
          "/$id" +
          jsonExt +
          "?auth=" +
          token));
      _items.removeWhere((element) => element.id == id);
      isLoaded.remove(id);
      notifyListeners();
    } catch (e) {
      print(e);
      print("Error in deletion!");
    }
  }

  Future<void> updateProduct(String id, Product newP) async {
    final pindex = _items.indexWhere((element) => element.id == id);
    try {
      await http.patch(
          Uri.parse(httpsHeader + url + productsPath + "/$id" + jsonExt),
          body: json.encode({
            "title": newP.title,
            "description": newP.description,
            "imageUrl": newP.imageUrl,
            "price": newP.price,
          }));
      _items[pindex] = newP;
    } catch (e) {
      print("patch request failed.");
    }
    if (pindex >= 0) {
      _items[pindex] = newP;
      notifyListeners();
    } else {
      print("...");
    }
  }
}
