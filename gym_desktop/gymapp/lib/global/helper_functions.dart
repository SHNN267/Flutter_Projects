import 'package:flutter/material.dart';
import 'package:gymapp/constants/colors/Mycolors.dart';
import 'package:gymapp/constants/fonts/Myfonts.dart';

class HelperFunctions {
  // 🔹 Helper: show loading dialog
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  // 🔹 Helper: success message
  static void showSuccessMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: MyFontStyle.normal(color: MyColor.white)),
        backgroundColor: MyColor.primary_color,
      ),
    );
  }

  // 🔹 Helper: error message
  static void showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: MyFontStyle.normal(color: MyColor.white)),
        backgroundColor: MyColor.red,
      ),
    );
  }

  static List<String> splitByDash(String text) {
    if (text.trim().isEmpty) return [];
    return text.split('-').map((e) => e.trim()).toList();
  }
}
