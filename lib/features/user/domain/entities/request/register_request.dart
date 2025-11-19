class RegisterRequest {
  RegisterRequest({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.type,
    required this.gender,
  });
  final String email;
  final String password;
  final String name;
  final String phone;
  final String type;
  final String gender;

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
        'phone': '0$phone',
        'type': type,
        'gender': gender,
      };
}
