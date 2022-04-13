import 'package:flutter/material.dart';

const snackBarDurationSeconds = 3;

showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: snackBarDurationSeconds),
  ));
}
