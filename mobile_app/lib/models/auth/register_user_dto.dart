class RegisterUserDto {
  String? email;
  String? password;
  String? name;
  String? surname;
  String? imageUrl;

  RegisterUserDto({
    required this.email,
    required this.password,
    required this.name,
    required this.surname,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'surname': surname,
      'imageUrl': imageUrl ?? ""
    };
  }

  factory RegisterUserDto.fromJson(Map<String, dynamic> json) {
    return RegisterUserDto(
      email: json['email'],
      password: json['password'],
      name: json['name'],
      surname: json['surname'],
      imageUrl: json['imageUrl'],
    );
  }
}
