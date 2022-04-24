import 'dart:convert';

class SignUpModel {
  final String nome;
  final String email;
  final String password;
  SignUpModel({
    required this.nome,
    required this.email,
    required this.password,
  });

  SignUpModel copyWith({
    String? nome,
    String? email,
    String? password,
  }) {
    return SignUpModel(
      nome: nome ?? this.nome,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'password': password,
    };
  }

  factory SignUpModel.fromMap(Map<String, dynamic> map) {
    return SignUpModel(
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpModel.fromJson(String source) =>
      SignUpModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'SignUpModel(nome: $nome, email: $email, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignUpModel &&
        other.nome == nome &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => nome.hashCode ^ email.hashCode ^ password.hashCode;
}
