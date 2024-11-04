class Club {
  final int id;
  final String name;
  final String country;
  final DateTime establishedYear;
  final String stadiumName;
  final String clubLogo;
  final String description;
  final bool status;

  Club({
    required this.id,
    required this.name,
    required this.country,
    required this.establishedYear,
    required this.stadiumName,
    required this.clubLogo,
    required this.description,
    required this.status,
  });

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      id: json['id'] ?? 0, // Đảm bảo ID không phải là null
      name: json['name'] ?? '',
      country: json['country'] ?? '',
      establishedYear: json['establishedYear'] != null
          ? DateTime.parse(json['establishedYear'])
          : DateTime(2000), // Đặt giá trị mặc định nếu null
      stadiumName: json['stadiumName'] ?? '',
      clubLogo: json['clubLogo'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'establishedYear': establishedYear.toIso8601String(),
      'stadiumName': stadiumName,
      'clubLogo': clubLogo,
      'description': description,
      'status': status,
    };
  }
}
