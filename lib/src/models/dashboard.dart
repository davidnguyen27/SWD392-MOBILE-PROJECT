class DashboardData {
  final int userCount;
  final int clubCount;
  final int sessionCount;
  final int playerCount;
  final int shirtCount;
  final int typeShirtCount;
  final int orderCount;

  DashboardData({
    required this.userCount,
    required this.clubCount,
    required this.sessionCount,
    required this.playerCount,
    required this.shirtCount,
    required this.typeShirtCount,
    required this.orderCount,
  });

  // Phương thức factory để tạo một đối tượng DashboardData từ JSON
  factory DashboardData.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {}; // Truy cập vào đối tượng `data`
    return DashboardData(
      userCount: data['userCount'] ?? 0,
      clubCount: data['clubCount'] ?? 0,
      sessionCount: data['sessionCount'] ?? 0,
      playerCount: data['playerCount'] ?? 0,
      shirtCount: data['shirtCount'] ?? 0,
      typeShirtCount: data['typeShirtCount'] ?? 0,
      orderCount: data['orderCount'] ?? 0,
    );
  }

  // Phương thức để chuyển đổi đối tượng DashboardData thành JSON
  Map<String, dynamic> toJson() {
    return {
      'userCount': userCount,
      'clubCount': clubCount,
      'sessionCount': sessionCount,
      'playerCount': playerCount,
      'shirtCount': shirtCount,
      'typeShirtCount': typeShirtCount,
      'orderCount': orderCount,
    };
  }
}
