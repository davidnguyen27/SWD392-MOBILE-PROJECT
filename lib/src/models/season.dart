class Season {
  final int id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final bool status;

  Season({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.status,
  });

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      id: json['id'],
      name: json['name'],
      startDate: DateTime.parse(json['startDdate']),
      endDate: DateTime.parse(json['endDdate']),
      description: json['description'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'startDdate': startDate.toIso8601String(),
      'endDdate': endDate.toIso8601String(),
      'description': description,
      'status': status,
    };
  }
}
