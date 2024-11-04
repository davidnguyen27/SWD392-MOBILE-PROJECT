class Player {
  final int id;
  final int clubId;
  final String clubName;
  final String fullName;
  final double height;
  final int weight;
  final DateTime birthday;
  final String nationality;
  final bool status;

  Player({
    required this.id,
    required this.clubId,
    required this.clubName,
    required this.fullName,
    required this.height,
    required this.weight,
    required this.birthday,
    required this.nationality,
    required this.status,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      clubId: json['clubId'],
      clubName: json['clubName'] ?? 'Unknown Club',
      fullName: json['fullName'] ?? 'Unknown Name',
      height: json['height']?.toDouble() ?? 0.0,
      weight: json['weight'] ?? 0,
      birthday: json['birthday'] != null
          ? DateTime.parse(json['birthday'])
          : DateTime(2000, 1, 1),
      nationality: json['nationality'] ?? 'Unknown Nationality',
      status: json['status'] == true || json['status'] == 1,
    );
  }
}
