import 'package:flutter/material.dart';

class Util {
  static showSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(
        content: Text(text, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey.shade800,
        duration: const Duration(milliseconds: 600),
      ));
  }
}
