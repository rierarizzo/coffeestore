import 'dart:convert';
import 'package:http/http.dart';
import 'package:loggy/loggy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/generalresponse.dart';
import '../utils/loginresponse.dart';

class AuthService {
  final client = Client();
  final uri = "http://localhost:8080";

  Future<bool> signIn(String email, String password) async {
    final params = {"email": email, "password": password};

    final body = jsonEncode(params);

    final response =
        await client.post(Uri.parse("$uri/auth/signin"), body: body);

    // Status OK
    if (response.statusCode == 200) {

      final responseJson = json.decode(response.body);
      String accessToken = responseJson['body']['accessToken'];
      String idUser = (responseJson['body']['user']['id']).toString();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('accessToken', accessToken);
      prefs.setString('idUser', idUser);

      
      logDebug(response.body);
      return true;
    } else {
      logError(response.statusCode);
      return false;
    }
  }

  Future<bool> signUp(String username, String name, String surname,
      String phone, String email, String password) async {
    final json = {
      "username": username,
      "name": name,
      "surname": surname,
      "phone": phone,
      "email": email,
      "password": password,
      "role": "A"
    };

    final body = jsonEncode(json);

    final response =
        await client.post(Uri.parse("$uri/auth/signup"), body: body);

    // Status created
    if (response.statusCode == 201) {
      logDebug(response.body);
      return true;
    } else {
      logError(response.statusCode);
      return false;
    }
  }

   Future<bool> hasToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('accessToken');
  }
}
