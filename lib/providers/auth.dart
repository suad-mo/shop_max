import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expiryDate;
  late String userId;

  Future<void> _authenticate(
    String email,
    String password,
    String urlSegment,
  ) async {
    final url = Uri.https(
      'identitytoolkit.googleapis.com',
      urlSegment,
      {'key': keyFirebase},
    );
    try {
      final res = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final resData = json.decode(res.body);
      if (resData['error'] != null) {
        throw HttpException(resData['error']['message']);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, '/v1/accounts:signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, '/v1/accounts:signInWithPassword');
  }
}
