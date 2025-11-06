import 'package:flutter/material.dart';

class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: Colors.black,
      secondary: Colors.grey.shade600,
      surface: Colors.white,
      background: Colors.grey.shade50,
    ),
    useMaterial3: true,
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Colors.white,
      secondary: Colors.grey.shade400,
      surface: Colors.grey.shade900,
      background: Colors.black,
    ),
    useMaterial3: true,
  );
}