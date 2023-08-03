import 'dart:convert';

import 'package:http/http.dart';
import 'package:loggy/loggy.dart';

class AuthService {
  final client = Client();
  final uri = "http://localhost:8080";

  Future<bool> signIn(String email, String password) async {
    final json = {"email": email, "password": password};

    final body = jsonEncode(json);

    final response =
        await client.post(Uri.parse("$uri/auth/signin"), body: body);

    if (response.statusCode == 200) {
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
      "Username": username,
      "name": name,
      "surname": surname,
      "phone": phone,
      "password": password,
    };

    final body = jsonEncode(json);

    final response =
        await client.post(Uri.parse("$uri/auth/signin"), body: body);

    if (response.statusCode == 200) {
      logDebug(response.body);
      return true;
    } else {
      logError(response.statusCode);
      return false;
    }
  }
}
