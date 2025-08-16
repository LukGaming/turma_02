class RegisterUserRequest {
  final String name;
  final String email;
  final String password;

  const RegisterUserRequest({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
