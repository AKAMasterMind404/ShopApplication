import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

const String mykey = "AIzaSyAHcwbd2ydssidu018WrvqT5vGfg7lQtwU";
const String signupurl =
    "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=";
const String signinurl =
    "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=";

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get userId=>_userId;

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    try {
      final url =
          "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=" +
              mykey;
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      if (jsonDecode(response.body)["error"] != null) {
        throw HttpException(jsonDecode(response.body)["error"]["message"]);
      }
      _token = jsonDecode(response.body)["idToken"];
      _userId = jsonDecode(response.body)["localId"];
      _expiryDate = DateTime.now().add(
          Duration(seconds: int.parse(jsonDecode(response.body)["expiresIn"])));
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }
}
