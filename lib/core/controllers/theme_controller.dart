import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Manages light / dark / system theme switching.
/// Access via Get.find[ThemeController]()
class ThemeController extends GetxController {
  final _themeMode = ThemeMode.dark.obs;

  ThemeMode get themeMode => _themeMode.value;

  bool get isDark =>
      _themeMode.value == ThemeMode.dark ||
      (_themeMode.value == ThemeMode.system &&
          WidgetsBinding
                  .instance.platformDispatcher.platformBrightness ==
              Brightness.dark);

  /// Toggle between light and dark themes.
  void toggleTheme() {
    _themeMode.value =
        isDark ? ThemeMode.light : ThemeMode.dark;
    Get.changeThemeMode(_themeMode.value);
  }

  /// Set a specific theme mode.
  void setTheme(ThemeMode mode) {
    _themeMode.value = mode;
    Get.changeThemeMode(mode);
  }
}
