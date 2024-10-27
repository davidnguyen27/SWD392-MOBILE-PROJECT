class Size {
  final int id;
  final int shirtId;
  final String shirtName;
  final int sizeId;
  final String sizeName;
  final String sizeDescription;
  final int quantity;
  final String description;
  final bool status;

  Size({
    required this.id,
    required this.shirtId,
    required this.shirtName,
    required this.sizeId,
    required this.sizeName,
    required this.sizeDescription,
    required this.quantity,
    required this.description,
    required this.status,
  });

  // Factory constructor để tạo một Size từ JSON
  factory Size.fromJson(Map<String, dynamic> json) {
    return Size(
      id: json['id'],
      shirtId: json['shirtId'],
      shirtName: json['shirtName'],
      sizeId: json['sizeId'],
      sizeName: json['sizeName'],
      sizeDescription: json['sizeDescription'],
      quantity: json['quantity'],
      description: json['description'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shirtId': shirtId,
      'shirtName': shirtName,
      'sizeId': sizeId,
      'sizeName': sizeName,
      'sizeDescription': sizeDescription,
      'quantity': quantity,
      'description': description,
      'status': status,
    };
  }
}

class Shirt {
  final int id;
  final int typeShirtId;
  final String typeShirtName;
  final int playerId;
  final String playerName;
  final String name;
  final int number;
  final double price;
  final DateTime date;
  final String description;
  final String urlImg;
  final int status;
  final List<Size> listSize; // Thêm listSize

  Shirt({
    required this.id,
    required this.typeShirtId,
    required this.typeShirtName,
    required this.playerId,
    required this.playerName,
    required this.name,
    required this.number,
    required this.price,
    required this.date,
    required this.description,
    required this.urlImg,
    required this.status,
    required this.listSize, // Thêm listSize
  });

  // Factory constructor để tạo một Shirt từ JSON
  factory Shirt.fromJson(Map<String, dynamic> json) {
    var listSizeJson = json['listSize'] as List?;
    List<Size> listSize = listSizeJson != null
        ? listSizeJson.map((sizeJson) => Size.fromJson(sizeJson)).toList()
        : [];

    return Shirt(
      id: json['id'],
      typeShirtId: json['typeShirtId'],
      typeShirtName: json['typeShirtName'],
      playerId: json['playerId'],
      playerName:
          json['fullName'] ?? '', // Thay đổi `playerName` thành `fullName`
      name: json['name'],
      number: json['number'],
      price: (json['price'] as num).toDouble(),
      date: DateTime.parse(json['date']),
      description: json['description'],
      urlImg: json['urlImg'],
      status: json['status'],
      listSize: listSize, // Cập nhật listSize
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'typeShirtId': typeShirtId,
      'typeShirtName': typeShirtName,
      'playerId': playerId,
      'playerName': playerName,
      'name': name,
      'number': number,
      'price': price,
      'date': date.toIso8601String(),
      'description': description,
      'urlImg': urlImg,
      'status': status,
      'listSize':
          listSize.map((size) => size.toJson()).toList(), // Trả về listSize
    };
  }
}
