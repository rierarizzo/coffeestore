import 'package:coffee_store/utils/userlogin.dart';

class LoginResponse {
  final UserLogin user;
  final String accessToken;

  LoginResponse({
    required this.user,
    required this.accessToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: UserLogin.fromJson(json['user']),
      accessToken: json['accessToken'],
    );
  }
}
