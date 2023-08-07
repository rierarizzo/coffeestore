class UserLogin {
  final int ?id;
  final String? username;
  final String? email;
  final String? role;

  UserLogin({
     this.id,
     this.username,
     this.email,
     this.role,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      role: json['role'],
    );
  }
}
