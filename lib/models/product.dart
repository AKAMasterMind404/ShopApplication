import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const url = "cloud-projects-8ea6a-default-rtdb.firebaseio.com/";
const String httpsHeader = "https://";
const String productsPath = "/products";
const String jsonExt = ".json";

class Product with ChangeNotifier {
  String id;
  String title;
  String description;
  double price;
  String imageUrl;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      await http.put(
          Uri.parse(httpsHeader +
              url +
              "userFavorites/"+
              "$userId/"+
              "${this.id}" +
              jsonExt +
              "?auth=$token"),
          body: jsonEncode(!isFavorite));
      notifyListeners();
    } catch (e) {
      isFavorite = oldStatus;
      print(e.toString());
      print("Favorite status change did'nt succeed!");
    }
  }
}
