import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonMessage {
  static void showMessage({
    required BuildContext context,
    required String title,
    required String message,
    SnackPosition? snackPosition,
  }) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: Colors.green,
        title: title,
        message: message,
        snackPosition: snackPosition ?? SnackPosition.BOTTOM,
      ),
    );
  }
}
