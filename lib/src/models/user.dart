class User {
  final int? id;
  final String email;
  final String token;
  final String password;
  final String userName;
  final DateTime dob;
  final String address;
  final String phoneNumber;
  final String gender;
  final String imgUrl;
  final String roleName;

  User({
    required this.id,
    required this.email,
    required this.token,
    required this.password,
    required this.userName,
    required this.dob,
    required this.address,
    required this.phoneNumber,
    required this.gender,
    required this.imgUrl,
    required this.roleName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] != null
          ? (json['id'] is String ? int.tryParse(json['id']) : json['id'])
          : null,
      email: json['email'] ?? '',
      token: json['token'] ?? '',
      password: json['password'] ?? '',
      userName: json['userName'] ?? '',
      dob: DateTime.parse(json['dob'] ?? DateTime.now().toIso8601String()),
      address: json['address'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      gender: json['gender'] ?? '',
      imgUrl: json['imgUrl'] ?? '',
      roleName: json['roleName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'token': token,
      'password': password,
      'userName': userName,
      'dob': dob.toIso8601String(),
      'address': address,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'imgUrl': imgUrl,
      'roleName': roleName,
    };
  }
}
