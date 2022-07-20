import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expiryDate;
  late String userId;

  Future<void> signup(String? email, String? password) async {
    final url = Uri.https(
      'identitytoolkit.googleapis.com',
      '/v1/accounts:signUp',
      {'key': 'AIzaSyDxKiRcl2WbAEoSO32V91x1cEH6w79qYIk'},
    );
    // const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDxKiRcl2WbAEoSO32V91x1cEH6w79qYIk';
    final res = await http.post(
      url,
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    print(json.decode(res.body));
  }
}


//https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDxKiRcl2WbAEoSO32V91x1cEH6w79qYIk
//https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]

//AIzaSyDxKiRcl2WbAEoSO32V91x1cEH6w79qYIk