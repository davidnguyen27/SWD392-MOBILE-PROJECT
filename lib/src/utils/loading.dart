import 'package:flutter/material.dart';

class LoadingUtils {
  static void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.of(context).pop(); // Đóng dialog
  }
}
