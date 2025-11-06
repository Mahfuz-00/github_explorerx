import 'package:flutter/material.dart';

class LanguageColor {
  static final Map<String, Color> _colors = {
    'Dart': Colors.blue,
    'Kotlin': Colors.purple,
    'Java': Colors.orange,
    'Swift': Colors.red,
    'JavaScript': Colors.yellow,
    'TypeScript': Colors.blue.shade700,
    'Python': Colors.green,
    'HTML': Colors.deepOrange,
    'CSS': Colors.indigo,
  };

  static Color get(String? language) {
    return _colors[language] ?? Colors.grey;
  }
}