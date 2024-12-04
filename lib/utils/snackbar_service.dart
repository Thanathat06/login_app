import 'package:flutter/material.dart';

enum SnackbarStatus {
  success, info, error, warning
}
class SnackbarService {
  static void displaySnackbar(BuildContext context, String msg, SnackbarStatus type, {Duration duration = const Duration(seconds: 3)})
  {
    final bgColor = switch (type){
      SnackbarStatus.success => Colors.green[600],
      SnackbarStatus.info => Colors.blue[400],
      SnackbarStatus.error => Colors.red[600],
      SnackbarStatus.warning => Colors.amber[400],
    };
    final snackBar = SnackBar(
      content: Text(msg, style: TextStyle(color: Colors.grey[400]),
    ),
    backgroundColor: bgColor,
    margin: const EdgeInsets.all(4),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    duration: duration,
    behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}