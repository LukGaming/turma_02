// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final int id;
  final String nome;
  final String email;
  final String token;

  const User({
    required this.id,
    required this.nome,
    required this.email,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'email': email,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      nome: map['nome'] as String,
      email: map['email'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
