class User {
  String id;
  String username;
  String password;
  String name;
  String country;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.country,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'name': name,
      'country': country,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      name: map['name'],
      country: map['country'],
    );
  }
}
