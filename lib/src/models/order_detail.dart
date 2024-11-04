class OrderDetail {
  final int id;
  final String orderId;
  final int shirtSizeId;
  final int shirtId;
  final String shirtName;
  final String shirtUrlImg;
  final int shirtPrice;
  final String shirtDescription;
  final int sizeId;
  final String sizeName;
  final String sizeDescription;
  final int quantity;
  final int price;
  final bool statusRating;
  final String? comment;
  final int? score;
  final bool status;

  OrderDetail({
    required this.id,
    required this.orderId,
    required this.shirtSizeId,
    required this.shirtId,
    required this.shirtName,
    required this.shirtUrlImg,
    required this.shirtPrice,
    required this.shirtDescription,
    required this.sizeId,
    required this.sizeName,
    required this.sizeDescription,
    required this.quantity,
    required this.price,
    required this.statusRating,
    this.comment,
    this.score,
    required this.status,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: json['id'],
      orderId: json['orderId'],
      shirtSizeId: json['shirtSizeId'],
      shirtId: json['shirtId'],
      shirtName: json['shirtName'],
      shirtUrlImg: json['shirtUrlImg'],
      shirtPrice: json['shirtPrice'],
      shirtDescription: json['shirtDescription'],
      sizeId: json['sizeId'],
      sizeName: json['sizeName'],
      sizeDescription: json['sizeDescription'],
      quantity: json['quantity'],
      price: json['price'],
      statusRating: json['statusRating'],
      comment: json['comment'],
      score: json['score'],
      status: json['status'],
    );
  }
}
