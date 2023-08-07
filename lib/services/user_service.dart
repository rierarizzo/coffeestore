import 'dart:convert';

import 'package:coffee_store/models/user.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService{
  final client = Client();
  final uri = "http://localhost:8080";

  Future<User> getProfileById(int idProfile) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('accessToken') ?? ''; // Obtener el token de SharedPreferences, si no hay, usar una cadena vacía

  final response = await client.get(
    Uri.parse("$uri/users/find/$idProfile"),
    headers: {'Authorization': '$accessToken'}, // Agregar el token al encabezado Authorization
  );

  // Status OK
  if (response.statusCode == 200) {
    final Map<String, dynamic> responseBody = json.decode(response.body);

    User userData = User.fromJson(responseBody["body"]); // Utilizar el constructor fromJson para crear el objeto User

    return userData;
  } else {
    throw Exception('Failed to load user profile');
  }
}



  Future<bool> updateProfile(User userToUpdate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken') ?? '';

    final response = await client.put(
      Uri.parse("$uri/users/update/${userToUpdate.id}"),
      headers: {
        'Authorization': '$accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "username": userToUpdate.username,
        "name": userToUpdate.completeName.split(' ').take(2).join(' '),
        "surname":  userToUpdate.completeName.split(' ').skip(2).join(' '),
        "phone": userToUpdate.phoneNumber,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update user profile');
    }
  }





}