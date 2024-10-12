// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Login {
  final String username;
  final String password;
  Login({
    required this.username,
    required this.password,
  });


  Login copyWith({
    String? username,
    String? password,
  }) {
    return Login(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
    };
  }

  factory Login.fromMap(Map<String, dynamic> map) {
    return Login(
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Login.fromJson(String source) =>
      Login.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Login(username: $username, password: $password)';

  @override
  bool operator ==(covariant Login other) {
    if (identical(this, other)) return true;

    return other.username == username && other.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}
