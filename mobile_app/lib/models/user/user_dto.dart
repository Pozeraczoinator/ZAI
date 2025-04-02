enum Authority { MANAGER }

class UserDto {
  int? id;
  String? name;
  String? surname;
  String? email;
  String? imageUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Authority>? authorities;
  String? username;
  bool? enabled;
  bool? credentialsNonExpired;
  bool? accountNonExpired;
  bool? accountNonLocked;

  UserDto({
    this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.authorities,
    required this.username,
    required this.enabled,
    required this.credentialsNonExpired,
    required this.accountNonExpired,
    required this.accountNonLocked,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      authorities: (json['authorities'] as List<dynamic>)
          .map((e) => Authority.values
              .firstWhere((a) => a.toString().split('.').last == e))
          .toList(),
      username: json['username'],
      enabled: json['enabled'],
      credentialsNonExpired: json['credentialsNonExpired'],
      accountNonExpired: json['accountNonExpired'],
      accountNonLocked: json['accountNonLocked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'email': email,
      'imageUrl': imageUrl,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'authorities':
          authorities?.map((a) => a.toString().split('.').last).toList(),
      'username': username,
      'enabled': enabled,
      'credentialsNonExpired': credentialsNonExpired,
      'accountNonExpired': accountNonExpired,
      'accountNonLocked': accountNonLocked,
    };
  }

  String get getInitials {
    if (name != null && surname != null) {
      return "${name![0]}${surname![0]}";
    }
    return "-";
  }
}
