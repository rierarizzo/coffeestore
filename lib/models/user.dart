class User {
  int id;
  String completeName;
  String username;
  String phoneNumber;
  String email;
  String role;

  User({
    required this.id,
    required this.completeName,
    required this.username,
    required this.phoneNumber,
    required this.email,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      completeName: json['completeName'],
      username: json['username'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      role: json['role'],
    );
  }

}
