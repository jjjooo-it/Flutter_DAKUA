class User {
  String id;
  String username;
  String password;
  String country;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.country,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'country': country,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      country: map['country'],
    );
  }
}
