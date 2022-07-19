import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/http_exception_handler.dart';

class Auth with ChangeNotifier {
  String _token = '';
  String _userId = '';
  var _timer;
  final dbSecret = 'IlPXOMwksfCOYJ8Xle5W90JG2xSEeQwswJr2Ccr4';
  bool get isAuth {
    return token != null;
  }

  get token {
    if (_token != '') {
      return _token;
    }
    return null;
  }

  setDataInLocalStorage(key, data) async {
    final parseData = json.encode(data);
    final localStorage = await SharedPreferences.getInstance();
    localStorage.setString(key, parseData);
  }

  signup(String? email, String? password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAighiAgiJtgvIfJ9yawEpOenr3wHE2pMg');
    try {
      final response = await http.post(
        url,
        body: json.encode({'email': email, 'password': password}),
      );
      final body = json.decode(response.body);
      final statusCode = response.statusCode;
      if (statusCode == 200) {
        _userId = body['localId'];
        _token = body['idToken'];
        setDataInLocalStorage('userData', {
          "userId": body['localId'],
          "token": body['idToken'],
        });
        notifyListeners();
      } else {
        if (body.containsKey('error')) {
          throw HttpException(body['error']['message']);
        } else {
          throw HttpException('Some things went wrong !');
        }
      }
    } catch (error) {
      rethrow;
    }
  }

  signin(String? email, String? password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAighiAgiJtgvIfJ9yawEpOenr3wHE2pMg');
    try {
      final response = await http.post(
        url,
        body: json.encode({'email': email, 'password': password}),
      );
      final body = json.decode(response.body);
      final statusCode = response.statusCode;
      if (statusCode == 200) {
        _userId = body['localId'];
        _token = body['idToken'];
        setDataInLocalStorage('userData', {
          "userId": body['localId'],
          "token": body['idToken'],
        });
        // autoLogout();
        notifyListeners();
      } else {
        if (body.containsKey('error')) {
          throw HttpException(body['error']['message']);
        } else {
          throw HttpException('Some things went wrong !');
        }
      }
    } catch (error) {
      rethrow;
    }
  }

  void logout() async {
    _token = '';
    _userId = '';
    final localStorage = await SharedPreferences.getInstance();
    localStorage.clear();
    notifyListeners();
  }

  void autoLogout() {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(const Duration(seconds: 3), logout);
  }
}
