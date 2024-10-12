import 'package:flutter/material.dart';

SnackBar notificationBar(String message, bool isError) {
  return SnackBar(
    content: Text(message),
    backgroundColor: isError ? Colors.red : Colors.greenAccent,
  );
}
