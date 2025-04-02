class LoginUserDto {
  String email;
  String password;

  LoginUserDto({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory LoginUserDto.fromJson(Map<String, dynamic> json) {
    return LoginUserDto(
      email: json['email'],
      password: json['password'],
    );
  }
}
