class Size {
  final int id;
  final String name;
  final String description;
  final bool status;

  Size({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
  });

  factory Size.fromJson(Map<String, dynamic> json) {
    return Size(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
    );
  }
}
