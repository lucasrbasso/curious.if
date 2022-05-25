import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String token;
  UserModel({
    required this.name,
    required this.email,
    required this.token,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? token,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'access_token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      token: map['access_token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(name: $name, email: $email, token: $token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.email == email &&
        other.token == token;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ token.hashCode;
}
