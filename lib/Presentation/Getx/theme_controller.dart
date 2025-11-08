import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Core/Config/Theme/app_theme.dart';

class ThemeController extends GetxController {
  final _isDark = false.obs;

  bool get isDark => _isDark.value;

  void toggleTheme() {
    _isDark.toggle(); // updates the reactive value
  }

  ThemeData get currentTheme => _isDark.value ? AppTheme.dark : AppTheme.light;
}