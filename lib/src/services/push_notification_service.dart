// import 'dart:convert';
// import 'package:googleapis_auth/auth_io.dart' as auth;

// class FirebaseNotificationService {
//   // Chuỗi JSON chứa thông tin tài khoản dịch vụ
//   static const String _serviceAccountJson = '''
//   {
//     "type": "service_account",
//   "project_id": "t-shirt-football-shop",
//   "private_key_id": "2bd07b29855a03b01b6ecd43e479ab9972ae5cf6",
//   "private_key": "-----BEGIN PRIVATE KEY-----\\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC+3a0ZwQW3ZgvY\\n/p+76Az+BbY/plRCeIAM5TYygIjOFvK+X8EN1Nv+Qah93h66v3SC4271t7BDGOg2\\nok/t7Z4GjpdyeLF6bcpAUJPqe2rvWihkwyiy0ltQ5y1tx1VI7Kkn18mt85dH0fRt\\nDroQT2N126GGfHkMX6+Js+lPpREp29Ee+aunPyLKxiM2tpD4ascGDKfx3FI6OlE+\\nQCxaTWPZ+/90R+0Xbq/skOYiFIK6bnNc8Mbc9UZ1lHVYtZEXmk05Ww6ncuy9VRC2\\nAEXnjJHwBzGQFpjSqGm7pZPmMVrjFFZROxILYx04eZ385CMCCd2S3bcuaSnzlol+\\nmaTrZagjAgMBAAECggEAJeZTyJDlBzFaueh5pHDkH47XzRTEl3xhBO6A0A9o2u+A\\nnR/bcFkro/W6tN+l33RD+PebYWxrsi8gcTTSxU6ROgEXfpILv+FML3AwpveB2Oxg\\np/1+t9+AZXS6NxnFTBk+T5yQPhvoFslQjVVGyhVRjSYjEVbnHHdlnmTct8VxvotB\\nUZG3VVvqD5wcV56Q7M9QIiiW7Y10A14nZ6LBCW87fjAMILufTV4Zk5NKy2nXnfx9\\nrMPP80jwnuZDrnZuUSr7oIpOUolxnNdS3WDaPKVwCf79TcaqVsE0Fip1tFna+alZ\\nOI27Sj5TeXDXWuiQfNLUeW8/tF7ARBPkxnuQm6ZoZQKBgQDho8o8kHkkOW3mE/ZS\\nb2is4h58VkHybwB/pEYjFdOrp0Mz8wa0TDU4oaHklNu9TwZWomJ4JQ/8NWFPzvd/\\ny9MOIT1h+6OmwwbXPeYqmvkX8V3OiE3cokULrKN0UdDl50O/lt8662Wt1tstuc0X\\n87hxFmSOFL1iZj6Qj8QmpTa2JwKBgQDYjBezpNvIV3x+uiNAgTuuzSI16cB8twyO\\n6Hll/LeMtwtA1RJc3MiXABWu/Bb77wdzhp9USxzBuylABZMg0K96HoU631W8z1pv\\nygBnLvTl22OxfImOfij8AbgSNNlVkTxsKPH1ovQHE2W1dnwAVkL/mOAFpjKtPo38\\nA5dHds1XpQKBgHUdbnrBAh+rLz+cXN2stcgGFYyzuMb8lmWp/j13tsYBqv/rxC8Q\\n3w7l1gGuwd8ghUmyPyndEs71Zezmn8/VG1baKeIRmn+T+pj9p9m1VlT3EpmAZel+\\n0BefI7fcP3EU+DUZOgR66euw+VJiffFQrwsDdG3KlgHcz9x4wnbMiflBAoGAQLZ0\\n6tGMgK1sXe7AVCmKrW1OGPB2/o4xaY+dn9XLAHk/GqvSJgAwzbdPw5BASh+fiW2k\\ntasQt/B3nlNMKZVTq1ntlK9jTt5kd13ViwBkXUCX5VWDQhr/onfdC0vR2xlhBi2i\\nSTbeWDL6xSTYX71nnjyQTf/hyxYTlkl4bvnY2aUCgYEAgtNrfLySuwq9zKKVh+0d\\nZ6yi2Eah4uTEFFFfxUFY8ezLYj9tFYSyvFD7btXaoFMEbcuxqf7IDkXW96vPS9JA\\nNuKMaV0NY8uutrY2TK8C8kBpOsgm/7Z/EOO7qYn0OM8IsWurJQ461JZ53SGvPFb4\\nA4c0611vdnEJAkOe7hFH1r8=\\n-----END PRIVATE KEY-----\\n",
//   "client_email": "firebase-adminsdk-2p3fq@t-shirt-football-shop.iam.gserviceaccount.com",
//   "client_id": "102019544987436062462",
//   "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//   "token_uri": "https://oauth2.googleapis.com/token",
//   "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
//   "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-2p3fq%40t-shirt-football-shop.iam.gserviceaccount.com",
//   "universe_domain": "googleapis.com"
//   }
//   ''';

//   // Hàm để lấy access token từ tài khoản dịch vụ
//   static Future<auth.AutoRefreshingAuthClient> _getAuthClient() async {
//     final jsonCredentials = json.decode(_serviceAccountJson);

//     // Thiết lập tài khoản dịch vụ từ JSON file
//     final accountCredentials =
//         auth.ServiceAccountCredentials.fromJson(jsonCredentials);

//     // Các scope cần để gửi thông báo qua Firebase
//     final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

//     // Lấy OAuth2 token bằng tài khoản dịch vụ
//     return await auth.clientViaServiceAccount(accountCredentials, scopes);
//   }

//   // Hàm gửi thông báo qua FCM API v1
//   static Future<void> sendNotificationToDevice({
//     required String title,
//     required String body,
//     // String? topic, // Có thể gửi theo topic hoặc FCM token của thiết bị
//     String? token, // Nếu muốn gửi đến một thiết bị cụ thể
//   }) async {
//     final client = await _getAuthClient();

//     // API v1 của Firebase Cloud Messaging
//     final url = Uri.parse(
//       'https://fcm.googleapis.com/v1/projects/t-shirt-football-shop/messages:send', // Thay YOUR_PROJECT_ID bằng project ID thực tế của bạn
//     );

//     // Tạo payload cho thông báo
//     final message = {
//       'token': token,
//       'message': {
//         'notification': {
//           'title': title,
//           'body': body,
//         },
//         // Gửi đến một topic hoặc token
//         // if (topic != null) 'topic': topic,
//         // if (token != null) 'token': token,
//       }
//     };

//     final response = await client.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(message),
//     );

//     if (response.statusCode == 200) {
//       print('Notification sent successfully: ${response.body}');
//     } else {
//       print('Failed to send notification: ${response.body}');
//     }

//     client.close();
//   }
// }
