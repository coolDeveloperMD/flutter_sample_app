import 'package:flutter/material.dart';

extension SnackBarExtension on ScaffoldMessengerState {
  void showSuccessSnackBarOnState({
    required String message,
  }) {
    showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
extension BoolParsing on String {
  bool parseBool() {
    return toLowerCase() == 'true';
  }
}