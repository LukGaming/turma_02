class LoginResponse {
  final int id;
  final String email;
  final String name;
  final String token;

  const LoginResponse({
    required this.id,
    required this.email,
    required this.name,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      token: json['token'],
    );
  }
}
