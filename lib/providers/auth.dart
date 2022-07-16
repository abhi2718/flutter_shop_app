import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception_handler.dart';

class Auth with ChangeNotifier {
  String _token = '';
  String _userId = '';
  late DateTime _tokenExpiryDate;
  bool get isAuth {
    return token != null;
  }

  get token {
    if (_token != '') {
      return _token;
    }
    return null;
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
}
